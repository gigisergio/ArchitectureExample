import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SportsListViewController: ViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib.init(nibName: PlayerTableViewCell.cellId, bundle: nil),
                               forCellReuseIdentifier: PlayerTableViewCell.cellId)
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    // MARK: - Private
    private let viewModel: SportsListViewModelType
    
    // MARK: - Init
    
    init(viewModel: SportsListViewModelType) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit SportsListViewController")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        setupViews()
        applyStyle()
        viewModel.reload()
    }
    
    // MARK: Setup
    
    private func setupViews() {
        title = "Best Players"
    }
    
    private func applyStyle() {
        
    }
    
    private func setupRx() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SportSection>(configureCell: {
            [weak self] dataSource, tableView, indexPath, cell  in
            let defaultCell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            guard let strongSelf = self else  { return defaultCell }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.cellId,
                                                           for: indexPath) as? PlayerTableViewCell else { return defaultCell }
            
            cell.configure(viewModel: strongSelf.viewModel.getViewModelForCell(indexPath: indexPath))
            return cell
            }, titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].model
        })
        
        viewModel.sectionDataSource.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by:bag)
        
        tableView.rx.itemSelected
            .throttle(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let strongSelf = self else { return }
                
                strongSelf.viewModel.didSelectItem(indexPath: indexPath)
            }).disposed(by:bag)
    }
}
