
import Foundation
import Alamofire
import ReachabilitySwift

class TvSeriesAPI: NSObject {
    
    let API_KEY = "d9e899ee7e1d255d852ae8449e57a1279e37e94d579beee69c6f5980687afa57"
    let URL = "https://api-v2launch.trakt.tv/shows/trending?extended=images&limite=page20&page="
    let VERSION_API = "2"
    
    var currentPage = 1
    
    override init() {
        let reachability : Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
            
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        do {
          try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        func reachabilityChanged(note: NSNotification) {
            
            let reachability = note.object as! Reachability
            
            if reachability.isReachable() {
                if reachability.isReachableViaWiFi() {
                    print("Reachable via WiFi")
                    
                } else {
                    print("Reachable via Celular")
                }
            } else {
                print("Not reachable")
            }
        }
    }

    func nextPagination() {
        self.currentPage++
    }

    func loadPopularShows(result: (shows: NSArray) -> Void, errorResult: (error: ErrorType) -> Void) {
        
        let url = "\(URL)\(currentPage)"
        let headers = [
                "trakt-api-version": VERSION_API,
                "trakt-api-key": self.API_KEY
        ]
        
        Alamofire.request(.GET, url, headers: headers)
            .responseJSON { (response) -> Void in
                switch response.result {
                case .Success:
                    result(shows: response.result.value as! NSArray)
                case .Failure(let error):
                    errorResult(error: error)
                }
        }
    }
}

