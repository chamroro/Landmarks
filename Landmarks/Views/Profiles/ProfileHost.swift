/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts the profile viewer and editor.
*/

import SwiftUI

struct ProfileHost: View {
    /*
     편집 버튼은 편집 모드를 지원하는 컨테이너 내 콘텐츠에 대한 환경의 editMode 값을 전환
     edit모드가 active일땐 editButton은 'Done'으로 변한다.
     https://developer.apple.com/documentation/swiftui/editmode
     
     */
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                /*
                 사용자가 편집 모드를 종료할 때까지 편집 내용이 적용되지 않도록 하려면 편집 중에 프로필의 초안 복사본(draftProfile)을 사용한 다음 사용자가 편집을 확인한 경우에만 초안 복사본을 실제 복사본에 할당
                 */
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }

            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile) //draftProfile 수정
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile //저장
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}
