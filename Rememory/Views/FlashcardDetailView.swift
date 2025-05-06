import SwiftUI

struct FlashcardDetailView: View {
    let flashcard: Flashcard

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false

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
            Section {
                NavigationLink("Bearbeiten") {
                    EditFlashcardView(flashcard: flashcard)
                }

                Button("Löschen", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .confirmationDialog("Karteikarte wirklich löschen?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
                    Button("Löschen", role: .destructive) {
                        modelContext.delete(flashcard)
                        dismiss()
                    }
                    Button("Abbrechen", role: .cancel) {}
                }
            }
        })
        .navigationTitle("Details")
    }
}
