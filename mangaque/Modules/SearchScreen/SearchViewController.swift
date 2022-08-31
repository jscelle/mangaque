//
//  SearchViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: ViewController<String?, [MangaViewData]> {
    
    private let translator = TranslateManager()
    
    private lazy var searchView = SearchCollectionView(frame: self.view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        Task {
            do {
                let response = await translator.detectLanguage(text: "Всем привет, с вами я Санечек")
            }
        }
    }
    
    private func setupViews() {
        
        view.backgroundColor = R.color.background()
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        searchView.setupViews()
    }
    
    override func eventsSubscribe() {
        super.eventsSubscribe()
        
        (searchView.textField.rx.text <-> viewModel.inputData).disposed(by: disposeBag)
        
        viewModel.outputData.bind(to: searchView.collectionView.rx.items(
                cellIdentifier: "MangaCollectionViewCell",
                cellType: MangaCollectionViewCell.self
            )
        ) { row, data, cell in
            cell.mangaItem = data
        }.disposed(by: disposeBag)
        
        searchView.collectionView.rx.modelSelected(MangaViewData.self).bind { item in
            
            let singleMangaController = Router.shared.getSeague(
                seague: Router.Scene.singleManga(
                    manga: item
                )
            )
            singleMangaController.modalPresentationStyle = .fullScreen
            self.present(singleMangaController, animated: true)
            
        }.disposed(by: disposeBag)
    }
}
