
import SwiftUI

struct ContentView: View {
    @State private var text: String = "TYPE!"

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    SuperTextField(
                                placeholder: Text("Enter your Text here").foregroundColor(.gray
                                                                                     ),
                                text: $text
                            )
                    
                        .multilineTextAlignment(.center)

                        .frame(height: 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white))
                        .font(.system(size: 24, weight: .regular, design: .default))
                            .foregroundColor(.black)  // Attempting to set text color
                            .accentColor(.black)  // Sets the cursor color to blue
                            .textFieldStyle(DefaultTextFieldStyle())  // Ensures the default styling supports color changes

                        .shadow(color: .black.opacity(0.5), radius: 0, x: 0, y: 0.33)
                    
                }
                .padding(.top, geometry.safeAreaInsets.top + 20)
                              .padding(.horizontal, 24)

                Spacer()
                
                
                HStack {
                                    Text(text.isEmpty ? "TYPE!" : text)
                                        .font(.system(size: fontSize(for: text, in: geometry.size), weight: .bold, design: .monospaced))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.1)
                                        .frame(maxWidth: .infinity) // Ensures the text always stays within the bounds
                                        .padding(.horizontal, 10)
                                        .background(Color.blue.opacity(0.2)) // Light blue background for the text display
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.blue, lineWidth: 2) // Consistent style with the text field
                                        )
                                }
                                .padding(.horizontal, 24)
                                .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
             
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all)) // White background for the entire view

        }
    }

    // Function to compute font size based on text length and available space
    func fontSize(for text: String, in size: CGSize) -> CGFloat {
        let maximumFontSize: CGFloat = size.height / 3  // Dynamic max size based on view height
        let baseFontSize: CGFloat = 500  // Large base font size for smaller screens
        let minimumFontSize: CGFloat = 24  // Minimum font size for readability

        if text.count <= 5 {
            // Keep font size maximized for up to 5 characters
            return maximumFontSize
        } else {
            // Scale font size down as text length increases beyond 5 characters
            let scaleFactor: CGFloat = 2000  // Factor to slow down the rate of shrinkage
            return max(minimumFontSize, min(baseFontSize, scaleFactor / CGFloat(text.count - 5)))
        }
    }
}
struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.multilineTextAlignment(.center).frame(maxWidth: .infinity, alignment: .center)  }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .padding(.all, 20)
                           .multilineTextAlignment(.center)

        }
    }
    
}

#Preview {
    ContentView()
}

