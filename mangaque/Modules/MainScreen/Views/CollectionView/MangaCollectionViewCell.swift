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
        
        #warning("make it fit full widht +  bind to top")
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.top.equalTo(coverImageView.snp.bottom).inset(10)
        }
        
        coverImageView.contentMode = .scaleAspectFit
        
        titleLabel.numberOfLines = 0
        
        backgroundColor = .lightGray.withAlphaComponent(0.05)
        layer.cornerRadius = 10
    }
    
    func configureCell() {
        
        guard let mangaItem = mangaItem else {
            return
        }
        titleLabel.text = mangaItem.title
        coverImageView.kf.setImage(with: mangaItem.coverURL) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            guard let coverImage = self.coverImageView.image else {
                return
            }
            
            self.coverImageView.image = coverImage.cropImage(
                cropWidth: coverImage.size.width,
                cropHeight: coverImage.size.width * 1.3
            )
        }
    }
}
