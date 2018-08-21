//
//  UITableView+ReusableViewTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 18.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class UITableViewReusableViewTests: XCTestCase {
    
    class ReusableTableViewCell: UITableViewCell, ReusableView {}
    
    var tableView: UITableView!
    let expectedReusableID = "ReusableTableViewCell"
    
    override func setUp() {
        super.setUp()
        tableView = UITableView()
        tableView.register(ReusableTableViewCell.self)
    }
    
    func testReusableIdIsValid() {
        XCTAssertEqual(ReusableTableViewCell.defaultReuseIdentifier, expectedReusableID)
    }
    
    func testRegisterReusableView() {
        let cell = tableView.dequeueReusableCell(withIdentifier: expectedReusableID) as? ReusableTableViewCell
        XCTAssertNotNil(cell)
    }
    
    func testDequeueReusabaleView() {
        let cell: ReusableTableViewCell = tableView.dequeueReusableCell()
        XCTAssertNotNil(cell)
    }
    
    func testDequeueReusabaleViewWithIndexPath() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell: ReusableTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        XCTAssertNotNil(cell)
    }
    
}
