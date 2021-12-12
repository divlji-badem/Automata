import XCTest
@testable import Automata

final class AutomatonTests: XCTestCase {
    
    func test_Automaton_State_initial() {
        XCTAssertEqual(Automaton.State.initial(radius: 0), [true])
        XCTAssertEqual(Automaton.State.initial(radius: 1), [false, true, false])
        XCTAssertEqual(Automaton.State.initial(radius: 2), [false, false, true, false, false])
    }
    
    func test() {
        /*
         90
          0   1   0   1   1   0   1   0
         111 110 101 100 011 010 001 000
          7   6   5   4   3   2   1   0
         */
        let ruleNumber = 90
        let rule = (0...7).map { i in ruleNumber & 1 << i != 0 }
        
        let x = rule.reversed().enumerated().reduce(0) { a, e in
            e.element ? a + 1 << e.offset : a
        }
        
        print("✅", rule, x)
    }
}
