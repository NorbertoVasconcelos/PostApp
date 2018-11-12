//
//  PostsViewController.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class PostsViewController: UIViewController {

    private let disposeBag = DisposeBag()

    var viewModel: PostsViewModel!
    var postsView: PostsView = PostsView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(postsView)
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        postsView.tableView.refreshControl = UIRefreshControl()
        postsView.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseID)
        postsView.tableView.backgroundColor = UIColor.clear
        postsView.tableView.separatorStyle = .none
        postsView.tableView.contentInset = UIEdgeInsets(top: 20,
                                                        left: 0.0,
                                                        bottom: 20,
                                                        right: 0.0)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let pull = postsView.tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let selection = postsView
            .tableView
            .rx
            .itemSelected
            .asDriver()
        
        let input = PostsViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         selection: selection)
        let output = viewModel.transform(input: input)
        
        
        output.combinedPosts
            .drive(postsView.tableView.rx.items(cellIdentifier: PostTableViewCell.reuseID,
                                                cellType: PostTableViewCell.self)) { (tv, post, cell) in
                                                    if let _post = post {
                                                        cell.bind(_post)
                                                    }
                                                }
            .disposed(by: disposeBag)
        
        output.fetching
            .drive(postsView.tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        output.selectedPost
            .drive(onNext: {
                post in
                print("Selected Post: \(post.title)")
            })
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: {
                error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    
}
