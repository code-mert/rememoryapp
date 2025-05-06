import Foundation
import SwiftData

@Model
class Flashcard {
    var question: String
    var answer: String
    var tags: [String]
    var createdAt: Date
    
    init(question: String, answer: String, tags: [String], createdAt: Date) {
        self.question = question
        self.answer = answer
        self.tags = tags
        self.createdAt = createdAt
    }
}
