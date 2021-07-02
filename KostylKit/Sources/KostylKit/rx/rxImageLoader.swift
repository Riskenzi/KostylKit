//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit
import AVKit

public let imageCacheItems = NSCache<AnyObject, AnyObject>()
public let videoPreviewsCacheItems = NSCache<AnyObject, AnyObject>()

open class rxImageLoader : UIImageView {
    
    var task : URLSessionTask!
    let loader = UIActivityIndicatorView(style: .medium)
    
    open func loadImage(from url: String) {
        
        guard let url = URL(string: url) else { return }
        
        image = nil
        
        addLoader()
        
        if let task = task {
            task.cancel()
        }
        
        if let imageFromCache = imageCacheItems.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            self.removeLoader()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data,response,error) in
            
           
            
            guard let data = data,
                  let newImage = UIImage(data: data) else {
                return
            }
            imageCacheItems.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.isHidden = false
                self.image = newImage
                self.loader.stopAnimating()
            }
        }
        task.resume()
    }

    open func addLoader()-> Void {
        addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.startAnimating()
    }
    
    open func removeLoader() -> Void {
        loader.removeFromSuperview()
    }
}

extension rxImageLoader {
   open func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        
        if let imageFromCache = videoPreviewsCacheItems.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            completion(imageFromCache)
        }
        rxDispatch.thread(dispatchLevel: .global) {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                videoPreviewsCacheItems.setObject(thumbImage, forKey: url.absoluteString as AnyObject)
                    rxDispatch.thread {
                        completion(thumbImage)
                    }
                   
                
            } catch {
                print(error.localizedDescription)
                rxDispatch.thread {
                    completion(nil)
                }
            }
        }
    }
}
