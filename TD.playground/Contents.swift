import UIKit

func factInt(x: Int) -> Int {
    var res: Int = 1
    for i in 1...x {
        res = i * res
    }
    return res
}

factInt(x: 4)
