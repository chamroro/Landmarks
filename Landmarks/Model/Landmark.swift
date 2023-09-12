/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation
    // Codable protocol: 파일에서 데이터를 읽기 위하여 Codable의 Decodable 구성요소에 의존
    // Identifiable:
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    /* 스위프트 주요 프로토콜 모음 https://seons-dev.tistory.com/entry/Swift-Swift%EC%9D%98-%EC%A3%BC%EC%9A%94-%ED%94%84%EB%A1%9C%ED%86%A0%EC%BD%9C-%EB%AA%A8%EC%9D%8C
     */
    /*
     CaseIterable 프로토콜은 열거형(enum)이 모든 케이스의 값을 순회 가능한(enumerable) 컬렉션으로 만들어줌
     이 프로토콜을 채택한 열거형은 allCases라는 정적 속성을 제공하며,
     이 속성을 통해 열거형의 모든 케이스를 배열 형태로 얻을 수 있습니다. allCases는 열거형의 케이스를 정의한 순서대로 배열에 담겨 있다.
     
     enum Fruit: CaseIterable {
         case apple, banana, orange, grape
     }

     let allFruits = Fruit.allCases
     print(allFruits) // 출력: [apple, banana, orange, grape]
     */
    /*
     Codable 프로토콜은 스위프트의 타입을 직렬화(인코딩)하거나 역직렬화(디코딩)할 수 있도록 해주는 프로토콜
     Codable은 두 개의 중첩된 프로토콜인 Encodable과 Decodable의 별칭으로 구성되어 있음.
     */
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
    /*
     여기서 imageName 속성은 이미지의 이름을 나타내며, image 속성은 해당 이미지를 실제로 로드하여 SwiftUI의 Image로 반환하는 computed property. 이렇게 함으로써, 랜드마크 구조체의 사용자들은 이미지 자체에만 관심을 가지게 됨. 또한 코드에 init 메서드를 추가하여 초기화할 때 imageName을 전달받도록 해야함.
     "이미지 자체에만 관심을 가진다"는 말은 사용자들이 랜드마크 구조체를 사용할 때 이미지의 실제 내용이나 로드 방식에 대해서 신경쓰지 않고, 단순히 이미지를 표시하거나 활용하는 데 집중한다는 의미
     사용자가 이미지를 효율적으로 활용하기 위한 인터페이스를 제공하면서도, 내부적인 이미지 로딩 및 관리를 랜드마크 구조체 내부로 캡슐화
     */
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }

    // 위와 마찬가지로, coordinates는 다음 단계에서 계산된 공용 속성을 만드는 데만 사용할 것이기 때문에 private로 표시
    private var coordinates: Coordinates
    // MapKit 사용하여 locationCoordinate computing
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
