//
//  NearByViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 02/04/21.
//

import UIKit
import GoogleMaps
import AFNetworking
class NearByViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet weak var bbView: UIView!
    
    @IBOutlet weak var lbl_fullLocation: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var listSearchView: UIView!
    
    @IBOutlet weak var btnChangeView: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapSearchView: UIView!
    var isMapView = false
    
    @IBOutlet weak var salonTableView: UITableView!
    @IBOutlet weak var salonCollectionView: UICollectionView!
    var locationManager:CLLocationManager!
    var userLat = NSNumber()
    var userLong = NSNumber()
    
//    var custlatt = [26.862337,22.293440,21.864870,26.826260,26.820351,14.230774]
//    var custlong = [81.019958,73.193527, 87.580063,80.914820,80.921318, 80.999999]
    var custlatt = [Double]()
    var custlong = [Double]()
    var distanceArray = [Double]()
    //var salonIdArray = [Int]()
    var nearByDataArray = [[String:Any]]()
    var currentUserLocation : CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchView.layer.borderColor = UIColor.gray.cgColor
        searchView.layer.borderWidth = 1
        lbl_fullLocation.text = "\(UserDefaults.standard.object(forKey: UPDATE_LOCATION) ?? "N/A")"
        listSearchView.isHidden = false
        mapSearchView.isHidden = true
        btnChangeView.isSelected = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(UPDATE_LOCATION), object: nil)
     
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentLocation()
        
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        
        lbl_fullLocation.text = "\(UserDefaults.standard.object(forKey: UPDATE_LOCATION) ?? "N/A")"
    }
    @IBAction func btnAction_changeLocation(_ sender: Any) {
        let changeLocation_VC = self.storyboard?.instantiateViewController(withIdentifier: "ChangeLocationViewController") as! ChangeLocationViewController
        
        self.navigationController?.pushViewController(changeLocation_VC, animated: true)
    }
    
    @IBAction func btnAction_changeView(_ sender: Any) {
        if isMapView {
            print("LIST VIEW")
            listSearchView.isHidden = false
            mapSearchView.isHidden = true
            isMapView = false
            btnChangeView.isSelected = false
        }
        else{
            print("MAP VIEW")
            listSearchView.isHidden = true
            mapSearchView.isHidden = false
            isMapView = true
            btnChangeView.isSelected = true
        }
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
        let camera = GMSCameraPosition.camera(withLatitude: userLat, longitude:userLong, zoom: 10.0)
        
        
        mapView.camera = camera
     
        ////////New
        self.mapView.delegate = self
//        for i in 0...custlatt.count-1{
//            let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(custlatt[i]), longitude: CLLocationDegrees(custlong[i]))
//                      print("location: \(location)")
//                      let marker = GMSMarker()
//                      marker.position = location
//            marker.icon = UIImage(named: "home.png")
//                      marker.map = mapView
//                  marker.isDraggable = true
//                  reverseGeocoding(marker: marker)
//                  marker.map = mapView
//                  }
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
    
    func getNearBySalon(latitude:NSNumber,longtitude:NSNumber,range:String) {
        // supportingfuction.showProgressHud("Please Wait...", labelText: "Getting Data!")
        print("Lat ==> \(latitude)")
        print("Long ==> \(longtitude)")
        print("Range ==> \(range)")
        let url = BASE_URL + GET_NEARBY_SALON + "?latitude=\(latitude)&longitude=\(longtitude)&bt_distance=\(range)"
        print(url)
        let manager = AFHTTPSessionManager()
        
        manager.get(url, parameters: nil, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                //print(dict)
                
                
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                    
                    if let dataDict = dict["data"] as? [[String: Any]] {
                        print("GET NearBy DATA = \(dataDict)")
                        
                        self.nearByDataArray = dataDict
                        
                        for i in 0...dataDict.count-1 {
                            print(i)
                           // if let locationArray = dataDict[i]["latlng"] as? [String:Any] {
                                // print("Location Array == \(locationArray)")
                                if let lon = dataDict[i]["longitude"] as? String {
                                    print("Lon \(lon)")
                                    let lonDouble = (lon as NSString).doubleValue
                                    print("Value in Int == \(lonDouble)")
                                    self.custlong.append(lonDouble)
                                }
                                if let lat = dataDict[i]["latitude"] as? String {
                                    print("Lat \(lat)")
                                    let latDouble = (lat as NSString).doubleValue
                                    print("Value in Int == \(latDouble)")
                                    self.custlatt.append(latDouble)
                                }
                                
                                
                                
                            //}
                        }
                        //DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            // Put your code which should be executed with a delay here
                            for i in 0...self.custlatt.count-1{
                                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.custlatt[i]), longitude: CLLocationDegrees(self.custlong[i]))
                                          print("location: \(location)")
                                
                            let salonLocation = CLLocation(latitude: CLLocationDegrees(self.custlatt[i]), longitude: CLLocationDegrees(self.custlong[i]))
                                let distanceInMeters = self.currentUserLocation.distance(from: salonLocation)
                                print("DISTANCE   == > \(distanceInMeters)")
                                self.distanceArray.append(distanceInMeters/1000.0)
                                          let marker = GMSMarker()
                                          marker.position = location
                                marker.icon = UIImage(named: "locationMarker.png")
                                marker.map = self.mapView
                                      marker.isDraggable = true
                                self.reverseGeocoding(marker: marker)
                                marker.map = self.mapView
                                      }
                        //}
                     
                        print("Salon Count == \(self.nearByDataArray.count)")
                        self.salonCollectionView.reloadData()
                        self.salonTableView.reloadData()
                        
                        
                    }
                }
                else
                {
                    
                    
                    
                }
            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
            
        })
        
    }
    
}

extension NearByViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        currentUserLocation = userLocation
        
        //Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        userLat = userLocation.coordinate.latitude as NSNumber
        userLong = userLocation.coordinate.longitude as NSNumber
        setUpMAP_View(userLat: userLocation.coordinate.latitude, userLong: userLocation.coordinate.longitude)
        getNearBySalon(latitude: userLat, longtitude: userLong, range: "500")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}
extension NearByViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return nearByDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "salonCell", for: indexPath)
        
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        
        
        
        let bookBtnView : UIButton = cell.viewWithTag(7) as! UIButton
        bookBtnView.layer.cornerRadius = 20
        bookBtnView.layer.maskedCorners = [.layerMinXMinYCorner]

        let salonImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        let salonName : UILabel = cell.viewWithTag(2) as! UILabel
        let location : UILabel = cell.viewWithTag(3) as! UILabel
        let ratingView: FloatRatingView = cell.viewWithTag(4) as! FloatRatingView
        let homeOption:  UILabel = cell.viewWithTag(5) as! UILabel
        let shopOption:  UILabel = cell.viewWithTag(6) as! UILabel
        let rating_lbl : UILabel = cell.viewWithTag(8) as! UILabel
        
        let distance:  UILabel = cell.viewWithTag(10) as! UILabel

        homeOption.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        shopOption.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        homeOption.layer.borderWidth = 1
        shopOption.layer.borderWidth = 1
        homeOption.backgroundColor = .white
        shopOption.backgroundColor = .white
        ratingView.delegate = self

        salonName.adjustsFontSizeToFitWidth = true
        location.adjustsFontSizeToFitWidth = true
        salonImage.contentMode = .scaleAspectFill

        if nearByDataArray.count > 0{
            if let imgUrl = nearByDataArray[indexPath.item]["image"]
            {
                let fileUrl = URL(string: imgUrl as! String)
                salonImage.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))

            }

            salonName.text = "\(nearByDataArray[indexPath.item]["name"] ?? "")"
            location.text = "\(nearByDataArray[indexPath.item]["landmark"] ?? ""), \(nearByDataArray[indexPath.item]["city"] ?? ""), \(nearByDataArray[indexPath.item]["state"] ?? ""), \(nearByDataArray[indexPath.item]["country"] ?? "")"
            distance.text = "\(String(format: "%.01 fkm", distanceArray[indexPath.item]))"
           // ratingView.rating = nearByDataArray[indexPath.item]["ratings"] as! Double
            rating_lbl.text = "\(nearByDataArray[indexPath.item]["ratings"] ?? "").0"
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let salonDetail_VC = self.storyboard?.instantiateViewController(withIdentifier: "SalonDetailsViewController") as! SalonDetailsViewController
        salonDetail_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(salonDetail_VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: 300, height: 240)
       
    }
}

extension NearByViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearByDataArray.count
       
    }
 
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salonCell", for: indexPath)
        cell.selectionStyle = .none

//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        
        
        let cellBgView : UIView = cell.viewWithTag(101)!
        cellBgView.layer.borderWidth = 1
        cellBgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        cellBgView.layer.cornerRadius = 20
        let bookBtnView : UIButton = cell.viewWithTag(7) as! UIButton
        bookBtnView.layer.cornerRadius = 20
        bookBtnView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]

        let salonImage : UIImageView = cell.viewWithTag(1) as! UIImageView
        let salonName : UILabel = cell.viewWithTag(2) as! UILabel
        let location : UILabel = cell.viewWithTag(3) as! UILabel
        let ratingView: FloatRatingView = cell.viewWithTag(4) as! FloatRatingView
        let homeOption:  UILabel = cell.viewWithTag(5) as! UILabel
        let shopOption:  UILabel = cell.viewWithTag(6) as! UILabel
        
        let distance:  UILabel = cell.viewWithTag(10) as! UILabel
        

        homeOption.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        shopOption.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
        homeOption.layer.borderWidth = 1
        shopOption.layer.borderWidth = 1
        homeOption.backgroundColor = .white
        shopOption.backgroundColor = .white
        ratingView.delegate = self

        salonName.adjustsFontSizeToFitWidth = true
        location.adjustsFontSizeToFitWidth = true
        salonImage.contentMode = .scaleAspectFill

        if nearByDataArray.count > 0{
            if let imgUrl = nearByDataArray[indexPath.row]["image"]
            {
                let fileUrl = URL(string: imgUrl as! String)
                salonImage.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))

            }

            salonName.text = "\(nearByDataArray[indexPath.row]["name"] ?? "")"
            location.text = "\(nearByDataArray[indexPath.row]["landmark"] ?? ""), \(nearByDataArray[indexPath.row]["city"] ?? ""), \(nearByDataArray[indexPath.item]["state"] ?? ""), \(nearByDataArray[indexPath.row]["country"] ?? "")"
            distance.text = "\(String(format: "%.01 fkm", distanceArray[indexPath.row]))"
           // ratingView.rating = nearByDataArray[indexPath.row]["ratings"] as! Double
        }
       
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DATA = \(indexPath.row)")
       
    }
}
extension NearByViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        print("Rating = \(ratingView.rating)")
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        print("Rating F = \(ratingView.rating)")
        
    }
    
}
class CustomDashedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
class ActualGradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.0)
        l.endPoint = CGPoint(x: 1, y: 1.0)
        l.cornerRadius = 8//l.frame.height / 2
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
