///
// RealmController.swift
///

import Realm
import RealmSwift

final class RealmController {
  
  static let shared = RealmController()
  
  private let db = try! Realm()
  
  private init() {}
  
  static var user: User {
    return shared.db.objects(User.self).first ?? shared.createUser()
  }
  
  private func createUser() -> User {
    try! db.write {
      db.add(User())
    }
    return RealmController.user
  }
  
  static func increase(karmaPerSecond: Float) {
    try! shared.db.write {
      user.karmaPerSecond = user.karmaPerSecond + karmaPerSecond
    }
  }
  
  static func increase(multiplierPerCrush: Float) {
    try! shared.db.write {
      user.multiplierPerCrush = user.multiplierPerCrush + multiplierPerCrush
    }
  }
  
  static func increase(valuePerCrush: Float) {
    try! shared.db.write {
      user.valuePerCrush = user.valuePerCrush + valuePerCrush
    }
  }
  
  static func save(user: User) {
    try! shared.db.write {
      shared.db.add(user)
    }
  }
  
  static func spend(user: User, price: Float) {
    try! shared.db.write {
      user.karma = user.karma - price
    }
  }
}
