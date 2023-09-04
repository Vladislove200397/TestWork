//
//  BreedsListViewController.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import UIKit
import Combine

class BreedsListViewController: UIViewController {
    // - Property
    private var viewModel: BreedsListControllerViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    // - Lifecycle
    init(viewModel: BreedsListControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        makeLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getBreeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - SetupVC
    private func makeLayout() {
        view.addSubview(collectionView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    // - BindingVM
    private func binding() {
        viewModel.$breedsArray
            .sink {[weak self] models in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

//MARK: CollectionViewDataSource

extension BreedsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

//MARK: CollectionViewDelegate

extension BreedsListViewController: UICollectionViewDelegate {
    
}
