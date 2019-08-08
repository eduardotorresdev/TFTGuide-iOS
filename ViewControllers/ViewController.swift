import UIKit

class ViewController: UIViewController{
    var itemsDefaultPosition = Array<CGPoint>()
    var itemOriginalCenterPosition:CGPoint?
    var itemAtivo:UIImageView?
    var itemRecenteAtivo:Item?
    var imgs:Array<UIImageView>?
    var item:ItemBuilder?
    var itemsBase:ItemBaseBuilder?
    var modalAberto = false
    var recentes:Array<UIImageView>?
    var distanceFromItemCenter:CGPoint?
    
    @IBOutlet var bgModal: BgModal?
    @IBOutlet var modalItem: ItemModal?
    @IBOutlet var itemDescricao: ItemDescricao?
    @IBOutlet var itemNome: UILabel?
    @IBOutlet var img1: ImageRounded?
    @IBOutlet var img2: ImageRounded?
    @IBOutlet var img3: ImageRounded?
    @IBOutlet var img4: ImageRounded?
    @IBOutlet var img5: ImageRounded?
    @IBOutlet var img6: ImageRounded?
    @IBOutlet var img7: ImageRounded?
    @IBOutlet var img8: ImageRounded?
    @IBOutlet var imgModal: ImageRounded?
    @IBOutlet var bgRecentes: BgRecentes?
    @IBOutlet var bgItensBase: BgItensBase?
    @IBOutlet var bgItensRecentes: BgItensRecentes?
    @IBOutlet var firstImgModal: ImageRounded?
    @IBOutlet var secondImgModal: ImageRounded?
    @IBOutlet var recentes1: UIImageView?
    @IBOutlet var recentes2: UIImageView?
    @IBOutlet var recentes3: UIImageView?
    @IBOutlet var recentes4: UIImageView?
    @IBOutlet var recentes5: UIImageView?
    
    @IBAction func modalItemDismiss(_ sender: UIButton) {
        UIView.transition(with: view, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.bgModal?.isHidden = true
        })
        UIView.transition(with: view, duration: 0.2, options: .curveEaseInOut, animations: {
            self.modalItem?.transform = CGAffineTransform(scaleX: 1.1, y:1.1)
            self.modalItem?.isHidden = true
            self.modalAberto = false
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imgs = self.getItems()
        guard let imagens = imgs else { return }
        for img in imagens {
            itemsDefaultPosition.append(img.center)
        }
        recentes = getItemsRecentes()
        itemsBase = ItemBaseBuilder(imgs: imagens)
        item = ItemBuilder(itemsBase: itemsBase!.getItemsBase())
        item?.itemsRecentes = ItemDao().carregarItems()
        item?.atualizaListaDeRecentes(recentes!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>?, with event: UIEvent?) {
        if(modalAberto == false){
            guard let touch = touches else { return }
            guard let touchLocation = touch.first?.location(in: self.view) else { return }
            guard let items = getItems() else { return }
            itemRecenteAtivo = item?.getItemRecenteByLocation(recentes!, on: touchLocation)
            itemAtivo = item?.getItemByLocation(items, on: touchLocation)
            guard let itemBase = itemAtivo else { return }
            itemOriginalCenterPosition = itemBase.center
            distanceFromItemCenter =  touchLocation-itemBase.center
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>?, with event: UIEvent!) {
        if(modalAberto == false){
            guard let touch = touches else { return }
            guard let touchLocation = touch.first?.location(in: self.view) else { return }
            guard let centerLocation = itemOriginalCenterPosition else { return }
            guard let distanceCenter = distanceFromItemCenter else { return }
            guard let imagem = itemAtivo else { return }
            guard let items = getItems() else { return }
            imagem.center = touchLocation-distanceCenter
            if(item?.itemIsAboveAnother(imagem, items: items, origin: centerLocation) != nil){
                imagem.layer.borderColor = UIColor.white.cgColor
                if(imagem.layer.borderWidth == 0){
                    imagem.animateBorderWidth(fromValue: 0, toValue: 6, duration: 0.1)
                }
            } else {
                if(imagem.layer.borderWidth == 6){
                    imagem.animateBorderWidth(fromValue: 6, toValue: 0, duration: 0.1)
                } else {
                    imagem.layer.borderWidth = 0
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>?, with event: UIEvent?) {
        if(modalAberto == false){
            if(itemAtivo != nil){
                combinacaoItemBase()
            } else if(itemRecenteAtivo != nil){
                consultaItemRecente()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let imagens = imgs else { return }
        for (index, imagem) in imagens.enumerated() {
            imagem.animatePosition(fromValue: imagem.layer.position, toValue: itemsDefaultPosition[index], duration: 0.3)
            if(imagem.layer.borderWidth == 6){
                imagem.animateBorderWidth(fromValue: 6, toValue: 0, duration: 0.3)
            }
        }
    }
    
    func getItems() -> Array<UIImageView>?{
        guard let item1 = img1 else { return nil }
        guard let item2 = img2 else { return nil }
        guard let item3 = img3 else { return nil }
        guard let item4 = img4 else { return nil }
        guard let item5 = img5 else { return nil }
        guard let item6 = img6 else { return nil }
        guard let item7 = img7 else { return nil }
        guard let item8 = img8 else { return nil }
        return [item1, item2, item3, item4, item5, item6, item7, item8]
    }
    
    func getItemsRecentes() -> Array<UIImageView>?{
        guard let item1 = recentes1 else { return nil }
        guard let item2 = recentes2 else { return nil }
        guard let item3 = recentes3 else { return nil }
        guard let item4 = recentes4 else { return nil }
        guard let item5 = recentes5 else { return nil }
        return [item5, item4, item3, item2, item1]
    }
    
    func setItemOnModal(_ item: Item, _ first:String, _ second:String) -> Bool{
        let maxSize = CGSize(width: 202, height: 59)
        guard let img = imgModal else { return false }
        guard let nome = itemNome else { return false }
        guard let descricao = itemDescricao else { return false }
        guard let firstImage = firstImgModal else { return false }
        guard let secondImage = secondImgModal else { return false }
        img.image = UIImage(named: item.img)
        nome.text = item.nome
        descricao.text = item.descricao
        let size = descricao.sizeThatFits(maxSize)
        descricao.frame = CGRect(origin: CGPoint(x: 86, y: 335), size: size)
        descricao.center.x = self.view.center.x
        if(first == item.base[0].nome){
            firstImage.image = item.base[0].img.image
            secondImage.image = item.base[1].img.image
        } else {
            firstImage.image = item.base[1].img.image
            secondImage.image = item.base[0].img.image
        }
        return true
    }
    
    func combinacaoItemBase() {
        guard let imagem = itemAtivo else { return }
        guard let centerLocation = itemOriginalCenterPosition else { return }
        guard let items = imgs else { return }
        let segImagem = item?.itemIsAboveAnother(imagem, items: items, origin: centerLocation)
        if(segImagem != nil){
            guard let itemsBaseUnpacked = itemsBase else { return }
            guard let firstItem = item?.getItemBaseByImg(imagem, itemsBaseUnpacked.getItemsBase()) else { return }
            guard let secondItem = item?.getItemBaseByImg(segImagem!, itemsBaseUnpacked.getItemsBase()) else {  return }
            guard let itemConsultado = item?.getItem(first: firstItem, second: secondItem) else { return }
            guard let imagensRecentes = recentes else { return }
            item?.inserirItemEmRecentes(itemConsultado)
            item?.atualizaListaDeRecentes(imagensRecentes)
            if(setItemOnModal(itemConsultado, firstItem, secondItem) == true){
                UIView.transition(with: view, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.bgModal?.isHidden = false
                })
                UIView.transition(with: view, duration: 0.2, options: .curveEaseInOut, animations: {
                    self.modalItem?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.modalItem?.isHidden = false
                    self.modalAberto = true
                })
            }
        }
        imagem.animatePosition(fromValue: imagem.layer.position, toValue: centerLocation, duration: 0.3)
        if(imagem.layer.borderWidth == 6){
            imagem.animateBorderWidth(fromValue: 6, toValue: 0, duration: 0.3)
        }
    }
    
    func consultaItemRecente(){
        guard let itemRecente = itemRecenteAtivo else { return }
        guard let imagensRecentes = recentes else { return }
        item?.inserirItemEmRecentes(itemRecente)
        item?.atualizaListaDeRecentes(imagensRecentes)
        if(setItemOnModal(itemRecente, itemRecente.base[0].nome, itemRecente.base[1].nome) == true){
            UIView.transition(with: view, duration: 0.1, options: .transitionCrossDissolve, animations: {
                self.bgModal?.isHidden = false
            })
            UIView.transition(with: view, duration: 0.2, options: .curveEaseInOut, animations: {
                self.modalItem?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.modalItem?.isHidden = false
                self.modalAberto = true
            })
        }
    }
    
}

extension UIImageView {
    func animateBorderWidth(fromValue: CGFloat, toValue: CGFloat, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
    }
    func animatePosition(fromValue: CGPoint, toValue: CGPoint, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(animation, forKey: "Position")
        layer.position = toValue
    }
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
