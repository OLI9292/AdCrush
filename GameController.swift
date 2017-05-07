///
/// GameController.swift
///

import Foundation
import RxSwift

final class GameController {
  
  static let shared = GameController()
  
  private init() {}
  
  func currentUser() -> Observable<User> {
    // Placeholder
    return Observable.just(
      User(karma: 10)
    )
  }
}
