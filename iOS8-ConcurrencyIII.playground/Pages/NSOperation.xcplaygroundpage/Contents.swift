//: [Previous](@previous)

import Foundation

let queue = OperationQueue()

//queue.maxConcurrentOperationCount = 1  // Makes it a serial queue

let downloadJSON = BlockOperation {
    sleep(1)
    print("1. Download JSON")
}

let processJSON = BlockOperation {
    sleep(1)
    print("2. Processing JSON")
}

let downloadImageFromJSON = BlockOperation {
    sleep(1)
    print("3. Download image from JSON")
}

let getWeather = BlockOperation {
    sleep(1)
    print("4. Get the weather!")
}

class MyHeartRateOperation: Operation {
    private var deviceName: String
    var data: Data?
    
    init(deviceName: String) {
        self.deviceName = deviceName
        super.init()
    }

    override func main() {
        print("Request bluetooth data from sensor: \(deviceName)")
        sleep(1)
        data = "75".data(using: .utf8)!
        print("Got data: \(data)")
    }
    
}

let heartRate = MyHeartRateOperation(deviceName: "Polar H10")


// Set up dependencies

processJSON.addDependency(downloadJSON)
downloadImageFromJSON.addDependency(processJSON)

queue.addOperation(heartRate)
//queue.addOperation(processJSON)
//queue.addOperation(downloadImageFromJSON)
//queue.addOperation(getWeather)
//queue.addOperation(downloadJSON)

// If we don't waitUntilFinished, the heartRate data will be nil
// waiting is a blocking call
queue.addOperations([downloadJSON, processJSON, downloadImageFromJSON, getWeather], waitUntilFinished: true)

// When you cancel an operation, it will remove any extra from the queue, but it doesn't just
// magically stop the operations. There is a isCanceled method to check in your "work" algorithm, so you can
// stop work early mid-operation.
//queue.cancelAllOperations()

print("Finished")
let heartRateString = String(bytes: heartRate.data!, encoding: .utf8)!
print("HeartRate is: \(heartRateString)")


//: [Next](@next)
