//
//  SinlgeMangaViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class SingleMangaViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: SingleMangaViewModel
    
    private lazy var pageView = MangaPageTableView(frame: self.view.bounds)
    
    private lazy var pickerView = UIPickerView()
    
    private lazy var chapterSelectView = UIView()
    
    init(viewModel: SingleMangaViewModel) {
        self.viewModel = viewModel
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
    
    func eventsSubscribe() {
        
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
