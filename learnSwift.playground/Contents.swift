import UIKit

/** INSTRUCTION **/

print("Hello, world") // ';' ain't needed
print("Another hello"); print(",world") // ';' is needed

/** Var & Const **/

// variables : var // suivit de : "type"
// const : let

let chaineHello = "Hello"

var chaineCar: String

let pi = 3.141 // We ca, use any caracter, like greek, chinese and emojis

/** Operators **/

let hello = "Hello"
let world = "World"
var mess = hello + world // HelloWorld

let pointEx : Character = "!"
mess.append(pointEx) // HelloWorld!

/** Table **/

var tableDouble: [Double] = [1,2,3,4]
var matriceDouble: [[Double]] = [[1,2],[3,4]]
// We can use the insert and remove methodes
matriceDouble.insert([5,6], at: 0)
matriceDouble.remove(at: 0)
// There are many more methods

/** Optionnal value **/

var doubleCouldNotExist: Double?
// in Java // Eleve e = new Eleve(); 'or' Eleve e = null;
// can take this value // doubleCouldNotExist = 3.0
// or this // doubleCouldNotExist = nil

// This is how we access the value of an optionnal value
//var exit1  = doubleCouldNotExist! // If nil, then error // In comments as it causes an error, like it should
// or we can declare our optionnal value by declaring it differently :
var otherWayOptional : Int! = 3
var exit2 = otherWayOptional

/** Condition in Swift **/

/**
 if condition {
    instruction
 } else if condition {
    instruction
 } else {
    instruction
 }
 **/

var testopt: Int? = 3
let test: Int = testopt!

if let test = testopt {
    print("\(test)")
}

/** Loop **/

for i in 0..<10 {
    print("\(i)")
}

var j = 0
while j < 10{
    print("\(j)")
    j += 1
}

var k = 0
repeat{
    print("\(k)")
    k += 1
}while k < 10

/** Operateur of intervals **/
// ... intervals between two values(ex: 1...3 covers 1 2 & 3)
// ..< covers an open interval (ex: 1..<3 covers 1 & 2)

/** Back to the tabbles **/

var tab = [1,2,3,4,5,6] // prints [1,2,3,4,5,6]
tab[1...3] = [7,8,9] // prints [7,8,9]

var tabTest1 = [1,2,3,4,5,6]
var tabTest2 = [8,7,3,4,5,9]
tabTest1 == tabTest2 // False
tabTest1[2...4] == tabTest2[2...4] //True

/** One sided ranges **/

var planets = ["Mercure", "Venus", "Terre", "Mars", "Jupiter", "Saturne", "Uranus", "Neptune"]
let outSideTheAsteroidRing = planets[4...]
let firstFour = planets[..<4]
// Other ...4 all inferior to 4; 2... all superior to 2

/** Tuples **/
let matAlgo: (String, Int) = ("IAP", 3) // Mat and coef
// By default the elements name are .0 and .1 // You can name them
let matAlgoBis: (nom:String, coef:Int) = ("IAP", 3)

/** Functions int swift **/
/**
 Can be declared outside of a class compared to Java
 
 func nameFunct(para1: type1, ..., paraN: typeN) -> typeReturn
 
 **/

func factoriel(n: Int) -> Int {
    var res = 1
    for i in 1...n{
        res = res * i
    }
    return res
}

// ex of void
func tailleIntervalle(min: Int, max: Int) {
    print("Start : \(min), Fin: \(max), Taille: \(max - min)")
}

let f15 = factoriel(n: 15)
print("\(f15)")

tailleIntervalle(min: 2, max: 10)

// multiple parameters function
