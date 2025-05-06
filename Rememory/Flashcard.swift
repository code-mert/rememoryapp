import Foundation
import SwiftData

@Model
class Flashcard {
    var question: String
    var answer: String
    var tags: [String]
    var createdAt: Date
    var imageData: Data?
    var nextReviewDate: Date?
    
    init(question: String, answer: String, tags: [String] = [], createdAt: Date = .now, imageData: Data? = nil, nextReviewDate: Date? = nil) {
        self.question = question
        self.answer = answer
        self.tags = tags
        self.createdAt = createdAt
        self.imageData = imageData
        self.nextReviewDate = nextReviewDate
    }
}
