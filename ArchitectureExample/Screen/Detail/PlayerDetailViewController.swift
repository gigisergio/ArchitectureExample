import UIKit
import RxSwift
import RxCocoa

class PlayerDetailViewController: ViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Private
    private let viewModel: PlayerDetailViewModelType
    
    // MARK: - Init
    init(viewModel: PlayerDetailViewModelType) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        setupViews()
        viewModel.reload()
    }
    
    // MARK: Setup
    private func setupViews() {
        title = "Player Detail"
    }
    
    private func setupRx() {
        viewModel.image
            .subscribe(onNext: {[weak self] urlString in
                guard let strongSelf = self, let urlString = urlString else  { return }
                
                if let url = URL(string: urlString) {
                    strongSelf.imageView.setImage(withURL: url)
                }
            })
            .disposed(by:self.bag)
    }
}

