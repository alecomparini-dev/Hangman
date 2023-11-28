//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

struct DollCodable {
    public var body: BodyDollCodable
    public var head: HeadDollCodable
    public var success: [String]
    public var fail: [String]
}

struct BodyDollCodable {
    public var images: [String]
    
    public init(dict: [String: Any]) {
        self.images = dict.values.map({$0 as? String ?? ""})
    }
}

struct HeadDollCodable {
    public var images: [String]

    public init(dict: [String: Any]) {
        self.images = dict.values.map({$0 as? String ?? ""})
    }
    
}
