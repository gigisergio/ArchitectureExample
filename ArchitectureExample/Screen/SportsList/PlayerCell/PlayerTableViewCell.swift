import UIKit
import RxSwift

class PlayerTableViewCell: UITableViewCell {
    
    static let cellId = String(describing: PlayerTableViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - private
    fileprivate var viewModel: PlayerCellViewModellType?
    private var bag = DisposeBag()
    
    // MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        bag = DisposeBag()
        photoImageView.cancelRequest()
        photoImageView.image = nil
    }
    
    func configure(viewModel: PlayerCellViewModellType) {
        self.viewModel = viewModel
        setupRx()
        applyStyle()
    }
    
    // MARK: - Setup
    func applyStyle() {
        infoView.style(.shadowCromoView)
    }
    
    func setupRx() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: bag)
        viewModel.surname
            .bind(to: surnameLabel.rx.text)
            .disposed(by: bag)
        viewModel.date
            .bind(to: dateLabel.rx.text)
            .disposed(by: bag)
        viewModel.image
            .subscribe(onNext: {[weak self] urlString in
                guard let strongSelf = self, let urlString = urlString else  { return }
                
                if let url = URL(string: urlString) {
                    strongSelf.photoImageView.setImage(withURL: url)
                }
            })
            .disposed(by:self.bag)
    }
}
