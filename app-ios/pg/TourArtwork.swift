import Foundation

class TourArtwork
{
    var artworkTableviewTitle:String
    var artworkDetailviewTitle:String
    var artworkThumbnail:String
    var artworkImage:String
    var artworkCaption:String
    var artworkVideos:[TourArtworkVideo]
    
    init(artworkTitle:String, artworkDetailTitle:String, artworkThumbnail:String, artworkImage:String, artworkCaption:String, artworkVideos:[TourArtworkVideo])
    {
        self.artworkTableviewTitle = artworkTitle
        self.artworkDetailviewTitle = artworkDetailTitle
        self.artworkThumbnail = artworkThumbnail
        self.artworkImage = artworkImage
        self.artworkCaption = artworkCaption
        self.artworkVideos = artworkVideos
    }
}