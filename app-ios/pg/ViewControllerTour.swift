import Foundation
import UIKit

class ViewControllerTour: UITableViewController
{
     var selectedArtworkPointer:Int = 0
     var jsonFileToLoad:String = ""
     var tourSetData:Array<TourArtwork> = []
    
    override  func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        loadTourData()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    
    override  func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override  func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override  var prefersStatusBarHidden : Bool
    {
        return true
    }
    
    override  func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        if (segue.identifier == "ShowArtworkDetailFromTable")
        {
            let artworkViewController:ViewControllerArtwork = segue.destination as! ViewControllerArtwork
            artworkViewController.artworkTitle = tourSetData[selectedArtworkPointer].artworkDetailviewTitle
            artworkViewController.artworkCaption = tourSetData[selectedArtworkPointer].artworkCaption
            artworkViewController.artworkImagePath = tourSetData[selectedArtworkPointer].artworkImage
            artworkViewController.artworkVideoList = tourSetData[selectedArtworkPointer].artworkVideos
        }
    }
    
    override var shouldAutorotate : Bool
    {
        return true;
    }

    
    override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 88
    }
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tourSetData.count
    }
    
    override  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell:ViewControllerTourCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! ViewControllerTourCell
        let title = "<span style=\"font-size: 17px;font-weight:lighter;font-family:Avenir-Book;\">" + tourSetData[(indexPath as NSIndexPath).row].artworkTableviewTitle + "</span>"
        tableViewCell.cellLabel.attributedText = title.html2AttStr
        
        
        tableViewCell.cellImage.image = UIImage(named: tourSetData[(indexPath as NSIndexPath).row].artworkThumbnail)
        tableViewCell.layoutMargins = UIEdgeInsets.zero
        return tableViewCell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedArtworkPointer = (indexPath as NSIndexPath).row
        self.performSegue(withIdentifier: "ShowArtworkDetailFromTable", sender: self)
    }
    
     func loadTourData()
    {
        var hasLoadedMetaFromFirstIndex = false
        let path = Bundle.main.path(forResource: jsonFileToLoad, ofType: "")
        print(jsonFileToLoad)
        
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
                if(hasLoadedMetaFromFirstIndex)
                {
                    let foundArtworkTableTitle:String = json["Artwork Tableview Title"] as! String
                    let foundArtworkDetailViewTitle:String = json["Artwork Detail Title"] as! String
                    let foundArtworkThumbnail:String = json["Artwork Thumbnail"] as! String
                    let foundArtworkImage:String = json["Artwork Image"] as! String
                    let foundArtworkCaption:String = json["Artwork Caption"] as! String
                    var foundArtworkVideos:[TourArtworkVideo] = []
                    if let videos = json["Artwork Videos"] as? [[String:AnyObject]]
                    {
                        for video in videos
                        {
                            foundArtworkVideos.append(TourArtworkVideo(videoTitle: video["Video Title"] as! String, videoFilePath: video["Video File"] as! String))
                        }
                    }
                    tourSetData.append(TourArtwork(artworkTitle: foundArtworkTableTitle, artworkDetailTitle: foundArtworkDetailViewTitle, artworkThumbnail: foundArtworkThumbnail, artworkImage: foundArtworkImage, artworkCaption: foundArtworkCaption, artworkVideos: foundArtworkVideos))
                }
                else
                {
                    self.navigationItem.title = json["Exhibition Title"] as? String
                    hasLoadedMetaFromFirstIndex = true
                }
            }
        }
    }
}
