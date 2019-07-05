//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Cameron Mcleod on 2019-07-05.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {

    var app : XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddMeal() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        addNewMeal(mealName: "Burger", numberOfCalories: 300)
        
        
    }
    

    func testShowMealDetail() {
        

        
        let mealName = "Burger"
        let numberOfCalories = 300
        mealDetails(mealName: mealName, numberOfCalories: numberOfCalories)
        
        XCTAssertTrue(app.staticTexts["detailViewControllerLabel"].exists)

        app.navigationBars["Detail"].buttons["Master"].tap()
        
        
    }
    
    func testDeleteMeal() {
        
        deleteMeal(mealName: "Burger", numberOfCalories: 300)
    }
    
    func testDeleteAllMeals() {
        
        let numElements = app.tables.staticTexts.containing(.staticText, identifier: nil).allElementsBoundByIndex.count
        for _ in 0..<numElements {
            app.tables.staticTexts.element(boundBy: 0).swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
    func testAddAndDeleteMeal() {
        
        self.measure {
            let meal = "food"
            let calories = 34532
            
            addNewMeal(mealName: meal, numberOfCalories: calories)
            deleteMeal(mealName: meal, numberOfCalories: calories)
        }

        
    }
    
    func addNewMeal (mealName: String , numberOfCalories: Int) {
    
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(numberOfCalories))
        addAMealAlert.buttons["Ok"].tap()
        
    }
    
    func deleteMeal (mealName: String , numberOfCalories: Int) {
        
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
        
    }
    
    func mealDetails ( mealName: String, numberOfCalories: Int) {
        
        let staticText = app.tables.cells.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.tap()
        }
        
    }
    
}
