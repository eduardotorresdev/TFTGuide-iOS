import Foundation

class ItemDao {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getURLItems() -> URL {
        return getDocumentsDirectory().appendingPathComponent("items.data")
    }
    
    func gravarItems(_ items:Array<Item>) {
        do {
            let caminho = getURLItems()
            print("xD")
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            try data.write(to: caminho)
        } catch {
            print("Couldn't write file")
        }
    }
    
    func carregarItems() -> Array<Item>{
        do {
            let data = try Data(contentsOf: getURLItems())
            if let items = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<Item> {
                return items
            }
        } catch {
            print("Couldn't read file.")
        }
        return []
    }
}
