//
//  VKOperationsService.swift
//  vkClient
//
//  Created by Anna Luchechko on 26.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

final class VKOperationsService {
    
    lazy var operationQueue = OperationQueue()
    
    enum DataType {
        case userGroups
        case searchGroups
    }
    
    func getApiData(dataType: DataType) {
        let jsonData = GetData()
        jsonData.dataType = dataType
        
        let parseData = ParseData()
        let saveRealm = SaveRealm()
        
        parseData.addDependency(jsonData)
        saveRealm.addDependency(parseData)
        
        let operations = [jsonData, parseData, saveRealm]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    
    class AsyncOperations: Operation {
        
        enum State: String {
            case ready, executing, finished
            fileprivate var keyPath: String {
                return "is" + rawValue.capitalized
            }
        }
        
        var state = State.ready {
            willSet {
                willChangeValue(forKey: state.keyPath)
                willChangeValue(forKey: newValue.keyPath)
            }
            didSet {
                didChangeValue(forKey: state.keyPath)
                didChangeValue(forKey: oldValue.keyPath)
            }
        }
        
        override var isAsynchronous: Bool {
            return true
        }

        override var isReady: Bool {
            return super.isReady && state == .ready
        }
        
        override var isExecuting: Bool {
            return state == .executing
        }
        
        override var isFinished: Bool {
            return state == .finished
        }
        
        override func start() {
            if isCancelled {
                state = .finished
            } else {
                main()
                state = .executing
            }
        }

        override func cancel() {
            super.cancel()
            state = .finished
        }
    }
    
    
    final class GetData: AsyncOperations {

        var apiData: Data?
        var apiError: Error?
        var dataType: DataType?

        override func main() {

            let configuration = URLSessionConfiguration.default
            let session =  URLSession(configuration: configuration)
            
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/users.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.124"),
            ]
            
            guard let dataType = dataType else { return }
            if dataType == .userGroups {
                urlConstructor.path = "/method/groups.get"
                urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(Session.shared.userID)))
                urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
            } else {
                urlConstructor.path = "/method/groups.search"
                urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "Google"))
                urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "h"))
            }
            
            let task = session.dataTask(with: urlConstructor.url!) { [weak self] (data, _, error) in
                guard let data = data else { return }

                self?.apiData = data
                self?.apiError = error
                self?.state = .finished
            }
            task.resume()
        }
    }
    
    
    final class ParseData: Operation {
        
        var groupData: [GroupRealm]?
        var groupError: Error?
        
        override func main() {
            
            guard let operation = dependencies.first as? GetData, let data = operation.apiData else { return }
            do {
                let groupModel = try JSONDecoder().decode(Group.self, from: data)
                var groupsList: [GroupRealm] = []
                for group in groupModel.response.items {
                    groupsList.append(GroupRealm(groupId: String(group.id), name: group.name, photo50: group.photo50, isMember: group.isMember ?? 0))
                }
                groupData = groupsList
            } catch let error {
                groupError = error
            }
        }
    }
    
    
    final class SaveRealm: Operation {
        
        override func main() {
            guard let operation = dependencies.first as? ParseData,
            let data = operation.groupData
            else { return }
            DispatchQueue.main.async {
                let vkRealmService = VKRealmService()
                vkRealmService.saveGroupsToRealm(groupsList: data)
            }
        }
    }
    
}
