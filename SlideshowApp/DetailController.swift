//
//  DetailController.swift
//  SlideshowApp
//
//  Created by Issei Komatsu on 2016/10/04.
//  Copyright © 2016年 Issei Komatsu. All rights reserved.
//
//  NOTE: http://qiita.com/wmoai/items/52b1901e62d28dae9f91

import UIKit

class DetailController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView!
    var imageName: String!
    var currentImageIndex: Int!     // スライドショー中の要件「戻るボタンがタップされると、スライドショー画面に戻り、同じ画像を表示してください」を満たすために保持

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        
        imageView = UIImageView(image: UIImage(named: imageName))
        scrollView.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let size = imageView.image?.size {
            // imageViewのサイズがscrollView内に収まるように調整
            let wrate = scrollView.frame.width / size.width
            let hrate = scrollView.frame.height / size.height
            let rate = min(wrate, hrate, 1)
            imageView.frame.size = CGSizeMake(size.width * rate, size.height * rate)
            
            // contentSizeを画像サイズに設定
            scrollView.contentSize = imageView.frame.size
            // 初期表示のためcontentInsetを更新
            updateScrollInset()
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        // ズームのために要指定
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        // ズームのタイミングでcontentInsetを更新
        updateScrollInset()
    }
    
    private func updateScrollInset() {
        // imageViewの大きさからcontentInsetを再計算
        // なお、0を下回らないようにする
        scrollView.contentInset = UIEdgeInsetsMake(
            max((scrollView.frame.height - imageView.frame.height)/2, 0),
            max((scrollView.frame.width - imageView.frame.width)/2, 0),
            0,
            0
        );
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
