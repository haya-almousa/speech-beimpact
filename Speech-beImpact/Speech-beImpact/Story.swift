import SwiftUI

// Preview: مثال التمساح
#Preview {
    AnimalQuizView(
        story: QuizStory(
            line: "Ahmed went to the zoo and found",
            placeholder: "............",
            imageName: "تمساح",
            options: ["Crocodile", "Alligator", "Lizard"],
            correct: "Crocodile"
        ),
        onCorrect: {
            print("Correct: Crocodile")
        }
    )
}
