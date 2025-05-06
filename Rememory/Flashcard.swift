import Foundation
import SwiftData

@Model
class Flashcard {
    var question: String
    var answer: String
    var tags: [String]
    var createdAt: Date
    var imageData: Data?
    
    init(question: String, answer: String, tags: [String], createdAt: Date, imageData: Data? = nil) {
        self.question = question
        self.answer = answer
        self.tags = tags
        self.createdAt = createdAt
        self.imageData = imageData
    }
}
