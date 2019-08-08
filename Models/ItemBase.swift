import UIKit
import Foundation

class ItemBase: NSObject, NSCoding {
    let nome:String
    let img:UIImageView
    
    init(nome:String, img:UIImageView) {
        self.nome = nome
        self.img = img
    }
    required init?(coder aDecoder: NSCoder) {
        let imgs = ["GPC":"gpc", "ArcoRecurvo":"arcoRecurvo", "CotaDeMalha":"cotaDeMalha", "CapaNegatron":"negatron", "Bastao":"bastao", "LagrimaDaDeusa":"gota", "CintoDoGigante":"cintoDoGigante", "Espatula":"espatula"]
        self.nome = aDecoder.decodeObject(forKey: "nome") as! String
        self.img = UIImageView()
        self.img.image = UIImage(named: imgs[self.nome]!)

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: "nome")
    }
    
}
