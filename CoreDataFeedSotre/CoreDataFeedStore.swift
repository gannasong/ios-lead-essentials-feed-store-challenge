//
//  CoreDataFeedStore.swift
//  FeedStoreChallenge
//
//  Created by SUNG HAO LIN on 2020/12/9.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class CoreDataFeedStore: FeedStore {

	public init() {}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		completion(.empty)
	}
}
