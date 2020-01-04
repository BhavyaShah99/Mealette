//
//  ViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-23.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var backVid : AVPlayer?
    var backvidLayer : AVPlayerLayer?
    @IBOutlet var createBtn: UIButton!
    @IBOutlet var loginbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set up background video
        let bundlePath = Bundle.path(forResource: "back", ofType: "mp4", inDirectory: "media")
        guard bundlePath != nil else {
            return
        }
        let vidUrl = URL(fileURLWithPath: bundlePath!)
        let avPlay = AVPlayerItem(url: vidUrl)
        backVid = AVPlayer(playerItem: avPlay)
        backvidLayer = AVPlayerLayer(player: backVid!)
        backvidLayer?.frame = CGRect(x: self.view.frame.size.width * 1.5, y: 0, width: self.view.frame.size.width * 4, height: self.view.frame.size.height)
        view.layer.insertSublayer(backvidLayer!, at: 0)
        backVid?.playImmediately(atRate: 0.8)
    }
    
    func setupView() {
        styleBtn(btn: createBtn)
        styleBtn(btn: loginbtn)
        createBtn.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        loginbtn.backgroundColor = UIColor.white
        createBtn.layer.borderColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor
        loginbtn.layer.borderColor = UIColor.black.cgColor
    }
    
    func styleBtn(btn : UIButton!) {
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1/UIScreen.main.nativeScale
    }
    
}

