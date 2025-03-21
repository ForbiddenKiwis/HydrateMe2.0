//
//  Users.swift
//  HydrateMe
//
//  Created by english on 2025-02-12.
//

import Foundation

class Users{
    static var currentUserId = 0
    static var userNum = currentUserId / 100

    private var email: String
    private var userId: Int
    private var firstName: String
    private var lastName: String
    private var password: String
    private var hydrationHistory: [HydrationRecord]
    private var rewards: [Rewards]
    private var reminders: [Reminders]
    
    public init(firstName: String, lastName: String, email: String ,password: String) {
        Users.currentUserId += 100
        self.userId = Users.currentUserId
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.hydrationHistory = []
        self.rewards = []
        self.reminders = []
    }
    
    public func getUserId() -> Int {
        return userId
    }
    
    public func setUserId(_ userId: Int) {
        Users.currentUserId += 100
        self.userId = Users.currentUserId
    }
    
    public func geFirstName() -> String {
        return firstName
    }
    
    public func setFirstName(_ firstName: String) {
        self.firstName = firstName
    }
    
    public func geLastName() -> String {
        return lastName
    }
    
    public func setLastName(_ lastName: String) {
        self.lastName = lastName
    }

    public func getEmail() -> String {
        return email
    }

    public func setEmail(_ email: String) {
        self.email = email
    }
    
    public func getPassword() -> String {
        return password
    }
    
    public func setPassword(_ password: String) {
        self.password = password
    }
    
    public func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }

    public func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
        return predicate.evaluate(with: email)
    }
    
    public func addRewards(){
        
    }
    
    public func addReminder(){
        
    }
    
    public func activateReminder() -> Bool{
        return true
    }
    
    public func doesUserAlrHaveReward(id: Int) -> Bool {
        return false
    }
}
