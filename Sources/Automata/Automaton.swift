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

public extension Automaton {

    enum Padding {
        case empty
        case wrapped
    }
}

public extension Automaton {

    func next() -> Automaton {
        fatalError()
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




