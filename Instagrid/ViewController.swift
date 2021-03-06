//
//  ViewController.swift
//  Instagrid
//
//  Created by Stéphane Rihet on 04/01/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: - Properties
    private var numberButton = 1
    private var imagePicker = UIImagePickerController()
    private var swipe = UISwipeGestureRecognizer()
    
    // MARK: - Outlets
    @IBOutlet weak var MyView: UIView!
    
    @IBOutlet var imageAddButton1: UIImageView!
    @IBOutlet var imageAddButton2: UIImageView!
    @IBOutlet var imageAddButton3: UIImageView!
    @IBOutlet var imageAddButton4: UIImageView!
    
    @IBOutlet weak var viewButton2: UIView!
    @IBOutlet weak var viewButton4: UIView!
    
    @IBOutlet var addButtonCollection: [UIImageView]!
    
    @IBOutlet var layoutsButton: [UIButton]!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.determinateSwipe()
        
    }
    
    
    // MARK: - Swipe to share
    
    func whichOrientation() -> Bool {
        //Comparison of interface sizes to determine screen orientation
        if view.bounds.size.width < view.bounds.size.height {
            return true
        } else {
            return false
        }
    }
    
    func determinateSwipe()  {
        //Swipe to the up
        let upSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipeToShare)) //A gesture recognizer that interprets swiping gestures in one or more directions.
        upSwipe.direction = .up //The permitted direction of the swipe for this gesture recognizer.
        view.addGestureRecognizer(upSwipe) //Attaches a gesture recognizer to the view.
        //Swipe to the left
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipeToShare))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    func displayShare() {
        let image = ImageGrid().createImage(self.MyView) //Using the class method
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: []) //A view controller that you use to offer standard services
        vc.completionWithItemsHandler = { activity, success, items, error in
            UIView.animate(withDuration: 0.4, delay: 0, animations: {
                self.MyView.transform = .identity //The completion handler to execute after the activity view controller is dismissed.
            })
        }
        present(vc, animated: true)
    }
    
    //Checking the content of the displayed views image
    func missingImage() -> Bool {
        for imageInGrid in addButtonCollection {
            if imageInGrid.image == nil && imageInGrid.superview!.isHidden == false {
                return true
            }
        }
        return false
    }
    
    func alertMissingImage() {
        //create the alert
        let alert = UIAlertController(title: "Missing image(s)", message: "You must complete the grid before sharing", preferredStyle: UIAlertController.Style.alert)
        //add action
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        //show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func swipeToShare (_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .up && whichOrientation() == true {
            if missingImage() == false {
                // animation du swipe, Myview sort de l'écran par le haut
                UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
                    self.MyView.transform = CGAffineTransform(translationX: 0, y:-1000)
                })
                displayShare()
            } else {
                alertMissingImage()
            }
        }else if sender.direction == .left && whichOrientation() == false {
            if missingImage() == false {
                // animation du swipe, Myview sort de l'écran par la gauche
                UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
                    self.MyView.transform = CGAffineTransform(translationX: -1000, y:0)
                })
                displayShare()
            } else {
                alertMissingImage()
                
            }
        }
    }
    
    
    
    
    // MARK: - Selection of layout between three choices
    
    @IBAction func layoutButtonsTouch(_ sender: UIButton) {
        for layoutButton in layoutsButton {
            layoutButton.isSelected = false
        }
        sender.isSelected = true
        switch sender.tag {
        case 1:
            viewButton2.isHidden = true
            viewButton4.isHidden = false
        case 2:
            viewButton2.isHidden = false
            viewButton4.isHidden = true
        case 3:
            viewButton2.isHidden = false
            viewButton4.isHidden = false
        default:
            break
        }
    }
    
    // MARK: - Ajout de photos
    
    @IBAction func addImageButton(_ sender: UIButton) {
        let tag = sender.tag
        addImagePicker(number: tag)
    }
    
    
    
    @objc func addImagePicker(number:Int) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false //user cropping the photo, set to false by default
        imagePicker.sourceType = .photoLibrary //choice of source
        numberButton = number //retrieve the number for use in imagePickerController
        present(imagePicker, animated: true, completion: nil)
    }
    
    //function called when the user has finished selecting the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage
        
        if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            
            switch numberButton {
            case 1:
                self.imageAddButton1.image = selectedImage //Adding the selected image to UIImageview
                self.button1.setImage(nil, for: .normal) //Remove button image (plus)
            case 2:
                self.imageAddButton2.image = selectedImage
                self.button2.setImage(nil, for: .normal)
            case 3:
                self.imageAddButton3.image = selectedImage
                self.button3.setImage(nil, for: .normal)
            case 4:
                self.imageAddButton4.image = selectedImage
                self.button4.setImage(nil, for: .normal)
            default:
                print("error in imagePickerController()")
            }
            
            dismiss(animated: true)
        }
    }
    
}



