import UIKit

typealias PlayerDetailRouterType = RouterType

class PlayerDetailRouter: Router {

    private var player: PlayerEntity
    
    init(navigationController: UINavigationController?, player: PlayerEntity) {
        self.player = player
        super.init(navigationController: navigationController)
    }
    
    override func start() {

        let viewModel = PlayerDetailViewModel(router:self, player: player)
        let viewController = PlayerDetailViewController(viewModel: viewModel)

        navigationController?.pushViewController(viewController, animated: true)
    }
}
