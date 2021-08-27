//
//  HomeViewModel.swift
//  Beem
//
//  Created by Noah on 2021/8/10.
//

import UIKit
import RxSwift
import RxCocoa

//MARK: ViewModel
struct HomeViewModel {
        
    //Home
    let homeType = BehaviorRelay(value: HomeType.chat)
            
    let currentTab: BehaviorRelay<HomeTab?> = BehaviorRelay(value: nil)
    
    //Net Status
    let loseConnect = BehaviorRelay(value: false)
    
    //Badge
    let unreadMessageCount = BehaviorRelay(value: 0)
    let newContactTip = BehaviorRelay(value: false)
}

extension HomeViewModel {
        
    func bind(home: HomeViewController) {
        
        let disposeBag = home.disposeBag
        
        //MARK: DataSource
        homeType.asDriver().drive(onNext: { type in
                        
            var tabs = [HomeTab]()
            switch type {
            case .chat:
                tabs = HomeTab.chatTab
            case .work:
                tabs = HomeTab.workTab
            }
            home.initialHomeTabs(tabs)
            currentTab.accept(tabs.first)
        }).disposed(by: disposeBag)
        
        currentTab.asDriver().drive(onNext: { tab in
            
            guard let tTab = tab else {
                return
            }
            
            home.homeNavigationBar.nameLabel.text = tTab.name
            home.homeNavigationBar.rightItemTypes = tTab.rightItemTypes
            
            home.homeTabBar.items.forEach { item in
                item.iconView.image = tTab == item.homeTab ? item.homeTab?.seletedIcon : item.homeTab?.icon
                item.iconView.tintColor = tTab == item.homeTab ? .theme_white_dy : .gray_8C959E
                item.titleLabel.textColor = tTab == item.homeTab ? .theme_white_dy : .gray_8C959E
            }
            home.children.forEach { child in
                child.view.isHidden = child != tTab.controller
            }
            
        }).disposed(by: disposeBag)
        
        bindNavigationBar(home.homeNavigationBar)
        bindTabBar(home.homeTabBar)
        
        home.view.addGestureRecognizer(home.homeSidebar.edgePan)
        bindSidebar(home.homeSidebar)
    }
    
    func showSidebar(_ home: HomeViewController) { }
    
    //MARK: Bind Navigation Bar
    func bindNavigationBar(_ navigationBar: HomeNavigationBar) {
        
        let disposeBag = navigationBar.disposeBag
        
        navigationBar.leftItemA.rx.tap.bind { _ in
            Compass.navigator?.open(Compass.Map.HomeMap.sidebarShow.actionPath)
        }.disposed(by: disposeBag)
        
        navigationBar.rightItemA.rx.tap.bind {
            guard let compassPath = navigationBar.rightItemTypes.0?.compassPath else {
                return
            }
            Compass.navigator?.open(compassPath)
        }.disposed(by: disposeBag)
        
        navigationBar.rightItemB.rx.tap.bind {
            guard let compassPath = navigationBar.rightItemTypes.1?.compassPath else {
                return
            }
            Compass.navigator?.open(compassPath)
        }.disposed(by: disposeBag)
        
        loseConnect.asDriver().drive(navigationBar.netIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    //MARK: Bind Tab Bar
    func bindTabBar(_ tabBar: HomeTabBar) {
        
        let disposeBag = tabBar.disposeBag
        
        for item in tabBar.items {
                        
//            if item.homeTab?.controller is MessagesController {
//                unreadMessageCount.asDriver().drive(onNext: {
//                    item.badgeView.isHidden = $0 <= 0
//                    item.badgeLabel.text = "\($0)"
//                }).disposed(by: disposeBag)
//            }
//
//            if item.homeTab?.controller is ContactsController {
//                newContactTip.asDriver().map {
//                    !$0
//                }.drive(item.dotView.rx.isHidden).disposed(by: disposeBag)
//            }
            
            item.itemButton.rx.tap.map {
                item.homeTab
            }.bind(to: currentTab).disposed(by: disposeBag)
        }
    }
    
    //MARK: Bind Sidebar
    func bindSidebar(_ sidebar: HomeSidebar) {
        
        let disposeBag = sidebar.disposeBag
        
        homeType.asDriver().map { (type)->[HomeSidebarAction] in
            switch type {
            case .chat:
                return HomeSidebarAction.chatActions
            case .work:
                return [HomeSidebarAction]()
            }
        }.drive(sidebar.actionTableView.rx.items(cellIdentifier: kSidebarCellID, cellType: HomeSidebarCell.self)) { tableView, model, cell in
            cell.nameLabel.text = model.name
            cell.iconView.image = model.icon
            cell.iconView.tintColor = model.tint
        }.disposed(by: disposeBag)
        
        sidebar.dismissButton.rx.tap.bind { _ in
            Compass.navigator?.open(Compass.Map.HomeMap.sidebarHidden.actionPath)
        }.disposed(by: disposeBag)
        
        sidebar.edgePan.edges = .left
        sidebar.edgePan.rx.event.bind { [weak sidebar] recognizer in
            
            let point = recognizer.translation(in: recognizer.view)
            let finish = recognizer.state == .ended ||
                recognizer.state == .cancelled ||
                recognizer.state == .failed
            sidebar?.move(point.x + 20, isOpen: true, isFinish: finish)
        }.disposed(by: disposeBag)
        
        sidebar.contentPan.rx.event.bind { [weak sidebar] recognizer in
            
            let point = recognizer.translation(in: sidebar)
            let finish = recognizer.state == .ended ||
                recognizer.state == .cancelled ||
                recognizer.state == .failed
            sidebar?.move(point.x, isOpen: false, isFinish: finish)
        }.disposed(by: disposeBag)
        
        sidebar.actionTableView.rx.modelSelected(HomeSidebarAction.self).bind { _ in
        }.disposed(by: disposeBag)
        
        sidebar.updateSkinButtons(SkinStyle)
  
        [sidebar.lightButton.rx.tap.map { _ in
            .light
        }, sidebar.darkButton.rx.tap.map { _ in
            .dark
        }, sidebar.autoButton.rx.tap.map { _ in
            .unspecified
        }].forEach{
            $0.bind(onNext: { [weak sidebar] (mode: UIUserInterfaceStyle) in
                sidebar?.updateSkinButtons(mode)
                SkinStyle = mode
            }).disposed(by: disposeBag)
        }
    }
}
