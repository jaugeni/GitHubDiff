//
//  NetworkErrors.swift
//  GitErrors
//
//  Created by YAUHENI IVANIUK on 2/17/21.
//

import Foundation

enum GitErrors: String, Error {
    
    case invalidUrl = "This owner name or repo name  is inavalid or repository is private. Please try again."
    case serverError = "Ups something went wrong. Please try again."
    case invalidResponse = "Incorrect response. Please try again."
    case ivalidData = "Data is not exist. Please try again."
    case failtoDecodeData = "Fail to decode data. Please try again."
}
