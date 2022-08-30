//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit
import RxSwift

class MainViewController: CollectionController<[MainViewData]> {
    
    private lazy var mangaView = MangaCollectionView(frame: self.view.bounds)
    private var searchView = SearchView()
    
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
        mangaView.setupView()
    }
    
    override func eventsSubscribe() {
        
        super.eventsSubscribe()
        
        // MARK: bind collection view
        collectionData.bind(
            to: mangaView.collectionView.rx.items(
                cellIdentifier: "MangaCollectionViewCell",
                cellType: MangaCollectionViewCell.self
            )
        ) { row, data, cell in
            cell.mangaItem = data
        }.disposed(by: disposeBag)
        
        // MARK: bind collection view action
        mangaView.collectionView.rx.modelSelected(MainViewData.self).bind { manga in
            
            let singleMangaController = Router.shared.getSeague(
                seague: Router.Scene.singleManga(
                    manga: manga
                )
            )
            
            singleMangaController.modalPresentationStyle = .fullScreen
            
            self.present(singleMangaController, animated: true)
            
        }.disposed(by: disposeBag)
    }
}

