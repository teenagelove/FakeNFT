import Observation
import os
import ProgressHUD

private let logger = Logger(subsystem: "Statistics", category: "UserCollectionView")

@MainActor
@Observable
final class UserCollectionViewModel {
    init(items: [UserCollectionItemViewModel]) {
        self.items = items
    }
    var items: [UserCollectionItemViewModel]
    var likes: Set<String> = []
    var inCart: Set<String> = []
    var isFavoritesLoaded = false
    var isInCartLoaded = false
}

extension UserCollectionViewModel {
    func update(serviceAssembly: ServicesAssembly) {
        ProgressHUD.animate(interaction: false)
        updateLikes(serviceAssembly: serviceAssembly)
        updateCart(serviceAssembly: serviceAssembly)
    }
    func maybeDismissHUD() {
        if isFavoritesLoaded && isInCartLoaded {
            ProgressHUD.dismiss()
        }
    }
    func updateLikes(serviceAssembly: ServicesAssembly) {
        logger.debug("Loading likes...")
        Task {
            do {
                let profile = try await serviceAssembly.profileService.loadProfile()
                likes = Set(profile.likes)
                logger.debug("Got likes: \(self.likes)")
                for item in self.items {
                    item.toggleFavorite = { [weak self] servicesAssembly in
                        self?.toggleFavorite(for: item, servicesAssembly: servicesAssembly)
                    }
                    item.isFavorite = self.likes.contains(item.tokenId)
                }
                isFavoritesLoaded = true
                maybeDismissHUD()
            } catch {
                isFavoritesLoaded = true
                maybeDismissHUD()
                logger.error("Failed to load likes: \(error)")
            }
        }
    }
    func toggleFavorite(for item: UserCollectionItemViewModel, servicesAssembly: ServicesAssembly) {
        var newLikes = likes
        ProgressHUD.animate(interaction: false)
        isFavoritesLoaded = false

        if likes.contains(item.tokenId) {
            logger.debug("Remove favorite from \(item.tokenId) (\(item.title))")
            newLikes.remove(item.tokenId)
        } else {
            logger.debug("Set favorite for \(item.tokenId) (\(item.title))")
            newLikes.insert(item.tokenId)
        }
        Task {
            do {
                let profile = try await servicesAssembly.profileService.updateProfile(for: newLikes)
                likes = Set(profile.likes)
                for item in self.items {
                    item.isFavorite = self.likes.contains(item.tokenId)
                }
                logger.debug("Success: \(item.tokenId) (\(item.title))")
                isFavoritesLoaded = true
                maybeDismissHUD()
            } catch {
                isFavoritesLoaded = true
                maybeDismissHUD()
                logger.error("Failed to process favorites (\(item.title)):  \(error)")
            }
        }
    }
    func updateCart(serviceAssembly: ServicesAssembly) {
        logger.debug("Loading cart contents...")
        Task {
            do {
                let order = try await serviceAssembly.nftOrdersService.loadOrders()
                inCart = Set(order.nfts)
                logger.debug("Got cart: \(self.inCart)")
                for item in self.items {
                    item.toggleInCart = { [weak self] servicesAssembly in
                        self?.toggleInCart(for: item, servicesAssembly: servicesAssembly)
                    }
                    item.isInCart = self.inCart.contains(item.tokenId)
                }
                isInCartLoaded = true
                maybeDismissHUD()
            } catch {
                isInCartLoaded = true
                maybeDismissHUD()
                logger.error("Failed to load cart contents: \(error)")
            }
        }
    }
    func toggleInCart(for item: UserCollectionItemViewModel, servicesAssembly: ServicesAssembly) {
        var newCart = inCart
        ProgressHUD.animate(interaction: false)
        isInCartLoaded = false

        if inCart.contains(item.tokenId) {
            logger.debug("Remove from cart: \(item.tokenId) (\(item.title))")
            newCart.remove(item.tokenId)
        } else {
            logger.debug("Add to cart: \(item.tokenId) (\(item.title))")
            newCart.insert(item.tokenId)
        }
        Task {
            do {
                let order = try await servicesAssembly.nftOrdersService.updateOrders(for: newCart)
                inCart = Set(order.nfts)
                for item in self.items {
                    item.isInCart = self.inCart.contains(item.tokenId)
                }
                logger.debug("Success: \(item.tokenId) (\(item.title))")
                isInCartLoaded = true
                maybeDismissHUD()
            } catch {
                isInCartLoaded = true
                maybeDismissHUD()
                logger.error("Failed to process cart (\(item.title)):  \(error)")
            }
        }
    }
}
