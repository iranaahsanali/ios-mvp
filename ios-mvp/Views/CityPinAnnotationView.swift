//
//  CityPin.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 14/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import UIKit
import MapKit

class CityPinAnnotationView: MKAnnotationView {
    
    // Container Corner Radius
    public var reportPopupCornerRadius : CGFloat = 8.0
    
    // Tip Height
    public var tipHeight : CGFloat = 15.0
    
    // Tip Width
    public var tipWidth : CGFloat = 15.0
        
    // Message Font
    public var font : UIFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    
    // Message Font Color
    public var fontColor : UIColor = UIColor.black
    
    // Contrainer Color
    public var containerColor : UIColor = UIColor.lightGray
    
    // Frame
    private var annotationFrame = CGRect(x: 0, y: 0, width: 150, height: 70)

    // Custome Views
    private let labelTitle : UILabel = UILabel()
    private let buttonDetail : UIButton = UIButton()
    
    // Data
    var city : City? {
        didSet{
            self.labelTitle.text = city?.name ?? ""
        }
    }
    
    // UI Draw Rendering
    private var borderPath = UIBezierPath()
    private var tipPath = UIBezierPath()
    
    // Clourse for Detail Action
    var openWeatherDetail : ((City?)->())?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Button Action
    @objc func actionOpenDetails()
    {
        self.openWeatherDetail?(self.city)
    }
    
    // MARK: - Rendering UI Programatically
    override func draw(_ rect: CGRect) {

        backgroundColor = UIColor.clear
        borderPath.removeAllPoints()
        tipPath.removeAllPoints()
        
        // Calculate width & heigh of content
        borderPath = UIBezierPath(roundedRect: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height - tipHeight), cornerRadius: reportPopupCornerRadius)
        containerColor.setFill()
        borderPath.fill()
        
        // Drawing Tip
        // By default tip is in center
        // STEP 1 : Calculate Tip Position
        var posX : CGFloat = 0.0
        var posY : CGFloat = 0.0
        
        posX = (self.frame.width / 2.0) - (tipHeight / 2.0)
        posY = self.frame.height - tipHeight
        
        // STEP 2: Draw Tip
        tipPath.move(to: CGPoint(x: posX,y: posY))
        tipPath.addLine(to: CGPoint(x: posX + tipWidth, y: posY))
        tipPath.addLine(to: CGPoint(x: posX + tipWidth / 2, y: posY + tipHeight))
        tipPath.addLine(to: CGPoint(x: posX, y: posY))
        containerColor.setFill()
        tipPath.fill()
        
        // STEP 3: SET LABEL UI
        setupLabel()
        
        // STEP 4: SET BUTTON UI
        setupButton()
        
        // STEP 4: SET Label Content
        labelTitle.text = city?.name ?? ""
    }
    
    private func setupLabel()
    {
        self.addSubview(labelTitle)
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font = font
        labelTitle.textColor = fontColor
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        
        NSLayoutConstraint.activate([labelTitle.topAnchor.constraint(equalTo: self.topAnchor,constant: 5.0),
                                     labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
                                     labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0)])
    }
    
    private func setupButton()
    {
        self.addSubview(buttonDetail)
        buttonDetail.backgroundColor = UIColor.clear
        buttonDetail.translatesAutoresizingMaskIntoConstraints = false
        
        buttonDetail.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        buttonDetail.titleLabel?.textAlignment = .center
        
        NSLayoutConstraint.activate([buttonDetail.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor),
                                     buttonDetail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
                                     buttonDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
                                     ])
        
        buttonDetail.addRightIcon(image: UIImage(named: "iconOpenDirection.png")!)
        buttonDetail.setTitleColor(UIColor.init(displayP3Red: 21/255.0, green: 126/255.0, blue: 251.0/255.0, alpha: 1.0), for: .normal)

        buttonDetail.setTitle("Weather Details", for: .normal)
        buttonDetail.addTarget(self, action: #selector(self.actionOpenDetails), for: .touchUpInside)
    }

}

extension UIButton {
    func addRightIcon(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        let length = CGFloat(15)
        titleEdgeInsets.right += length

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: 5.0),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: length),
            imageView.heightAnchor.constraint(equalToConstant: length)
        ])
    }
}
