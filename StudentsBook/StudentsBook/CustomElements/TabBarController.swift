//
//  TabBarController.swift
//  StudentsBook
//
//  Created by Alexandr on 31.08.2024.
//

import UIKit
class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()

        tabBar.tintColor = .brown
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabs() {
        
        let description = createNav(with: "Description", and: UIImage(systemName: "book.circle"), vc: DescriptionController())
        let color = createNav(with: "Colors", and: UIImage(systemName: "paintpalette"), vc: ColorsController())
        let student = createNav(with: "Students", and: UIImage(systemName: "graduationcap.circle"), vc: StudentsController())
        let studntAndColor = createNav(with: "Students And Color", and: UIImage(systemName: "circles.hexagonpath"), vc: StudentBookController())
        
        self.setViewControllers([description, color, student, studntAndColor], animated: true)
        
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
}
