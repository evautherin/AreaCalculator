import SwiftUI
import shared


struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            LengthView(label: "Width", state: $viewModel.width)
            LengthView(label: "Height", state: $viewModel.height)
            Text("Area: \(viewModel.area)").padding()
        }
    }
}

//struct ContentView: View {
//    @State var width = 1.0
//    @State var height = 1.0
//
//    var body: some View {
//        let area = width*height
//
//        VStack {
//            LengthView(label: "Width", state: $width)
//            LengthView(label: "Height", state: $height)
//            Text("Area: \(area)").padding()
//        }
//    }
//}


struct LengthView: View {
    var label: String
    @Binding var state: Double

    var body: some View {
        VStack {
            Text("\(label): \(state)")
            Slider(value: $state, in: 1.0...10.0)
        }
        .padding()
    }
}

