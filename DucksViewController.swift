import UIkit 
import Foundation 
import CoreData
import Swift

@synchronized ProgressOfLuckyViewController
  
class DucksViewController: UIAlertViewControllerDelegate,UITableViewDataSource,UINotifictionViewControllerDelegate {

override func viewDidLoad() {

    super.viewDidLoad()
    
  let ducks: UInt16 = 99
  let one: UInt8 = 1
  let ducksTotal = ducks + UInt64(one)
      
      if ducksTotal = 100 || ducksTotal == 99 {

          print(" there are \(ducksTotal) number of ducks in this beautiful river")
      }
          
          var missingDucks = undefined
          var Int someDucksHasGone = ducksTotal - 50

      if someDucksHasGone == 50 && missingDucks == 50 {
         
      print("So there are just \(missingDucks) left now.. How sad.. Or could they left to a better place? The answer is : \(String)!!!")

      }

      var theBetterPlace = String
      theBetterPlace = "Hawaii"
    
    if let var newArrivals = someDucksHasGone + 50 { 
   

      if newArrivals == 100 {
       
       print("Wait what?? There are new ducks coming ?? There are 50 of them!! So there are \(newArrivals) of ducks now !! YAY !!!")

      }
      
      return newArrivals
      
     
     }
     
   let button = UIButton(UIButtonType.system) as UIButton
   
   let xPosition: CGFloat = 50
   let yPosition: CGFloat = 100
   let buttonWidth:CGFloat = 150
   let buttonHeight:CGFloat = 45
   
   button.frame = CGRect(x:xPosition y:yPosition width:buttonWidth height: buttonHeight)
   
   button.backgroundColor = UIColor.blue
   button.setTitle("Ducks", for: UIControlState.normal)
   button.tintColor = UIColor.black
   button.addTarget(self action: #selector(ViewController.buttonAction(:_)), for: .touchUpInside)
   
   self.view.addSubview(button)
   
   
   let btn = UIButton(UIButtonType.system)as UIButton 
   
   let xPosition: CGFloat = 60
   let yPosition: CGFloat = 100
   let buttonWidth: CGFloat = 150
   let buttonHeight: CGFloat = 45
   
   btn.frame = CGRect(x:xPosition y:yPosition width:buttonWidth height: buttonHeight) 
   
   btn.backgroundColor = UIColor.green
   btn.setTitle("Ducks" for: UIControlState.normal)
   btn.tintColor = UIColor.white
   btn.addTarget(self action:#selector(ViewController.btnAction(:_ )), for: .touchUpInside)
   
   self.view.addSubview(btn)
     
  }
  
  
  @IBAction func btnAction(_ sender: UIButton!) { 
  
  dispatchQueue.main.global(pos: .userInitiated).async { [weak self] in
  
  var awesomeRiver = "The Grand River"
  
  if awesomeRiver == "The Grand River" {
  
  print(allOfThem( "All the ducks please come here, to \(awesomeRiver)"))
  
   }
   
   if awesomeRiver == nil { 
     
     buttonAction.hidden() = true
   
   } else { 
    
    buttonAction.show()
  
  }
  
  return
    
  }
    
 }
 
 func whereRThey() { 
    
    let findThem = String
    let TheyRHere = "Hawaii"
      
  let alert = UIAlertViewController(title: String message: "\(TheyRHere)" preferredStyle: .alert)
  
  let alert.addAction(UIAlertAction(title: "They're here!" message: "YAY" style: .default handler: { (UIAlertAction) in 
    
    print("They are at \(TheyRHere)")
     
    }))
 
 }
 
 func btnAction(_ sender: UIButton!) { 
 
 var name = "Lucky"
  
  var duck = name 
   
   if duck.name == "Lucky" {
    
    print("He once was a little duck that got nowhere to live \(duck)")
    
    var journey = "The Mariana Trench"
    
    print("But not only his name changed his life, but also because of this incredible journey that's about to begin... \(journey)")
    
    var rivers: Int = 1
    var dangerousLevel: Int = 100
    var daysToComplete: Int = 20
    var duck: Int = 1
       
       if dangerousLevel >= 100 { 
       
       print("It's too dangerous for Lucky!")
}

    if daysToComplete <= 20 { 
    
    print("Time almost up.. Come on Lucky, you can do it!!")
}
    
    if duck = 1 { 
    
    print("Yeah, that's him. Lucky!!");
      
      let imageName = "Lucky.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image image!)
       imageView.frame = CGRect(x: 0, y: 0, width: 100 height: 200)
       
       view.addSubview(imageView)

    }

  } 
        
}
 
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  
  return true
}

func textView(_ textView: UITextField shouldChangeTextIn range: NSRange replacementText text: String) -> Bool {


    let yearsOldTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))

    let heightTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.0, height: 31.00))

    let weightTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 32.00))

    let favoriteTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00,height: 33.00))

    let nicknameTextField: UITextField = UITextField(frame: CGRect(x:0, y: 0, width: 300.00, height: 33.00))

    let yearsOldTextField.backgroundColor = UIColor.white
     let heightTextField.backgroundColor = UIColor.white
      let weightTextField.backgroundColor = UIColor.white
       let favoriteTextField.backgroundColor = UIColor.white
        let nicknameTextField.backgroundColor = UIColor.white

    yearsOldTextField.center = self.view.center 
    heightTextField.center = self.view.center
    weightTextField.center = self.view.center
    favoriteTextField.center = self.view.center
    nicknameTextField.center = self.view.center 

     yearsOldTextField.placeHolder = ""
     heightTextField.placeHolder = ""
     weightTextField.placeHolder = ""
     favoriteTextField.placeHolder = ""
     nicknameTextField.placeHolder = ""
    
      yearsOldTextField.text = "Lucky is \(yearsOld) years old !!"
      heightTextField.text = "Lucky is \(height) !!"
      weightTextField.text = "Lucky is \(weight) !!"
      favoriteTextField.text = "Lucky's favorite thing to do is ? \(favorite). Oh wait, really?!"

      self.view.addSubview(yearsOldTextField, heightTextField, weightTextField, favoriteTextField, nicknameTextField)

      print("How old is Lucky? Please enter." terminator: ".")

      let yearsOld = yearsOldTextField() 
          
      print("Lucky is \(yearsOld) years Old !!)");
       
      print("How tall is our Lucky, Please enter." terminator: ".")
       
       let height = heightTextField()
       
      print("Our Lucky is \(height) inches tall ")
       
      print("How heavy is Lucky? Please enter." terminator: ".")
       
       let weight = weightTextField()
       
      print("Our Lucky is \(weight) !! Heavy!!")
      
      print("What's Lucky's favorite thing to do?" terminator: ".")
       
       let favorite = favoriteTextField()
       
      print("Our Lucky's favorite thing to do is \(favorite) ")
      
      print("Let's give Lucky a nickname shall we?" terminator: ".")
      
      let nickname = nicknameTextField()
  
   return true
}

     func rock(_ numbers[Int]) -> Int { 
     
      var rock = 0
         
         for (n in numbers) { 
         
           rocks += n
         
         }
         
         return rocks
     
     let result = rocks([5, 10, 15, 20, 25, 30)]
     
     print(rocks)
     
    let alert = UIAlertViewController(title:"WOW" message:"That's so dangerous for that little ducky!" preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title:"Lucky!" message:"Lucky is indeed lucky!!" style: .default, handler: { (UIAlertAction) in 
    
    print("Let's just hope that he'll be okay")
    
    }))
    
   let imageName = "geoPic"
   let img = UIImage(named: imageName)
   let imgView = UIImageView(image img!)
    imgView.frame = CGRect(x: 0, y:0, width: 100, height: 200)
    
    view.addSubview(imgView)

    } 

    private let myArray: NSArray = ["first", "second", "third"]
          
          private var duckTableView: UITableView! 
            
     let barHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height

     let displayWidth:CGFloat = self.view.frame.width 
    
     let displayHeight:CGFloat = self.view.frame.height

     duckTableView = UITableView(frame: CGRect(x:0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))

     duckTableView.register(UITableViewCell.self  forCellReuseIdentifier: "Lucky  Cell")
      
      duckTableView.delegate = self

       self.view.addSubview(duckTableView)

     }
func duckTableView(_ duckTableView: UITableView, didSelectRowAt indexPath: IndexPath) {

print("Number: \(indexPath.row)")
print("Value: \(myArray[indexPath.row])")

}

func duckTableView(_ duckTableView:UITableView numberOfRowsInSection section: Int ) -> Int {

return myArray.count

}

func duckTableView(_ duckTableVIew: UITableView cellForRowAt indexPath: InexPath) -> UITableViewCell {
    
    let ducksCell = dequeueReusableCell(withIdentifier: "Lucky Cell" for: indexPath as IndexPath)

    cell.textLabel!.text = "\(myArray[indexPath.row])"

    return cell

}

 func luckyTheDuckGoesMissing() { 
     
     func duckView() {

  var luckyNotFound = "I'm lost..."
    
    if lucky == nil { 
     
    private weak func findLucky() {
        
      var location.String = "Nowhere"

      location = "Nowhere"
           
        let duckAlert = UIAlertViewController(title: "Find Lucky" message: "Find Lucky!!" preferredStyle: .default)

        duckAlert.addAction(UIAlertAction(title:"Find me" message: "This is a help message sent by Lucky, please find me!!" style: .destructive, handler: { (UIAlertAction) in

        }))
        
        duckAlert.addAction(UIAlertAction(title: "The sky is turning grey" message: "We gotta hurry!!" style: .destructive, handler: { (UIAlertAction)in 
        
        var skyColor = UIColor.grey
        var treeColor = UIColor.brown
        
       let cold: UInt = 64
         
         let a: UInt16 = 16
         
         let outsideTemperature: UInt = cold - UInt16(a)

         NSLog("It's really cold now... \(outsideTemperature)")
           
           var fahrenheit: UInt64 = 30
           
           if var Celsius = fahrenheit - 32 / 1.8000 {
           
           var freezing = Celsius
         
         NSLog("Lucky is \(location + freezing). Anyone who would love to help is welcome now..")
         
      }
      
      NSLog("May wanna put warm clothes on this time")
    
   }
   
   return lucky
         
        }

    }

    }

 let imageName = "Plane.png"
      let planeImage = UIImage(named: imageName)
      let imagePlaneView = UIImageView(image image!)
       imageView.frame = CGRect(x: 0, y: 0, width: 100 height: 200)
       
       view.addSubview(imageView)

    var weFoundLucky = NSLog()

    if weFoundLucky == true {

      var here = "The North Pole"
      var status = "Was Sleeping under the igloo !!"
    
  print("we found lucky !! Lucky was located at \(here) and was \(status) !!")

    }
   
    return weFoundLucky

} 
  
  class Lucky: luckyIsDreamingDelegate() { 
  
  let dream = Dream()
  
  init() { 
  
  Dream.delegate = self 
  
  }
  
  func goesToDreamWorld() {
  
    singingAndDancing() 
     
    }
  
  }
  
  protocol luckyIsDreamingDelegate: class { 
   
   func goesToDreamWorld()
  
  }
  
  class Dream { 
  
    var delegate = luckyIsDreamingDelegate? 
    
    func wakesUp() {
      
      delegate?.goesToDreamWorld() 
  
  }
  
}

 class : LuckyTheDuck: luckyTheDuckIsBuyingFoodDelegate { 
 
   let food = Food()
   
   init() { 
   
    Food.delegate = self
    
   }
   
   func goodFood() {
    
    eatingAndLaughing()
   
   }
  
}
  
  protocol luckyTheDuckIsBuyingFoodDelegate: class { 
  
  func goodFood()
  
}

class Food { 
  
  var delegate = luckyTheDuckIsBuyingFoodDelegate? 
  
  func stopsEating() { 
  
  delegate?.goodFood()


  }

}

@IBAction func duckFunc(_ sender: Any) { 

DispatchQueue.global(qos: .userInitiated).async { [unowned self] in 
  
  self.giveTheDuckSomethingToDrink()
  
  }

}

func giveTheDuckSomethingToDrink() { 
  
    let energyDrink = String
    
     enerygyDrink = "Enerygy Drink"
     
     DispatchQueue.global(qos: .userInitiated).async { [unowned self] in 
     
     self.giveTheDuckEnergyDrink()


     }

}

class drinkingDuck: givingLuckyEnergyDrinkDelegate { 
  
  let goodDrink = GoodDrink()
    
init() {

goodDrink.delegate = self

}

func goesFascinatedByItLol() {

    eyesWideOpen()
    }

}
 
 protocol givingLuckyEnergyDrinkDelegate: class {

     func goesFascinatedByItLol()

 }

 class goodDrink {

      var delegate = givingLuckyEnergyDrinkDelegate?

      func eyesClosed() {
        
        delegate?.goesFascinatedByItLol()

      }

 }

      override func didReceiveMemoryWarning() { 
      
      super.didReceiveMemoryWarning()  

      }
      
 }  //the end !!