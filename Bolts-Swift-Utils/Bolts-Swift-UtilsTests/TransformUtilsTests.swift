//
//  TransformUtilsTests.swift
//  Bolts-Swift-Utils
//
//  Created by thinhvoxuan on 8/28/16.
//  Copyright © 2016 Thinhvoxuan. All rights reserved.
//

import XCTest

class TransformUtilsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testReformat1() {
        let input = "20/12/2016"
        let expectResult = "2016/12/20"
        let result = TransformUtils.changeFormatDate(input, fromFormat: "dd/MM/yyyy", toFormat: "yyyy/MM/dd")
        XCTAssertEqual(result, expectResult)
    }

    func testReformat2() {
        let input = "20/12/2016"
        let expectResult = "2016/20/12"
        let result = TransformUtils.changeFormatDate(input, fromFormat: "dd/MM/yyyy", toFormat: "yyyy/dd/MM")
        XCTAssertEqual(result, expectResult)
    }

    func testReformat3() {
        let input = "20/12/2016"
        let expectResult = "12/20/2016"
        let result = TransformUtils.changeFormatDate(input, fromFormat: "dd/MM/yyyy", toFormat: "MM/dd/yyyy")
        XCTAssertEqual(result, expectResult)
    }

    func testStringEmpty() {
        let input = "20/20/2016"
        let expectResult = ""
        let result = TransformUtils.changeFormatDate(input)
        XCTAssertEqual(result, expectResult)
    }
}
