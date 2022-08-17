//
//  SinlgeMangaViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

class SinlgeMangaViewController: UIViewController {

    #warning("TODO: Implement router ")
    
    private var viewModel: SingleMangaViewModelInterface
    
    init(viewModel: SingleMangaViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.startFetch()
        view.backgroundColor = .gray
    }
}
