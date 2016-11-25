import UIKit
import MapKit

class ViewControllerInformation: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView?
    
    override func viewDidLoad()
    {
        if let informationMap = mapView
        {
            informationMap.delegate = self
            informationMap.setRegion(MKCoordinateRegionMakeWithDistance(woodsonCoordinates, 2000, 2000), animated: true)
            informationMap.addAnnotation(woodsonCoordinatesPin)
            informationMap.selectAnnotation(woodsonCoordinatesPin, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
    
    override var shouldAutorotate : Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.portraitUpsideDown]
    }
    
    @IBAction func tapCategoryVisit(_ recognizer: UITapGestureRecognizer)
    {
        self.performSegue(withIdentifier: "SegueTapVisit", sender: self)
    }
    
    @IBAction func tapCategoryLearn(_ recognizer: UITapGestureRecognizer)
    {
        self.performSegue(withIdentifier: "SegueTapLearnMore", sender: self)
    }
    
    @IBAction func tapCategoryLocation(_ recognizer: UITapGestureRecognizer)
    {
        self.performSegue(withIdentifier: "SegueTapLocation", sender: self)
    }
    
    @IBAction func tapCategoryHours(_ recognizer: UITapGestureRecognizer)
    {
        self.performSegue(withIdentifier: "SegueTapHours", sender: self)
    }

    @IBAction func tapVideoDirectorWelcome(_ sender: UIButton)
    {
        videoController.playVideo(self, navn: "DirectorsWelcome", type: "mp4")
    }
    
    @IBAction func tapVideoOurStory(_ sender: UIButton)
    {
        videoController.playVideo(self, navn: "OurStory", type: "mp4")
    }
}
