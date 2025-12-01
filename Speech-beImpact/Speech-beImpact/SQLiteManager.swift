//
//  SQLiteManager.swift
//  speech app test
//
//  Created by Wed Ahmed Alasiri on 29/05/1447 AH.
//
import Foundation
import SQLite3

class SQLiteManager {
    var db: OpaquePointer?

    init() {
        openDatabase()
        createTable()
    }

    func openDatabase() {
        let path = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("results.db")

        if sqlite3_open(path.path, &db) != SQLITE_OK {
            print("Error opening DB")
        }
    }

    func createTable() {
        let query = """
        CREATE TABLE IF NOT EXISTS results(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            word TEXT,
            correct INTEGER
        );
        """
        sqlite3_exec(db, query, nil, nil, nil)
    }

    func insert(word: String, correct: Bool) {
        let query = "INSERT INTO results (word, correct) VALUES (?, ?);"
        var stmt: OpaquePointer?

        sqlite3_prepare_v2(db, query, -1, &stmt, nil)
        sqlite3_bind_text(stmt, 1, NSString(string: word).utf8String, -1, nil)
        sqlite3_bind_int(stmt, 2, correct ? 1 : 0)

        sqlite3_step(stmt)
        sqlite3_finalize(stmt)
    }
}
