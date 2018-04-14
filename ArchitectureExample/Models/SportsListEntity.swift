import Foundation

struct SportsListEntity {
    var items: [SportEntity] = []
}

extension SportsListEntity: JSONDecodable {
    init(dictionary: JSONDictionary) throws {
    }
}
