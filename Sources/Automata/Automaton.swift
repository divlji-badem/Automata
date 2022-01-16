//
//  Created by Jelena Tasic on 12.12.21.
//

public struct Automaton {

    public typealias Rule = UInt8
    public typealias State = [Bool]
    public typealias Evolution = [Automaton]

    public let rule: Rule
    public let state: State
    public let padding: Padding

    public init(rule: Rule, state: State, padding: Padding = .wrapped) {
        self.rule = rule
        self.state = state
        self.padding = padding
    }
}

extension Automaton: CustomStringConvertible {
    
    public init(rule: Rule, state: String, on: Character, off: Character, padding: Padding = .wrapped) {
        self.rule = rule
        self.state = state.map{
            $0 == on ? true : false
        }
        self.padding = padding
    }
    
    public func string(on: String, off: String) -> String {
        state.enumerated().reduce(""){ a, e in e.element ? a + on : a + off }
    }
    
    @inlinable public var description: String {
        string(on: "●", off: "∙")
    }
}

public extension Automaton {

    enum Padding {
        case empty
        case wrapped
    }
}

extension Automaton: Sequence, IteratorProtocol {
    
    func currentNeighbours(for possition: Int) -> [Bool] {
        var current = Array(repeating: false, count: 3)
        if possition == 0 {
            current[0] = padding == .wrapped ? state[state.count - 1] : false
        } else {
            current[0] = state[possition - 1]
        }
        current[1] = state[possition]
        if possition == state.count - 1 {
            current[2] = padding == .wrapped ? state[0] : false
        } else {
            current[2] = state[possition + 1]
        }
        return current
    }
    
    public func boolArrayToInt(boolArray: [Bool]) -> Int {
        boolArray.reversed().enumerated().reduce(0) { a, e in
            e.element ? a + 1 << e.offset : a
        }
    }
    
    public var ruleAsBinaryArray: [Bool] {
        (0...7).lazy.reversed().map { i in rule & 1 << i != 0 }
    }
    
    public mutating func nextGeneration() {
        
        var nextState: State = State()

        for i in 0 ..< state.count {
            let current = currentNeighbours(for: i)
            let currentToNumber = boolArrayToInt(boolArray: current)
            nextState.append(ruleAsBinaryArray[7 - Int(currentToNumber)])
        }
        self = Automaton(rule: rule, state: nextState, padding: padding)
    }
    
    public mutating func next() -> Automaton? {
        nextGeneration()
        return self
    }
}

public extension Automaton.State {

    static func random(count: UInt) -> Automaton.State {
        (1...count).map{ _ in Bool.random() }
    }

    static func initial(radius: UInt) -> Automaton.State {
        var o = Array(repeating: false, count: Int(radius) * 2 + 1)
        o[Int(radius)] = true
        return o
    }
}




