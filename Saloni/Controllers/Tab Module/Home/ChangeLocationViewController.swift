//
//  ChangeLocationViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 25/12/1442 AH.
//

import UIKit
import GoogleMaps
import CoreLocation
class ChangeLocationViewController: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager:CLLocationManager!
    var userLat = NSNumber()
    var userLong = NSNumber()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //, '~>3.0.2'
        
        // Do any additional setup after loading the view.
       
        
        //self.hideKeyboardWhenTappedAround()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentLocation()
        
    }
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCurrentLocation()  {
        if CLLocationManager.locationServicesEnabled() {
            
            determineMyCurrentLocation()
        } else {
            print("Location services are not enabled")
            let alert = UIAlertController(title: "Alert !", message: "Location services are not enabled.\nPlease go to Settings and turn on the permissions.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                print("Click of Ok button")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.startUpdatingLocation()
        }
    }
    
    func setUpMAP_View(userLat:CLLocationDegrees, userLong:CLLocationDegrees)  {
       // let camera = GMSCameraPosition.camera(withLatitude: 26.8034, longitude: 75.8178, zoom: 15.0)
        print("USER LOCATION ==> \(userLat) == \(userLong)")
        let camera = GMSCameraPosition.camera(withLatitude: userLat, longitude:userLong, zoom: 15.0)
        
        
        mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        marker.isDraggable = true
        marker.map = mapView
        self.mapView.delegate = self
        marker.isDraggable = true
        reverseGeocoding(marker: marker)
        marker.map = mapView
    }
    @IBAction func btnAction_ChangeLocation(_ sender: Any) {
        
       
        self.navigationController?.popViewController(animated: true)
    }
    //Mark: Marker methods
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
        reverseGeocoding(marker: marker)
    print("Position of marker is = \(marker.position.latitude),\(marker.position.longitude)")
    }
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }

    
    //Mark: Reverse GeoCoding
    
    func reverseGeocoding(marker: GMSMarker) {
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
        
        var currentAddress = String()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
                print("Response is = \(address)")
                print("Response is = \(lines)")
                
                currentAddress = lines.joined(separator: "\n")
             print("CURRENT LOCATION ==> \(currentAddress)")
                UserDefaults.standard.setValue(currentAddress, forKey: UPDATE_LOCATION)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: Notification.Name(UPDATE_LOCATION), object: nil, userInfo: nil)
                
                
                
            }
            marker.title = currentAddress
            marker.map = self.mapView
        }
    }

}
extension ChangeLocationViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        //Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        userLat = userLocation.coordinate.latitude as NSNumber
        userLong = userLocation.coordinate.longitude as NSNumber
        setUpMAP_View(userLat: userLocation.coordinate.latitude, userLong: userLocation.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}
