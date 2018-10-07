//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Danny on 9/11/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchNowPlayingMovies()
            DispatchQueue.main.async {
                self.createCustomActivityIndicator()
                self.createPullToRefreshControl()
            }
        }
    }
    
    func createCustomActivityIndicator() {
        let rect = CGRect(origin: CGPoint(x: self.tableView.contentSize.width/2.0,
                                          y: self.tableView.contentSize.height/2.0), size: CGSize(width: 5000, height: 5000))
        self.activityIndicator = UIActivityIndicatorView(frame: rect) as UIActivityIndicatorView
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.activityIndicator.color = UIColor.red
        self.activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func createPullToRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_ :)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        self.activityIndicator.startAnimating()
        fetchNowPlayingMovies()
    }
    
    func fetchNowPlayingMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            // This will run when the network request return
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try!
                    JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                self.movies = Movie.movies(dictionaries: movieDictionaries)
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
        
        for movie in movies {
            print("\(movie)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.titleLabel.text = movies[indexPath.row].title
        cell.overviewLabel.text = movies[indexPath.row].overview
        cell.posterImageView.af_setImage(withURL: movies[indexPath.row].posterUrl!)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        
        if segue.identifier == "detailView" {
            //if let indexPath = tableView.indexPath(for: cell) {
            //let movie = movies[indexPath.row]
            
            
            let detailViewController = segue.destination as! DetailViewController
                
                //detailViewController.movies = self.movies[indexPath.row]
            
            let row = tableView.indexPathForSelectedRow!.row
            detailViewController.movies = self.movies[row]
            
            //}
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
