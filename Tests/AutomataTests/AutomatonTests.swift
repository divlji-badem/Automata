import XCTest
@testable import Automata

final class AutomatonTests: XCTestCase {
    
    func test_Automaton_State_initial() {
        XCTAssertEqual(Automaton.State.initial(radius: 0), [true])
        XCTAssertEqual(Automaton.State.initial(radius: 1), [false, true, false])
        XCTAssertEqual(Automaton.State.initial(radius: 2), [false, false, true, false, false])
    }
    
    func test_ruleAsBinaryArray() {
        
        let (T, F) = (true, false)
        let expectations: [UInt8: [Bool]] = [
            0: [F, F, F, F, F, F, F, F],
            1: [F, F, F, F, F, F, F, T],
            90: [F, T, F, T, T, F, T, F],
            254: [T, T, T, T, T, T, T, F],
            255: [T, T, T, T, T, T, T, T],
        ]
        for (rule, expect) in expectations {
            let automaton = Automaton(rule: rule, state: [])
            XCTAssertEqual(automaton.ruleAsBinaryArray, expect)
        }
        
        for rule in UInt8.min ... .max {
            let automaton = Automaton(rule: rule, state: [])
            let ruleAsBinaryArray = automaton.ruleAsBinaryArray
            let x: UInt8 = ruleAsBinaryArray.reversed().enumerated().reduce(0) { a, e in
                e.element ? a + 1 << e.offset : a
            }
            XCTAssertEqual(x, rule)
        }
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
    
    func test_rule() {
        
        let automaton = Automaton(rule: 110, state: .initial(radius: 20), padding: .empty)
        print(automaton)
        for a in automaton.prefix(50) {
            print(a)
        }
    }
    
    func test_historyRule110_nextGeneration() {
        
        let tests: [Automaton.Padding: [String]] = [
            .wrapped: History.rule110Wrapped,
            .empty: History.rule110Empty,
        ]
        
        for (padding, history) in tests {
            for (before, after) in zip(history, history.dropFirst()) {
                var automaton = Automaton(
                    rule: 110,
                    state: before,
                    on: "●",
                    off: "∙",
                    padding: padding
                )
                automaton.nextGeneration()
                XCTAssertEqual(automaton.string(on: "●", off: "∙"), after)
            }
        }
    }
    
    func test_historyRules_nextGeneration() {
        
        struct Test {
            let padding: Automaton.Padding
            let rule: Automaton.Rule
            let history: [String]
        }
        
        let tests: [Test] = [
            Test(
                padding: .empty,
                rule: 90,
                history: History.rule90Empty
            ),
            Test(
                padding: .wrapped,
                rule: 90,
                history: History.rule90Empty
            ),
            Test(
                padding: .empty,
                rule: 110,
                history: History.rule110Empty
            ),
            Test(
                padding: .wrapped,
                rule: 110,
                history: History.rule110Wrapped)
        ]
        
        for test in tests {
            for (before, after) in zip(test.history, test.history.dropFirst()) {
                var automaton = Automaton(
                    rule: test.rule,
                    state: before,
                    on: "●",
                    off: "∙",
                    padding: test.padding
                )
                automaton.nextGeneration()
                XCTAssertEqual(automaton.string(on: "●", off: "∙"), after)
            }
        }
    }
}
