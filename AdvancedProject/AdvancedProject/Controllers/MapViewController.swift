//
//  MapViewController.swift
//  AdvancedProject
//
//  Created by Лилия on 8/10/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
   
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    var locationManager = CLLocationManager()
    var locationUserMap = UserLocationModel()
    
    var arrayInfoUserOnMap = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 15
        mapView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        designButton(button: userProfileButton)
        userProfileButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        designButton(button: logOutButton)
        logOutButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        setCurrentLocation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    
    func designButton(button: UIButton) {
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8393759131, green: 0.8210689425, blue: 0.9248689413, alpha: 1)
    }
    
    func selectedButton(button: UIButton) {
        
        button.backgroundColor = #colorLiteral(red: 0.8519480228, green: 0.8357690573, blue: 0.929525435, alpha: 1)
        button.setTitleColor(.black, for: .normal)
    }
    
    func notSelectedButton(button: UIButton) {
        
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitleColor(.black, for: .normal)
    }
    
   
    
    @IBAction func didTapProfileUser(_ sender: Any) {
        
        selectedButton(button: userProfileButton)
        notSelectedButton(button: logOutButton)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.arrayInfoUserProfile = arrayInfoUserOnMap
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func didTapLogOut(_ sender: Any) {
        
        selectedButton(button: logOutButton)
        notSelectedButton(button: userProfileButton)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension MapViewController: CLLocationManagerDelegate, GMSMapViewDelegate {

    func setCurrentLocation() {
        
        locationManager.delegate = self
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(locationUserMap.latitude), longitude: CLLocationDegrees(locationUserMap.longtitude)))
        
        let markerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 27, height: 37))
        markerImage.image = UIImage(named: "mapMarker")
            let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(locationUserMap.latitude), longitude: CLLocationDegrees(locationUserMap.longtitude), zoom: 13.0)
            self.mapView.animate(to: camera)
        marker.iconView = markerImage
        marker.map = mapView
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        alert()
        return true
    }
    
    func alert() {
        
        let alert = UIAlertController(title: "Attention", message: "Go to news?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: goToNews))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    func goToNews(alert: UIAlertAction!) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
