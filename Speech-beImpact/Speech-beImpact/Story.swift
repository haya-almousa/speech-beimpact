import SwiftUI

struct CurvedHeader: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.maxY * 0.6),
            control: CGPoint(x: rect.midX, y: rect.maxY * 1.2)
        )
        path.addLine(to: .zero)
        return path
    }
}

struct AnimalQuizView: View {
    // Track if a correct answer (Lion) has been chosen
    @State private var isCorrect = false
    // Track which option was tapped (for coloring or preventing repeat)
    @State private var selectedOption: String? = nil
    // Show alert on correct answer
    @State private var showCorrectAlert = false
    
    var body: some View {
        ZStack(alignment: .top) {
            // App background from assets
            Image("خلفيتي")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Push content to vertical center
                Spacer(minLength: 0)
                
                // Content card: story + letters + image
                VStack(spacing: 0) {
                    // Main text
                    VStack(spacing: 0) {
                        Text("Ahmed went to the zoo and found")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(.black)
                        Text("............")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.top, 2)
                    }
                    .padding(.top, 2)
                    
                    // Animal names with colored first letters (English)
                    HStack(spacing: 20) {
                        // Camel
                        HStack(spacing: 0) {
                            Text("C")
                                .foregroundColor(.brown)
                            Text("amel")
                                .foregroundColor(.black)
                        }
                        .font(.system(size: 24, weight: .regular))
                        
                        // Duck
                        HStack(spacing: 0) {
                            Text("D")
                                .foregroundColor(.brown)
                            Text("uck")
                                .foregroundColor(.black)
                        }
                        .font(.system(size: 24, weight: .regular))
                        
                        // Lion
                        HStack(spacing: 0) {
                            Text("L")
                                .foregroundColor(.brown)
                            Text("ion")
                                .foregroundColor(.black)
                        }
                        .font(.system(size: 24, weight: .regular))
                    }
                    .padding(.horizontal, 12)
                    
                    // Lion image (asset still named in Arabic unless you provide an English name)
                    Image("أسد")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, 2)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .frame(maxWidth: 560) // wider on small screens
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.gray).opacity(0.15))
                )
                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 8)
                .shadow(color: .white.opacity(0.2), radius: 2, x: -1, y: -1)
                .padding(.horizontal, 30)
                
                // Answer options horizontally
                HStack(spacing: 12) {
                    liquidGlassButton(title: "Camel") {
                        handleSelection(option: "Camel")
                    }
                    liquidGlassButton(title: "Duck") {
                        handleSelection(option: "Duck")
                    }
                    liquidGlassButton(title: "Lion") {
                        handleSelection(option: "Lion")
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 40)
                
                Spacer(minLength: 0)
            }
        }
        // Keep only the correct alert
        .alert("Great job!", isPresented: $showCorrectAlert) {
            Button("Continue") {
                // TODO: Navigate to next page on correct answer
            }
        } message: {
            Text("Correct choice.")
        }
    }
    
    // MARK: - Actions
    private func handleSelection(option: String) {
        selectedOption = option
        if option == "Lion" {
            isCorrect = true
            showCorrectAlert = true
        } else {
            isCorrect = false
            // No alert for wrong answer; only button color changes via selectedOption
        }
    }
    
    // MARK: - Components
    // Reusable "Liquid Glass" button
    @ViewBuilder
    private func liquidGlassButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            let isSelected = selectedOption == title
            let isRight = title == "Lion"
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(isSelected ? (isRight ? .green : .red) : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.white.opacity(0.35), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
        }
        .disabled(isCorrect && title != "Lion")
    }
}

#Preview {
    AnimalQuizView()
}
