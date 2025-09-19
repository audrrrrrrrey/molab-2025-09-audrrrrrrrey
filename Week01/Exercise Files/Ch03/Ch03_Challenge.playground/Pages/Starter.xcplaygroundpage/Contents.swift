/*:
 # Chapter Challenge -> Merchant Shop
 ---
 ### Tasks
 1. Create an array called **shopItemsArray** and fill it with a few strings, then create a dictionary called **shopItemsDictionary** with keys that match your array items, with prices for their values
 2. Use the `contains` method to check if **shopItemsArray** has the item you want (make it an item that is not in the array)
 3. Use the `insert` method to add the missing item to **shopItemsArray** at an index you choose
 4. Create a new variable called **selectedItem** and assign it an item from **shopItemsArray** by using subscript syntax.
 5. Create another variable called **selectedItemPrice** and use **selectedItem** and subscript syntax to access it's value from **shopItemsDictionary**
 6. Create a set called **fullArmorSet** and assign it a few string values, then create a second set called **currentArmorSet** and assign it some, but not all, of the same values as **fullArmorSet**
 7. Use the `subtract` method to find out which items **currentArmorSet** is missing for a complete set
 8. Create a tuple called **armorPieceTuple** and assign it named variables for *name*, *cost*, and *canEquip*, all with initial values. Then access the canEquip value with dot notation.
 
 [Previous Topic](@previous)
 
 */
// 1
var shopItemsArray: [String] = ["Sword", "Shield", "Potion"]
var shopItemsDictionary: [String: Int] = ["Sword": 100, "Shield": 50, "Potion": 25]

// 2
print(shopItemsArray.contains("Pool Noodle"))

// 3
shopItemsArray.insert("Pool Noodle", at: 1)

// 4
var selectedItem = shopItemsArray[2]

// 5
var selectedItemPrice = shopItemsDictionary[selectedItem]

// 6
var fullArmorSet: Set = ["Helmet", "Chestplate", "Greaves"]
var currentArmorSet: Set = ["Helmet", "Chestplate"]


// 7
print(fullArmorSet.subtracting(currentArmorSet))

// 8
var armorPieceTuple: (name: String, cost: Int, canEquip: Bool) = ("", 0, false)
print(armorPieceTuple.canEquip)

