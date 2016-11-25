import Foundation
import UIKit
import MediaPlayer

extension String
{
    var html2AttStr:NSAttributedString
    {
        let contents: NSMutableAttributedString?
            
            
            
        do {
            let attrTextStyle = NSMutableParagraphStyle()
            attrTextStyle.alignment = NSTextAlignment.center
            contents = try NSMutableAttributedString(data: data(using: String.Encoding.utf8)!, options:[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8], documentAttributes: nil)
        } catch _ {
            contents = nil
        }
        
        
        
        return NSAttributedString(attributedString: contents!)
    }
}
