/*Copyright (c) 2016, Andrew Walz.
 
 Redistribution and use in source and binary forms, with or without modification,are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
 BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController
{
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    public var delegate:VideoViewControllerDelegate!
    private var videoURL: URL
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    var movieData:Data?
    var isPlayingVideo:Bool?
    var playButton:UIButton!
    
    //MARK:Implementation
    
    init(videoURL: URL)
    {
        self.videoURL = videoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.isPlayingVideo = false
        self.view.backgroundColor = UIColor.gray
        player = AVPlayer(url: videoURL)
        playerController = AVPlayerViewController()
        
        guard player != nil && playerController != nil else
        {
            return
        }
        playerController!.showsPlaybackControls = false
        
        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 40.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cross"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        let sendButton = UIButton(frame: CGRect(x: self.view.frame.size.width-40, y: 40.0, width: 30.0, height: 30.0))
        sendButton.setImage(#imageLiteral(resourceName: "send"), for: UIControlState())
        sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        view.addSubview(sendButton)
        
        playButton = UIButton(frame: CGRect(x: self.view.frame.size.width-40, y: 40.0, width: 64.0, height: 64.0))
        playButton.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        playButton.setImage(#imageLiteral(resourceName: "play"), for: UIControlState())
        playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        view.addSubview(playButton)
        
        do
        {
            // movieData =  try Data.init(contentsOf: self.filePathArray[index] as! URL, options: .alwaysMapped)
            movieData = try Data.init(contentsOf: videoURL)
        }
        catch
        {
            
        }
        print("ABC")
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
//        player?.play()
    }
    
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification)
    {
        if self.player != nil
        {
            self.player!.seek(to: kCMTimeZero)
            self.playButton.isHidden =  false
//            self.player!.play()
        }
    }
    
    func backgroundViewTapped(_ sender: UITapGestureRecognizer)
    {
        if self.isPlayingVideo!
        {
            player?.pause()
            self.isPlayingVideo = false
            self.playButton.isHidden =  false
        }
    }
    
    func cancel()
    {
        dismiss(animated: true, completion: nil)
    }
    
    func send()
    {
        dismiss(animated: true, completion: nil)
        self.delegate.sendVideo(videoData: self.movieData!)
    }
    
    func playVideo()
    {
        if self.isPlayingVideo!
        {
            self.isPlayingVideo = false
        }
        else
        {
            self.isPlayingVideo = true
            player?.play()
            self.playButton.isHidden =  true
        }
    }
    
}

protocol VideoViewControllerDelegate
{
    func sendVideo(videoData:Data)
}
