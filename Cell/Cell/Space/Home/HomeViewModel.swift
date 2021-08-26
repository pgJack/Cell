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
    let netStatus = BehaviorRelay(value: false)
    
    //Badge
    let unreadMessageCount = BehaviorRelay(value: 0)
    let newContactTip = BehaviorRelay(value: false)
}

extension HomeViewModel {
        
    func bind(home: HomeViewController) {
        
        let disposeBag = home.disposeBag
        
        //MARK: DataSource
        home.homeSidebar.actionTableView.register(HomeSidebarCell.self, forCellReuseIdentifier: kSidebarCellID)
        homeType.asDriver().map { (type)->[HomeSidebarAction] in
            switch type {
            case .chat:
                return HomeSidebarAction.chatActions
            case .work:
                return [HomeSidebarAction]()
            }
        }.drive(home.homeSidebar.actionTableView.rx.items(cellIdentifier: kSidebarCellID, cellType: HomeSidebarCell.self)) { tableView, model, cell in
            cell.nameLabel.text = model.name
            cell.iconView.image = model.icon
        }.disposed(by: disposeBag)
        
        homeType.asDriver().drive(onNext: { [weak home] type in
                        
            var tabs = [HomeTab]()
            switch type {
            case .chat:
                tabs = [HomeTab.messages, HomeTab.meets, HomeTab.contacts]
            case .work:
                tabs = [HomeTab.messages, HomeTab.meets]
            }
            home?.initialHomeTabs(tabs)
            self.currentTab.accept(tabs.first)
        }).disposed(by: disposeBag)
        
        //MARK: Navigation Bar
        currentTab.asDriver().drive(onNext: { [weak home] tab in
            
            guard let tTab = tab else {
                return
            }
            
            home?.homeNavigationBar.nameLabel.text = tTab.name
            
            let types = tTab.rightItemTypes
            
            let itemA = home?.homeNavigationBar.rightItemA
            let itemB = home?.homeNavigationBar.rightItemB
            
            home?.initialRightItem(itemA, with: types.0)
            home?.initialRightItem(itemB, with: types.1)
            
            home?.homeTabBar.items.forEach { item in
                item.iconView.image = tTab == item.homeTab ? item.homeTab?.seletedIcon : item.homeTab?.icon
                item.titleLabel.textColor = tTab == item.homeTab ? .theme : .gary_8C959E
            }
            
            home?.children.forEach { child in
                child.view.isHidden = child != tTab.controller
            }
            
        }).disposed(by: disposeBag)
        
        home.homeNavigationBar.leftItemA.rx.tap.bind { [weak home] _ in
            home?.homeSidebar.show(true)
        }.disposed(by: disposeBag)

        netStatus.asDriver().drive(home.homeNavigationBar.netIndicator.rx.isAnimating).disposed(by: disposeBag)

        //MARK: Tab Bar
        for item in home.homeTabBar.items {
                        
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
                
        //MARK: Sidebar
        home.homeSidebar.dismissButton.rx.tap.bind { [weak home] _ in
            home?.homeSidebar.dismiss(true)
        }.disposed(by: disposeBag)
                
        home.view.addGestureRecognizer(home.homeSidebar.edgePan)
        home.homeSidebar.edgePan.edges = .left
        home.homeSidebar.edgePan.rx.event.bind { [weak home] recognizer in
            
            let point = recognizer.translation(in: home?.view)
            let finish = recognizer.state == .ended ||
                recognizer.state == .cancelled ||
                recognizer.state == .failed
            home?.homeSidebar.move(point.x + 20, isOpen: true, isFinish: finish)
        }.disposed(by: disposeBag)
        
        home.homeSidebar.contentPan.rx.event.bind { [weak home] recognizer in
            
            let point = recognizer.translation(in: home?.homeSidebar)
            let finish = recognizer.state == .ended ||
                recognizer.state == .cancelled ||
                recognizer.state == .failed
            home?.homeSidebar.move(point.x, isOpen: false, isFinish: finish)
        }.disposed(by: disposeBag)
        
        home.homeSidebar.actionTableView.rx.modelSelected(HomeSidebarAction.self).bind { _ in
        }.disposed(by: disposeBag)
        
        home.homeSidebar.lightButton.isSelected = SkinStyle == .light
        home.homeSidebar.darkButton.isSelected = SkinStyle == .dark
        home.homeSidebar.autoButton.isSelected = SkinStyle == .unspecified
        
        [home.homeSidebar.lightButton.rx.tap.map { _ in
            .light
        }, home.homeSidebar.darkButton.rx.tap.map { _ in
            .dark
        }, home.homeSidebar.autoButton.rx.tap.map { _ in
            .unspecified
        }].forEach{
            $0.bind(onNext: { [weak home] (mode: UIUserInterfaceStyle) in
                home?.homeSidebar.lightButton.isSelected = mode == .light
                home?.homeSidebar.darkButton.isSelected = mode == .dark
                home?.homeSidebar.autoButton.isSelected = mode == .unspecified
                SkinStyle = mode
            }).disposed(by: disposeBag)
        }
    }
}
