import Foundation
import UIKit
import AVKit
import AVFoundation

class ViewControllerArtwork: UIViewController, UITableViewDelegate, UITableViewDataSource
    
{
    @IBOutlet var artworkVideoTable:UITableView!
    @IBOutlet var artworkImageView:UIImageView!
    @IBOutlet var artworkCaptionView:UILabel!
    var artworkTitle:String = String()
    var artworkImagePath:String = String()
    var artworkCaption:String = String()
    var artworkVideoList:[TourArtworkVideo] = []
    var selectedIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        artworkVideoTable.tableFooterView = UIView(frame: CGRect.zero)
        artworkVideoTable.dataSource = self;
        artworkVideoTable.delegate = self;
        artworkVideoTable.separatorInset = UIEdgeInsets.zero
        artworkVideoTable.layoutMargins = UIEdgeInsets.zero
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.title = artworkTitle
        
        
        let title = "<center><span style=\"font-size: 17px;font-weight:lighter;font-family:Avenir-Book;\">" + artworkCaption + "</span></center>"
        artworkImageView.image = UIImage(named: artworkImagePath)
        
        artworkCaptionView.attributedText = title.html2AttStr
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return artworkVideoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view:UIView = UIView()
        view.backgroundColor = UIColor.black
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell:UITableViewCell? = self.artworkVideoTable.dequeueReusableCell(withIdentifier: "Cell")
        tableViewCell!.layoutMargins = UIEdgeInsets.zero
        tableViewCell?.textLabel?.text = artworkVideoList[(indexPath as NSIndexPath).row].videoTitle
        return tableViewCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndex = (indexPath as NSIndexPath).row
        videoController.playVideo(self, navn: artworkVideoList[selectedIndex].videoFilePath, type: String())
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
