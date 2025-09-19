// trying ui render but with local images
import UIKit

// loading local images
// couldn't figure out swift doc for this, so used chatgpt for help on this function
func loadImage(named name: String) -> UIImage? {
    let path = Bundle.main.path(forResource: name, ofType: nil)
    if let path = path {
        return UIImage(contentsOfFile: path)
    } else {
        print("Image not found: \(name)")
        return nil
    }
}

// loading two local images
if let image1 = loadImage(named: "marin.JPG"),
   let image2 = loadImage(named: "marin2.jpeg"),
   let image3 = loadImage(named: "marin3.jpeg"),
   let image4 = loadImage(named: "orchids.jpeg") {
    
    // creating 200x200 canvas
    let sz = CGSize(width: 200, height: 200)
    let renderer = UIGraphicsImageRenderer(size: sz)
    
    // compositing images side by side
    let finalImage = renderer.image { context in
        image1.draw(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        image2.draw(in: CGRect(x: 100, y: 0, width: 100, height: 100))
        image3.draw(in: CGRect(x: 0, y: 100, width: 100, height: 100))
        image4.draw(in: CGRect(x: 100, y: 100, width: 100, height: 100))
    }
    
    finalImage
}
