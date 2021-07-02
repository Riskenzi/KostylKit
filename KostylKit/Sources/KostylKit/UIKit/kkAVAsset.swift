//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import AVFoundation
import UIKit
import Photos
import PhotosUI
import MobileCoreServices

extension AVAsset {
    
    open  func assetID() -> String? {
        
        let metadata = self.metadata(forFormat: .quickTimeMetadata)
        
        for item in metadata {
            let keyContentIdentifier =  "com.apple.quicktime.content.identifier"
            let keySpaceQuickTimeMetadata = "mdta"
            if item.key as? String == keyContentIdentifier &&
                item.keySpace!.rawValue == keySpaceQuickTimeMetadata {
                return item.value as? String
            }
        }
        return nil
        
    }
    
    open func exportToDocuments(filename:String, completion: @escaping (_ outputURL: URL) -> ()) -> Bool {
        
        var isExporting = false
        
        if let exportSession = AVAssetExportSession(asset: self, presetName: AVAssetExportPresetHighestQuality) {
           
            var documentsURL: URL?
            
            do {
                documentsURL = try FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            }
            catch {
                print(error)
                return false
            }
            
            if let outputURL = documentsURL?.appendingPathComponent(filename) {
                
                if FileManager.default.fileExists(atPath: outputURL.path) {
                    do {
                        
                        try FileManager.default.removeItem(atPath: outputURL.path)
                        
                    } catch _ as NSError {
                    }
                }
                
                exportSession.outputURL = outputURL
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileType.mov
                
                isExporting = true
                
                exportSession.exportAsynchronously(completionHandler: {
                    
                    if exportSession.status == .completed && exportSession.error == nil {
                        
                        completion(outputURL)
                    }
                    
                })
            }
        }
        
        return isExporting
    }
    
  open func audioAsset() throws -> AVAsset {
        
        let composition = AVMutableComposition()
        
        let audioTracks = tracks(withMediaType: AVMediaType.audio)
        
        for track in audioTracks {
            
            let compositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
            do {
                try compositionTrack?.insertTimeRange(track.timeRange, of: track, at: track.timeRange.start)
            } catch {
                throw error
            }
            compositionTrack?.preferredTransform = track.preferredTransform
        }
        return composition
    }
}
