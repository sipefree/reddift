//
//  Session+messages.swift
//  reddift
//
//  Created by sonson on 2015/05/19.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation

extension Session {
    
    // MARK: Update message status
    
    /**
    Mark messages as "unread"
    - parameter id: A comma-separated list of thing fullnames
    - parameter modhash: A modhash, default is blank string not nil.
    - returns: Data task which requests search to reddit.com.
    */
    public func markMessagesAsUnread(fullnames: [String], modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        let commaSeparatedFullameString = fullnames.joinWithSeparator(",")
        let parameter = ["id":commaSeparatedFullameString]
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/unread_message", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    /**
    Mark messages as "read"
    - parameter id: A comma-separated list of thing fullnames
    - parameter modhash: A modhash, default is blank string not nil.
    - returns: Data task which requests search to reddit.com.
    */
    public func markMessagesAsRead(fullnames: [String], modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        let commaSeparatedFullameString = fullnames.joinWithSeparator(",")
        let parameter = ["id":commaSeparatedFullameString]
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/read_message", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    /**
     Mark all messages as "read"
     Queue up marking all messages for a user as read.
     This may take some time, and returns 202 to acknowledge acceptance of the request.
     - parameter modhash: A modhash, default is blank string not nil.
     - returns: Data task which requests search to reddit.com.
     */
    public func markAllMessagesAsRead(modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/read_all_messages", parameter:nil, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    /**
     Collapse messages
     - parameter id: A comma-separated list of thing fullnames
     - parameter modhash: A modhash, default is blank string not nil.
     - returns: Data task which requests search to reddit.com.
     */
    public func collapseMessages(fullnames: [String], modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        let commaSeparatedFullameString = fullnames.joinWithSeparator(",")
        let parameter = ["id":commaSeparatedFullameString]
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/collapse_message", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    /**
     Uncollapse messages
     - parameter id: A comma-separated list of thing fullnames
     - parameter modhash: A modhash, default is blank string not nil.
     - returns: Data task which requests search to reddit.com.
     */
    public func uncollapseMessages(fullnames: [String], modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        let commaSeparatedFullameString = fullnames.joinWithSeparator(",")
        let parameter = ["id":commaSeparatedFullameString]
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/uncollapse_message", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    /**
     For blocking via inbox.
     - parameter id: fullname of a thing
     - parameter modhash: A modhash, default is blank string not nil.
     - returns: Data task which requests search to reddit.com.
     */
    public func blockViaInbox(fullname: String, modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        let parameter = ["id":fullname]
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(Session.OAuthEndpointURL, path:"/api/block", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    /**
     For unblocking via inbox.
     - parameter id: fullname of a thing
     - parameter modhash: A modhash, default is blank string not nil.
     - returns: Data task which requests search to reddit.com.
     */
    public func unblockViaInbox(fullname: String, modhash: String = "", completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        let parameter = ["id":fullname]
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/unblock_subreddit", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
            completion(result)
        })
        task.resume()
        return task
    }
    
    // MARK: Get messages
    
    /**
    Get the message from the specified box.
    - parameter messageWhere: The box from which you want to get your messages.
    - parameter limit: The maximum number of comments to return. Default is 100.
    - parameter completion: The completion handler to call when the load request is complete.
    - returns: Data task which requests search to reddit.com.
    */
    public func getMessage(messageWhere: MessageWhere, limit: Int = 100, completion: (Result<Listing>) -> Void) throws -> NSURLSessionDataTask {
        guard let request = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/message" + messageWhere.path, method:"GET", token:token)
            else { throw ReddiftError.URLError.error }
        let task = URLSession.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            self.updateRateLimitWithURLResponse(response)
            let result: Result<Listing> = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
                .flatMap(response2Data)
                .flatMap(data2Json)
                .flatMap(json2RedditAny)
                .flatMap(redditAny2Object)
            completion(result)
        })
        task.resume()
        return task
    }
    
    // MARK: Compose a message
    
    /**
    Compose new message to specified user.
    - parameter to: Name of user to who you want to send a message.
    - parameter subject: A string no longer than 100 characters
    - parameter text: Raw markdown text
    - parameter fromSubreddit: Subreddit name?
    - parameter captcha: The user's response to the CAPTCHA challenge
    - parameter captchaIden: The identifier of the CAPTCHA challenge
    - parameter completion: The completion handler to call when the load request is complete.
    - returns: Data task which requests search to reddit.com.
    */
    public func composeMessage(to: String, subject: String, text: String, fromSubreddit: Subreddit?, captcha: String, captchaIden: String, completion: (Result<JSON>) -> Void) throws -> NSURLSessionDataTask {
        var parameter: [String:String] = [
            "api_type" : "json",
            "text" : text,
            "subject" : subject,
            "to" : to
        ]
        
        if let fromSubreddit = fromSubreddit {
            parameter["from_sr"] = fromSubreddit.displayName
        }
        
        if captcha != "" && captchaIden != "" {
            parameter["captcha"] = captcha
            parameter["iden"] = captchaIden
        }
        
        guard let request: NSMutableURLRequest = NSMutableURLRequest.mutableOAuthRequestWithBaseURL(baseURL, path:"/api/compose", parameter:parameter, method:"POST", token:token)
            else { throw ReddiftError.URLError.error }
        return handleAsJSONRequest(request, completion:completion)
    }
}
