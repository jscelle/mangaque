//
//  MangaCollectionViewCell.swift
//  mangaque
//
//  Created by Artyom Raykh on 11.08.2022.
//

import Kingfisher

class MangaCollectionViewCell: UICollectionViewCell {
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var mangaItem: MangaViewDataItem? {
        didSet {
            configureCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        addSubview(titleLabel)
        addSubview(coverImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        coverImageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(10)
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        backgroundColor = .lightGray.withAlphaComponent(0.05)
        layer.cornerRadius = 10
    }
    
    func configureCell() {
        
        guard let mangaItem = mangaItem else {
            return
        }
        titleLabel.text = mangaItem.title
        coverImageView.kf.setImage(with: mangaItem.coverURL) { result in
            switch result {
            case .failure(let error):
                #warning("present error")
                print(error)
            case .success:
                break
            }
        }
    }
}
