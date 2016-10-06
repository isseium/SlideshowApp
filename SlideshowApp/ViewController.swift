//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Issei Komatsu on 2016/10/04.
//  Copyright © 2016年 Issei Komatsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    var currentImageIndex:Int = 0
    var images: [String] = ["1.jpg", "2.jpg", "3.jpg"]
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshImageView()
        
        imageView.userInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func refreshImageView() {
        imageView.image = UIImage(named: images[currentImageIndex])
    }


    @IBAction func prev(sender: AnyObject) {
        if(currentImageIndex == 0){
            currentImageIndex = images.count - 1
        }else{
            currentImageIndex -= 1
        }
        
        refreshImageView()
    }
    
    @IBAction func next(sender: AnyObject) {
        if(currentImageIndex == images.count - 1){
            currentImageIndex = 0
        }else{
            currentImageIndex += 1
        }
        
        refreshImageView()
    }

    
    @IBAction func slideshow(sender: AnyObject) {
        if(timer != nil && timer.valid){
            stopSlideshow()
        }else{
            startSlideshow()
        }
    }
    
    private func stopSlideshow(){
        // スライドショーを停止する
        timer.invalidate()
        timer = nil
        
        // ボタンの設定
        prevButton.enabled = true
        nextButton.enabled = true
        playButton.setTitle("再生", forState: .Normal)
    }
    
    private func startSlideshow(){
        // スライドショー開始
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.next), userInfo: nil, repeats:true)
        
        // ボタンの設定
        prevButton.enabled = false
        nextButton.enabled = false
        playButton.setTitle("停止", forState: .Normal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let detailController:DetailController = segue.destinationViewController as! DetailController
        detailController.imageName = images[currentImageIndex]
        detailController.currentImageIndex = currentImageIndex
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        // 要件「戻るボタンがタップされると、スライドショー画面に戻り、同じ画像を表示してください」のため
        if(timer != nil && timer.valid){
            stopSlideshow()
            let detailController:DetailController = segue.sourceViewController as! DetailController
            currentImageIndex = detailController.currentImageIndex
            refreshImageView()
            startSlideshow()
        }
    }
}

