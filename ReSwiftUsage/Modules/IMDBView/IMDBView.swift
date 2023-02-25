//
//  IMDBView.swift
//  ReSwiftUsage
//
//  Created by Timur on 24/2/23.
//

import SwiftUI

struct IMDBView: View {
    var title: String
    
    
    var body: some View {
        Text("IMDB View")
    }
}

struct IMDBView_Previews: PreviewProvider {
    static var previews: some View {
        IMDBView(title: "IMDB")
    }
}
