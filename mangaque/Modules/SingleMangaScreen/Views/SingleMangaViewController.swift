//
//  SinlgeMangaViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class SingleMangaViewController: UIViewController {

    #warning("TODO: Implement router ")
    
    private var viewModel: SingleMangaViewModel
    private lazy var pageView = MangaPageTableView(frame: self.view.bounds)
    
    init(viewModel: SingleMangaViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        setupViews()
        
        updateView()
    }
    
    private func setupViews() {
        viewModel.startFetch()
        
        view.addSubview(pageView)
        pageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageView.setupViews()
    }
    
    private func updateView() {
        
        #warning("make this work :)")
        
        
        viewModel.data.bind(
            to: pageView.pageTableView.rx.items(
                cellIdentifier: "MangaPageTableViewCell",
                cellType: MangaPageTableViewCell.self
            ) { (row, model, cell) in
                
                cell.url = model.url
            }
        )
    }
}
