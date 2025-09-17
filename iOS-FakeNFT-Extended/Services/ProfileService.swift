//
//  ProfileService.swift
//  iOS-FakeNFT-Extended
//
//  Created by Danil Kazakov on 17.09.2025.
//

final class ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadProfile() async throws -> Profile {
        let request = GetProfileRequest()
        return try await networkClient.send(request: request)
    }
    
    func updateProfile(for likes: Set<String>) async throws -> Profile {
        let request = PutProfileRequest(likes: likes)
        return try await networkClient.send(request: request)
    }
}
