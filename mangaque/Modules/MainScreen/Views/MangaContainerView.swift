//
//  MangaContainerView.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import SnapKit

class MangaContainerView: UIView {

    var viewData: ViewData<[MangaViewDataItem]> = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    var mangas: [MangaViewDataItem] = []
    
    lazy var collectionView = createCollectionView()
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        switch viewData {
        case .initial:
            break
        case .loading(_):
            break
        case .success(let success):
            setupView(viewData: success)
            break
        case .failure(_):
            break
        }
    }
    
    private func setupView(viewData: [MangaViewDataItem]) {
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
    }
}
