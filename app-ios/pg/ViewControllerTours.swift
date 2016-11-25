import Foundation
import UIKit

class ViewControllerTours: UITableViewController
{
    var tourSetPointer = 0
    var tourSetData:Array<Tour> = []
    var tourSetSelectedLink:String = String()
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addBackButton()
        loadTourData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        if (segue.identifier == "ExhibitionView")
        {
            let tourViewController:ViewControllerTour = segue.destination as! ViewControllerTour
            tourViewController.jsonFileToLoad = tourSetSelectedLink
        }
        else if(segue.identifier == "ExhibitionViewGrid")
        {
            let tourViewController:ViewControllerTourGallery = segue.destination as! ViewControllerTourGallery
            tourViewController.jsonFileToLoad = tourSetSelectedLink
        }
    }
    
    override var shouldAutorotate : Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        {
            return UIInterfaceOrientationMask.allButUpsideDown
        }
        else
        {
            return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.portraitUpsideDown]
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return tableView.frame.height / 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tourSetData.count
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell:ViewControllerToursCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! ViewControllerToursCell
        let tableViewCellBackgroundImage = UIImage(named: tourSetData[(indexPath as NSIndexPath).row].tourCoverPhoto)
        let tableViewCellBackgroundImageView = UIImageView(image: tableViewCellBackgroundImage)
        tableViewCellBackgroundImageView.clipsToBounds = true
        tableViewCellBackgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
        tableViewCell.backgroundView = tableViewCellBackgroundImageView
        tableViewCell.button.setTitle(tourSetData[(indexPath as NSIndexPath).row].tourBeginButtonText, for: UIControlState())
        tableViewCell.button.addTarget(self, action: #selector(ViewControllerTours.tourButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        tableViewCell.button.tag = (indexPath as NSIndexPath).row
        return tableViewCell
    }
    
    func isNumeric(_ a: String) -> Bool {
        return Int(a) != nil
    }
    
    func tourButtonClicked(_ sender: UIButton)
    {
        let indexPathRow = sender.tag
        let indexPathRowLink = tourSetData[indexPathRow].tourBeginButtonLink
        if isNumeric(indexPathRowLink)
        {
            let tourSelectorViewController = self.storyboard?.instantiateViewController(withIdentifier: "TourSelector") as? ViewControllerTours
            tourSelectorViewController!.tourSetPointer = Int(indexPathRowLink)!
            self.navigationController?.pushViewController(tourSelectorViewController!, animated: true)
        }
        else
        {
            self.tourSetSelectedLink = indexPathRowLink
            if tourSetData[indexPathRow].tourDisplayType == TourDisplayType.tableView
            {
                self.performSegue(withIdentifier: "ExhibitionView", sender: self)
            }
            else if tourSetData[indexPathRow].tourDisplayType == TourDisplayType.gridView
            {
                self.performSegue(withIdentifier: "ExhibitionViewGrid", sender: self)
            }
            else
            {
                print("Invalid display type for segue")
            }
        }
    }
    
    func backButtonClicked(_ sender: UIButton)
    {
    _ = self.navigationController?.popViewController(animated: true)
    }
    
    func loadTourData()
    {
        let path = Bundle.main.path(forResource: "Tours", ofType: "json")
  
        let text: String?
        do {
            text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch _ {
            text = nil
        }
        
        
        let rootJsonArray: Any?
        do {
            rootJsonArray = try JSONSerialization.jsonObject(with: text!.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions(rawValue: 0))
        } catch _ {
            rootJsonArray = nil
        }
        
        self.tourSetData = []
        if rootJsonArray is [[String:AnyObject]]
        {
            for json in rootJsonArray as! [[String:AnyObject]]
            {
                if (json["id"] as! Int) == tourSetPointer
                {
                    if let tours = json["content"] as? [[String:AnyObject]]
                    {
                        for tours in tours
                        {
                            let image:String = tours["image"] as! String
                            let link:String = tours["link"] as! String
                            let button:String = tours["button"] as! String
                            let displayType:String = tours["Display Type"] as! String
                            if displayType == "Grid"
                            {
                                tourSetData.append(Tour(tourCoverPhoto: image, tourBeginButtonText: button, tourBeginButtonLink: link, tourDisplayType: TourDisplayType.gridView))
                            }
                            else if displayType == "Table"
                            {
                                tourSetData.append(Tour(tourCoverPhoto: image, tourBeginButtonText: button, tourBeginButtonLink: link, tourDisplayType: TourDisplayType.tableView))
                            }
                            else
                            {
                                tourSetData.append(Tour(tourCoverPhoto: image, tourBeginButtonText: button, tourBeginButtonLink: link, tourDisplayType: TourDisplayType.none))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addBackButton()
    {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 65, height: 35))
        button.setTitle("Back", for: UIControlState())
        button.setBackgroundImage(UIImage(named: "Button.png"), for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.alpha = 0.75
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 17)
        button.addTarget(self, action: #selector(ViewControllerTours.backButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        self.view.bringSubview(toFront: button)
    }
}
