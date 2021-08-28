//
//  HomeViewModel.swift
//  Beem
//
//  Created by Noah on 2021/8/10.
//

import UIKit
import RxSwift
import RxCocoa

private let kSidebarCellID = "side_bar_cell"

//MARK: ViewModel
class HomeViewModel: NSObject {
        
    //Home
    let homeType = BehaviorRelay(value: HomeType.chat)
    let homeTabs: BehaviorRelay<[HomeTab]> = BehaviorRelay(value: [])
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
        homeType.asDriver().map { type in
            type == .chat ? HomeTab.chatTab : HomeTab.workTab
        }.drive(homeTabs).disposed(by: disposeBag)
        
        homeTabs.asDriver().map {
            $0.first
        }.drive(currentTab).disposed(by: disposeBag)
        
        homeTabs.asDriver().drive(onNext: { [weak home] tabs in
            home?.initialHomeTabs(tabs)
        }).disposed(by: disposeBag)
        
        currentTab.asDriver().drive(onNext: { [weak home] tab in
            
            guard let tTab = tab,
                  let tHome = home else {
                return
            }
            
            tHome.homeNavigationBar.nameLabel.text = tTab.name
            tHome.homeNavigationBar.rightItemTypes = tTab.rightItemTypes
            
            tHome.homeTabBar.items.forEach { item in
                item.iconView.image = tTab == item.homeTab ? item.homeTab?.seletedIcon : item.homeTab?.icon
                item.iconView.tintColor = tTab == item.homeTab ? .theme_white_dy : .gray_8C959E
                item.titleLabel.textColor = tTab == item.homeTab ? .theme_white_dy : .gray_8C959E
            }
            tHome.children.forEach { child in
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
            CellSkipper.navigator?.open(Compass.HomeMap.sidebarShow.actionPath)
        }.disposed(by: disposeBag)
        
        navigationBar.rightItemA.rx.tap.bind { [weak navigationBar] _ in
            guard let compassPath = navigationBar?.rightItemTypes.0?.compassPath else {
                return
            }
            CellSkipper.navigator?.open(compassPath)
        }.disposed(by: disposeBag)
        
        navigationBar.rightItemB.rx.tap.bind { [weak navigationBar] _ in
            guard let compassPath = navigationBar?.rightItemTypes.1?.compassPath else {
                return
            }
            CellSkipper.navigator?.open(compassPath)
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
            
            item.itemButton.rx.tap.map { [weak item] _ in
                item?.homeTab
            }.bind(to: currentTab).disposed(by: disposeBag)
        }
    }
    
    //MARK: Bind Sidebar
    func bindSidebar(_ sidebar: HomeSidebar) {
        
        let disposeBag = sidebar.disposeBag
        
        sidebar.profileButton.rx.tap.bind { _ in
            CellSkipper.navigator?.open(Compass.SettingMap.myAccountEditPush.actionPath)
        }.disposed(by: disposeBag)
        
        sidebar.muteButton.isSelected = MuteStatus
        sidebar.muteButton.rx.tap.bind { [weak sidebar] _ in            
            guard let tSidebar = sidebar else {
                return
            }
            tSidebar.muteButton.isSelected = !tSidebar.muteButton.isSelected
            MuteStatus = tSidebar.muteButton.isSelected
        }.disposed(by: disposeBag)
        
        sidebar.actionTableView.register(HomeSidebarCell.self, forCellReuseIdentifier: kSidebarCellID)
        sidebar.actionTableView.delegate = self
        sidebar.actionTableView.dataSource = self
        
        sidebar.dismissButton.rx.tap.bind { _ in
            CellSkipper.navigator?.open(Compass.HomeMap.sidebarHidden.actionPath)
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

extension HomeViewModel: UITableViewDataSource, UITableViewDelegate {
    
    var sidebarActions: [HomeSidebarAction] { homeType.value == .chat ? HomeSidebarAction.chatActions : [] }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sidebarActions.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSidebarCellID, for: indexPath) as! HomeSidebarCell
        let action = sidebarActions[indexPath.row]
        cell.nameLabel.text = action.name
        cell.iconView.image = action.icon
        cell.iconView.tintColor = action.tint
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        let action = sidebarActions[indexPath.row]
//        if let compassPath = action.compassPath {
//            Compass.navigator?.open(compassPath)
//        }
        Soul.awakedSoul = nil
        Cell.alivedCell?.frozen()
        CellSkipper.navigator?.open(Compass.entangle.oceanPath)
    }
}
