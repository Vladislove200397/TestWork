//
//  AboutBreedViewController.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import UIKit
import WebKit
import Combine

final class AboutBreedViewController: UIViewController {
    // - Property
    private(set) var viewModel: AboutBreedControllerViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // - UI
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        return webView
    }()
    
    // - Lifecycle
    init(viewModel: AboutBreedControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        makeLayout()
        makeConstraints()
        title = viewModel.breedName
    }
    
    // - Configure
    private func makeLayout() {
        view.addSubview(webView)

        view.backgroundColor = APPColor.backgroundViewThemeColor
    }
    
    private func makeConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // - Binding
    private func binding() {
        self.viewModel.$wikiURL
            .sink { url in
                var request = URLRequest(url: URL(string: url)!)
                request.cachePolicy = .returnCacheDataElseLoad
                self.webView.load(request)
            }
            .store(in: &cancellables)
    }
}
