/*:
 # Core Array Methods
 ---
 
 ## Topic Essentials
 Now that we know how to create and access arrays, we need to learn how to dynamically modify them. Like `Strings`, `Arrays` come with several handy methods built right in for just that purpose.
 
 ### Objectives
 + Create an array called **characterClasses** and assign it initial values
 + Use `append` and += operator to add items
 + Use the `insert` and `remove` methods to change the array further
 + Explore the `reverse`, `contains`, and`sort` methods
 + Create a jagged array called **skillTree** that stores arrays as its values
 + Use chained **subscript syntax** to access a value in **skillTree**
 
  [Previous Topic](@previous)                                                 [Next Topic](@next)
 
 */
// Changing & appending items
var characterClasses = ["A", "B", "C"]
characterClasses.append("D")
characterClasses += ["E", "F"]

//Inserting and removing items
characterClasses.insert("G", at: 1)
characterClasses.remove(at: 3)

// Ordering and querying values
characterClasses.reverse()
var reversedClasses = characterClasses.reversed()

characterClasses.sort()
var sortedClasses = characterClasses.sorted()

print(characterClasses)

// 2D arrays and subscripts
var skillTree: [[String]] = [
    ["A", "B", "C"],
    ["D", "E", "F"]
]

var attackTreeSkill = skillTree[0][2]
