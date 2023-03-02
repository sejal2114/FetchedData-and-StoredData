//
//  DBHelper.swift
//  ApiFetch-Save
//
//  Created by Sejal on 02/03/23.
//

import Foundation
import SQLite3

class DBHelper{
    
    let dbPath: String = "productDB.sqlite"
    var db: OpaquePointer?
    let TABLE_NAME = "product"
    let COLUMN_TITLE = "title"
    
    init()
    {
        db = openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        print(dbPath)
        print(fileURL)
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
        
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME)(Id INTEGER PRIMARY KEY, \(COLUMN_TITLE) TEXT, description TEXT, brand TEXT, price INTEGER, thumbnail TEXT );"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("product table created.")
            } else {
                print("product table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(product: Product)
    {
        let insertStatementString = "INSERT INTO \(TABLE_NAME) (Id, \(COLUMN_TITLE), description, brand, price, thumbnail) VALUES (?, ?, ?, ?, ?, ?);"
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(product.id))
            sqlite3_bind_text(insertStatement, 2, (product.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (product.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (product.brand as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, Int32(product.price))
            sqlite3_bind_text(insertStatement, 6, (product.thumbnail as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Product] {
        let queryStatementString = "SELECT * FROM \(TABLE_NAME);"
        var queryStatement: OpaquePointer? = nil
        //SQlite prepare statement
        
        var products : [Product] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                //        let createTableString = "CREATE TABLE IF NOT EXISTS \(TABLE_NAME)(Id INTEGER PRIMARY KEY, \(COLUMN_TITLE) TEXT, description TEXT, brand TEXT, price INTEGER );"

                let title = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))

                let brand = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))

                let price = sqlite3_column_int(queryStatement, 4)
                let thumbnail = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))

                let product = Product(id: Int(id), title: title, description: description, price: Int(price), discountPercentage: 0, rating: 0, stock: 0, brand: brand, thumbnail: thumbnail)
                
                products.append(product)
                print("Query Result:")
                
                print("\(id) | \(title) | \(brand)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return products
    }
}
