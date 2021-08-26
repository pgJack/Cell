//
//  HomeBarLayout.swift
//  Beem
//
//  Created by Noah on 2021/8/20.
//

import UIKit

extension HomeNavigationBar {
    
    func barLayout() {
        addSubview(moreView)
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(netIndicator)
        
        addSubview(leftItemA)
        addSubview(rightItemA)
        addSubview(rightItemB)
        
        moreView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(6)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(9)
            maker.height.equalTo(16)
        }
        
        avatarView.snp.makeConstraints { maker in
            maker.leading.equalTo(moreView.snp.trailing).offset(6)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(32)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(avatarView.snp.trailing).offset(8)
            maker.centerY.equalToSuperview()
        }
        
        netIndicator.snp.makeConstraints { maker in
            maker.leading.equalTo(nameLabel.snp.trailing).offset(8)
            maker.centerY.equalToSuperview()
        }
        
        leftItemA.snp.makeConstraints { maker in
            maker.leading.top.bottom.equalToSuperview()
            maker.trailing.equalTo(rightItemA.snp.leading).offset(-16)
        }
        rightItemA.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
            maker.trailing.equalTo(rightItemB.snp.leading).offset(-4)
            maker.width.equalTo(40)
        }
        rightItemB.snp.makeConstraints { maker in
            maker.trailing.top.bottom.equalToSuperview()
            maker.width.equalTo(rightItemA)
        }
    }
}

extension HomeTabBar {
    func barLayout() {
        addSubview(topLine)
        addSubview(tabsView)
        
        topLine.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(safeAreaLayoutGuide.snp.top)
            maker.height.equalTo(1)
        }
        
        tabsView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(topLine.snp.bottom)
            maker.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension HomeTabItem {
    func itemLayout() {
        addSubview(iconView)
        addSubview(titleLabel)
        
        addSubview(dotView)
        addSubview(badgeView)
        badgeView.addSubview(badgeLabel)
        addSubview(itemButton)
        
        iconView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(24)
            maker.top.equalToSuperview().offset(8)
        }
        titleLabel.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-3)
            maker.centerX.equalToSuperview()
        }
        badgeLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.top.equalToSuperview().offset(2)
            maker.leading.equalToSuperview().offset(4.75)
        }
        badgeView.snp.makeConstraints { maker in
            maker.centerX.equalTo(iconView.snp.trailing).offset(-3)
            maker.centerY.equalTo(iconView.snp.top).offset(2)
        }
        dotView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalTo(badgeView)
            maker.width.height.equalTo(10)
        }
        itemButton.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

