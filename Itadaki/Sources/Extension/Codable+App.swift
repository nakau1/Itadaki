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
        return to(String.self, key, substitute)
    }
    
    func stringOrNil(_ key: Key) -> String? {
        return toOrNil(String.self, key)
    }
    
    func int(_ key: Key, _ substitute: Int = 0) -> Int {
        return to(Int.self, key, substitute)
    }
    
    func intOrNil(_ key: Key) -> Int? {
        return toOrNil(Int.self, key)
    }
    
    func bool(_ key: Key, _ substitute: Bool = false) -> Bool {
        return to(Bool.self, key, substitute)
    }
    
    func boolOrNil(_ key: Key) -> Bool? {
        return toOrNil(Bool.self, key)
    }
    
    func cgfloat(_ key: Key, _ substitute: CGFloat = 0) -> CGFloat {
        return to(CGFloat.self, key, substitute)
    }
    
    func cgfloatOrNil(_ key: Key) -> CGFloat? {
        return toOrNil(CGFloat.self, key)
    }
    
    func cgPoint(_ key: Key, _ substitute: CGPoint = .zero) -> CGPoint {
        return to(CGPoint.self, key, substitute)
    }
    
    func cgPointOrNil(_ key: Key) -> CGPoint? {
        return toOrNil(CGPoint.self, key)
    }
    
    func color(_ key: Key, _ substitute: UIColor = .clear) -> UIColor {
        return colorOrNil(key) ?? substitute
    }
    
    func colorOrNil(_ key: Key) -> UIColor? {
        guard let colorCode = toOrNil(String.self, key), let color = UIColor(colorCodeOrNil: colorCode) else {
            return nil
        }
        return color
    }
}

extension KeyedEncodingContainerProtocol {
    
    mutating func encode(_ value: UIColor, forKey key: Key) throws {
        try encode(value.colorCode, forKey: key)
    }
}
