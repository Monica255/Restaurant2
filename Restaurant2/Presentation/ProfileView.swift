//
//  ProfileView.swift
//  RestaurantApp
//
//  Created by Monica Sucianto on 08/01/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 12){
            Image("profile image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(15)
            Text("Monica Sucianto").font(.title2).fontWeight(.semibold)
            Text("monicasucianto123@gmail.com")
        }
    }
}

#Preview {
    ProfileView()
}
