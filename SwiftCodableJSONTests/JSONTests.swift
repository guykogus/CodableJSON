//
//  JSONTests.swift
//  SwiftCodableJSONTests
//
//  Created by Guy Kogus on 22/12/2018.
//  Copyright © 2018 Guy Kogus. All rights reserved.
//

import XCTest
@testable import SwiftCodableJSON

class JSONTests: XCTestCase {
    struct Dummy {
        static let null = JSON.null
        static let bool = JSON.bool(value: false)
        static let int = JSON.int(value: 0)
        static let double = JSON.double(value: 0)
        static let string = JSON.string(value: "")
        static let array = JSON.array(value: [])
        static let object = JSON.object(value: [:])
    }

    func testNull() {
        XCTAssertFalse(Dummy.bool.isNull)
        XCTAssertFalse(Dummy.int.isNull)
        XCTAssertFalse(Dummy.double.isNull)
        XCTAssertFalse(Dummy.string.isNull)
        XCTAssertFalse(Dummy.array.isNull)
        XCTAssertFalse(Dummy.object.isNull)

        XCTAssertTrue(Dummy.null.isNull)
    }

    func testBool() {
        XCTAssertNil(Dummy.null.boolValue)
        XCTAssertNil(Dummy.int.boolValue)
        XCTAssertNil(Dummy.double.boolValue)
        XCTAssertNil(Dummy.string.boolValue)
        XCTAssertNil(Dummy.array.boolValue)
        XCTAssertNil(Dummy.object.boolValue)

        XCTAssertNotNil(Dummy.bool.boolValue)
        XCTAssertFalse(JSON.bool(value: false).boolValue!)
        XCTAssertTrue(JSON.bool(value: true).boolValue!)
    }

    func testInt() {
        XCTAssertNil(Dummy.null.intValue)
        XCTAssertNil(Dummy.bool.intValue)
        XCTAssertNil(Dummy.string.intValue)
        XCTAssertNil(Dummy.array.intValue)
        XCTAssertNil(Dummy.object.intValue)

        XCTAssertEqual(Dummy.double.intValue, 0)
        XCTAssertNil(JSON.double(value: Double.leastNormalMagnitude).intValue)
        XCTAssertNil(JSON.double(value: Double.leastNonzeroMagnitude).intValue)

        XCTAssertEqual(Dummy.int.intValue, 0)
        let positive: JSON = 123
        XCTAssertEqual(positive.intValue, 123)
        let negative: JSON = -123
        XCTAssertEqual(negative.intValue, -123)
    }

    func testDouble() {
        XCTAssertNil(Dummy.null.doubleValue)
        XCTAssertNil(Dummy.bool.doubleValue)
        XCTAssertNil(Dummy.string.doubleValue)
        XCTAssertNil(Dummy.array.doubleValue)
        XCTAssertNil(Dummy.object.doubleValue)

        XCTAssertEqual(Dummy.int.doubleValue, 0)
        XCTAssertEqual(Dummy.double.doubleValue, 0)
        let positive: JSON = 123.0
        XCTAssertEqual(positive.doubleValue, 123)
        let negative: JSON = -123.0
        XCTAssertEqual(negative.doubleValue, -123)
    }

    func testNumbers() {
        let numbersString = "[-0, 0, 0.0, 0.1]"
        let decoder = JSONDecoder()
        let doublesJSON = try! decoder.decode(JSON.self, from: numbersString.data(using: .utf8)!)
        XCTAssertEqual(doublesJSON[0]?.intValue, 0)
        XCTAssertEqual(doublesJSON[1]?.intValue, 0)
        XCTAssertEqual(doublesJSON[2]?.intValue, 0)
        XCTAssertNil(doublesJSON[3]?.intValue)
        XCTAssertEqual(doublesJSON[0]?.doubleValue, 0)
        XCTAssertEqual(doublesJSON[1]?.doubleValue, 0)
        XCTAssertEqual(doublesJSON[2]?.doubleValue, 0)
        XCTAssertEqual(doublesJSON[3]?.doubleValue, 0.1)
    }

    func testString() {
        XCTAssertNil(Dummy.null.stringValue)
        XCTAssertNil(Dummy.bool.stringValue)
        XCTAssertNil(Dummy.int.stringValue)
        XCTAssertNil(Dummy.double.stringValue)
        XCTAssertNil(Dummy.array.stringValue)
        XCTAssertNil(Dummy.object.stringValue)

        XCTAssertNotNil(Dummy.string.stringValue)
        let string: JSON = "Hello world"
        XCTAssertEqual(string.stringValue, "Hello world")
    }

    func testArray() {
        XCTAssertNil(Dummy.null[0])
        XCTAssertNil(Dummy.bool[0])
        XCTAssertNil(Dummy.int[0])
        XCTAssertNil(Dummy.double[0])
        XCTAssertNil(Dummy.string[0])
        XCTAssertNil(Dummy.object[0])

        let array: JSON = ["foo", "bar", 5, 8.0, [nil]]
        XCTAssertEqual(array.count, 5)
        XCTAssertEqual(array[0]?.stringValue, "foo")
        XCTAssertEqual(array[1]?.stringValue, "bar")
        XCTAssertEqual(array[2]?.intValue, 5)
        XCTAssertEqual(array[3]?.doubleValue, 8.0)
        XCTAssertEqual(array[4]?.count, 1)
        XCTAssertEqual(array[4]?[0]?.isNull, true)
        XCTAssertNil(array[4]?[1])
        XCTAssertNil(array[5])

        var newArray = array
        newArray[2] = nil
        XCTAssertEqual(newArray[2]?.isNull, true)
        XCTAssertEqual(array[2]?.intValue, 5)
        newArray[3] = 8
        XCTAssertEqual(newArray[3]?.intValue, 8)
    }

    func testObject() {
        XCTAssertNil(Dummy.null[""])
        XCTAssertNil(Dummy.bool[""])
        XCTAssertNil(Dummy.int[""])
        XCTAssertNil(Dummy.double[""])
        XCTAssertNil(Dummy.string[""])
        XCTAssertNil(Dummy.array[""])

        let object: JSON = [
            "foo": "bar",
            "fib": [1, 1, 2, 3, 5, 8, 13],
            "life": 42,
            "nothing": nil,
            "apple": [
                "address": [
                    "street": "1 Infinite Loop",
                    "city": "Cupertino",
                    "state": "CA",
                    "zip": "95014"
                ]
            ]
        ]
        XCTAssertEqual(object.count, 5)
        XCTAssertEqual(object["foo"]?.stringValue, "bar")
        XCTAssertEqual(object["fib"]?[4]?.intValue, 5)
        XCTAssertEqual(object["life"]?.intValue, 42)
        XCTAssertEqual(object["nothing"]?.isNull, true)
        XCTAssertEqual(object["apple"]?["address"]?.count, 4)
        XCTAssertEqual(object["apple"]?["address"]?["city"], "Cupertino")

        var newObject = object
        newObject["apple"]?["address"] = nil
        XCTAssertNil(newObject["apple"]?["address"]?["city"])
        XCTAssertEqual(newObject["apple"]?["address"]?.isNull, true)
        XCTAssertEqual(object["apple"]?["address"]?["city"], "Cupertino")
        newObject["life"] = "great"
        XCTAssertEqual(newObject["life"]?.stringValue, "great")
    }

    func testCodable() {
        // Example taken from https://json.org/example.html
        let stringValue = """
{"glossary":{"GlossDiv":{"GlossList":{"GlossEntry":{"Abbrev":"ISO 8879:1986","Acronym":"SGML","GlossDef":{"GlossSeeAlso":["GML","XML"],"para":"A meta-markup language, used to create markup languages such as DocBook."},"GlossSee":"markup","GlossTerm":"Standard Generalized Markup Language","ID":"SGML","SortAs":"SGML"}},"title":"S"},"title":"example glossary"}}
"""
        let jsonValue: JSON = [
            "glossary": [
                "GlossDiv": [
                    "GlossList": [
                        "GlossEntry": [
                            "Abbrev": "ISO 8879:1986",
                            "Acronym": "SGML",
                            "GlossDef": [
                                "GlossSeeAlso": [
                                    "GML",
                                    "XML"
                                ],
                                "para": "A meta-markup language, used to create markup languages such as DocBook."
                            ],
                            "GlossSee": "markup",
                            "GlossTerm": "Standard Generalized Markup Language",
                            "ID": "SGML",
                            "SortAs": "SGML"
                        ]
                    ],
                    "title": "S"
                ],
                "title": "example glossary"
            ]
        ]

        XCTAssertEqual(try! JSONDecoder().decode(JSON.self, from: stringValue.data(using: .utf8)!),
                       jsonValue)

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        XCTAssertEqual(String(data: try! encoder.encode(jsonValue), encoding: .utf8),
                       stringValue)
    }
}
