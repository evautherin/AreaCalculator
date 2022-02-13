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
        connect(ViewModel.logic.setWidth, withPublisher: $width)
        connect(ViewModel.logic.setHeight, withPublisher: $height)
        
        assignablePublisher(for: ViewModel.logic.areaFlowNative)
            .map(KotlinDouble.toDouble)
            .assign(to: &$area)
    }
}


extension KotlinDouble {
    class func toDouble(value: KotlinDouble) -> Double { Double(truncating: value) }
}


extension ViewModel {
    func connect<T, P: Publisher>(
        _ receiver: @escaping (T) -> (),
        withPublisher publisher: P
    ) where P.Output == T, P.Failure == Never {
        publisher
            .dropFirst()
            .sink(receiveValue: receiver)
            .store(in: &subscriptions)
    }

    func assignablePublisher<Output, Failure, Unit>(
        for nativeFlow: @escaping NativeFlow<Output, Failure, Unit>
    ) -> AnyPublisher<Output, Never> where Failure : Error {

        createPublisher(for: nativeFlow)
            .catch { _ in Empty<Output, Never>() }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
