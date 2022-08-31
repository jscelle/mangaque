//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit
import RxSwift
import RxCocoa

class MainViewController: CollectionController<Empty, [MangaViewData]> {
    
    private lazy var mangaView = MangaCollectionView(frame: self.view.bounds)
    private lazy var searchView = SearchView()
    
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
        
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        searchView.setupView()
        
        let tapGesture = UITapGestureRecognizer()
        searchView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.subscribe(onNext: { recognizer in
            
            let searchViewController = Router.shared.getSeague(seague: Router.Scene.search)
            
            self.present(searchViewController, animated: true)
            
        }).disposed(by: disposeBag)
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
        mangaView.collectionView.rx.modelSelected(MangaViewData.self).bind { manga in
            
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

