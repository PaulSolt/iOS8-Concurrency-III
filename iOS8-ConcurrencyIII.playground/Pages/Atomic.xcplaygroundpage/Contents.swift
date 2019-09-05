//: [Previous](@previous)

import Foundation

// Serial = work happens in order (like following a series of steps in a recipe)
// Concurrent = work happens all at the same time (10 workers picking blueberries)

// Sync = work happens now (fire alarm -> leave the building)
// Async = work happens at some point in the future (apply to an iOS job)


class Atomic<Element> {
    private var value: Element
    private var queue = DispatchQueue(label: "SerialQueue")
    
    init(value: Element) {
        self.value = value
    }
    
    func modify(_ modifier: (Element) -> Element) {
        queue.sync {
            value = modifier(value)
        }
    }
    
    func get() -> Element {
        return queue.sync { value }
    }
}

let sharedValue = Atomic(value: 10)
//let sharedValue = Atomic(value: "Hello")

DispatchQueue.concurrentPerform(iterations: 100) { (threadNumber) in
    sharedValue.modify { $0 + 1 }
}

sharedValue.get()


//: [Next](@next)
