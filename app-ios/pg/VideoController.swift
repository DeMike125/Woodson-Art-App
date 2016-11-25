import Foundation
import UIKit
import MediaPlayer
import AVKit

class VideoControllerView : AVPlayerViewController
{
    override var shouldAutorotate : Bool
    {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.allButUpsideDown
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return true
    }
}


class VideoController : NSObject
{
    func playVideo(_ view:UIViewController, navn:String, type:String)
    {
        let path = Bundle.main.path(forResource: navn, ofType: type)
        let videoURL = URL(fileURLWithPath: path!)
        
        let player = AVPlayer(url: videoURL as URL)
        player.play()
    }
}
