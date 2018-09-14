//
//  ProfileLogicController.swift
//  LogicControllersDemo
//
//  Created by Mike Gopsill on 14/09/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

enum ProfileError: Error {
    case couldNotLoad
}

enum ProfileState {
    case loading
    case presenting(User)
    case failed(Error)
}

class ProfileLogicController {
    typealias Handler = (ProfileState) -> Void
    
    func load(than handler: @escaping Handler) {
        // load state of view then run handler
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // mocks a 2 second network response
            let profileImage = UIImage(named: "tyrion")
            let user = User(firstName: "Tyrion", surname: "Lannister", profileImage: profileImage!)
            
            // mock success or failure loading user
            self.randomBool() ? handler(.presenting(user)) : handler(.failed(ProfileError.couldNotLoad))
        }
    }
    
    func changeDisplayName(to name: String, then handler: @escaping Handler) {
        // change the user's display name and then run completion handler
    }
    
    func changeProfilePhoto(to photo: UIImage, then handler: @escaping Handler) {
        // Change the user's profile photo and then run a completion handler
    }
    
    func logout() {
        // Log the user out, then re-direct to the login screen
    }
    
    private func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
}


