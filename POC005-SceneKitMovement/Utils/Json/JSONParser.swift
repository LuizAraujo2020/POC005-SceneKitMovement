//
//  JSONParser.swift
//  POC02
//
//  Created by Luiz Araujo on 22/05/23.
//

import Foundation

func testDecode<T: Codable>(_ file: String, ext: String = "json") async -> T? {
    let url = Bundle.main.url(forResource: file, withExtension: ext)!

    let urlSession = URLSession.shared
    do {
        let (data, _) = try await urlSession.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    catch {
        // Error handling in case the data couldn't be loaded
        // For now, only display the error on the console
        debugPrint("Error loading \(url): \(String(describing: error))")
    }

    return nil
}

//func encode<T>(_ value: T) throws -> Data where T : Encodable {
//    let encoder = JSONEncoder()
//    encoder.outputFormatting = .prettyPrinted
//
//    let data = try encoder.encode(information)
//}
