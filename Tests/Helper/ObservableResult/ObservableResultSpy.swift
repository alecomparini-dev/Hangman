//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

class ObservableResultSpy {
    private(set) var emit: ((Any?) -> Void)?
    
    var setResult: Result<Any?, Error> = .success(nil)
    
    func observer(_ completion: @escaping (Any?) -> Void ) {
        emit = completion
    }
    
    func result<T>() async throws -> T? {
        switch setResult {
            case .success(let data):
                emit?(data)
                return data as? T
            case .failure(let error):
                emit?(error)
                throw error
        }
    }
    
    func sendOutput(_ output: Any) {
        emit?(output)
    }
    
}
