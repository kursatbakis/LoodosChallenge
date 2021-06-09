//
//  MovieTableViewCell.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation
import Reusable
import Kingfisher

class MovieTableViewCell: UITableViewCell, Reusable {
    let posterImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let yearLabel = UILabel(frame: .zero)
    let runtimeLabel = UILabel(frame: .zero)
    let genreLabel = UILabel(frame: .zero)
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.04505732534, green: 0.03730001125, blue: 0.3747620558, alpha: 1)
        [posterImageView, titleLabel, yearLabel, runtimeLabel, genreLabel].forEach(contentView.addSubview)
                
        posterImageView.snp.makeConstraints { (maker) in
            maker.left.top.bottom.equalToSuperview().inset(3.0)
            maker.width.equalTo(70.0)
        }
        posterImageView.layer.cornerRadius = 4.0
        posterImageView.layer.masksToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.backgroundColor = .systemGray4
        posterImageView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        activityIndicatorView.hidesWhenStopped = true
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(posterImageView.snp.right).offset(10.0)
            maker.top.equalTo(posterImageView).offset(10.0)
            maker.right.equalToSuperview().inset(10.0)
        }
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: Constants.Helvetica, size: 16.0)
        titleLabel.lineBreakMode = .byTruncatingMiddle
        
        genreLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            maker.left.equalTo(titleLabel)
            maker.right.equalToSuperview()
        }
        genreLabel.textAlignment = .left
        genreLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        genreLabel.font = UIFont(name: Constants.Helvetica, size: 16.0)
        genreLabel.numberOfLines = 0
        
        runtimeLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(titleLabel)
            maker.top.equalTo(genreLabel.snp.bottom).offset(5.0)
        }
        runtimeLabel.textAlignment = .center
        runtimeLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        runtimeLabel.font = UIFont(name: Constants.Helvetica, size: 16.0)
        
        yearLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().inset(10.0)
            maker.top.equalTo(runtimeLabel)
        }
        yearLabel.textAlignment = .center
        yearLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        yearLabel.font = UIFont(name: Constants.HelveticaLight, size: 16.0)
    }
    
    func prepare(with movie: MovieResponse) {
        if movie.Poster != "N/A" {
            activityIndicatorView.startAnimating()
            posterImageView.kf.setImage(with: URL(string: movie.Poster)) { (_) in
                self.activityIndicatorView.stopAnimating()
            }
        } else {
            posterImageView.image = UIImage(named: "cross")
        }
        titleLabel.text = movie.Title
        yearLabel.text = movie.Year
        runtimeLabel.text = movie.Runtime
        genreLabel.text = movie.Genre
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
