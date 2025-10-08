//
//  ProfileServiceProtocol.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

protocol ProfileServiceProtocol {
    func loadProfile() async throws -> Profile
    func updateProfile(for likes: Set<String>) async throws -> Profile
}
