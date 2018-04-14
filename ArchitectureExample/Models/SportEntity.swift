import Foundation

struct SportEntity: Decodable {
    var title: String
    var type: String
    var players: [PlayerEntity]
}
