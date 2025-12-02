import Combine
import SwiftUI

@MainActor
final class AnimalQuizViewModel: ObservableObject {
    let story: QuizStory
    let onCorrect: (() -> Void)?

    @Published var selectedOption: String?
    @Published var isCorrect = false
    @Published var showCorrectAlert = false

    init(story: QuizStory, onCorrect: (() -> Void)? = nil) {
        self.story = story
        self.onCorrect = onCorrect
    }

    func select(option: String) {
        selectedOption = option
        isCorrect = (option == story.correct)
        showCorrectAlert = isCorrect
    }

    func dismissAlert() {
        showCorrectAlert = false
        if isCorrect { onCorrect?() }
    }

    func isDisabled(_ option: String) -> Bool {
        isCorrect && option != story.correct
    }

    func foregroundColor(for option: String) -> Color {
        guard selectedOption == option else { return .black }
        return option == story.correct ? .green : .red
    }
}
