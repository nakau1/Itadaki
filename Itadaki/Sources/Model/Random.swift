// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class Random {
    
    func value(min: Int, max: Int) -> Int {
        let n = min >= 0 ? min : 0
        let m = max + 1
        let v = UInt32(m < n ? 0 : m - n)
        let r = Int(arc4random_uniform(v))
        return n + r
    }
    
    func value(_ range: CountableRange<Int>) -> Int {
        return value(min: range.lowerBound, max: range.upperBound - 1)
    }
    
    func value(_ range: CountableClosedRange<Int>) -> Int {
        return value(min: range.lowerBound, max: range.upperBound)
    }
    
    func bool(percentage: Int) -> Bool {
        if percentage <= 0 { return false } else if 100 <= percentage { return true }
        let percentages = [percentage, 100 - percentage]
        let rand = value(0..<100)
        return percentages.boundPosition(of: rand) == 0
    }
    
    func choose(probabilities: [Int]) -> Int {
        let cnt = probabilities.count
        if cnt <= 0 {
            return -1
        } else if cnt == 1 {
            return 0
        }
        
        let percentages = toPercentages(fromProbabilities: probabilities)
        let rand = value(0..<100)
        return percentages.boundPosition(of: rand)
    }
    
    func selectItem<T>(from items: [T]) -> T? {
        if items.isEmpty { return nil }
        let index = value(0..<items.count)
        return items[index]
    }
    
    func selectItems<T>(from items: [T], number: Int, duplicatable: Bool = false) -> [T] {
        if duplicatable {
            return (0..<number).map { _ -> T in
                items[value(0..<items.count)]
            }
        }
        else {
            var ret = [T]()
            var mutatingItems = items
            for _ in (0..<number) {
                let randomIndex = value(0..<mutatingItems.count)
                if let item = mutatingItems.pull(at: randomIndex) {
                    ret.append(item)
                }
                if mutatingItems.isEmpty {
                    break
                }
            }
            return ret
        }
    }
}

private extension Random {
    
    func toPercentages(fromProbabilities probabilities: [Int]) -> [Int] {
        let total = probabilities.sum.f
        return adjuctPercentages(probabilities.enumerated().map { i, n -> Int in
            if n <= 0 { return 0 }
            let v = n.f / total
            return Int(v * 100)
        })
    }
    
    func adjuctPercentages(_ percentages: [Int]) -> [Int] {
        var mutatingPercentages = percentages
        guard let _ = mutatingPercentages.popLast() else { return percentages }
        mutatingPercentages.append(100 - mutatingPercentages.sum)
        return mutatingPercentages
    }
}

private extension Array where Element == Int {
    
    var sum: Int {
        return reduce(0) { $0 + $1 }
    }
    
    func boundPosition(of value: Int) -> Int {
        var lower = 0, upper = 0, index = 0
        for n in self {
            upper = lower + n
            if lower <= value && value < upper {
                return index
            }
            index += 1
            lower += n
        }
        return -1
    }
}

private extension Array {
    
    mutating func pull(at index: Int) -> Element? {
        if isEmpty || index < 0 || count <= index {
            return nil
        }
        
        let element = self[index]
        remove(at: index)
        return element
    }
}

private extension Int {
    
    func percentage(for denominator: Int) -> Float {
        guard denominator > 0 else { return 0 }
        let divided = Float(self) / Float(denominator)
        return (divided * 10000).rounded(.toNearestOrEven) / 100
    }
}

// MARK: - テスト用
extension Random {
    
    func test_value(_ range: CountableRange<Int>) {
        print("Random.value (CountableRange) Test: ----")
        let times = 50
        print("Random.value (CountableRange) Test: testing times = \(times)")
        let randoms = (0..<times).map { _ -> Int in value(range) }
        print("Random.value (CountableRange) Test: results = \(randoms)")
        print("Random.value (CountableRange) Test: /---")
    }
    
    func test_value(_ range: CountableClosedRange<Int>) {
        print("Random.value (CountableClosedRange) Test: ----")
        let times = 50
        print("Random.value (CountableClosedRange) Test: testing times = \(times)")
        let randoms = (0..<times).map { _ -> Int in value(range) }
        print("Random.value (CountableClosedRange) Test: results = \(randoms)")
        print("Random.value (CountableClosedRange) Test: /---")
    }
    
    func test_bool(percentage: Int) {
        print("Random.bool Test: ----")
        print("Random.bool Test: expect > \(percentage)%")
        let times = 300
        print("Random.bool Test: testing times = \(times)")
        (0..<times).reduce(into: [true : 0, false : 0]) { dic, n in
            let choosed = bool(percentage: percentage)
            dic[choosed] = (dic[choosed] ?? 0) + 1
        }.forEach { elem in
            if elem.key {
                let perc = elem.value.percentage(for: times)
                print("Random.bool Test: result > \(perc)% (\(elem.value) times)")
            }
        }
        print("Random.bool Test: /---")
    }
    
    func test_choose(probabilities: [Int]) {
        print("Random.choose Test: ----")
        toPercentages(fromProbabilities: probabilities).enumerated().forEach { index, perc in
            print("Random.choose Test: expect > index: \(index) = \(perc)% (\(probabilities[index]) given)")
        }
        
        let times = 300
        print("Random.choose Test: testing times = \(times)")
        
        (0..<times).reduce(into: [Int : Int]()) { dic, n in
            let choosed = choose(probabilities: probabilities)
            dic[choosed] = (dic[choosed] ?? 0) + 1
        }.sorted(by: { a, b in
                a.key < b.key
        }).forEach { elem in
            let perc = elem.value.percentage(for: times)
            print("Random.choose Test: result > index: \(elem.key) = \(perc)% (\(elem.value) times)")
        }
        print("Random.choose Test: /---")
    }
    
    func test_selectItem<T>(from items: [T]) {
        if items.isEmpty { return }
        print("Random.selectItem Test: ----")
        print("Random.selectItem Test: choose > \(selectItem(from: items)!)")
        print("Random.selectItem Test: /---")
    }
    
    func test_selectItems<T>(from items: [T], number: Int, duplicatable: Bool = false) {
        if items.isEmpty { return }
        print("Random.selectItem Test: ----")
        print("Random.selectItem Test: choose > \(selectItems(from: items, number: number, duplicatable: duplicatable))")
        print("Random.selectItem Test: /---")
    }
}
