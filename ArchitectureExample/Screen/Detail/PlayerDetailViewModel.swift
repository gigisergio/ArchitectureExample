import RxSwift

protocol PlayerDetailViewModelType: ViewModelType {

    // var xxxObservable: Observable<type> {get}

}

class PlayerDetailViewModel: ViewModel,  PlayerDetailViewModelType {

    // MARK: - Input
    //private var xxxVariable: Variable<type> = Variable()
    
    // MARK: - Output
    //lazy var xxxObservable: Observable<type> = self.xxxVariable.asObservable()
    
    // MARK: - Private
    private let bag = DisposeBag()
    private let router: PlayerDetailRouterType

    // MARK: - Init
    
    init(router: PlayerDetailRouterType, player: PlayerEntity) {

        self.router = router
        super.init(router: router)
    }

}


