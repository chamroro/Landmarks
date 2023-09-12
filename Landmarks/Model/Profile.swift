/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of user profile data.
*/

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "Hani")

    /*
     CaseIterable 프로토콜을 따를 때 Enum의 모든 케이스를 순회(iterate)할 수 있는 기능을 제공
     이를 활용하여 Enum의 모든 케이스를 반복적으로 처리
     */
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
