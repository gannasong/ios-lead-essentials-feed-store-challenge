//
//  ManagedCache.swift
//  FeedStoreChallenge
//
//  Created by SUNG HAO LIN on 2020/12/16.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
internal class ManagedCache: NSManagedObject {
	@NSManaged internal var timestamp: Date
	@NSManaged internal var feed: NSOrderedSet

	internal static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
		let entityName = entity().name!
		let request = NSFetchRequest<ManagedCache>(entityName: entityName)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}

	internal static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
		try find(in: context).map(context.delete)
		return ManagedCache(context: context)
	}

	internal var localFeed: [LocalFeedImage] {
		return feed.compactMap { ($0 as? ManagedFeedImage)?.local }
	}
}
