// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

class Realm {
    
    private static var sharedRealm: RealmSwift.Realm!
    
    static var path: String {
        return RealmSwift.Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? ""
    }
    
    private static var realm: RealmSwift.Realm {
        if sharedRealm == nil {
            sharedRealm = try! RealmSwift.Realm()
        }
        return sharedRealm
    }
    
    class func begin() {
        realm.beginWrite()
    }
    
    class func deleteRealm() {
        do {
            if FileManager.default.fileExists(atPath: path) {
                try FileManager.default.removeItem(atPath: path)
            }
        } catch let e {
            print("failed delete realm file. \(e.localizedDescription)")
        }
    }
    
    class func create<Entity>(_ type: Entity.Type) -> Entity where Entity: RealmSwift.Object {
        return realm.create(type)
    }
    
    class func select<Entity>(from type: Entity.Type, predicate: NSPredicate? = nil) -> RealmSwift.Results<Entity> where Entity: RealmSwift.Object {
        var results = realm.objects(type)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        return results
    }
    
    class func count<Entity>(of type: Entity.Type, predicate: NSPredicate? = nil) -> Int where Entity: RealmSwift.Object {
        return select(from: type, predicate: predicate).count
    }
    
    class func save<Entity>(_ entity: Entity) where Entity: RealmSwift.Object {
        save([entity])
    }
    
    class func save<Entity>(_ entities: [Entity]) where Entity: RealmSwift.Object {
        let r = realm
        try! r.write {
            r.add(entities, update: true)
        }
    }
    
    class func insert<Entity>(_ entity: Entity) where Entity: RealmSwift.Object {
        insert([entity])
    }
    
    class func insert<Entity>(_ entities: [Entity]) where Entity: RealmSwift.Object {
        let r = realm
        var i = 0, id = 0
        try! r.write {
            for entity in entities {
                if var identifiedObject = entity as? RealmIdentifiedObject {
                    if i == 0 {
                        id = identifiedObject.id
                    } else {
                        id += 1
                        identifiedObject.id = id
                    }
                }
                r.add(entity, update: true)
                i += 1
            }
        }
    }
    
    class func delete<Entity>(for type: Entity.Type, predicate: NSPredicate? = nil) where Entity: RealmSwift.Object {
        let r = realm
        try! r.write {
            if let predicate = predicate {
                r.delete(r.objects(Entity.self).filter(predicate))
            } else {
                r.delete(r.objects(Entity.self))
            }
        }
    }
    
    class func update<Entity>(for type: Entity.Type, predicate: NSPredicate?, updating: @escaping (Entity, Int) -> Void) where Entity: RealmSwift.Object {
        let r = realm
        try! r.write {
            let results: RealmSwift.Results<Entity>
            if let predicate = predicate {
                results = r.objects(Entity.self).filter(predicate)
            } else {
                results = r.objects(Entity.self)
            }
            
            var i = 0
            for entity in results {
                updating(entity, i)
                i += 1
            }
        }
    }
}
