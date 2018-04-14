import RxSwift

protocol PlayerCellViewModellType {
    var name: Observable<String> {get}
    var surname: Observable<String> {get}
    var image: Observable<String?> {get}
    var date: Observable<String?> {get}
}

class PlayerCellViewModel: PlayerCellViewModellType {
    
    // MARK: - output
    lazy var name: Observable<String> = self.nameVariable.asObservable()
    lazy var surname: Observable<String> = self.surnameVariable.asObservable()
    lazy var image: Observable<String?> = self.imageVariable.asObservable()
    lazy var date: Observable<String?> = self.dateVariable.asObservable()
    
    // MARK: - input
    private var nameVariable: Variable<String> = Variable("")
    private var surnameVariable: Variable<String> = Variable("")
    private var imageVariable: Variable<String?> = Variable(nil)
    private var dateVariable: Variable<String?> = Variable(nil)
    
    // MARK: - private
    private let bag = DisposeBag()
    
    init(player: PlayerEntity) {
        self.nameVariable.value = player.name
        self.surnameVariable.value = player.surname
        self.imageVariable.value = player.image
        self.dateVariable.value = player.date
    }
}
