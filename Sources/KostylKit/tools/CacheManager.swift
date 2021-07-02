//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit
public  enum Result<T> {
    case success(T)
    case failure
}

open class CacheManager {

    static let shared = CacheManager()
    private let fileManager = FileManager.default
    private lazy var mainDirectoryUrl: URL = {

    let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl
    }()

   open func getFileWith(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {
        let file = directoryFor(stringUrl: stringUrl)

        //return file path if already exists in cache directory
        guard !fileManager.fileExists(atPath: file.path)  else {
            completionHandler(Result.success(file))
            return
        }
        
        rxDispatch.thread(dispatchLevel: .global) {
            if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
                videoData.write(to: file, atomically: true)
                
                rxDispatch.thread(dispatchLevel: .main) {
                    completionHandler(Result.success(file))
                }
            } else {
                rxDispatch.thread(dispatchLevel: .main) {
                    completionHandler(Result.failure)
                }
            }
        }
    }

    private func directoryFor(stringUrl: String) -> URL {
        let fileURL = URL(string: stringUrl)!.lastPathComponent
        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)

        return file
    }
}
