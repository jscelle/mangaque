//
//  ViewController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import UIKit
import RxSwift

class ViewController<T>: UIViewController {
    
    var viewModel: ViewModel<T>
    
    let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel<T>) {
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
        
        viewModel.startFetch()
        
        // MARK: Bind to loading
        viewModel.loading.subscribe(onNext: { isLoading in
            #warning("add skeleton for loading")
            print(isLoading)
        }).disposed(by: disposeBag)
        
        // MARK: Bind to error
        
        viewModel.error.subscribe(onNext: { error in
            #warning("show error")
            print(error)
        }).disposed(by: disposeBag)
    }
}
