//
//  WeatherDetailVC.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import UIKit

class WeatherDetailVC: UIViewController {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelTemprature: UILabel!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewHourly: UIView!
    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelTempratureRange: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var defaultOffSet: CGPoint?
    
    private let weatherPresenter = WeatherDetailPresenter(coordinator: WeatherCoordinator())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupPresenter()
    }
    
    func setCity(city : City){
        self.weatherPresenter.city = city
    }
    
    override func viewWillLayoutSubviews() {
       super.updateViewConstraints()
       DispatchQueue.main.async {
           self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
       }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupPresenter()
    {
        self.weatherPresenter.setDelegae(delegate: self)
        self.weatherPresenter.fetchData()
    }
    
    // MARK: - Setting UI Programmatically
    func setupUI()
    {
        // Setting Table View
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "DayWeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "DayWeatherTableViewCell")
        self.tableView.rowHeight = 35.0
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.allowsSelection = false

        // Setting Collection View
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = layoutForCollectionView()

        self.collectionView.register(UINib(nibName: "HourlyWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourlyWeatherCollectionViewCell")
    }
    
    func populateData()
    {
        self.labelCity.text = self.weatherPresenter.city?.name ?? ""
        self.labelStatus.text = self.weatherPresenter.weatherData?.currently?.weather?.first?.description ?? ""
        self.labelTemprature.text = self.weatherPresenter.weatherData?.currently?.getTemprature()
        
        self.labelDay.text = self.weatherPresenter.weatherData?.currently?.getTodayDay()
        self.labelTempratureRange.text = self.weatherPresenter.weatherData?.getTempratureRange()
        
        // Reloading Collection View
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    private func layoutForCollectionView() -> UICollectionViewFlowLayout {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let calculatedHeight = collectionView.frame.height
        layout.itemSize = CGSize(width: 55.0, height: calculatedHeight)
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        return layout
    }
}

// MARK : - Presenter Data Notifiers
extension WeatherDetailVC : WeatherDetailDelegate {
    func fetchingData() {
        DispatchQueue.main.async {
            self.showProgress()
        }
    }
    
    func dataFetched() {
        self.populateData()
        self.hideProgress()
    }
}

// MARK : - Table View Handling
extension WeatherDetailVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherPresenter.weatherData?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherTableViewCell", for: indexPath) as! DayWeatherTableViewCell
        cell.setupCell(weather: self.weatherPresenter.weatherData?.daily?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

// MARK : - Collection View Handling
extension WeatherDetailVC : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherPresenter.weatherData?.hourly?.count ?? 0 > 0 ? 14 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCollectionViewCell", for: indexPath) as! HourlyWeatherCollectionViewCell
        cell.setupCell(weather: self.weatherPresenter.weatherData?.hourly?[indexPath.row])
        return cell
    }
}
