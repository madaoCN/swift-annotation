import Foundation

class SwiftAnnotation: NSObject  {
    
    #warning("annotation")
    func hookedFunc() {
        
        print("this is a hookedFunc")
    }
}
