//
//  TvSeries.swift
//  recrutamento-ios
//
//  Created by Vinicius Carvalho on 20/01/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

import Foundation
import Alamofire
import ReachabilitySwift

class TvSeriesAPI: NSObject {
    
    let API_KEY: String = "d9e899ee7e1d255d852ae8449e57a1279e37e94d579beee69c6f5980687afa57"
    let reachibility =  Reachability.reachabilityForInternetConnection()!
    
    var currentPage : Int = 1
    
    override init() {
        self.reachibility.whenUnreachable = { reachibility in
            NSNotificationCenter.defaultCenter().postNotification("networkUnreachable", object: nil)
        
        }
        
        self.reachibility.startNofifier()
    
    }

    func nextPagination() {
        self.currentPage++
    }

    func loadPopularShows(result: (shows: NSArray) -> Void, errorResult: (error: ErrorType) -> Void) {
        
        let url = "https://api-v2launch.trakt.tv/shows/trending?extended=images&limite=page10&page=\(currentPage)"
        let headers = [
                "trakt-api-version": "2",
                "trakt-api-key": self.API_KEY
        ]
        
        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { (_,_, response) -> Void in
                switch response {
                case .Sucess:
                    result(shows: response.value as! NSArray)
                case .Failure(_, let error):
                    errorResult(error: error)
                }
        }

    }

}