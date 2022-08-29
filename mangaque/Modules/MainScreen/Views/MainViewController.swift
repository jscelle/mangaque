//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit
import RxSwift

class MainViewController: UIViewController {
    
#warning("TODO: Change kingfisher to own image download implementation")
#warning("TODO: Make loading view")
    
    private let bag = DisposeBag()
    
    private var router: Router
    private var mangaViewModel: MainViewModel
    private lazy var mangaView = MangaCollectionView(frame: self.view.bounds)
    private var searchView = SearchView()
    
    init(
        mangaViewModel: MainViewModel,
        router: Router
    ) {
        self.mangaViewModel = mangaViewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = R.color.background()
        
        view.addSubview(mangaView)
        
        mangaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mangaView.collectionView.rx.modelSelected(MainViewData.self).bind { manga in
            print(manga)
        }.disposed(by: bag)
        
        updateView()
        
        mangaView.setupView()
        
        mangaViewModel.startFetch()
    }
    
    private func updateView() {
        
        mangaViewModel.data.subscribe(
            onNext: { [weak self] viewData in
                
                guard let self = self else {
                    return
                }
                
                switch viewData {
                case .success(let data):
                    
                    print(data.count)
                    
                    DispatchQueue.main.async {
                        self.mangaView.mangaItems = data
                        self.mangaView.collectionView.reloadData()
                    }
                case .failure(let error):
                    #warning("error handler")
                case .loading:
                    #warning("loading skeleton")
                case .initial:
                    #warning("initial skeleton")
                }
            }).disposed(by: bag)
    }
}

