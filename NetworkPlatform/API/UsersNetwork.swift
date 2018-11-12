//
//  UsersNetwork.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift
import Domain

public final class UsersNetwork: Domain.UsersUseCase {
    
    private let network: Network<User>
    
    init(network: Network<User>) {
        self.network = network
    }
    
    public func users() -> Observable<[User]> {
        return network.getItems("users")
    }
    
    public func user(with id: Int) -> Observable<User> {
        return network.getItem("users", itemId: String(id))
    }
}
