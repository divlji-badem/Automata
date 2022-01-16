//
//  File.swift
//  
//
//  Created by Jelena Tasic on 9.1.22..
//

import XCTest

final class StringTests: XCTestCase {
    
    func test() {
        
        XCTAssertEqual("".lines(), [""])
        XCTAssertEqual("x".lines(), ["x"])
        XCTAssertEqual("x\ny".lines(), ["x", "y"])
        XCTAssertEqual("x\ry".lines(), ["x", "y"])
    }
}

extension String {
    
    @inlinable func lines() -> [String] {
        components(separatedBy: .newlines)
    }
}
