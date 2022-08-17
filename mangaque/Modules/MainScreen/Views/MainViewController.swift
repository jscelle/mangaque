//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit


class MainViewController: UIViewController {
    
    private var mangaViewModel: MainScreenMangaViewModelInterface
    private var mangaView = MangaCollectionView()
    private var searchView = SearchView()
    
    private var router: Router
    
    init(
        mangaViewModel: MainScreenMangaViewModelInterface,
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
        
        mangaView.mangaSelected = { [weak self] item in
            
            guard let self = self else {
                return
            }
            
            self.router.route(
                to: MainScreenRoutes.MangaScreen.rawValue,
                from: self,
                parameters: item
            )
        }
        
        updateView()
        
        mangaViewModel.startFetch()
    }
    
    private func updateView() {
        mangaViewModel.updateMangaViewData = { [weak self] viewData in
            self?.mangaView.viewData = viewData
        }
    }
}

