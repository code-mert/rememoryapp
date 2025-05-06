import SwiftUI
import PhotosUI

struct NewFlashcardView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil

    @State private var availableTags: [String] = []
    @State private var selectedTags: Set<String> = []
    @State private var newTag: String = ""

    var body: some View {
        Form {
            Section(header: Text("Frage")) {
                TextField("Frage eingeben", text: $question)
            }

            Section(header: Text("Antwort")) {
                TextField("Antwort eingeben", text: $answer)
            }

            Section(header: Text("Bild hinzufügen")) {
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    Text("Bild auswählen")
                }

                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }

            Section(header: Text("Tags")) {
                if !availableTags.isEmpty {
                    ForEach(availableTags, id: \.self) { tag in
                        Button(action: {
                            if selectedTags.contains(tag) {
                                selectedTags.remove(tag)
                            } else {
                                selectedTags.insert(tag)
                            }
                        }) {
                            HStack {
                                Text(tag)
                                Spacer()
                                if selectedTags.contains(tag) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }

                HStack {
                    TextField("Neuer Tag", text: $newTag)
                    Button("Hinzufügen") {
                        let trimmed = newTag.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty, !availableTags.contains(trimmed) else { return }
                        availableTags.append(trimmed)
                        selectedTags.insert(trimmed)
                        newTag = ""
                    }
                }
            }

            Button("Karteikarte speichern") {
                let flashcard = Flashcard(
                    question: question,
                    answer: answer,
                    tags: Array(selectedTags),
                    createdAt: Date(),
                    imageData: imageData
                )
                modelContext.insert(flashcard)
                question = ""
                answer = ""
                selectedTags = []
                imageData = nil
            }
        }
        .navigationTitle("Neue Karteikarte")
        .onChange(of: selectedImage) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    imageData = data
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewFlashcardView()
    }
}
