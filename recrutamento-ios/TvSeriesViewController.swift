
import UIKit

class TvSeriesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: "didPullRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    var shows: NSArray = []
    
    let traktAPI = TvSeriesAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shows"
        
        self.collectionView.addSubview(self.refreshControl)
        
        self.loadShows()
    }
    
    func loadShows() {
        
        self.traktAPI.loadPopularShows({ (shows) -> Void in
            if self.refreshControl.refreshing{
                self.refreshControl.endRefreshing()
            }
            
            self.shows = shows
            self.collectionView.reloadData()
            
            }) { (error) -> Void in
                
                if self.refreshControl.refreshing {
                    self.refreshControl.endRefreshing()
                }
        }
    }
    
    // MARK: Verify connection
    
    func networkUnreachable() {
        
        let alert: UIAlertController = UIAlertController(title: "Aviso", message: "Por favor, verifique sua conexão com a internet.",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(alertAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
            if self.refreshControl.refreshing {
                    self.refreshControl.endRefreshing()
                }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func didPullRefresh(refreshControl: UIRefreshControl) {
        self.traktAPI.nextPagination()
        self.loadShows()
        
    }
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shows.count
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellIdentifier =  "TvSeriesViewCell"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! TvSeriesViewCell
        
        let show: NSDictionary = shows[indexPath.row] as! NSDictionary
        
        cell.title.text = show["show"]!["title"] as? String
        
        let showImages: NSDictionary = show["show"]!["images"] as! NSDictionary
        
        cell.useThumbImage(showImages["poster"]!["thumb"] as! NSString)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(150, 200)
    }

}
