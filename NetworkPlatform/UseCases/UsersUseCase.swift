//
//  UsersUseCase.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class UsersUseCase: Domain.UsersUseCase {
    
    let network: UsersNetwork
    
    init(network: UsersNetwork) {
        self.network = network
    }

    public func user(with id: Int) -> Observable<User> {
        return network.user(with: id)
    }
}
