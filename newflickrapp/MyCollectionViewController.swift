//
//  MyCollectionViewController.swift
//  newflickrappCollectionViewCell
//
//  Created by alex berkson on 1/15/16.
//  Copyright © 2016 alex berkson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MyCollectionViewController: UICollectionViewController, UITextFieldDelegate {

    
    let apiKey = "343b1ac324a41431e417c7e8ced2ef19"
    let secret = "edaaf44b1e5dbe34"
    var photoArray = [flickrPhoto]()
    var imageArray = [UIImage]()
    
    @IBOutlet weak var searchfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchfield.delegate = self

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count > 0 {
            photoArray = [flickrPhoto]()
            imageArray = [UIImage]()
           let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(textField.text!)&per_page=10&format=json&nojsoncallback=1"
           
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            searchfield.addSubview(activityIndicator)
            activityIndicator.frame = searchfield.bounds
            activityIndicator.startAnimating()
            textField.text = ""
            Alamofire.request(.GET, url, encoding: .JSON)
                .responseJSON{ (json) in
                    activityIndicator.removeFromSuperview()
                    self.parsevalue(json.result.value!)
                }
        }
        textField.endEditing(true)
        return true
    }
    
    func parsevalue(json: AnyObject) {
        
        let json = JSON(json)
        let photos = json["photos"]["photo"]
        
        for (key: _, subJson: JSON) in photos {
            
            let id = JSON["id"].stringValue
            let farm = JSON["farm"].stringValue
            let secret = JSON["secret"].stringValue
            let server = JSON["server"].stringValue
            //let title = JSON ["title"].stringValue
            let size = "m"
            
            let url = "http://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg"
            
            let photo = flickrPhoto(photoID: id, farm: farm, server: server, secret: secret)
            photo.url = url
            photoArray.append(photo)
        
        }
            displaypictures()
    }
    
    func displaypictures() {
        
        for photo in photoArray {
            
            let url = photo.url
            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: url!)!)!)
            imageArray.append(image!)
        }
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! myCollectionViewCell
    
        // Configure the cell
        
        cell.photoImage.image = imageArray[indexPath.row]
        
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
