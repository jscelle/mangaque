//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit

class ViewController: UIViewController {

    var mangaViewModel: MangaViewModelInterface!
    
    private var mangaView = MangaContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        view.addSubview(mangaView)
        mangaView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        updateView()
        
        mangaViewModel.startFetch()
    }
    
    private func updateView() {
        mangaViewModel.updateMangaViewData = { [weak self] viewData in
            guard let self = self else {
                return
            }
            
            self.mangaView.viewData = viewData
        }
    }
}

