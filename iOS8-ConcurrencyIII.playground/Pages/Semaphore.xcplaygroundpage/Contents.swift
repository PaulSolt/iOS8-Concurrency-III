//: [Previous](@previous)

import Foundation


// Semaphore is a flag
// 1. Can behave just like a lock (0)
// 2. Can be used to protect finite resources (10 buckets of blueberries)

func download(url: URL) -> Data? {
    var data: Data?
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: url) { (d, _, _) in
        data = d
        semaphore.signal()  // QUESTION: what happens when we comment this line? (Deadlock)
        }
        .resume()
    
    semaphore.wait() // QUESTION: What happens when we comment this line? (Early return, nil data, didn't wait)
    
    return data
}

print("About to wait for luke to download")

let url = URL(string: "https://swapi.co/api/people/1/")!
if let myData = download(url: url) {
    print("Downloaded: \(myData)")
} else {
    print("Error: no data")
}

print("Luke has finished downloading")


// Explore protecting resource
let semaphore = DispatchSemaphore(value: 5)

print("Waiting 1")
semaphore.wait()  // 4

print("Waiting 2")
semaphore.wait()

print("Waiting 3")
semaphore.wait()

print("Waiting 4")
semaphore.wait()

print("Waiting 5")
semaphore.wait()

//print("Waiting 6")
//semaphore.wait()        // blocks the following lines of code here

print("Finished")

//: [Next](@next)
