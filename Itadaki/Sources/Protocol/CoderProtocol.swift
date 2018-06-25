// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

protocol CoderProtocol {
    
    func save<T>(_ object: T, to path: String) where T: Encodable
    
    func loadOrNil<T>(path: String, to type: T.Type) -> T? where T: Decodable
    
    func clone<T>(_ value: T, type: T.Type) -> T where T: Codable
}

extension CoderProtocol {
    
    func load<T>(path: String, to type: T.Type, default defaultValue: T) -> T where T: Decodable {
        return loadOrNil(path: path, to: type) ?? defaultValue
    }
}
