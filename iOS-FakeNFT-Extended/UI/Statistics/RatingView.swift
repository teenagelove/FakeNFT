import SwiftUI

struct RatingView: View {
    var starCount = 0
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                index < self.starCount
                ? Image(uiImage: .starYellow)
                : Image(uiImage: .starGray)
            }
        }
    }
}

#Preview {
    RatingView(starCount: 3)
        .border(.red)
}
