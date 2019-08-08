import UIKit
import Foundation

class Item : NSObject, NSCoding {
    let nome:String
    let img:String
    let descricao:String
    let base:Array<ItemBase>
    
    init(nome:String, descricao:String, img:String, base:Array<ItemBase>) {
        self.descricao = descricao
        self.nome = nome
        self.img = img
        self.base = base
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.descricao = aDecoder.decodeObject(forKey: "descricao") as! String
        self.nome = aDecoder.decodeObject(forKey: "nome") as! String
        self.img = aDecoder.decodeObject(forKey: "img") as! String
        self.base = aDecoder.decodeObject(forKey: "base") as! Array
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(descricao, forKey: "descricao")
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(img, forKey: "img")
        aCoder.encode(base, forKey: "base")
    }
    
    static func ==(first: Item, second: Item) -> Bool {
        return first.nome == second.nome && first.descricao == second.descricao
    }
}
