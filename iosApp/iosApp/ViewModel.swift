import Foundation
import SwiftUI
import Combine
import shared
import KMPNativeCoroutinesCore
import KMPNativeCoroutinesCombine


class ViewModel: ObservableObject {
    static let logic = AppLogic()
    
    @Published public var width = logic.initialWidth
    @Published public var height = logic.initialHeight
    @Published public var area = logic.initialArea

    var subscriptions = Set<AnyCancellable>()

    
    init() {
        connect(ViewModel.logic.setWidth, with: $width)
        connect(ViewModel.logic.setHeight, with: $height)
        
        assignablePublisher(for: ViewModel.logic.areaFlowNative)
            .map({ Double(truncating: $0) })
            .assign(to: &$area)
    }
    
    
    func assignablePublisher<Output, Failure, Unit>(
        for nativeFlow: @escaping NativeFlow<Output, Failure, Unit>
    ) -> AnyPublisher<Output, Never> where Failure : Error {

        createPublisher(for: nativeFlow)
            .catch { _ in Empty<Output, Never>() }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }


    func connect<T>(
        _ receiver: @escaping (T) -> (),
        with publisher: Published<T>.Publisher
    ) {
        publisher
            .dropFirst()
            .sink(receiveValue: receiver)
            .store(in: &subscriptions)
    }
}


//func publisherDouble<Output, Failure, Unit>(
//    for nativeFlow: @escaping NativeFlow<Output, Failure, Unit>
//) -> AnyPublisher<Double, Never> where Failure : Error, Output: NSNumber {
//
//    publisher(for: nativeFlow)
//        .map({ Double(truncating: $0) })
//        .eraseToAnyPublisher()
//}
