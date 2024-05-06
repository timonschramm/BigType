
import SwiftUI

struct ContentView: View {
    @State private var text: String = ""

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    TextField("Enter your text here", text: $text)
                        .multilineTextAlignment(.center)
                        .frame(height: 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white))
                        .font(Font.system(size: 24, design: .default))
                    
                        .padding([.horizontal], 24)
                        .shadow(color: .black.opacity(0.5), radius: 0, x: 0, y: 0.33)
                    
                }
                .padding(.top, 50)
                .padding(.horizontal, 500)

                Spacer()
                
                
                HStack{
                    Text(text.isEmpty ? "TYPE!" : text)  // Show a space when empty to maintain layout
                        .font(.system(size: fontSize(for: text, in: geometry.size), weight: .bold, design: .monospaced))
                        .lineLimit(1)  // Ensure text does not wrap
                        .minimumScaleFactor(0.1)  // Allows text to shrink to fit the line if needed
                        .padding(.horizontal, 10)  // Small margin on sides
                        .multilineTextAlignment(.center)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white))
                }
                .padding(.horizontal, 50)
             
                Spacer()
            }
        }
    }

    // Function to compute font size based on text length and available space
    func fontSize(for text: String, in size: CGSize) -> CGFloat {
        let maximumFontSize: CGFloat = size.height / 2  // Dynamic max size based on view height
        let baseFontSize: CGFloat = 500  // Large base font size for smaller screens
        let minimumFontSize: CGFloat = 24  // Minimum font size for readability

        if text.count <= 5 {
            // Keep font size maximized for up to 5 characters
            return maximumFontSize
        } else {
            // Scale font size down as text length increases beyond 5 characters
            let scaleFactor: CGFloat = 2800  // Factor to slow down the rate of shrinkage
            return max(minimumFontSize, min(baseFontSize, scaleFactor / CGFloat(text.count - 5)))
        }
    }
}

#Preview {
    ContentView()
}

