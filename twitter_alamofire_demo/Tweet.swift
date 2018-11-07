//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class Tweet: NSObject
{
    var id: Int?
    var text: String?
    var favoriteCount: Int?
    var favorited: Bool?
    var retweeted: Bool?
    var retweetCount: Int?
    var user: User?
    var createdAtString: String?
    
    var retweetedByUser: User?
    
    init(dictionary: [String : Any])
    {
        var dictionary = dictionary
        
        if let originalTweet = dictionary["retweeted_status"] as? [String: Any]
        {
            let userDictionary = dictionary["user"] as! [String: Any]
            self.retweetedByUser = User(dictionary: userDictionary)
            
            dictionary = originalTweet
        }
        
        id = dictionary["id"] as! Int
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"]as! Bool
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d HH:..:ss Z y"
        let date = formatter.date(from: createdAtOriginalString)!
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        createdAtString = formatter.string(from: date)
    }
    
    static func tweets(with array: [[String: Any]]) -> [Tweet]
    {
        var tweets: [Tweet] = []
        for tweetDictionary in array
        {
            let tweet = Tweet(dictionary: tweetDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}
