//
//  UserProfile.swift
//  Speech-beImpact
//
//  Created by Hneen on 12/06/1447 AH.
//
import SwiftUI
import Combine

class UserProfile: ObservableObject {
    @Published var childName: String {
        didSet { UserDefaults.standard.set(childName, forKey: "childName") }
    }
    
    @Published var gender: Gender? {
        didSet {
            if let gender = gender {
                UserDefaults.standard.set(gender.rawValue, forKey: "childGender")
            }
        }
    }
    
    @Published var profileImageName: String {
        didSet { UserDefaults.standard.set(profileImageName, forKey: "profileImageName") }
    }
    
    init() {
        self.childName = UserDefaults.standard.string(forKey: "childName") ?? ""
        
        if let savedGender = UserDefaults.standard.string(forKey: "childGender"),
           let gender = Gender(rawValue: savedGender) {
            self.gender = gender
        } else {
            self.gender = nil
        }
        
        self.profileImageName = UserDefaults.standard.string(forKey: "profileImageName") ?? "boyCharacter"
    }
}

enum Gender: String {
    case boy = "boy"
    case girl = "girl"
}
