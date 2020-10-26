import SwiftUI

public struct LevelGridView: View {

    @Binding var selectedLevel: Int

    public var body: some View {
        VStack {
            ForEach(1..<4) { row in
                HStack{
                    ForEach(1..<5) { column in
                        let item = column+(row*4)-4
                        Button(action: {
                            selectedLevel = item
                        }, label: {
                            Text("\(item)")
                                .bold()
                                .accentColor(.black)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        })
                        .background(selectedLevel == item ? Color.yellow.opacity(0.3) : Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
    }
}

struct LevelViewView_Previews: PreviewProvider {
    static var previews: some View {
        LevelGridView(selectedLevel: .constant(1))
    }
}
