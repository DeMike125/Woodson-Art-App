import Foundation
import UIKit

class ViewControllerTourGallery : UICollectionViewController
{
    var jsonFileToLoad:String = String()
    fileprivate let reuseIdentifier = "GalleryCell"
    fileprivate let cellSize = 135
    fileprivate let cellSizePad = 300
    fileprivate let sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    fileprivate let sectionInsetsPad = UIEdgeInsets(top: 32.0, left: 32.0, bottom: 32.0, right: 32.0)
    fileprivate var artwork:Array<TourArtwork> = []
    fileprivate var selectedIndex:Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadTourDataFromJson()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        if (segue.identifier == "ShowArtworkDetail")
        {
            let artworkViewController:ViewControllerArtwork = segue.destination as! ViewControllerArtwork
            artworkViewController.artworkTitle = artwork[selectedIndex].artworkDetailviewTitle
            artworkViewController.artworkCaption = artwork[selectedIndex].artworkCaption
            artworkViewController.artworkImagePath = artwork[selectedIndex].artworkImage
            artworkViewController.artworkVideoList = artwork[selectedIndex].artworkVideos
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return artwork.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ViewControllerTourGalleryCell
        cell.imageView.image = UIImage(named: artwork[(indexPath as NSIndexPath).row].artworkThumbnail)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedIndex = (indexPath as NSIndexPath).row
        self.performSegue(withIdentifier: "ShowArtworkDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            return CGSize(width: cellSize, height: cellSize)
        }
        else {
            return CGSize(width: cellSizePad, height: cellSizePad)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        {
            return sectionInsetsPad
        }
        else
        {
            return sectionInsets
        }
    }
    
    func loadTourDataFromJson()
    {
        var hasLoadedMetaFromFirstIndex = false
        let path = Bundle.main.path(forResource: jsonFileToLoad, ofType: "")

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

        
        
        self.artwork = []
        if rootJsonArray is NSArray
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
                    self.artwork.append(TourArtwork(artworkTitle: foundArtworkTableTitle, artworkDetailTitle: foundArtworkDetailViewTitle, artworkThumbnail: foundArtworkThumbnail, artworkImage: foundArtworkImage, artworkCaption: foundArtworkCaption, artworkVideos: foundArtworkVideos))
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
