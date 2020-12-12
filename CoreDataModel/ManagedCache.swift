//
//  ManagedCache.swift
//  Tests
//
//  Created by SUNG HAO LIN on 2020/12/12.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
internal class ManagedCache: NSManagedObject {
	@NSManaged internal var timestamp: Date
	@NSManaged internal var feed: NSOrderedSet
}

@objc(ManagedFeedImage)
internal class ManagedFeedImage: NSManagedObject {
	@NSManaged internal var id: UUID
	@NSManaged internal var imageDescription: String?
	@NSManaged internal var location: String?
	@NSManaged internal var url: URL
	@NSManaged internal var cache: ManagedCache
}
