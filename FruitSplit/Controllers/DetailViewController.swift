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
    
    func configureView() {
        // Update the user interface for the detail item.
        if let fruit = fruit {
            if let label = detailDescriptionLabel {
                label.text = fruit.altDescription
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

    var fruit: Fruit? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

extension UIImageView {
    func load(url: URL) {
    }
}


