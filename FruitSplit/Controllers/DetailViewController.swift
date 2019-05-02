//
//  DetailViewController.swift
//  FruitSplit
//
//  Created by Chelsea Troy on 4/29/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    var fruit: Fruit?

    
    func configureView() {
        // Update the user interface for the detail item.
        if let fruit = fruit {
            if let label = detailDescriptionLabel {
                label.text = fruit.altDescription
            }
            
            if let user = self.fruit?.user {
                self.nameLabel.text = user.name ?? "Unavailable"
                self.usernameLabel.text = user.username ?? "Unavailable"
                self.locationLabel.text = user.location ?? "Unavailable"
                self.bioLabel.text = user.bio ?? "Unavailable"
            }
            
            if let imageURL = URL(string: fruit.urls.small) {
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    let imageData: NSData = NSData(contentsOf: imageURL)!
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData as Data)
                        self.imageView.image = image
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        
    }
}



