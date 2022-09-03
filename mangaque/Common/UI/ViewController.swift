//
//  ViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class ViewController<Input, Output>: UIViewController {
    
    var viewModel: ViewModel<Input, Output>
    
    let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel<Input, Output>) {
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
        
        viewModel.getOutput()
        
        // MARK: Bind to loading
        viewModel.loading.subscribe(onNext: { isLoading in
#warning("add skeleton for loading")
        }).disposed(by: disposeBag)
        
        // MARK: Bind to error
        
        viewModel.error.subscribe(onNext: { [weak self] error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.alert(message: error.localizedDescription)
            }
            
        }).disposed(by: disposeBag)
    }
    
    
    private func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
