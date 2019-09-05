//: [Previous](@previous)

import Foundation

let urls = [
    URL(string: "https://swapi.co/api/people/1/")!,
    URL(string: "https://swapi.co/api/people/2/")!,
    URL(string: "https://swapi.co/api/people/3/")!,
    URL(string: "https://swapi.co/api/people/4/")!
]

var peopleGroup = DispatchGroup()
var networkingGroup = DispatchGroup()

extension DispatchGroup {
    
    func enter(times: Int) {
        for _ in 0 ..< times { enter() }
    }
}

for personURL in urls {
    peopleGroup.enter(times: 1)
    networkingGroup.enter(times: 3)
    
    let task = URLSession.shared.dataTask(with: personURL) { (data, _, _) in
        // do stuff with data
        print("Got data for \(personURL): \(String(describing: data))")
        //String(data)
//        print(String(bytes: data!, encoding: .utf8)!)
        
        networkingGroup.leave()
        networkingGroup.leave()
        networkingGroup.leave()   // QUESTION: What happens if you comment out this line?
        peopleGroup.leave()
    }
    task.resume()
}

// Question: how do i know when all 3 are done?
// You can add a completion handler to notify using a queue (main for updating UI)
// The completion handler is called when all of the tasks complete
// ie. when enter + leave are matched in number (3 enters, 3 leaves)

peopleGroup.notify(queue: .main) {
    print("All 3 are done!")
    //    tableView.reloadData()
}

networkingGroup.notify(queue: .main) {
    print("Networking has completed")
    
}






//: [Next](@next)
