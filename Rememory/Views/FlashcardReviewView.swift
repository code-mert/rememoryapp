import SwiftUI

struct FlashcardReviewView: View {
    let flashcard: Flashcard
    @State private var showAnswer = false
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 40) {
            Text(flashcard.question)
                .font(.title)
                .multilineTextAlignment(.center)

            if showAnswer {
                Text(flashcard.answer)
                    .font(.title2)
                    .foregroundColor(.green)
                
                HStack {
                    Button("Ich wusste es") {
                        flashcard.nextReviewDate = Date().addingTimeInterval(10)
                        try? modelContext.save()
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Ich wusste es nicht") {
                        flashcard.nextReviewDate = nil
                        try? modelContext.save()
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                Button("Antwort anzeigen") {
                    showAnswer = true
                }
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Lernen")
    }
}
