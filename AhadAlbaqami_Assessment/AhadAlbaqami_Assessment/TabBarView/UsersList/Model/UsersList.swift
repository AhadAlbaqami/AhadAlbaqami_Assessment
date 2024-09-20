//
//  UsersList.swift
//  AhadAlbaqami_Assessment
//
//  Created by Ahad Albaqami on 9/18/24.
//

import Foundation

// MARK: - UsersList
struct UsersList: Codable, Hashable {
    let id: String
    let createdAt: Date
    let width, height: Int
    let color: String
    let likes: Int
    let likedByUser: Bool
    let user: User
    let currentUserCollections: [String]
    let urls: Urls
    let categories: [Category]
    let links: WelcomeLinks
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, color, likes
        case likedByUser = "liked_by_user"
        case user
        case currentUserCollections = "current_user_collections"
        case urls, categories, links
    }
    
    static func == (lhs: UsersList, rhs: UsersList) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let title: String
    let photoCount: Int
    let links: CategoryLinks
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case photoCount = "photo_count"
        case links
    }
}

// MARK: - CategoryLinks
struct CategoryLinks: Codable {
    let linksSelf, photos: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case photos
    }
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let linksSelf: String
    let html, download: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let id, username, name: String
    let profileImage: ProfileImage
    let links: UserLinks
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case profileImage = "profile_image"
        case links
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf: String
    let html: String
    let photos, likes: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}
