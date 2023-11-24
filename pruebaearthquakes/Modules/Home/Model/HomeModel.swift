//
//  HomeModel.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import Foundation

// MARK: - Welcome
struct HomeResponse: Codable {
    let type: String
    let metadata: Metadata
    let features: [Feature]
    let bbox: [Double]
}

// MARK: - Feature
struct Feature: Codable {
    let type: FeatureType
    let properties: Properties
    let geometry: Geometry
    let id: String
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

// MARK: - Properties
struct Properties: Codable {
    let mag: Double?
    let place: String?
    let time, updated: Int
    let tz: JSONNull?
    let url, detail: String
    let felt: Int?
    let cdi, mmi: Double?
    let alert: String?
    let status: Status
    let tsunami, sig: Int
    let net: Net
    let code, ids, sources, types: String
    let nst: Int?
    let dmin: Double?
    let rms: Double
    let gap: Double?
    let magType: MagType
    let type: PropertiesType
    let title: String?
}

enum MagType: String, Codable {
    case mb = "mb"
    case mbLg = "mb_lg"
    case md = "md"
    case ml = "ml"
    case mwr = "mwr"
    case mww = "mww"
}

enum Net: String, Codable {
    case ak = "ak"
    case av = "av"
    case ci = "ci"
    case hv = "hv"
    case mb = "mb"
    case nc = "nc"
    case nm = "nm"
    case nn = "nn"
    case ok = "ok"
    case pr = "pr"
    case se = "se"
    case us = "us"
    case uu = "uu"
    case uw = "uw"
}

enum Status: String, Codable {
    case automatic = "automatic"
    case reviewed = "reviewed"
}

enum PropertiesType: String, Codable {
    case earthquake = "earthquake"
    case iceQuake = "ice quake"
}

enum FeatureType: String, Codable {
    case feature = "Feature"
}

// MARK: - Metadata
struct Metadata: Codable {
    let generated: Int
    let url: String
    let title: String
    let status: Int
    let api: String
    let count: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
