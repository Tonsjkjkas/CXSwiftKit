//
//  CXKingfisherReferer.swift
//  CXSwiftKit
//
//  Created by chenxing on 2022/11/14.
//

#if canImport(Kingfisher) && canImport(Foundation)
import Kingfisher
import Foundation

public class CXKingfisherReferer: ImageDownloadRequestModifier {
    
    let headers: [String : String]
    
    public init(headers: [String : String]) {
        self.headers = headers
    }
    
    func modified(for request: URLRequest) -> URLRequest? {
        var request = request
        for key in headers.keys {
            if let value = headers[key], !value.isEmpty {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
}

#endif
