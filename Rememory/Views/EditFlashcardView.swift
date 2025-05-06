import SwiftUI
import PhotosUI

struct EditFlashcardView: View {
    @Bindable var flashcard: Flashcard

    @Environment(\.dismiss) private var dismiss

    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var showSavedAlert = false

    var body: some View {
        Form {
            Section(header: Text("Frage")) {
                TextField("Frage eingeben", text: $flashcard.question)
            }

            Section(header: Text("Antwort")) {
                TextField("Antwort eingeben", text: $flashcard.answer)
            }

            Section(header: Text("Bild")) {
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    Text("Bild ändern")
                }

                if let imageData = flashcard.imageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }

            Button("Änderungen speichern") {
                showSavedAlert = true
            }
            .alert("Gespeichert", isPresented: $showSavedAlert) {
                Button("OK") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Bearbeiten")
        .onChange(of: selectedImage) { old, new in
            Task {
                if let data = try? await new?.loadTransferable(type: Data.self) {
                    flashcard.imageData = data
                }
            }
        }
    }
}
