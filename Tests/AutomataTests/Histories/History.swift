//
//  File.swift
//  
//
//  Created by Jelena Tasic on 3.1.22..
//

import Automata

enum History {}

struct Test {
    let padding: Automaton.Padding
    let rule: Automaton.Rule
    let history: [String]
}

extension History {
    static let tests: [Test] = [
        Test(
            padding: .empty,
            rule: 90,
            history: History.rule90Empty
        ),
        Test(
            padding: .wrapped,
            rule: 90,
            history: History.rule90Wrapped
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
}


