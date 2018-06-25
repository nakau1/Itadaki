// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension KeyedDecodingContainerProtocol {
    
    func to<T>(_ type: T.Type, _ key: Key, _ substitute: T) -> T where T: Decodable {
        guard let tmp = try? decodeIfPresent(type, forKey: key), let ret = tmp else {
            return substitute
        }
        return ret
    }
    
    func toOrNil<T>(_ type: T.Type, _ key: Key) -> T? where T: Decodable {
        guard let ret = try? decodeIfPresent(type, forKey: key) else {
            return nil
        }
        return ret
    }
    
    func string(_ key: Key, _ substitute: String = "") -> String {
        guard let tmp = try? decodeIfPresent(String.self, forKey: key), let ret = tmp else {
            return substitute
        }
        return ret
    }
    
    func stringOrNil(_ key: Key) -> String? {
        guard let ret = try? decodeIfPresent(String.self, forKey: key) else {
            return nil
        }
        return ret
    }
    
    func int(_ key: Key, _ substitute: Int = 0) -> Int {
        guard let tmp = try? decodeIfPresent(Int.self, forKey: key), let ret = tmp else {
            return substitute
        }
        return ret
    }
    
    func bool(_ key: Key, _ substitute: Bool = false) -> Bool {
        guard let tmp = try? decodeIfPresent(Bool.self, forKey: key), let ret = tmp else {
            return substitute
        }
        return ret
    }
    
    func cgfloat(_ key: Key, _ substitute: CGFloat = 0) -> CGFloat {
        guard let tmp = try? decodeIfPresent(CGFloat.self, forKey: key), let ret = tmp else {
            return substitute
        }
        return ret
    }
    
    func point(_ key: Key, _ substitute: CGPoint = .zero) -> CGPoint {
        guard let tmp = try? decodeIfPresent(CGPoint.self, forKey: key), let ret = tmp else {
            return substitute
        }
        return ret
    }
    
    func color(_ key: Key, _ substitute: UIColor = .clear) -> UIColor {
        guard let tmp = try? decodeIfPresent(String.self, forKey: key), let ret = tmp else {
            return substitute
        }
        return UIColor(colorCode: ret)
    }
}

extension KeyedEncodingContainerProtocol {
    
    mutating func encode(_ value: UIColor, forKey key: Key) throws {
        try encode(value.colorCode, forKey: key)
    }
}
