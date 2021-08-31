//
//  HomeViewController.swift
//  Saloni
//
//  Created by Ankur Verma on 02/04/21.
//

import UIKit
import AFNetworking

import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar_textF: UITextField!
    
    @IBOutlet weak var aroundYou_CollectionView: UICollectionView!
    @IBOutlet weak var topServices_CollectionView: UICollectionView!
    
    @IBOutlet weak var offers_CollectionView: UICollectionView!
    
    @IBOutlet weak var lbl_userName: UILabel!
    
    @IBOutlet weak var lbl_userFullLocation: UILabel!
    var nearByDataArray = [[String:Any]]()
    var topServicesDataArray = [[String:Any]]()
    var offersDataArray = [[String:Any]]()
    var lonArray = [String]()
    var latArray = [String]()
    var locationArray = [String]()
    
    
    @IBOutlet weak var userView: UIView!
    
    @IBOutlet weak var lbl_userLocation: UILabel!
    
    var currentLocationStr = ""
    var locationManager:CLLocationManager!
    var userLat = NSNumber()
    var userLong = NSNumber()
    
    var salonIdArray = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchBar_textF.setLeftPaddingPoints(40)
        lbl_userName.text = "\(UserDefaults.standard.object(forKey: "name") ?? "Hello")"
        lbl_userLocation.adjustsFontSizeToFitWidth = true
        lbl_userFullLocation.adjustsFontSizeToFitWidth = true
        userView.layer.borderWidth = 1
        userView.layer.borderColor = UIColor.gray.cgColor
        getCurrentLocation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(UPDATE_PROFILE), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(UPDATE_LOCATION), object: nil)
        getTopServices()
        // getNearBySalon()
        //getOffers()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        lbl_userName.text = "\(UserDefaults.standard.object(forKey: "name") ?? "Hello")"
        lbl_userFullLocation.text = "\(UserDefaults.standard.object(forKey: UPDATE_LOCATION) ?? "N/A")"
    }
    
    
    
    @IBAction func btnAction_ViewAllTopServices(_ sender: Any) {
        if topServicesDataArray.count > 0 {
            let topServices_VC = self.storyboard?.instantiateViewController(withIdentifier: "TopServicesViewAllViewController") as! TopServicesViewAllViewController
            topServices_VC.getTopServicesDataArray = topServicesDataArray
            self.navigationController?.pushViewController(topServices_VC, animated: true)
        }
        else{
            print("NO DATA")
        }
       
    }
    
    @IBAction func btnAction_ViewAllAroundYou(_ sender: Any) {
        if nearByDataArray.count > 0 {
            let around_VC = self.storyboard?.instantiateViewController(withIdentifier: "AroundYouViewAllViewController") as! AroundYouViewAllViewController
            around_VC.getNearByDataArray = nearByDataArray
           
            self.navigationController?.pushViewController(around_VC, animated: true)
        }
        else{
            print("NO DATA")
          
        }
       
    }
    
    @IBAction func btnAction_ViewAllOffers(_ sender: Any) {
    }
    
    @IBAction func btnAction_changeLocation(_ sender: Any) {
        let changeLocation_VC = self.storyboard?.instantiateViewController(withIdentifier: "ChangeLocationViewController") as! ChangeLocationViewController
        //salonDetail_VC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(changeLocation_VC, animated: true)
        
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
                        self.salonIdArray = []
                        for i in 0...dataDict.count-1 {
                            print(i)
                            if let salonId = dataDict[i]["id"] as? Int {
                                print("SALON IDs == \(salonId)")
                                
                                self.salonIdArray.append(salonId)
                            }
                        }
                        print("SALON ID ARRAY ==> \(self.salonIdArray) == Count ===> \(self.salonIdArray.count)")
                        print("Salon Count == \(self.nearByDataArray.count)")
                        self.aroundYou_CollectionView.reloadData()
                        self.getOffers(withSalonIds: self.salonIdArray)
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
    
    
    func getTopServices() {
        // supportingfuction.showProgressHud("Please Wait...", labelText: "Getting Data!")
        let url = BASE_URL + GET_TOP_SERVICES
        print(url)
        let manager = AFHTTPSessionManager()
        
        manager.get(url, parameters: nil, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                print(dict)
                
                
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                    
                    if let dataDict = dict["data"] as? [[String: Any]] {
                        print("GET TopServices DATA = \(dataDict)")
                        
                        self.topServicesDataArray = dataDict
                        self.topServices_CollectionView.reloadData()
                    }
                }
                else
                {
                    
                    
                    
                }
            }
            //            //temp
            //            supportingfuction.hideProgressHudInView()
            //            if let dict = responseObject as? NSArray{
            //                supportingfuction.hideProgressHudInView()
            //                print(dict)
            //                self.topServicesDataArray = dict as! [[String : Any]]
            //                self.topServices_CollectionView.reloadData()
            //
            //            }
        }, failure: {
            (operation, error) in
            supportingfuction.hideProgressHudInView()
            print("Error: " + error.localizedDescription)
            
        })
        
    }
    
    func getOffers(withSalonIds:[Int]) {
         supportingfuction.showProgressHud("Please Wait...", labelText: "Getting Data!")
        print("Salon IDS ==>>>> \(withSalonIds)")
        let url = BASE_URL + GET_OFFERS
        print(url)
        let manager = AFHTTPSessionManager()
        let salon_ids = ["salon_ids":[4,5]]
        manager.get(url, parameters: salon_ids, progress: nil, success: {
            (operation, responseObject) in
            if let dict = responseObject as? NSDictionary {
                supportingfuction.hideProgressHudInView()
                print(dict)
                
                
                let str = dict["success"] as? Int
                if (str == 1) {
                    print("ok")
                    
                    if let dataDict = dict["data"] as? [[String: Any]] {
                        print("GET Offers DATA = \(dataDict)")
                        
                        self.offersDataArray = dataDict
                        
                        
                        
                        for i in 0...dataDict.count-1 {
                            print(i)
                            if let locationArray = dataDict[i]["latlng"] as? [String:Any] {
                                // print("Location Array == \(locationArray)")
                                if let lon = locationArray["longitude"] as? String {
                                    print("Lon \(lon)")
                                    self.lonArray.append(lon)
                                }
                                if let lat = locationArray["latitude"] as? String {
                                    print("Lat \(lat)")
                                    self.latArray.append(lat)
                                }
                                
                                
                                
                            }
                            
                            if let latValue = Double(self.latArray[i]) , let longValue =  Double(self.lonArray[i]){
                                let latInt = NSNumber(value:latValue)
                                let longInt =  NSNumber(value:longValue)
                                
                                
                                
                                var completeLocation = ""
                                let geoCoder = CLGeocoder()
                                let location = CLLocation(latitude: CLLocationDegrees(truncating: latInt), longitude: CLLocationDegrees(truncating: longInt))
                                geoCoder.reverseGeocodeLocation(location, completionHandler:
                                                                    {
                                                                        placemarks, error -> Void in
                                                                        
                                                                        
                                                                        
                                                                        // Second Method
                                                                        var addressArray = [String]()
                                                                        if let mPlacemark = placemarks{
                                                                            if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                                                                                if let fullAddress = dict["FormattedAddressLines"] as? [String]{
                                                                                    for i in 0...fullAddress.count-1 {
                                                                                        addressArray.append(fullAddress[i])
                                                                                    }
                                                                                    
                                                                                }
                                                                            }
                                                                        }
                                                                        print("NEW METHOD == \(addressArray)")
                                                                        
                                                                        // Place details
                                                                        guard let placeMark = placemarks?.first else { return }
                                                                        // City
                                                                        if let city = placeMark.subLocality {
                                                                            print(city)
                                                                            completeLocation = "\(city)"
                                                                        }
                                                                        
                                                                        //State
                                                                        if let stateName = placeMark.administrativeArea {
                                                                            print(stateName)
                                                                            completeLocation = "\(completeLocation), \(stateName)"
                                                                        }
                                                                        print(completeLocation)
                                                                        
                                                                        // self.currentLocationStr = completeLocation
                                                                        self.locationArray.append(completeLocation)
                                                                        
                                                                        
                                                                    })
                                
                                
                            }
                            
                            
                        }
                        print("ALL LOCATION == \(self.locationArray)")
                    }
                    self.offers_CollectionView.reloadData()

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
    
    
    func getLocationName(lat: NSNumber , long: NSNumber)
    {
        let uLat = lat as NSNumber
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 4
        _ = formatter.string(from: uLat)
        
        let uLong = long as NSNumber
        let formatter1 = NumberFormatter()
        formatter1.maximumFractionDigits = 4
        formatter1.minimumFractionDigits = 4
        _ = formatter1.string(from: uLong)
        
        print("\(uLat),\(uLong)")
        var completeLocation = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: CLLocationDegrees(truncating: lat), longitude: CLLocationDegrees(truncating: long))
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
                                                placemarks, error -> Void in
                                                
                                                
                                                
                                                // Second Method
                                                var addressArray = [String]()
                                                if let mPlacemark = placemarks{
                                                    if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                                                        if let fullAddress = dict["FormattedAddressLines"] as? [String]{
                                                            for i in 0...fullAddress.count-1 {
                                                                addressArray.append(fullAddress[i])
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                                print("NEW METHOD == \(addressArray)")
                                                if UserDefaults.standard.object(forKey: UPDATE_LOCATION) == nil{
                                                self.lbl_userFullLocation.text = addressArray.joined(separator: ", ")
                                                }
                                                else{
                                                    
                                                    self.lbl_userFullLocation.text = "\(UserDefaults.standard.object(forKey: UPDATE_LOCATION) ?? "N/A")"
                                                    
                                                }
                                                // Place details
                                                guard let placeMark = placemarks?.first else { return }
                                                // City
                                                if let city = placeMark.subAdministrativeArea {
                                                    print(city)
                                                    completeLocation = "\(city)"
                                                }
                                                
                                                //State
                                                if let stateName = placeMark.administrativeArea {
                                                    print(stateName)
                                                    completeLocation = "\(completeLocation), \(stateName)"
                                                }
                                                print(completeLocation)
                                                
                                                self.currentLocationStr = completeLocation
                                                self.lbl_userLocation.text = completeLocation
                                                self.locationArray.append(completeLocation)
                                                
                                                
                                            })
        
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK:- UICollectionView Delegate Methods
    //MARK:-
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch  collectionView {
        case topServices_CollectionView:
            if topServicesDataArray.count > 0
            {
                return topServicesDataArray.count
            }else{
                return 0
            }
        case aroundYou_CollectionView:
            if nearByDataArray.count > 0 {
                return nearByDataArray.count
            }
            else{
                return 0
            }
            
        case offers_CollectionView:
            if offersDataArray.count > 0{
                return offersDataArray.count
            }
            else{
                return 0
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        switch collectionView {
        case topServices_CollectionView:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath)
            //cell.backgroundColor = .green
            // Configure the cell
            let serviceImage : UIImageView = cell.viewWithTag(1) as! UIImageView
            
            let serviceTitle_lbl : UILabel = cell.viewWithTag(2) as! UILabel
            let places_lbl : UILabel = cell.viewWithTag(3) as! UILabel
            serviceImage.layer.borderWidth = 1
            serviceImage.layer.borderColor = UIColor(named: ACCENT_COLOR)?.cgColor
            serviceImage.layer.cornerRadius = 10
            //serviceTitle_lbl.adjustsFontSizeToFitWidth = true
            if topServicesDataArray.count > 0 {
                if let imgUrl = topServicesDataArray[indexPath.item]["imagepath"]
                {
                    let fileUrl = URL(string: imgUrl as! String)
                    serviceImage.setImageWith(fileUrl!, placeholderImage: UIImage(named: "placeholder"))
                    
                }
                serviceTitle_lbl.text = "\(topServicesDataArray[indexPath.item]["name"] ?? "")"
                places_lbl.text = "\(topServicesDataArray[indexPath.item]["places_count"] ?? "") Places"
            }
            
            //cell.backgroundColor = .blue
            return cell
        case aroundYou_CollectionView:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "aroundCell", for: indexPath)
            
            
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
                
              //  ratingView.rating = nearByDataArray[indexPath.item]["ratings"] as! Double
                rating_lbl.text = "\(nearByDataArray[indexPath.item]["ratings"] ?? "").0"
            }
            return cell
        case offers_CollectionView:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "specialCell", for: indexPath)
            
            //let offerImage : UIImageView = cell.viewWithTag(1) as! UIImageView
            let offerSalonName : UILabel = cell.viewWithTag(2) as! UILabel
            let offerSalonLocation : UILabel = cell.viewWithTag(3) as! UILabel
            let offerExpiryDate : UILabel = cell.viewWithTag(4) as! UILabel
            let offerDiscount : UILabel = cell.viewWithTag(6) as! UILabel
            let btnView : UIButton = cell.viewWithTag(5) as! UIButton
            btnView.layer.cornerRadius = 20
            btnView.layer.maskedCorners = [.layerMinXMinYCorner]
            
            if offersDataArray.count > 0{
                offerSalonName.text = "\(offersDataArray[indexPath.item]["title"] ?? "")"
                
//                if locationArray.count > 0{
//                    offerSalonLocation.text = "\(locationArray[indexPath.item])"
//                }
                offerExpiryDate.text = "\(offersDataArray[indexPath.item]["expiry_date"] ?? "")"
                offerDiscount.text = "\(offersDataArray[indexPath.item]["discount"] ?? "") %"
                
            }
            
            return cell
        default:
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case topServices_CollectionView:
            print(indexPath.item)
        case aroundYou_CollectionView:
            let salonDetail_VC = self.storyboard?.instantiateViewController(withIdentifier: "SalonDetailsViewController") as! SalonDetailsViewController
            salonDetail_VC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(salonDetail_VC, animated: true)
        case offers_CollectionView:
            print(indexPath.item)
        default:
            print(indexPath.item)
        }
        
        
        // self.present(salonDetail_VC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case topServices_CollectionView:
            return CGSize(width: 100, height: 120)
        case aroundYou_CollectionView:
            return CGSize(width: 300, height: 240)
        case offers_CollectionView:
            return CGSize(width: 320, height: 220)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
extension HomeViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        print("Rating = \(ratingView.rating)")
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        print("Rating F = \(ratingView.rating)")
        
    }
    
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        //Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        userLat = userLocation.coordinate.latitude as NSNumber
        userLong = userLocation.coordinate.longitude as NSNumber
        getLocationName(lat: userLat, long: userLong)
        getNearBySalon(latitude: userLat, longtitude: userLong, range: "500")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
}
