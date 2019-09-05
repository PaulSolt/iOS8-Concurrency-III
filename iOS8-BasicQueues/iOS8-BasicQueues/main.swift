//
//  main.swift
//  iOS8-BasicQueues
//
//  Created by Paul Solt on 9/5/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

let queue = DispatchQueue(label: "MyBackgroundSerialQueue") // does 1 thing at a time

//print("1. I'm on the main thread")
//
//queue.sync { // what happens if this is sync?
//    print("2.1 Downloading images in the background")
//
//    usleep(5_000_000) // 1 second
////    usleep(100) // microseconds
//    print("2.2 Downloading images in the background")
//}
//
//print("3. I'm finished")


let concurrentQueue = DispatchQueue(label: "MyBackgroundConcurrentQueue", attributes: [.concurrent])

print("1. I'm on the main thread")
concurrentQueue.async { // what happens if this is sync?
    print("2.1 Downloading images in the background")
    
    usleep(1_000)
    print("2.2 Downloading images in the background")
}

print("3. I'm on the main thread")
concurrentQueue.async { // what happens if this is sync?
    print("4.1 Downloading images in the background")
    
    usleep(1_000)
    print("4.2 Downloading images in the background")
}

print("5. I'm on the main thread")
concurrentQueue.async { // what happens if this is sync?
    print("6.1 Downloading images in the background")
    
    usleep(1_000)
    print("6.2 Downloading images in the background")
}

print("7. I'm finished")


// Keep the Terminal app alive (indenfinitely)
RunLoop.current.run()
