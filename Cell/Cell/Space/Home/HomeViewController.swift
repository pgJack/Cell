//
//  HomeViewController.swift
//  Beem
//
//  Created by Noah on 2021/8/10.
//

import UIKit

class HomeViewController: BaseViewController {
            
    let homeViewModel = HomeViewModel()
    
    lazy var homeNavigationBar = HomeNavigationBar()
    lazy var homeTabBar = HomeTabBar()
    lazy var homeSidebar = HomeSidebar()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialHomeBar()
        homeViewModel.bind(home: self)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        homeSidebar.dismiss(false)
    }
}

//MARK: UI
extension HomeViewController {
    
    func initialHomeBar() {
        navigationItem.titleView = homeNavigationBar

        view.addSubview(homeTabBar)
        homeTabBar.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-kTabBarHeight)
        }
    }
    
    func initialHomeTabs(_ homeTabs:[HomeTab]) {
        
        homeTabBar.initialItems(by: homeTabs)
        
        children.forEach {
            $0.removeFromParent()
            $0.view.removeFromSuperview()
        }
        homeTabs.forEach {
            let controller = $0.controller
            addChild(controller)
            view.addSubview(controller.view)
            controller.view.snp.makeConstraints { maker in
                maker.leading.trailing.top.equalToSuperview()
                maker.bottom.equalTo(homeTabBar.snp.top)
            }
        }
        
        view.bringSubviewToFront(homeTabBar)
    }
}
