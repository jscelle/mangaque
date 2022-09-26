//
//  SearchViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import SnapKit
import RxSwift
import RxCocoa
import Nivelir

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
            .bind
        { item in
            self.navigator.navigate(from: self) { route in
                route.present(SingleMangaScreen(item: item), animated: true)
            }
            
        }.disposed(by: disposeBag)
        
        // trigger to loading start
        viewModel.inputData.accept("")
    }
}

struct Screens {
    func someScreen(item: MangaViewData) -> AnyModalScreen {
        return SingleMangaScreen(item: item).eraseToAnyScreen()
    }
}