//
//  PrimaryButton.swift
//  MuviSelcta
//
//  Created by Connor Jones on 10/02/2023.
//

import Foundation
import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.brandYellow)
            .padding()
            .buttonStyle(.borderless)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.orange, lineWidth: 3)
                    .fontWeight(.heavy)
                    .frame(width: 150)
            )
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 10)

    }
}

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.brandOrange)
            .padding()
            .buttonStyle(.borderedProminent)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.brandOrange, lineWidth: 3)
                    .fontWeight(.heavy)
                    .frame(width: 150)

            )
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 10)

    }
}
