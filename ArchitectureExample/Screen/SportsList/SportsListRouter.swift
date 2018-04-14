import UIKit

typealias SportsListRouterType = RouterType & PlayerDetailNavigable

class SportsListRouter: Router, PlayerDetailNavigable {

    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: nil)
    }
    
    override func start() {

        let viewModel = SportsListViewModel(router:self,
                                            useCase: container.resolve(GetSportsListUseCase.self)!)
        let viewController = SportsListViewController(viewModel: viewModel)

        self.navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
        
    }

    func navigateTo(player: PlayerEntity) {
        PlayerDetailRouter.init(navigationController: navigationController, player: player).start()
    }
}
