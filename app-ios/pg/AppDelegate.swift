import UIKit
import MapKit

let woodsonCoordinates         = CLLocationCoordinate2D(latitude: 44.9620, longitude: -89.6130)
let woodsonCoordinatesPin      = MKPointAnnotation()
let colorPrimary               = UIColor(red: 147.0 / 255.0, green: 140.0 / 255.0, blue: 126.0 / 255.0, alpha:1.0)
let colorSecondary             = UIColor.white
let colorTertiary              = UIColor.black
let primaryFont                = UIFont(name: "Avenir", size: 17)!
let primaryTitleTextAttributes = [NSForegroundColorAttributeName: colorSecondary, NSFontAttributeName: primaryFont]
let videoController:VideoController = VideoController()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        UIBarButtonItem.appearance().setTitleTextAttributes(primaryTitleTextAttributes, for: UIControlState())
        UINavigationBar.appearance().titleTextAttributes = primaryTitleTextAttributes
        UINavigationBar.appearance().barTintColor = colorPrimary
        UINavigationBar.appearance().tintColor = colorSecondary
        UINavigationBar.appearance().barStyle = UIBarStyle.black
        woodsonCoordinatesPin.coordinate = woodsonCoordinates
        woodsonCoordinatesPin.title = "Leigh Yawkey Woodson Art Museum"
        woodsonCoordinatesPin.subtitle = "700 N 12th St, Wausau, WI 54403"
        return true
    }
}
