//
//  SearchViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: ViewController {
        
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
        
        guard let viewModel = self.viewModel as? SearchViewModel else {
            return
        }
        
        let textInput = getText()
        
        let input = SearchInput(
            text: textInput
        )
        
        let output = viewModel.transform(input: input)
               
        output
            .mangaData
            .drive(
                searchView
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
            
            viewModel.toSingle(item: item)
            
        }.disposed(by: disposeBag)
    }
    
    private func getText() -> Observable<String> {
        searchView
            .textField
            .rx
            .text
            .compactMap { $0 }
            .asObservable()
    }
}
