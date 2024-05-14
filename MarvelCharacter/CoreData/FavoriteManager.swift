//
//  FavoriteManager.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 12/05/24.
//

import CoreData

protocol FavoriteManagerProtocol {
    func getFavorites() -> [Character]
    func isFavorite(id: Int64) -> Bool
    func removeFromFavorites(id: Int64)
    func addToFavorites(id: Int64, imagePath: String?, name: String?, text: String?)
}

class FavoriteManager: FavoriteManagerProtocol {
   
    static let shared = FavoriteManager()
    private init() {}

    private var favorites: [FavoriteCharacter] {
        let fetchRequest: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            let result = try AppDelegate.sharedAppDelegate.coreDataStack.context.fetch(fetchRequest)
            return result
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
            return []
        }
    }
    
    func getFavorites() -> [Character] {
        let fetchRequest: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            let favoriteCharacters = try AppDelegate.sharedAppDelegate.coreDataStack.context.fetch(fetchRequest)
            return favoriteCharacters.map { favoriteCharacter in
                return Character(id: Int(favoriteCharacter.id),
                                 name: favoriteCharacter.name ?? "",
                                 description: favoriteCharacter.text ?? "", 
                                 urlImage: favoriteCharacter.imagePath ?? "")
            }
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
            return []
        }
    }

    func isFavorite(id: Int64) -> Bool {
        return favorites.contains { $0.id == id }
    }

    func addToFavorites(id: Int64, imagePath: String?, name: String?, text: String?) {
        guard !isFavorite(id: id) else { return }

        let context = AppDelegate.sharedAppDelegate.coreDataStack.context
        let favoriteCharacter = FavoriteCharacter(context: context)
        favoriteCharacter.id = id
        favoriteCharacter.imagePath = imagePath
        favoriteCharacter.name = name
        favoriteCharacter.text = text
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }

    func removeFromFavorites(id: Int64) {
        let fetchRequest: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)

        let context = AppDelegate.sharedAppDelegate.coreDataStack.context
        if let result = try? context.fetch(fetchRequest), let objectToDelete = result.first {
            context.delete(objectToDelete)
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        }
    }
}
