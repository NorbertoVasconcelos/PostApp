//
//  PostDetailViewController.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import RxDataSources

class PostDetailViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    var viewModel: PostDetailViewModel!
    var postView: PostDetailView = PostDetailView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(postView)
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        postView.tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseID)
        postView.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseID)
        postView.tableView.backgroundColor = UIColor.clear
        postView.tableView.separatorStyle = .none
        postView.tableView.contentInset = UIEdgeInsets(top: 20,
                                                        left: 0.0,
                                                        bottom: 0.0,
                                                        right: 0.0)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let back = postView.btnBack.rx.tap.asDriver()
        
        let input = PostDetailViewModel.Input(trigger: viewWillAppear, back: back)
        let output = viewModel.transform(input: input)

        let dataSource = PostDetailViewController.dataSource()
        
        output.populatedPost
            .map { populatedPost -> [MultipleSectionModel] in
                let sections: [MultipleSectionModel] = [
                    .PostSection(title: "",
                                 items: [.PostSectionItem(viewModel: populatedPost)]),
                    .CommentSection(title: "",
                                    items: populatedPost.comments.map { return .CommentSectionItem(comment: $0) })
                ]
                return sections
            }
            .drive(postView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.back.drive().disposed(by: disposeBag)
        
        output.error
            .drive(onNext: {
                error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

}

extension UIViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxTableViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { (dataSource, table, idxPath, _) in
                switch dataSource[idxPath] {
                case let .PostSectionItem(viewModel):
                    let cell: PostTableViewCell = table.dequeueReusableCell(at: idxPath)
                    cell.bind(viewModel)
                    return cell
                case let .CommentSectionItem(comment):
                    let cell: CommentTableViewCell = table.dequeueReusableCell(at: idxPath)
                    cell.bind(comment)
                    return cell
                }
        },
            titleForHeaderInSection: { dataSource, index in
                let section = dataSource[index]
                return section.title
        }
        )
    }
}

enum MultipleSectionModel {
    case PostSection(title: String, items: [SectionItem])
    case CommentSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case PostSectionItem(viewModel: PopulatedPost)
    case CommentSectionItem(comment: Comment)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .PostSection(title: _, items: let items):
            return items
        case .CommentSection(title: _, items: let items):
            return items

        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .PostSection(title: title, items: _):
            self = .PostSection(title: title, items: items)
        case let .CommentSection(title, _):
            self = .CommentSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .PostSection(title: let title, items: _):
            return title
        case .CommentSection(title: let title, items: _):
            return title
        }
    }
}
