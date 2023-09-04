//
//  BreedsListViewController.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import UIKit
import Combine
import SnapKit

final class BreedsListViewController: UIViewController {
    // - Property
    private var viewModel: BreedsListControllerViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 32) / 2
        let cellHeghit = cellWidth * 1.3
        layout.itemSize = CGSize(width: cellWidth, height: 200)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: BreedCollectionViewCell.id)
        collection.backgroundColor = .clear
        return collection
    }()
    
    // - Lifecycle
    init(viewModel: BreedsListControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
        binding()
        viewModel.getBreeds()
        view.backgroundColor = APPColor.backgroundViewThemeColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Cat Breed List"
    }
    
    // - SetupVC
    private func makeLayout() {
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // - BindingVM
    private func binding() {
        viewModel.$breedsArray
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in self?.collectionView.reloadData() }
            .store(in: &cancellables)
    }
}

//MARK: CollectionViewDataSource
extension BreedsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.breedsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.id, for: indexPath)

        (cell as? BreedCollectionViewCell)?.set(model: viewModel.breedsArray[indexPath.row])
        
        if indexPath.row == viewModel.breedsArray.count - 1, !viewModel.isLoad {
            viewModel.page += 1
            viewModel.getBreeds()
        }
        return cell
    }
}

//MARK: CollectionViewDelegate
extension BreedsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let wikiURL = viewModel.breedsArray[indexPath.row].wikiURL else { return }
        let breedName = viewModel.breedsArray[indexPath.row].name
        let wikiControllerVM = AboutBreedControllerViewModel(wikiURL: wikiURL, breedName: breedName)
        let wikiVC = AboutBreedViewController(viewModel: wikiControllerVM)
        
        navigationController?.pushViewController(wikiVC, animated: true)
    }
}
