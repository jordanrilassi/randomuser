//
//  CustomError.swift
//  RandomUsers
//
//  Created by Rilassi Jordan on 11/01/2022.
//

import Foundation

enum CustomError: Error {
    case unknownError
    case noNetwork
    
    var customMessage: String {
        switch self {
        case .unknownError:
            return "Une erreur inconnue s'est produite."
        case .noNetwork:
            return "Pas de connexion réseau."
        }
    }
}
