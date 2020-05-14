

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import SVProgressHUD

class mapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var cityString: UILabel!
    @IBOutlet weak var streetString: UILabel!
    @IBOutlet weak var map: MKMapView!
    var cityString2:String = ""
    var streetString2: String = ""
    var lat = ""
    var long = ""
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.streetString.text = self.streetString2
        self.cityString.text = self.cityString2
        
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.map.setRegion(region, animated: true)
        
        self.lat = String(location.coordinate.latitude)
        self.long = String(location.coordinate.longitude)
        
        self.getAddressFromLatLon(pdblLatitude:String(location.coordinate.latitude), withLongitude: String(location.coordinate.longitude))
        
        self.map.showsUserLocation = true
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hideKeyboardWhenTappedAround()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    
    @IBAction func confirm(_ sender: Any) {
        
        
        userSetting.saveLatandLong(lat: self.lat, long: self.long)
        API.addressAPI(title:"Home") {(error:Error?, done: Bool?) in
            
            if  done == true {
                self.performSegue(withIdentifier: "homePage", sender: nil)
                self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                
                self.manager.stopUpdatingLocation()

            }else {
                SVProgressHUD.showError(withStatus:"عذرا, لايمكن اتمام الطلب")
            }
            
            
        }
        
    }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    if pm.locality != nil{
                        self.cityString2 =  pm.locality!
                        userSetting.saveCityLocaion(city: pm.locality!)
                    }
                    if pm.subLocality != nil {
                        self.streetString2 =  pm.subLocality!
                        userSetting.saveStreetLocaion(street: pm.subLocality!)
                    }
                    
                    
                }
        })
        
    }
}






