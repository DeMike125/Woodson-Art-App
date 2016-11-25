import Foundation

class Tour
{
    var tourCoverPhoto:String
    var tourBeginButtonText:String
    var tourBeginButtonLink:String
    var tourDisplayType:TourDisplayType
    
    init(tourCoverPhoto:String, tourBeginButtonText:String, tourBeginButtonLink:String, tourDisplayType:TourDisplayType)
    {
        self.tourCoverPhoto = tourCoverPhoto
        self.tourBeginButtonText = tourBeginButtonText
        self.tourBeginButtonLink = tourBeginButtonLink
        self.tourDisplayType = tourDisplayType
    }
}