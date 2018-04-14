import RxSwift

class GetSportsListUseCase {
    
    let container = DependencyInjection.shared.container
    let repository: SportsApiRepository
    
    init(repository: SportsApiRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<[SportEntity]> {
        return repository.getSportList()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }
}
