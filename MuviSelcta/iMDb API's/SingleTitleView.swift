//
//  SingleTitleView.swift
//  MuviSelcta
//
//  Created by Connor Jones on 26/01/2023.
//

import SwiftUI

fileprivate let testTitleImageData = TitlePosterInformation(
    id: "image-test-id",
    url: "image-test-url",
    height: 100,
    width: 100)

fileprivate let testTitle = TitleDetailsResponse(
    type: "title",
    image: testTitleImageData,
    id: "tt575574899857439",
    movieLength: 136,
    nextEpisode: "Test Movie Name",
    numberOfEpisodes: 1,
    seriesEndYear: 2023,
    seriesStartYear: 2023,
    title: "Title of movie",
    titleType: "movie",
    year: 2023)

struct SingleTitleView: View {
    @State var title: TitleDetailsResponse

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title.title)
                .frame(maxWidth: 230, maxHeight: 50, alignment: .leading)
                .layoutPriority(10)
                .padding([.leading, .top, .bottom])
                .foregroundColor(.brandDarkBlue)
            Text("\(title.movieLength) mins")
                .layoutPriority(1)
                .foregroundColor(.brandDarkBlue)
            Text("\(String(title.year))")
                .frame(maxWidth: 50, maxHeight: 50, alignment: .bottomTrailing)
                .layoutPriority(1)
                .padding(.trailing)
                .foregroundColor(.brandDarkBlue)
        }
    }

    init(title: TitleDetailsResponse) {
        self.title = title
    }

    init(title: Title) {
        self.title = TitleDetailsResponse(entity: title)
    }
}


//extension SingleTitleView {
//    class ViewModel: ObservableObject {
//        @Published private(set) var title: TitleDetailsResponse?
//
//        func setTitle(_ title: TitleDetailsResponse) {
//            self.title = title
//        }
//
//    }
//}

struct SingleTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTitleView(title: testTitle)
    }
}
