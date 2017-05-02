///
/// ViewController.swift
///

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(crushAd))
    tapGesture.delegate = self
    
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.addGestureRecognizer(tapGesture)
    webView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    webView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    webView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    webView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    getVideo(videoCode: "RmHqOSrkZnk")
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  func animateCrush() {
    let foldHeight = webView.frame.size.height / 8
    for i in 0..<8 {
      let y = webView.frame.minY + foldHeight * CGFloat(i)
      let rect = CGRect(
        x: webView.frame.origin.x,
        y: y,
        width: webView.frame.width,
        height: foldHeight
      )
      
      UIGraphicsBeginImageContext(rect.size)
      webView.drawHierarchy(in: rect, afterScreenUpdates: false)
      let image = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      let imageView = UIImageView(frame: rect)
      imageView.image = image
      view.addSubview(imageView)
    }
    webView.removeFromSuperview()
  }

  func crushAd(_:UITapGestureRecognizer) {
    //replaceVideoWithImage()
    animateCrush()
  }
  
  func replaceVideoWithImage() {
    UIGraphicsBeginImageContext(webView.frame.size)
    webView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    let imageView = UIImageView(frame: webView.frame)
    webView.removeFromSuperview()
    imageView.image = image
    view.addSubview(imageView)
  }
  
  func getVideo(videoCode: String) {
    let youtubeUrl = "https://www.youtube.com/embed/\(videoCode)"
    let htmlString = "<iframe width=\"300\" height=\"200\" src=\"\(youtubeUrl)?playsinline=1&autoplay=1&cc_load_policy=1&controls=0\" framerborder=\"0\"></iframe>"
    webView.loadHTMLString(htmlString, baseURL: nil)
  }
}

