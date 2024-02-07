//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public struct DollPresenterDTO {
    public var head: String?
    public var body: String?
    public var success: String?
    public var fail: String?
    
    public init(head: [String]? = nil, body: [String]? = nil, success: [String]? = nil, fail: [String]? = nil) {
        self.head = head
        self.body = body
        self.success = success
        self.fail = fail
    }
    
}
