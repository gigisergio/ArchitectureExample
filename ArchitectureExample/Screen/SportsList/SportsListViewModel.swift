import RxSwift
import RxDataSources

typealias SportSection = SectionModel<String, PlayerEntity>

protocol SportsListViewModelType: ViewModelType {
    var sectionDataSource: Variable<[SportSection]> { get }
    
    func getViewModelForCell(indexPath: IndexPath)-> PlayerCellViewModellType
    func didSelectItem(indexPath: IndexPath)
}

class SportsListViewModel: ViewModel,  SportsListViewModelType {

    var sectionDataSource: Variable<[SportSection]> = Variable([])

    // MARK: - Private
    private let bag = DisposeBag()
    private let router: SportsListRouterType
    private let useCase: GetSportsListUseCase
    
    // MARK: - Init
    init(router: SportsListRouterType,
         useCase: GetSportsListUseCase) {
        self.router = router
        self.useCase = useCase
        super.init(router: router)
    }
    
    // MARK: - Setup
    override func reload() {
        super.reload()
        
        useCase.execute()
            .subscribe(onNext:{ [weak self] sports in
                guard let strongSelf = self else { return }
                
                strongSelf.configureTableData(withItems: sports)
                
                }, onError: { error in
                    print(error)
            })
            .disposed(by:bag)
    }
    
    private func configureTableData(withItems items: [SportEntity]) {
        var itemsForSection = [SportSection]()
        items.forEach { itemsForSection.append(SportSection(model: $0.title, items: $0.players)) }
        sectionDataSource.value = itemsForSection
    }
    
    func getViewModelForCell(indexPath: IndexPath)-> PlayerCellViewModellType {
        let player = sectionDataSource.value[indexPath.section].items[indexPath.row]
        return PlayerCellViewModel(player: player)
    }

    func didSelectItem(indexPath: IndexPath) {
        let player = sectionDataSource.value[indexPath.section].items[indexPath.row]
        router.navigateTo(player: player)
    }
}
