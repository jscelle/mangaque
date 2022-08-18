//
//  SinlgeMangaViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

class SingleMangaViewController: UIViewController {

    #warning("TODO: Implement router ")
    
    private var viewModel: SingleMangaViewModelInterface
    private var pageView = MangaPageCollectionView()
    
    init(viewModel: SingleMangaViewModelInterface) {
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
        
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.pageView.viewData = viewData
            }
        }
    }
}
