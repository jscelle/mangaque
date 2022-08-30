//
//  SinlgeMangaViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class SingleMangaViewController: CollectionController<[PageViewData]> {

    #warning("TODO: Implement router ")
    
    private lazy var pageView = MangaPageTableView(frame: self.view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(pageView)
        pageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageView.setupViews()
    }
    
    override func eventsSubscribe() {
        
        super.eventsSubscribe()
        
        // MARK: bind collection view
        collectionData.bind(
            to: pageView.pageTableView.rx.items(
                cellIdentifier: "MangaPageTableViewCell",
                cellType: MangaPageTableViewCell.self
            )
        ) { row, data, cell in
            cell.data = data
        }.disposed(by: disposeBag)
    }
}