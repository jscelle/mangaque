//
//  SinlgeMangaViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class SingleMangaViewController: ViewController
{
    private lazy var pageView = MangaPageTableView(frame: self.view.bounds)
    
    private lazy var pickerView = UIPickerView()
    
    private lazy var chapterSelectView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(chapterSelectView)
        chapterSelectView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        view.addSubview(pageView)
        pageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageView.setupViews()
    }
    
    override func eventsSubscribe() {
        super.eventsSubscribe()
        
        guard let viewModel = self.viewModel as? SingleMangaViewModel else {
            return
        }
        
        let output = viewModel.transform()
        
        // MARK: bind collection view
        output
            .page
            .drive(
                pageView
                    .pageTableView
                    .rx
                    .items(
                        cellIdentifier: "MangaPageTableViewCell",
                        cellType: MangaPageTableViewCell.self
                    )
        ) { row, data, cell in
            cell.data = data
        }.disposed(by: disposeBag)
    }
}
