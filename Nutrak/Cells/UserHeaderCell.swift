//
//  UserHeaderCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 25/03/25.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var subtextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
    }

    func configure(with name: String, profileImage: UIImage?) {
        greetingLabel.text = "Good Morning, \(name)!"
        subtextLabel.text = "Track nutrition, stay healthy!"
        profileImageView.image = profileImage ?? UIImage(named: "defaultProfile")
    }
}
