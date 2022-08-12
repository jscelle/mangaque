//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit

class MainViewController: UIViewController {
    
    var mangaViewModel: MangaViewModelInterface
    private var mangaView = MangaCollectionView()
    
    
    init(mangaViewModel: MangaViewModelInterface) {
        self.mangaViewModel = mangaViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = R.color.background()
        
        view.addSubview(mangaView)
        mangaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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

