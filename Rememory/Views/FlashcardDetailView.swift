import SwiftUI

struct FlashcardDetailView: View {
    let flashcard: Flashcard

    var body: some View {
        Form(content: {
            Section(header: Text("Frage")) {
                Text(flashcard.question)
            }
            Section(header: Text("Antwort")) {
                Text(flashcard.answer)
            }
            if !flashcard.tags.isEmpty {
                Section(header: Text("Tags")) {
                    Text(flashcard.tags.joined(separator: ", "))
                }
            }
            if let imageData = flashcard.imageData,
               let uiImage = UIImage(data: imageData) {
                Section(header: Text("Bild")) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
            }
        })
        .navigationTitle("Details")
    }
}
