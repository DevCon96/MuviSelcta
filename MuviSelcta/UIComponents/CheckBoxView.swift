//
//  CheckBoxView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 20/02/2023.
//

import SwiftUI


struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.brandLightBlue) : Color.brandWhite)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct CheckCheckBoxView: View {
    var tapGestureAction: () -> Void

    var body: some View {
        Image(systemName:"checkmark.square.fill")
            .foregroundColor(Color.brandLightBlue)
            .onTapGesture {
                tapGestureAction()
            }
    }

    init(tapGestureAction: @escaping () -> Void) {
        self.tapGestureAction = tapGestureAction
    }
}

struct UncheckCheckBoxView: View {
    var tapGestureAction: () -> Void

    var body: some View {
        Image(systemName:"square")
            .foregroundColor(Color(UIColor.brandOrange))
            .onTapGesture {
                tapGestureAction()
            }
    }

    init(tapGestureAction: @escaping () -> Void) {
        self.tapGestureAction = tapGestureAction
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
            @State var checked = false

            var body: some View {
                CheckBoxView(checked: $checked)
            }
        }

        static var previews: some View {
            CheckBoxViewHolder()
        }
}
