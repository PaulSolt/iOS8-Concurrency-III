//
//  main.swift
//  iOS8-BasicQueues
//
//  Created by Paul Solt on 9/5/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import Foundation

let queue = DispatchQueue(label: "MyBackgroundQueue")

print("1. I'm on the main thread")

queue.async {
//    usleep(1_000_000) // 1 second
    usleep(100) // microseconds
    print("2. Downloading images in the background")
}

print("3. I'm finished")
