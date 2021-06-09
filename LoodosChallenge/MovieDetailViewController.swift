//
//  MovieDetailViewController.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: MovieResponse
    let posterImageView = UIImageView(frame: .zero)
    let titleContainerView = UIView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let seperatorView = UIView(frame: .zero)
    let directorLabel = UILabel(frame: .zero)
    let yearLabel = UILabel(frame: .zero)
    let categoriesLabel = UILabel(frame: .zero)
    let categoriesContainerView = UIView(frame: .zero)
    let descriptionTextView = UITextView(frame: .zero)
    let plotLabel = UILabel(frame: .zero)
    let closeButton = UIButton(frame: .zero)
    // bunlari da bir yere ekle, loading animasyonu, ekran gecisleri, poster bulunamadiysa default bir resim.
    let countryLabel = UILabel(frame: .zero)
    let ratedLabel = UILabel(frame: .zero)
    
    init(with movie: MovieResponse) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [posterImageView, titleContainerView, categoriesContainerView, descriptionTextView, plotLabel, closeButton].forEach(view.addSubview)
        [titleLabel, seperatorView, directorLabel, yearLabel, ratedLabel].forEach(titleContainerView.addSubview)
        categoriesContainerView.addSubview(categoriesLabel)
        
        view.backgroundColor = UIColor.black
        
        posterImageView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(posterImageView.snp.width).multipliedBy(1.14)
        }
        posterImageView.contentMode = .scaleAspectFill
        if movie.Poster != "N/A" {
            posterImageView.kf.setImage(with: URL(string: movie.Poster))
        } else {
            posterImageView.image = UIImage(named: "blackCross")
        }
        posterImageView.backgroundColor = .red
        posterImageView.clipsToBounds = true
        
        closeButton.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview().inset(10.0)
            maker.width.equalTo(70.0)
            maker.height.equalTo(30.0)
        }
        closeButton.setAttributedTitle(NSAttributedString(string: "Close", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: Constants.Helvetica, size: 18.0)!]), for: .normal)
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.layer.cornerRadius = 5.0
        
        titleContainerView.snp.makeConstraints { (maker) in
            maker.top.equalTo(posterImageView.snp.bottom)
            maker.left.right.equalToSuperview()
        }
        titleContainerView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview().offset(10.0)
            maker.right.lessThanOrEqualToSuperview()
        }
        titleLabel.attributedText = NSAttributedString(string: movie.Title, attributes: [.foregroundColor: UIColor.black, .font: UIFont(name: Constants.HelveticaBold, size: 25.0)!])
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        seperatorView.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(3.0)
            maker.left.equalTo(titleLabel)
            maker.width.equalTo(80.0)
            maker.height.equalTo(3.5)
        }
        seperatorView.backgroundColor = .black
        seperatorView.layer.cornerRadius = 2.0
        
        directorLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(seperatorView.snp.bottom).offset(8.0)
            maker.left.equalTo(titleLabel)
            maker.bottom.equalToSuperview().inset(10.0)
        }
        directorLabel.attributedText = NSAttributedString(string: "Directed by \(movie.Director)", attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont(name: Constants.Helvetica, size: 16.0)!])
        directorLabel.textAlignment = .left
        
        yearLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().inset(10.0)
            maker.top.equalTo(directorLabel)
        }
        yearLabel.attributedText = NSAttributedString(string: movie.Year, attributes: [.foregroundColor: UIColor.black, .font: UIFont(name: Constants.Helvetica, size: 16.0)!])
        
        ratedLabel.snp.makeConstraints { (maker) in
            maker.right.equalTo(yearLabel)
            maker.top.equalTo(titleLabel)
        }
        ratedLabel.textAlignment = .right
        ratedLabel.attributedText = NSAttributedString(string: "\(movie.imdbRating)✭", attributes: [.foregroundColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), .font: UIFont(name: Constants.HelveticaBold, size: 16.0)!])
        plotLabel.snp.makeConstraints { (maker) in
            maker.centerY.equalTo(categoriesContainerView)
            maker.left.equalToSuperview().inset(20.0)
        }
        plotLabel.attributedText = NSAttributedString(string: "PLOT", attributes: [.foregroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), .font: UIFont(name: Constants.HelveticaBold, size: 18.0)!])
        plotLabel.textAlignment = .left
        plotLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        categoriesContainerView.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleContainerView.snp.bottom).offset(10.0)
            maker.right.equalToSuperview().inset(15.0)
            maker.left.greaterThanOrEqualTo(plotLabel.snp.right).offset(20.0)
        }
        categoriesContainerView.layer.cornerRadius = 5.0
        categoriesContainerView.backgroundColor = .clear
        categoriesContainerView.layer.borderWidth = 1.0
        categoriesContainerView.layer.borderColor = UIColor.gray.cgColor
        
        categoriesLabel.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview().inset(10.0)
            maker.top.bottom.equalToSuperview().inset(2.0)
        }
        categoriesLabel.attributedText = NSAttributedString(string: movie.Genre, attributes: [.foregroundColor: UIColor.gray, .font: UIFont(name: Constants.Helvetica, size: 16.0)!])
        categoriesLabel.textAlignment = .center
        categoriesLabel.numberOfLines = 0
        
        descriptionTextView.snp.makeConstraints { (maker) in
            maker.top.equalTo(categoriesContainerView.snp.bottom).offset(10.0)
            maker.left.right.equalToSuperview().inset(15.0)
            maker.height.equalTo(200.0)
        }
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isUserInteractionEnabled = false
        descriptionTextView.text = movie.Plot
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.textColor = .white
        descriptionTextView.font = UIFont(name: Constants.HelveticaLight, size: 14.0)
        descriptionTextView.textContainerInset = .zero
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
