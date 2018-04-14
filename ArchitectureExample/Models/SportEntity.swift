import Foundation

struct SportEntity {
    var title: String
    var type: String
    var players: [PlayerEntity]
}

extension SportEntity: JSONDecodable {
    init(dictionary: JSONDictionary) throws {
        guard let title = dictionary["title"] as? String else {
            throw JSONDecodingError.wrongJSONFormat
        }
        guard let type = dictionary["type"] as? String else {
            throw JSONDecodingError.wrongJSONFormat
        }
        guard let players = dictionary["players"] as? Array<JSONDictionary> else {
            throw JSONDecodingError.wrongJSONFormat
        }
        self.players = try players.fill()
        self.title = title
        self.type = type
    }
}
