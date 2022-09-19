//
//  SearchViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: ViewController<String?, [MangaViewData]> {
        
    private lazy var searchView = SearchCollectionView(frame: self.view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
        
        searchView
            .textField
            .rx
            .text
            .bind(to: viewModel.inputData)
            .disposed(by: disposeBag)
                
        viewModel
            .outputData
            .bind(
                to: searchView
                    .collectionView
                    .rx
                    .items(
                cellIdentifier: "MangaCollectionViewCell",
                cellType: MangaCollectionViewCell.self
            )
        ) { row, data, cell in
            cell.mangaItem = data
        }.disposed(by: disposeBag)
        
        searchView
            .collectionView
            .rx
            .modelSelected(MangaViewData.self)
            .bind { item in
            
            self.coordinator.push(
                to: .singleManga(manga: item),
                sender: self
            )
            // this is for test only
                let vc = self.coordinator.getSeague(seague: .singleManga(manga: item))
                self.present(vc, animated: true)
                
            
        }.disposed(by: disposeBag)
        
        // trigger to loading start
        viewModel.inputData.accept("")
    }
}
