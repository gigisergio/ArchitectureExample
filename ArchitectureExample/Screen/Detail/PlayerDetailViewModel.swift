import RxSwift

protocol PlayerDetailViewModelType: ViewModelType {
    var image: Observable<String?> {get}
}

class PlayerDetailViewModel: ViewModel,  PlayerDetailViewModelType {
    
    // MARK: - Input
    private var imageVariable: Variable<String?> = Variable(nil)
    
    // MARK: - Output
    lazy var image: Observable<String?> = self.imageVariable.asObservable()
    
    // MARK: - Private
    private let bag = DisposeBag()
    private let router: PlayerDetailRouterType
    
    // MARK: - Init
    
    init(router: PlayerDetailRouterType, player: PlayerEntity) {
        
        self.router = router
        self.imageVariable.value = player.image
        super.init(router: router)
    }
    
}


