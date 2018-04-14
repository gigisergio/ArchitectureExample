import Swinject

final class DependencyInjection {
    let container: Container
    static let shared = DependencyInjection()
    
    private init() {
        container = Container()
        setup()
    }
    
    private func setup() {
        container.register(SportsApiRepository.self) {_ in
            SportsApiRepository(apiClient: ApiClient.shared)
        }
        container.register(GetSportsListUseCase.self) {r in
            GetSportsListUseCase(repository: r.resolve(SportsApiRepository.self)!)
        }
    }
}
