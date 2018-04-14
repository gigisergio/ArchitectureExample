import Foundation

struct PlayerEntity {
    var name: String
    var surname: String
    var image: String? = nil
    var date: String? = nil
}

extension PlayerEntity: JSONDecodable {
    init(dictionary: JSONDictionary) throws {
        guard let name = dictionary["name"] as? String else {
            throw JSONDecodingError.wrongJSONFormat
        }
        guard let surname = dictionary["surname"] as? String else {
            throw JSONDecodingError.wrongJSONFormat
        }
        if let image = dictionary["image"] as? String {
            self.image = image
        }
        if let date = dictionary["date"] as? String {
            self.date = date
        }
        self.name = name
        self.surname = surname
    }
}
