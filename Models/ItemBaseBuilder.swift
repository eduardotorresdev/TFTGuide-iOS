import UIKit
import Foundation

class ItemBaseBuilder {
    private var itemsBase = Array<ItemBase>()
    
    init(imgs:Array<UIImageView>) {
        self.itemsBase = itemsBaseBuilder(imgs)
    }
    
    func itemsBaseBuilder(_ imgs:Array<UIImageView>) ->  Array<ItemBase>{
        var itemsBase = Array<ItemBase>()
        itemsBase.append(ItemBase(nome: "GPC", img: imgs[0]))
        itemsBase.append(ItemBase(nome: "ArcoRecurvo", img: imgs[1]))
        itemsBase.append(ItemBase(nome: "CotaDeMalha", img: imgs[2]))
        itemsBase.append(ItemBase(nome: "CapaNegatron", img: imgs[3]))
        itemsBase.append(ItemBase(nome: "Bastao", img: imgs[4]))
        itemsBase.append(ItemBase(nome: "LagrimaDaDeusa", img: imgs[5]))
        itemsBase.append(ItemBase(nome: "CintoDoGigante", img: imgs[6]))
        itemsBase.append(ItemBase(nome: "Espatula", img: imgs[7]))
        return itemsBase
    }
    
    func getItemsBase() -> Array<ItemBase>{
        return itemsBase
    }
}
