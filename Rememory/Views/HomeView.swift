
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Willkommen bei Rememory")
                    .font(.headline)
                    .foregroundColor(.secondary)

                NavigationLink(destination: NewFlashcardView()) {
                    Text("Neue Karteikarte erstellen")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            
            NavigationLink(destination: FlashcardListView()) {
                Text("Karteikarten anzeigen")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}

