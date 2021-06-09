//
//  MainViewController.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation
import UIKit
import Alamofire
import Reusable
import Firebase

class MainViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    let searchBar = UISearchBar(frame: .zero)
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let gradientLayer = CAGradientLayer()
    let titleLabel = UILabel(frame: .zero)
    var movie: MovieResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(searchBar)
        view.addSubview(activityIndicator)
        view.addSubview(titleLabel)
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.3844258561, green: 0.1748774167, blue: 0.3205406568, alpha: 0.935359589).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        activityIndicator.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.snp.topMargin).offset(20.0)
            maker.left.right.equalToSuperview()
        }
        titleLabel.textAlignment = .center
        titleLabel.attributedText = NSAttributedString(string: "Main Screen", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: Constants.Chalkduster, size: 31.0)!, .kern: 1.0])
        titleLabel.shadowColor = .cyan
        titleLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        searchBar.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(20.0)
            maker.left.right.equalToSuperview().inset(20.0)
            maker.height.equalTo(40.0)
        }
        searchBar.delegate = self
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search by movie title...", attributes: [.foregroundColor: UIColor.black, .font: UIFont(name: Constants.HelveticaLight, size: 16.0)!])
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .black
        searchBar.backgroundColor = .white
        searchBar.searchTextField.backgroundColor = .clear
        
        tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(searchBar.snp.bottom).offset(10.0)
            maker.left.right.equalToSuperview().inset(3.0)
            maker.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(cellType: MovieTableViewCell.self)
    }
    
    func showNoResultAlert() {
        let alertController = UIAlertController(title: "No movie found", message: "Try searching with another name", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func fetchMovies(with name: String) {
        activityIndicator.startAnimating()
        AF.request("\(Constants.website)/?apikey=\(Constants.APIKey)&t=\(name)").responseData(completionHandler: { [weak self] (responseData) in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            switch responseData.result {
            case let .success(result):
                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: result)
                    self.movie = response
                    
                } catch {
                    self.movie = nil
                    self.showNoResultAlert()
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case let .failure(error):
                self.show(error: error)
            }
        })
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.prepare(with: movie!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = movie else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        Analytics.logEvent("navigated_to_film_detail", parameters: ["title": movie.Title, "imdbID": movie.imdbID])
        let movieDetailVc = MovieDetailViewController(with: movie)
        movieDetailVc.modalTransitionStyle = .crossDissolve
        present(movieDetailVc, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        fetchMovies(with: text.replacingOccurrences(of: " ", with: "+"))
    }
}
