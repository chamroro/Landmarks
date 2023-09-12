/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A button that acts as a favorites indicator.
*/

import SwiftUI

struct FavoriteButton: View {
    // @Binding은 value이자 value를 변화시키는 방법.
    // 값의 저장소를 제어하고 데이터를 읽거나 써야하는 다른 view로 전달할 수 있음.
    @Binding var isSet: Bool

    var body: some View {
        Button {
            // 아래 식은 isSet = !isSet 과 같다. 다만 toggle이 더 직관적!
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
