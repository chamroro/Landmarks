/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine

// 랜드마크 데이터를 관찰 가능한 객체에 저장
// ObservableObject 란? SwiftUI 환경의 저장소에서 뷰에 바인딩될 수 있는 데이터에 대한 사용자 정의 객체.

// final이란? final은 클래스, 메서드 또는 속성 앞에 붙여서 해당 요소를 상속 또는 재정의할 수 없도록 만드는 키워드로, final 키워드를 사용하면 해당 요소는 최종적이고 변경 불가능한 것으로 간주됨.
// final은 코드의 안정성을 유지하고 의도하지 않은 변경을 방지하기 위한 유용한 도구로 활용
    // final의 주요 역할
    // 상속 제한: 클래스에 final을 사용하면 해당 클래스를 상속할 수 없습니다. 이를 통해 클래스의 구현을 변경하지 않는 한 클래스의 동작을 보호하고 안정성을 유지할 수 있습니다.
    // 재정의 방지: 메서드나 속성에 final을 사용하면 하위 클래스에서 해당 멤버를 재정의할 수 없습니다. 이로써 클래스의 특정 동작이나 속성을 변경하지 못하도록 할 수 있습니다.


final class ModelData: ObservableObject {
    //@Published 속성 래퍼와 ObservableObject 프로토콜을 활용하여 랜드마크 데이터를 관찰 가능한 객체로 선언. 이를 통해 데이터의 변경을 자동으로 감지하고, SwiftUI 뷰가 해당 데이터에 바인딩되어 있는 경우에 자동으로 업데이트가 발생. (Combine)
    // @Published 속성 래퍼는 프로퍼티의 값이 변경될 때마다 관찰 가능한 객체에게 변경 사항을 알리도록 함. 이를 통해 객체에 등록된 SwiftUI 뷰가 해당 데이터에 대한 변경 사항을 즉시 반영.
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    //"메인 번들(Main Bundle)"은 iOS, macOS 등의 애플 플랫폼에서 앱의 실행 가능한 파일과 리소스(이미지, 사운드, 데이터 파일 등)가 포함되어 있는 디렉토리를 의미. 간단히 말해, 앱이 설치되고 실행될 때 포함된 파일과 리소스가 저장되어 있는 곳
    
    // iOS 앱을 예로 들면, 메인 번들이 포함하고 있는 것은:

    // 앱의 실행 파일 (실행 가능한 코드)
    // 이미지 파일
    // 사운드 파일
    // 데이터 파일 (예: JSON, XML 등)
    // 스토리보드 파일 (인터페이스 구성)
    // 아이콘 및 이미지 리소스
    // 지역화된 문자열 파일 등
    // 따라서 "메인 번들에서 파일을 찾는다"는 것은 앱의 실행 가능한 위치에서 파일을 검색한다는 의미.
    // 코드에서 Bundle.main은 현재 실행 중인 앱의 메인 번들을 나타내며, 여기서 파일을 찾거나 리소스에 액세스할 수 있음
    
    // guard 문은 Swift 프로그래밍 언어에서 사용되는 제어 흐름 문
    // guard 문은 주로 조건이 참이 아닌 경우, 빠르게 코드를 종료하거나 에러를 처리하기 위해 사용됨.
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

