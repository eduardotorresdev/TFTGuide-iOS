import UIKit
import Foundation

class ItemBuilder {
    private var arvoresItems = [String: Dictionary<String, Item>]()
    var itemsRecentes = Array<Item>()
    
    init(itemsBase:Array<ItemBase>) {
        self.arvoresItems = itemsBuilder(itemsBase)
    }
    
    func itemsBuilder(_ itemsBase:Array<ItemBase>) -> [String: Dictionary<String, Item>]{
        var arvoresItems = [String:Dictionary<String, Item>]()
        let setItemsBase = [
            "GPC":itemsBase[0],
            "ArcoRecurvo":itemsBase[1],
            "CotaDeMalha":itemsBase[2],
            "CapaNegatron":itemsBase[3],
            "Bastao":itemsBase[4],
            "LagrimaDaDeusa":itemsBase[5],
            "CintoDoGigante":itemsBase[6],
            "Espatula":itemsBase[7],
                            ]
        let allItems = self.buildItems(setItemsBase)
        arvoresItems["GPC"] = arvoreGPC(allItems)
        arvoresItems["CintoDoGigante"] = arvoreCintoDoGigante(allItems)
        arvoresItems["ArcoRecurvo"] = arvoreArcoRecurvo(allItems)
        arvoresItems["CotaDeMalha"] = arvoreCotaDeMalha(allItems)
        arvoresItems["CapaNegatron"] = arvoreNegatron(allItems)
        arvoresItems["LagrimaDaDeusa"] = arvoreLagrimaDaDeusa(allItems)
        arvoresItems["Espatula"] = arvoreEspatula(allItems)
        arvoresItems["Bastao"] = arvoreBastao(allItems)
        return arvoresItems
    }
    
    func getItem(first:String, second:String) -> Item? {
        return arvoresItems[first]?[second]
    }
    func getItemsRecentes() -> Array<Item> {
        return itemsRecentes
    }
    func atualizaListaDeRecentes(_ recentes:Array<UIImageView>){
        var j = 4
        for i in itemsRecentes.reversed() {
            recentes[j].isHidden = false
            recentes[j].image = UIImage(named: i.img)
            j -= 1
        }
    }
    
    func inserirItemEmRecentes(_ item:Item){
        let dao = ItemDao()
        for (index, element) in itemsRecentes.enumerated(){
            if(item.nome == element.nome){
                let lastIndex = itemsRecentes.count-1
                if(itemsRecentes.count > 1 && index != lastIndex){
                    for i in index...lastIndex-1{
                        itemsRecentes[i] = itemsRecentes[i+1]
                    }
                    itemsRecentes[lastIndex] = element
                }
                dao.gravarItems(itemsRecentes)
                return
            }
        }
        if(itemsRecentes.count < 5){
            itemsRecentes.append(item)
        } else {
            itemsRecentes.remove(at: 0)
            itemsRecentes.append(item)
        }
        dao.gravarItems(itemsRecentes)
    }
    
    func collision(to elm1: UIImageView, from elm2: UIImageView) -> Bool {
        let elm1X = elm1.frame.origin.x
        let elm2X = elm2.frame.origin.x
        let elm1Y = elm1.frame.origin.y
        let elm2Y = elm2.frame.origin.y
        let elm1Radius = elm1.frame.width / 2
        let elm2Radius = elm2.frame.width / 2
        let dX = elm2X - elm1X
        let dY = elm2Y - elm1Y
        let radius = elm1Radius + elm2Radius;
        return ((dX * dX) + (dY * dY) <= (radius * radius))
    }
    
    func collisionWithValues(to elm1: UIImageView, point:CGPoint, width:CGFloat) -> Bool {
        let elm1X = elm1.frame.origin.x
        let elm2X = point.x
        let elm1Y = elm1.frame.origin.y
        let elm2Y = point.y
        let elm1Radius = elm1.frame.width / 2
        let elm2Radius = width / 2
        let dX = elm2X - elm1X
        let dY = elm2Y - elm1Y
        let radius = elm1Radius + elm2Radius;
        return ((dX * dX) + (dY * dY) <= (radius * radius))
    }
    
    func itemIsAboveAnother(_ item: UIImageView, items:Array<UIImageView>, origin: CGPoint) -> UIImageView?{
        var itemEncontrado:UIImageView? = nil
        if(item.center == origin){
            itemEncontrado = item
        }
        for i in items {
            if(i != item){
                if(collision(to: i, from: item) == true){
                    if(itemEncontrado == nil){
                        itemEncontrado = i
                    } else {
                        itemEncontrado = nil
                        break
                    }
                }
            }
        }
        return itemEncontrado
    }
    
    func getItemByLocation(_ items:Array<UIImageView>, on location:CGPoint) -> UIImageView? {
        for i in items {
            if(i.frame.contains(location)){
                return i
            }
        }
        return nil
    }
    
    func getItemRecenteByLocation(_ items:Array<UIImageView>, on location:CGPoint) -> Item? {
        var x = itemsRecentes.count-1
        for element in items.reversed() {
            if(element.frame.contains(location) && element.isHidden == false){
                return itemsRecentes[x]
            }
            x -= 1
        }
        return nil
    }
    
    func getItemBaseByImg(_ img:UIImageView, _ itemsBase: Array<ItemBase>) -> String?{
        for item in itemsBase {
            if(item.img == img){
                return item.nome
            }
        }
        return nil
    }
    
    func arvoreGPC(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["gumeDoInfinito"]
        items["ArcoRecurvo"] = allItems["espadaDoDivino"]
        items["CotaDeMalha"] = allItems["anjoGuardiao"]
        items["CapaNegatron"] = allItems["sedentaPorSangue"]
        items["Bastao"] = allItems["pistolaHextech"]
        items["LagrimaDaDeusa"] = allItems["lancaDeShojin"]
        items["CintoDoGigante"] = allItems["arautoDoZeke"]
        items["Espatula"] = allItems["laminaYoumuu"]
        return items
    }
    func arvoreArcoRecurvo(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["espadaDoDivino"]
        items["ArcoRecurvo"] = allItems["canhaoFumegante"]
        items["CotaDeMalha"] = allItems["dancarinaFantasma"]
        items["CapaNegatron"] = allItems["laminaAmaldicoada"]
        items["Bastao"] = allItems["laminaGuinsoo"]
        items["LagrimaDaDeusa"] = allItems["facaStatikk"]
        items["CintoDoGigante"] = allItems["hidraTitanica"]
        items["Espatula"] = allItems["espadaReiDestruido"]
        return items
    }
    func arvoreCotaDeMalha(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["anjoGuardiao"]
        items["ArcoRecurvo"] = allItems["dancarinaFantasma"]
        items["CotaDeMalha"] = allItems["armaduraEspinho"]
        items["CapaNegatron"] = allItems["quebraEspada"]
        items["Bastao"] = allItems["solari"]
        items["LagrimaDaDeusa"] = allItems["coracaoCongelado"]
        items["CintoDoGigante"] = allItems["efeitoVermelho"]
        items["Espatula"] = allItems["juramentoDoCavaleiro"]
        return items
    }
    func arvoreNegatron(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["sedentaPorSangue"]
        items["ArcoRecurvo"] = allItems["laminaAmaldicoada"]
        items["CotaDeMalha"] = allItems["quebraEspada"]
        items["CapaNegatron"] = allItems["garraDoDragao"]
        items["Bastao"] = allItems["centelhaIonica"]
        items["LagrimaDaDeusa"] = allItems["quietude"]
        items["CintoDoGigante"] = allItems["zefiro"]
        items["Espatula"] = allItems["runaan"]
        return items
    }
    func arvoreBastao(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["pistolaHextech"]
        items["ArcoRecurvo"] = allItems["laminaGuinsoo"]
        items["CotaDeMalha"] = allItems["solari"]
        items["CapaNegatron"] = allItems["centelhaIonica"]
        items["Bastao"] = allItems["rabadon"]
        items["LagrimaDaDeusa"] = allItems["ecoDeLuden"]
        items["CintoDoGigante"] = allItems["morello"]
        items["Espatula"] = allItems["yuumi"]
        return items
    }
    func arvoreLagrimaDaDeusa(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["lancaDeShojin"]
        items["ArcoRecurvo"] = allItems["facaStatikk"]
        items["CotaDeMalha"] = allItems["coracaoCongelado"]
        items["CapaNegatron"] = allItems["quietude"]
        items["Bastao"] = allItems["ecoDeLuden"]
        items["LagrimaDaDeusa"] = allItems["abracoDeSeraph"]
        items["CintoDoGigante"] = allItems["redencao"]
        items["Espatula"] = allItems["darkin"]
        return items
    }
    func arvoreCintoDoGigante(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["arautoDoZeke"]
        items["ArcoRecurvo"] = allItems["hidraTitanica"]
        items["CotaDeMalha"] = allItems["efeitoVermelho"]
        items["CapaNegatron"] = allItems["zefiro"]
        items["Bastao"] = allItems["morello"]
        items["LagrimaDaDeusa"] = allItems["redencao"]
        items["CintoDoGigante"] = allItems["armaduraWarmog"]
        items["Espatula"] = allItems["malhoCongelado"]
        return items
    }
    func arvoreEspatula(_ allItems:[String:Item]) -> [String: Item] {
        var items = [String:Item]()
        items["GPC"] = allItems["laminaYoumuu"]
        items["ArcoRecurvo"] = allItems["espadaReiDestruido"]
        items["CotaDeMalha"] = allItems["juramentoDoCavaleiro"]
        items["CapaNegatron"] = allItems["runaan"]
        items["Bastao"] = allItems["yuumi"]
        items["LagrimaDaDeusa"] = allItems["darkin"]
        items["CintoDoGigante"] = allItems["malhoCongelado"]
        items["Espatula"] = allItems["forcaDaNatureza"]
        return items
    }
    
    func buildItems(_ itemsBase:[String:ItemBase]) -> [String:Item] {
        var items = [String:Item]()
        items["gumeDoInfinito"] = Item(
            nome: "Gume do infinito",
            descricao: "Acertos críticos causam +150% de dano",
            img: "gumeDoInfinito",
            base: [itemsBase["GPC"]!, itemsBase["GPC"]!]
        )
        items["arautoDoZeke"] = Item(
            nome: "Arauto do Zeke",
            descricao: "No início de combate, os aliados dentro de 2 casas na mesma linha recebem +15% de Velocidade de Ataque pelo resto do combate.",
            img: "zeke",
            base: [itemsBase["GPC"]!, itemsBase["CintoDoGigante"]!]
        )
        items["espadaDoDivino"] = Item(
            nome: "Espada do Divino",
            descricao: "A cada segundo, o usuário tem 5% de chance de receber 100% de Acerto Crítico",
            img: "espadaDivino",
            base: [itemsBase["GPC"]!, itemsBase["ArcoRecurvo"]!]
        )
        items["anjoGuardiao"] = Item(
            nome: "Anjo guardião",
            descricao: "Usuário ressuscita com 1000 de Vida",
            img: "anjoGuardiao",
            base: [itemsBase["GPC"]!, itemsBase["CotaDeMalha"]!]
        )
        items["sedentaPorSangue"] = Item(
            nome: "A Sedenta por Sangue",
            descricao: "Ataques curam em 50% do dano",
            img: "sedenta",
            base: [itemsBase["GPC"]!, itemsBase["CapaNegatron"]!]
        )
        items["lancaDeShojin"] = Item(
            nome: "Lança de Shojin",
            descricao: "Depois de conjurar, o usuário recebe 15% da sua Mana máxima por ataque",
            img: "shojin",
            base: [itemsBase["GPC"]!, itemsBase["LagrimaDaDeusa"]!]
        )
        items["laminaYoumuu"] = Item(
            nome: "Lâmina Fantasma de Youmuu",
            descricao: "+20 de dano de ataque adicional. Usuário também é um Assassino",
            img: "youmuu",
            base: [itemsBase["GPC"]!, itemsBase["Espatula"]!]
        )
        items["pistolaHextech"] = Item(
            nome: "Pistola Laminar Hextec",
            descricao: "Cura em 33% de todo o dano causado",
            img: "hextech",
            base: [itemsBase["GPC"]!, itemsBase["Bastao"]!]
        )
        items["hidraTitanica"] = Item(
            nome: "Hidra Titânica",
            descricao: "Ataques causam dano de dispersão de 10% da Vida máxima do usuário",
            img: "hidra",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["CintoDoGigante"]!]
        )
        items["canhaoFumegante"] = Item(
            nome: "Canhão Fumegante",
            descricao: "Os ataques do usuário não podem ser esquivados. Alcance de Ataque dobrado",
            img: "canhao",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["ArcoRecurvo"]!]
        )
        items["dancarinaFantasma"] = Item(
            nome: "Dançarina Fantasma",
            descricao: "Usuário esquiva de todos os Acertos Críticos",
            img: "dancarina",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["CotaDeMalha"]!]
        )
        items["laminaAmaldicoada"] = Item(
            nome: "Lâmina Amaldiçoada",
            descricao: "Ataques de contato têm uma chance baixa de reduzir o nível de estrela do inimigo em 1 pelo resto do combate",
            img: "laminaAmaldicoada",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["CapaNegatron"]!]
        )
        items["facaStatikk"] = Item(
            nome: "Faca de Statikk",
            descricao: "O 3º ataque causa 100 de Dano Mágico de dispersão",
            img: "statikk",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["LagrimaDaDeusa"]!]
        )
        items["espadaReiDestruido"] = Item(
            nome: "Espada do Rei Destruído",
            descricao: "+20 de velocidade de ataque adicional. Usuário também é um Mestre das Lâminas",
            img: "reiDestruido",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["Espatula"]!]
        )
        items["laminaGuinsoo"] = Item(
            nome: "Lâmina da Furia de Guinsoo",
            descricao: "Ataques concedem 4% de Velocidade de Ataque. Acumula infinitamente",
            img: "guinsoo",
            base: [itemsBase["ArcoRecurvo"]!, itemsBase["Bastao"]!]
        )
        items["efeitoVermelho"] = Item(
            nome: "Efeito vermelho",
            descricao: "Ataques causam dano de queimadura igual a 13% da Vida máxima do inimigo por 5.0s e impedem cura",
            img: "vermelho",
            base: [itemsBase["CotaDeMalha"]!, itemsBase["CintoDoGigante"]!]
        )
        items["armaduraEspinho"] = Item(
            nome: "Armadura de espinho",
            descricao: "Reflete 100% do dano mitigado por ataques",
            img: "armaduraEspinhos",
            base: [itemsBase["CotaDeMalha"]!, itemsBase["CotaDeMalha"]!]
        )
        items["quebraEspada"] = Item(
            nome: "Quebra-espada",
            descricao: "Ataques têm uma chance de desarmar por 4.0s",
            img: "quebraEspada",
            base: [itemsBase["CotaDeMalha"]!, itemsBase["CapaNegatron"]!]
        )
        items["coracaoCongelado"] = Item(
            nome: "Coração congelado",
            descricao: "Inimigos adjacentes perdem 25% de Velocidade de Ataque",
            img: "coracaoCongelado",
            base: [itemsBase["CotaDeMalha"]!, itemsBase["LagrimaDaDeusa"]!]
        )
        items["juramentoDoCavaleiro"] = Item(
            nome: "Juramento do Cavaleiro",
            descricao: "+20 de armadura adicional. Usuário também é um Cavaleiro",
            img: "juramentoDoCavaleiro",
            base: [itemsBase["CotaDeMalha"]!, itemsBase["Espatula"]!]
        )
        items["solari"] = Item(
            nome: "Medalhão dos Solari de Ferro",
            descricao: "No início de combate, aliados dentro de 2 casas na mesma linha recebem um escudo que bloqueia 200 de dano",
            img: "solari",
            base: [itemsBase["CotaDeMalha"]!, itemsBase["Bastao"]!]
        )
        items["zefiro"] = Item(
            nome: "Zéfiro",
            descricao: "No início do combate, um inimigo é banido por 5.0s",
            img: "zefiro",
            base: [itemsBase["CapaNegatron"]!, itemsBase["CintoDoGigante"]!]
        )
        items["garraDoDragao"] = Item(
            nome: "Garra do dragão",
            descricao: "Recebe 83% de Resistência a Dano Mágico",
            img: "garraDoDragao",
            base: [itemsBase["CapaNegatron"]!, itemsBase["CapaNegatron"]!]
        )
        items["quietude"] = Item(
            nome: "Quietude",
            descricao: "Ataques de contato têm alta chance de causar Silêncio, impedindo que o inimigo conjure habilidades por 5.0s",
            img: "quietude",
            base: [itemsBase["CapaNegatron"]!, itemsBase["LagrimaDaDeusa"]!]
        )
        items["runaan"] = Item(
            nome: "Furacão de Runaan",
            descricao: "+20 de resistência mágica adicional. Invoca um espírito que espelha seus ataques, causando 25% de dano",
            img: "runaan",
            base: [itemsBase["CapaNegatron"]!, itemsBase["Espatula"]!]
        )
        items["centelhaIonica"] = Item(
            nome: "Centelha Iônica",
            descricao: "Sempre que um inimigo conjurar uma habilidade, ele sofre 200 de dano",
            img: "centelhaIonica",
            base: [itemsBase["CapaNegatron"]!, itemsBase["Bastao"]!]
        )
        items["morello"] = Item(
            nome: "Morellonomicon",
            descricao: "Habilidades causam dano de queimadura igual a 25% da Vida máxima do inimigo por 5.0s e impedem cura",
            img: "morello",
            base: [itemsBase["Bastao"]!, itemsBase["CintoDoGigante"]!]
        )
        items["ecoDeLuden"] = Item(
            nome: "Eco de Luden",
            descricao: "Habilidades causam 200 de dano de dispersão ao contato",
            img: "ecoDeLuden",
            base: [itemsBase["Bastao"]!, itemsBase["LagrimaDaDeusa"]!]
        )
        items["yuumi"] = Item(
            nome: "Yuumi",
            descricao: "+20 de poder de habilidade adicional. Usuário também é um Feiticeiro",
            img: "yuumi",
            base: [itemsBase["Bastao"]!, itemsBase["Espatula"]!]
        )
        items["rabadon"] = Item(
            nome: "Capuz da Morte de Rabadon",
            descricao: "O atributo de Poder de Habilidade do usuário é amplificado em 50%",
            img: "rabadon",
            base: [itemsBase["Bastao"]!, itemsBase["Bastao"]!]
        )
        items["redencao"] = Item(
            nome: "Redenção",
            descricao: "Ao ficar abaixo de 25% de Vida, cura todos os aliados próximos em 1000 de Vida",
            img: "redencao",
            base: [itemsBase["LagrimaDaDeusa"]!, itemsBase["CintoDoGigante"]!]
        )
        items["abracoDeSeraph"] = Item(
            nome: "Abraço de Seraph",
            descricao: "Usuário recobra 20 de Mana depois da conjuração da habilidade",
            img: "seraph"
            ,
            base: [itemsBase["LagrimaDaDeusa"]!, itemsBase["LagrimaDaDeusa"]!]
        )
        items["darkin"] = Item(
            nome: "Darkin",
            descricao: "+20 de mana adicional. Usuário também é um Demônio",
            img: "darkin",
            base: [itemsBase["LagrimaDaDeusa"]!, itemsBase["Espatula"]!]
        )
        items["armaduraWarmog"] = Item(
            nome: "Armadura de Warmog",
            descricao: "Usuário regenera 6% da Vida máxima por segundo",
            img: "warmog",
            base: [itemsBase["CintoDoGigante"]!, itemsBase["CintoDoGigante"]!]
        )
        items["malhoCongelado"] = Item(
            nome: "Malho Congelado",
            descricao: "+200 de vida adicional. Usuário também é um Glacial",
            img: "malhoCongelado",
            base: [itemsBase["CintoDoGigante"]!, itemsBase["Espatula"]!]
        )
        items["forcaDaNatureza"] = Item(
            nome: "Força da Natureza",
            descricao: "Recebe +1 de tamanho da equipe",
            img: "forcaDaNatureza",
            base: [itemsBase["Espatula"]!, itemsBase["Espatula"]!]
        )
        return items
    }
    
}
