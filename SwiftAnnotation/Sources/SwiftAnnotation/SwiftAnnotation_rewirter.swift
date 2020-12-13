import Foundation

class SwiftAnnotation: NSObject  {
    
    #warning("annotation")
    func hookedFunc() {
	print("before __format__")
        
        print("this is a hookedFunc") 
	print("after __format__")
    }
    
    // annotation: myAnnotation
    func commitHookedFunc() {
	print("before myAnnotation")
        
        print("this is a commitHookedFunc") 
	print("after myAnnotation")
    }
}
