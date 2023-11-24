//
//  DetailModel.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import Foundation

// MARK: - Welcome
struct DetailResponse: Codable {
    let type: String
    let properties: WelcomeProperties
    let geometry: Geometry
    let id: String
}

// MARK: - Geometry
struct GeometryDetail: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - WelcomeProperties
struct WelcomeProperties: Codable {
    let mag: Double
    let place: String
    let time, updated: Int
    let tz: JSONNull?
    let url: String
    let felt, cdi, mmi, alert: JSONNull?
    let status: String
    let tsunami, sig: Int
    let net, code, ids, sources: String
    let types: String
    let nst: Int
    let dmin, rms: Double
    let gap: Int
    let magType, type, title: String
    let products: Products
}

// MARK: - Products
struct Products: Codable {
    let origin, phaseData: [Origin]

    enum CodingKeys: String, CodingKey {
        case origin
        case phaseData = "phase-data"
    }
}

// MARK: - Origin
struct Origin: Codable {
    let indexid: String
    let indexTime: Int
    let id, type, code, source: String
    let updateTime: Int
    let status: String
    let properties: OriginProperties
    let preferredWeight: Int
    let contents: Contents
}

// MARK: - Contents
struct Contents: Codable {
    let contentsXML, quakemlXML: XML

    enum CodingKeys: String, CodingKey {
        case contentsXML = "contents.xml"
        case quakemlXML = "quakeml.xml"
    }
}

// MARK: - XML
struct XML: Codable {
    let contentType: String
    let lastModified, length: Int
    let url: String
    let sha256: String
}

// MARK: - OriginProperties
struct OriginProperties: Codable {
    let azimuthalGap, depth, depthType, evaluationStatus: String
    let eventType, eventParametersPublicID, eventsource, eventsourcecode: String
    let eventtime, horizontalError, latitude, longitude: String
    let magnitude, magnitudeError, magnitudeNumStationsUsed, magnitudeType: String
    let minimumDistance, numPhasesUsed, numStationsUsed, originalSignature: String
    let originalSignatureVersion, pdlClientVersion, quakemlMagnitudePublicid, quakemlOriginPublicid: String
    let quakemlPublicid, reviewStatus, standardError: String
    let title: String?
    let verticalError: String

    enum CodingKeys: String, CodingKey {
        case azimuthalGap = "azimuthal-gap"
        case depth
        case depthType = "depth-type"
        case evaluationStatus = "evaluation-status"
        case eventType = "event-type"
        case eventParametersPublicID, eventsource, eventsourcecode, eventtime
        case horizontalError = "horizontal-error"
        case latitude, longitude, magnitude
        case magnitudeError = "magnitude-error"
        case magnitudeNumStationsUsed = "magnitude-num-stations-used"
        case magnitudeType = "magnitude-type"
        case minimumDistance = "minimum-distance"
        case numPhasesUsed = "num-phases-used"
        case numStationsUsed = "num-stations-used"
        case originalSignature = "original-signature"
        case originalSignatureVersion = "original-signature-version"
        case pdlClientVersion = "pdl-client-version"
        case quakemlMagnitudePublicid = "quakeml-magnitude-publicid"
        case quakemlOriginPublicid = "quakeml-origin-publicid"
        case quakemlPublicid = "quakeml-publicid"
        case reviewStatus = "review-status"
        case standardError = "standard-error"
        case title
        case verticalError = "vertical-error"
    }
}
