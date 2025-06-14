import RealmSwift
import Foundation

public class DBManager {
    public static let shared = DBManager()
    
    private var realm: Realm {
        return try! Realm()
    }
    
    private init() {
        setupRealmMigration()
    }
    
    // MARK: - Delete DB - for dev only
    public func clearAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    // MARK: - Save/Update
    public func save<T: Object>(_ object: T, isUpdate: Bool = true) {
        try? realm.write {
            realm.add(object, update: isUpdate ? .modified : .error)
        }
    }
    
    // MARK: - Save/Update Array
    public func save<T: Object>(_ objects: [T], isUpdate: Bool = true) {
        try? realm.write {
            realm.add(objects, update: isUpdate ? .modified : .error)
        }
    }
    
    // MARK: - Fetch by id
    public func fetchById<T: Object, K>(_ type: T.Type, id: K) -> T? {
        return realm.object(ofType: type, forPrimaryKey: id)
    }
    
    // MARK: - Fecth All
    public func fetchAll<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    // MARK: - Filtered Fetch
    public func fetch<T: Object>(_ type: T.Type, filter: NSPredicate) -> Results<T> {
        return realm.objects(type).filter(filter)
    }
    
    // MARK: - Delete
    public func delete<T: Object>(_ object: T) {
        try? realm.write {
            realm.delete(object)
        }
    }
    
    // MARK: - Delete All of Type
    public func deleteAll<T: Object>(_ type: T.Type) {
        try? realm.write {
            let objects = realm.objects(type)
            realm.delete(objects)
        }
    }
    
    // MARK: - Delete All (Full Reset)
    public func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    private func setupRealmMigration() {
        let config = Realm.Configuration(
            schemaVersion: 1, // 🔁 Increment this every time schema changes
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Automatic migration - no manual changes needed
                }
            }
        )
        
        Realm.Configuration.defaultConfiguration = config
    }
}

