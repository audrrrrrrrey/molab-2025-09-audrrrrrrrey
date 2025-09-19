//spelling nato phonetic words with nato phonetic words

import Foundation

let natos: [String: String] = ["a":"alfa" , "b":"bravo" , "c":"charlie" , "d":"delta" , "e":"echo" , "f":"foxtrot" , "g":"golf" , "h":"hotel" , "i":"india" , "j":"juliett" , "k":"kilo" , "l":"lima" , "m":"mike" , "n":"november" , "o":"oscar" , "p":"papa" , "q":"quebec" , "r":"romeo" , "s":"sierra" , "t":"tango" , "u":"uniform" , "v":"victor" , "w":"whiskey" , "x":"x-ray" , "y":"yankee" , "z":"zulu"]

//referenced example playground 01
func charAt(_ str:String, _ offset:Int) -> String {
    let index = str.index(str.startIndex, offsetBy: offset)
    let char = str[index]
    return String(char)
}

//pick a random word from natos values
let randomIndex = Int.random(in: 0..<26)
let randomWord = Array(natos.values)[randomIndex]

//for each character, get the corresponding word and print it
for c in 0..<randomWord.count {
    let char = charAt(randomWord, c)
    print (natos[char]!)
}
