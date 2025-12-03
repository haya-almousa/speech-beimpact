import Foundation

/// يمثل قصة الاختبار: نص، فراغ، اسم صورة، خيارات، وإجابة صحيحة.
public struct QuizStory: Identifiable, Equatable {
    public let id = UUID()
    public let line: String
    public let placeholder: String
    public let imageName: String
    public let options: [String]
    public let correct: String
    public let imageSize: CGSize?   // ← حجم مخصص للصورة (اختياري)

    public init(line: String,
                placeholder: String = "............",
                imageName: String,
                options: [String],
                correct: String,
                imageSize: CGSize? = nil) {  // ← معامل اختياري
        self.line = line
        self.placeholder = placeholder
        self.imageName = imageName
        self.options = options
        self.correct = correct
        self.imageSize = imageSize
    }
}
