//
//  CoreDataFeedStore.swift
//  FeedStoreChallenge
//
//  Created by SUNG HAO LIN on 2020/12/9.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext
	private let modelName = "FeedStore"

	public init(storeURL: URL, bundle: Bundle = .main) throws {
		container = try NSPersistentContainer.load(modelName: modelName, url: storeURL, in: bundle)
		context = container.newBackgroundContext()
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		perform { context in
			do {
				try ManagedCache.find(in: context)
					.map(context.delete)
					.map(context.save)
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		perform { (context) in
			do {
				let managedCache = try ManagedCache.newUniqueInstance(in: context)
				managedCache.timestamp = timestamp
				managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
				try context.save()
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		perform { (context) in
			do {
				if let cache = try ManagedCache.find(in: context) {
					completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
				} else {
					completion(.empty)
				}
			} catch {
				completion(.failure(error))
			}
		}
	}

	// MARK: - Helpers

	private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
		let context = self.context
		context.perform {
			action(context)
		}
	}
}
