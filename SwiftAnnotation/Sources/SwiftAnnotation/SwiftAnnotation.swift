import Foundation

class SwiftAnnotation: NSObject  {
    
    #warning("annotation")
    func hookedFunc() {
        
        print("this is a hookedFunc")
    }
    
    // annotation: myAnnotation
    func commitHookedFunc() {
        
        print("this is a commitHookedFunc")
    }
}
