/*:
 # Core Dictionary Methods
 ---
 
 ## Topic Essentials
Dictionary elements can be easily updated and removed using subscript syntax or class methods.
 
 ### Objectives
 + Create a dictionary called **playerStats** and initialize it with key-value pairs
 + Update **playerStats** using different methods
 + Remove key-value pairs from **playerStats** using different methods
 + Create a 2 dimensional dictionary called **questDict** and populate it
 + Use chained subcripts to access a nested key-value pair
 
 [Previous Topic](@previous)                                                 [Next Topic](@next)

 */
// Caching and overwriting items
var playerStats: [String: Int] = ["HP": 100, "Attack": 35]
var oldValue = playerStats.updateValue(30, forKey: "Attack")

playerStats = ["Evasion": 12, "MP": 55] //overrides dictionary

// Caching and removing items
var removedValue = playerStats.removeValue(forKey: "HP")
//playerStats["Gold"] = nil

// Nested dictionaries
var questBoard = ["Quest 1": ["Reward": "Item X", "Difficulty": 1],
                  "Quest 2": ["Reward": "Item Y", "Difficulty": 2]]

var gemstoneObjective = questBoard["Fetch gemstones"]?["Reward"]
//? breaks the chain if the compiler knows the second part doesnt exist
