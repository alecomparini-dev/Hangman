//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

class ObservableResultSpy<T> {
    private(set) var emit: ((T?) -> Void)?
    
    var setResult: Result<T?, Error> = .success(nil)
    
    func observer(_ completion: @escaping (T?) -> Void ) {
        emit = completion
    }
    
    func result() async throws -> T? {
        switch setResult {
            case .success(let data):
                emit?(data)
                return data
            case .failure(let error):
                emit?(nil)
                throw error
        }
    }
    
}
