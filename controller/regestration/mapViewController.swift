

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import SVProgressHUD
import FirebaseCrashlytics


class mapViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate , MKMapViewDelegate{
    
    var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var cityString: UILabel!
    @IBOutlet weak var streetString: UILabel!
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    
    var cityString2:String = ""
    var streetString2: String = ""
    
   // var lat:String = userSetting.getLat() ?? "21.3606920"
   // var long:String = userSetting.getLong() ?? "39.7897930"

     var lat:String = userSetting.getLat() ?? "21.40185484"
     var long:String = userSetting.getLong() ?? "39.80361974"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hideKeyboardWhenTappedAround()
        self.manager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
        
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
          longPressRecogniser.minimumPressDuration = 0.5
          map.addGestureRecognizer(longPressRecogniser)
          map.mapType = MKMapType.standard
          
        
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(NSString(string: self.lat).floatValue),longitude: CLLocationDegrees(NSString(string: self.long).floatValue))
                   
                   let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                   let region = MKCoordinateRegion(center: location, span: span)
                   map.setRegion(region, animated: true)
                   
                   let annotation = MKPointAnnotation()
                   annotation.coordinate = location
                   
                   getAddressFromLatLon(pdblLatitude: lat, withLongitude: long)
                   
                   annotation.title = userSetting.getCityLocation()
                   annotation.subtitle = userSetting.getStreetLocation()
                   
                   map.addAnnotation(annotation)
                   
                   if let coor = map.userLocation.location?.coordinate{
                       map.setCenter(coor, animated: true)
                   }
            
        if CLLocationManager.locationServicesEnabled() {
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }

        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        SVProgressHUD.showInfo(withStatus: "اضغط مطولاً على الخريطة لتحديد الموقع")
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        
      
        
        let location = gestureReconizer.location(in: map)
        let coordinate = map.convert(location,toCoordinateFrom: map)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "latitude:" + String(format: "%.02f",annotation.coordinate.latitude) + "& longitude:" + String(format: "%.02f",annotation.coordinate.longitude)
        
        //Remove annotations
        let annotationsO = self.map.annotations
        self.map.removeAnnotations(annotationsO)
        
        self.lat = "\(annotation.coordinate.latitude)"
        self.long = "\(annotation.coordinate.longitude)"
        
        getAddressFromLatLon(pdblLatitude: self.lat, withLongitude: self.long)
        
        
           print(self.lat)
           print(self.long)
        map.addAnnotation(annotation)
        
    }
    
    
    
    @IBAction func searchButton(_ sender: Any)
    {
        
        manager.stopUpdatingLocation()
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "الغاء"
        
        searchController.searchBar.placeholder = "بحث"
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.tintColor =  UIColor.systemPink
        
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.map.annotations
                self.map.removeAnnotations(annotations)
                
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                self.lat = "\(String(describing: latitude!))"
            
                let longitude = response?.boundingRegion.center.longitude
                self.long = "\(String(describing: longitude!))"
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                
                
                self.getAddressFromLatLon(pdblLatitude: "\(String(describing: latitude!))", withLongitude: "\(String(describing: longitude!))")
                
                
                self.map.showsUserLocation = true
                
                
                self.map.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.map.setRegion(region, animated: true)
            }
            
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if (annotation is MKUserLocation) {
            return nil
        }
        else {
            
            
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
            annotationView.canShowCallout = true
            annotationView.image =  UIImage(named: "location")
            
            return annotationView
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        //Remove annotations
        let annotationsO = self.map.annotations
        self.map.removeAnnotations(annotationsO)
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        map.mapType = MKMapType.standard
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: locValue, span: span)
        map.setRegion(region, animated: true)
        
        self.lat = String(manager.location!.coordinate.latitude)
        self.long = String(manager.location!.coordinate.longitude)
   

        self.getAddressFromLatLon(pdblLatitude:String(manager.location!.coordinate.latitude), withLongitude: String(manager.location!.coordinate.longitude))
        
        manager.stopUpdatingLocation()
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        map.addAnnotation(annotation)
        
    }

    @IBAction func confirm(_ sender: Any) {
        
        userSetting.saveLatandLong(lat: self.lat, long: self.long)
        self.performSegue(withIdentifier: "homePage", sender: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.manager.stopUpdatingLocation()
        
        
    }
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String){
        
        manager.stopUpdatingLocation()
        
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            if let placemark = placemarks?.first {
                
                if placemark.locality != nil{
                    self.cityString.text =  placemark.locality!
                    userSetting.saveCityLocaion(city: placemark.locality!)
                }
                if placemark.subLocality != nil {
                    self.streetString.text =  placemark.subLocality!
                    userSetting.saveStreetLocaion(street: placemark.subLocality!)
                }
                
            }
        })
  
    }
}

