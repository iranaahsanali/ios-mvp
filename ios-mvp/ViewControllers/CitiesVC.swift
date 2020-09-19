//
//  ViewController.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 14/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import UIKit
import MapKit

class CitiesVC: UIViewController {

    private let citiesPresenter = CitiesPresenter(citiesCoordinator: CitiesCoordinator())
    @IBOutlet weak var mapView: MKMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Map View UI
        setupMapView()
        
        // Setting Presenter
        setupPresenter()
    }
    
    private func setupPresenter()
    {
        citiesPresenter.setDelegae(delegate: self)
        citiesPresenter.fetchCities()
    }
    
    // MARK: - Setting UI Programmatically
    private func openWeatherDetails(city : City)
    {
        let weatherDetailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailVC") as! WeatherDetailVC
        weatherDetailVC.modalPresentationStyle = .formSheet
        weatherDetailVC.preferredContentSize = CGSize(width: 600, height: 670)
        weatherDetailVC.setCity(city: city)
        self.present(weatherDetailVC, animated: true, completion: {
            weatherDetailVC.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
        })
    }
    
    private func setupMapView()
    {
        self.mapView.delegate = self
        self.mapView.isZoomEnabled = true
        self.mapView.isPitchEnabled = true
        self.mapView.isAccessibilityElement = false
        
        self.mapView.register(CityPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "CityAnnotationView")
    }
    
    private func renderMarkers()
    {
        var latitudeSum = 0.0
        var longitudeSum = 0.0
        for city in self.citiesPresenter.cities {
            let annotation = MKPointAnnotation()
            annotation.title = city.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: city.latitude!, longitude: city.longitude!)
            mapView.addAnnotation(annotation)
            latitudeSum += city.latitude!
            longitudeSum += city.longitude!
        }
        self.zoomToFitMapAnnotations(mapView: self.mapView)
    }
    
    // Zoom it cover all pins/annotations
    private func zoomToFitMapAnnotations(mapView: MKMapView) {
        guard mapView.annotations.count > 0 else {
            return
        }
        var topLeftCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        topLeftCoord.latitude = -90
        topLeftCoord.longitude = 180
        var bottomRightCoord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        bottomRightCoord.latitude = 90
        bottomRightCoord.longitude = -180
        for annotation: MKAnnotation in mapView.annotations {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude)
        }

        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 2.0
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 2.0
        region = mapView.regionThatFits(region)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - Presenter Notifiers
extension CitiesVC : CitiesViewDelegate
{
    func fetchingData() {
        self.showProgress()
    }
    
    func dataFetched() {
        self.renderMarkers()
        self.hideProgress()
    }
}

// MARK: - MAP View Annoataion Delegate
extension CitiesVC : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        let cityPinView  = self.cityPinView(in: mapView, for: annotation)
        cityPinView.canShowCallout = false

        cityPinView.containerColor = UIColor(red:1, green:0.91, blue:0, alpha:1)
        let city = self.citiesPresenter.cities.first(where: { $0.name == annotation.title })
        cityPinView.city = city
        cityPinView.openWeatherDetail = {[weak self](city) in
            guard let _city = city else { return }
            self?.openWeatherDetails(city: _city)
        }
        return cityPinView
    }
    
    // Custom Pin View
    func cityPinView(in mapView: MKMapView, for annotation: MKAnnotation) -> CityPinAnnotationView {
        let identifier = "CityAnnotationView"
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CityPinAnnotationView {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let customAnnotationView = CityPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            customAnnotationView.canShowCallout = true
            return customAnnotationView
        }
    }
}
