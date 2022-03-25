//
//  ContentView.swift
//  AlexCard
//
//  Created by Oleksandr Kachkin on 23.03.2022.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Color(red: 0.09, green: 0.63, blue: 0.52)
        .edgesIgnoringSafeArea(.all)
      VStack {
        
        Image("Alex")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 150.0, height: 150.0)
          .clipShape(Circle())
          .overlay(
            Circle().stroke(Color.white, lineWidth: 5)
          )
        Text("Alexander Kachkin")
          .font(Font.custom("Pacifico-Regular", size: 40))
          .foregroundColor(.white)
          .bold()
        Text("iOS Developer")
          .foregroundColor(.white)
          .font(.system(size: 25))
        Divider()
        InfoView(text: "+38 095 345 67 89", imageName: "phone.fill")
        InfoView(text: "alexander@email.com", imageName: "envelope.fill")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


