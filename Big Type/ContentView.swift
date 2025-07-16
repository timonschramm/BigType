
import SwiftUI

struct ContentView: View {
    @State private var text: String = "TYPE!"
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    SuperTextField(
                                placeholder: Text("Type it BIG!").foregroundColor(.secondary),
                                text: $text
                            )
                    
                        .multilineTextAlignment(.center)

                        .frame(height: 55)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(16)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary.opacity(0.1)))
                        .font(.system(size: 24, weight: .regular, design: .default))
                            .foregroundColor(.primary)
                            .accentColor(.accentColor)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(NSColor.controlBackgroundColor))
                            )

                        .shadow(color: .primary.opacity(0.08), radius: 8, x: 0, y: 2)
                    
                }
                .padding(.top, geometry.safeAreaInsets.top + 20)
                              .padding(.horizontal, 24)

                Spacer()
                
                
                HStack {
                                    Text(text.isEmpty ? "TYPE!" : text)
                                        .font(.system(size: fontSize(for: text, in: geometry.size), weight: .bold, design: .monospaced))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.1)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(.primary)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color(NSColor.controlBackgroundColor).opacity(0.8))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
                                        )
                                }
                                .padding(.horizontal, 24)
                                .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
             
                Spacer()
            }
            .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all))

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

