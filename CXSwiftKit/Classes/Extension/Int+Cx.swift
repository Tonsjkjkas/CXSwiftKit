//
//  Int+Cx.swift
//  CXSwiftKit
//
//  Created by chenxing on 2022/11/14.
//

import Foundation

extension Int: CXSwiftBaseCompatible {}

extension CXSwiftBase where T == Int {
    
    /// Convert the seconds to a string which contains the format(0d0h0m0s).
    ///
    /// - Parameter sinicized: Whether to convert an English string into Chinese.
    /// - Returns: A string which contains the format(0d0h0m0s).
    public func secondsAsTimeString(sinicized: Bool = true) -> String {
        let formatter = DateComponentsFormatter.init()
        /// .dropMiddle(0d0h0m0s)
        formatter.zeroFormattingBehavior = .dropMiddle
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
        
        // 1d 1h 1m 1s
        var result = formatter.string(from: TimeInterval(self.base)) ?? ""
        // Handle according to your own needs.
        if sinicized {
            result = result.replacingOccurrences(of: "d", with: "天", options: .literal, range: nil)
            result = result.replacingOccurrences(of: "h", with: "小时", options: .literal, range: nil)
            result = result.replacingOccurrences(of: "m", with: "分", options: .literal, range: nil)
            result = result.replacingOccurrences(of: "s", with: "秒", options: .literal, range: nil)
        }
        return result
    }
    
}
