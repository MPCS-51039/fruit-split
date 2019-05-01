//
//  Fruit.swift
//  FruitSplit
//
//  Created by Chelsea Troy on 4/29/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

struct FruitResult: Codable {
    let results: [Fruit]
}

struct Fruit: Codable {
    let altDescription: String
    let description: String?
    let urls: PictureResult
    let user: Photographer?
}

struct PictureResult: Codable {
    let small: String
}
