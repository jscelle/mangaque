//
//  ViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class ViewController: UIViewController {
        
    let viewModel: ViewModel
        
    private var isLoading = false
    
    let disposeBag = DisposeBag()
    
    init(
        viewModel: ViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsSubscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func eventsSubscribe() {
        
        // MARK: Bind to loading
        isLoading = true
        
        // MARK: Bind to error
        #warning("add error handling")
    }
    
    
    private func alert(message: String, title: String = "") {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let OKAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        
        alertController.addAction(OKAction)
        present(
            alertController,
            animated: true
        )
    }
}
