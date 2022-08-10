//
//  MangaContainerView.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import SnapKit

class MangaContainerView: UIView {

    var viewData: ViewData<MangaViewDataItem> = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    
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
    #warning("make sure this is the most accurate way")
    private func setupView(viewData: MangaViewDataItem) {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.text = viewData.title
        print(viewData.title)
    }
}
