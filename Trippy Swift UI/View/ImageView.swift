//
//  ImageView.swift
//  Trippy Swift UI
//
//  Created by Jonathan Morris on 7/27/20.
//

import SwiftUI

struct ImageView: View {
    let image:UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(35)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: #imageLiteral(resourceName: "placeholder"))
            .frame(width: 400, height: 400, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
