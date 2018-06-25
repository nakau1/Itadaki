// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

private let IDProperty = "id"

protocol RealmIdentifiedObject {
    
    var id: Int { get set }
}

extension RealmIdentifiedObject where Self: RealmSwift.Object {
    
    static var idProperty: String { return IDProperty }
    
    func generateAutoIncrementedId() -> Int {
        
        guard
            let realm = try? RealmSwift.Realm(),
            let max = realm.objects(Self.self).sorted(byKeyPath: IDProperty, ascending: false).first
            else {
                return 1
        }
        return max.id + 1
    }
}

extension NSPredicate {
    
    convenience init(id: Int) {
        self.init(format: "\(IDProperty) = %@", argumentArray: [NSNumber(value: id)])
    }
    
    convenience init(ids: [Int]) {
        let arr = ids.map { NSNumber(value: $0) }
        self.init(format: "\(IDProperty) IN %@", argumentArray: [arr])
    }
}
