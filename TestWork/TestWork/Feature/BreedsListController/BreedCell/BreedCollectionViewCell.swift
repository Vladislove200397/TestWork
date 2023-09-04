//
//  BreedCollectionViewCell.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import UIKit
import Combine

final class BreedCollectionViewCell: UICollectionViewCell {
    // - Property
    static let id = String(describing: BreedCollectionViewCell.self)
    private var cancellables: Set<AnyCancellable> = []
    private var loadImageTask: Task<Void, Never>?
    private var loadTask: Task<Void, Never>?
    var breedImageDataService = NetworkManager<[BreedImageModel]>()
    
    // - UI
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = APPColor.labelThemeColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var breedImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = APPColor.activityIndicatorThemeColor
        return indicator
    }()
    
    // - lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - SetupCell
    private func makeLayout() {
        contentView.addSubview(breedImageView)
        contentView.addSubview(nameLabel)
        breedImageView.addSubview(activityIndicator)
        
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true
        contentView.backgroundColor = APPColor.cellContentViewThemeColor
    }
    
    private func makeConstraints() {
        breedImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-35)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func set(model: BreedModel) {
        nameLabel.text = model.name
        loadImage(id: model.id)
    }
    
    private func configureImage(for url: URL) {
        loadImageTask?.cancel()
        
        loadImageTask = Task { [weak self] in
            self?.breedImageView.image = nil
            self?.activityIndicator.startAnimating()
            do {
                try await self?.breedImageView.setImage(by: url)
                self?.breedImageView.contentMode = .scaleAspectFill
            } catch {
                self?.breedImageView.contentMode = .center
            }
            
            self?.activityIndicator.stopAnimating()
        }
    }
    
    func loadImage(id: String) {
        loadTask?.cancel()
        
        loadTask = Task {
            do {
                let result = try await breedImageDataService.getData(.imageURL(id: id))
                guard let image = result.first else { return }
                configureImage(for: URL(string: image.url)!)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
}
