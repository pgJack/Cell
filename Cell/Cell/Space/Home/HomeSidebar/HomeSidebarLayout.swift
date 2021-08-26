//
//  HomeSidebarLayout.swift
//  Cell
//
//  Created by Noah on 2021/8/26.
//

import UIKit
import SnapKit

extension HomeSidebarCell {
    
    func layoutCell() {
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        
        iconView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(40)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(23)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(iconView.snp.trailing).offset(16)
            maker.trailing.equalToSuperview().offset(-48)
            maker.top.equalToSuperview().offset(16)
            maker.centerY.equalToSuperview()
        }
    }
}

extension HomeSidebar {
    
    func sidebarLayout() {
        addSubview(dismissButton)
        addSubview(preferencePanel)
        
        preferencePanel.addSubview(muteButton)
        preferencePanel.addSubview(avatarView)
        preferencePanel.addSubview(nameLabel)
        preferencePanel.addSubview(editIconView)
        preferencePanel.addSubview(profileButton)
        preferencePanel.addSubview(actionTableView)
        preferencePanel.addSubview(bottomLine)
        preferencePanel.addSubview(lightButton)
        preferencePanel.addSubview(darkButton)
        preferencePanel.addSubview(autoButton)
        
        dismissButton.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalTo(self)
        }
        preferencePanel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(originalPanelX)
            maker.top.bottom.equalToSuperview()
            maker.width.equalTo(panelWidth)
        }
        muteButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview()
            maker.centerY.equalTo(avatarView)
            maker.width.height.equalTo(84)
        }
        avatarView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(40)
            maker.top.equalTo(preferencePanel.safeAreaLayoutGuide.snp.top).offset(20)
            maker.width.height.equalTo(72)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(avatarView.snp.bottom).offset(8)
            maker.leading.equalToSuperview().offset(40)
            maker.trailing.lessThanOrEqualTo(muteButton.snp.leading)
            maker.height.equalTo(29)
        }
        editIconView.snp.makeConstraints { maker in
            maker.leading.equalTo(nameLabel.snp.trailing).offset(8)
            maker.centerY.equalTo(nameLabel)
            maker.width.height.equalTo(17.5)
        }
        profileButton.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview()
            maker.trailing.equalTo(muteButton.snp.leading).offset(-20)
            maker.bottom.equalTo(nameLabel).offset(8)
        }
        actionTableView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(profileButton.snp.bottom)
            maker.bottom.equalTo(bottomLine.snp.top)
        }
        bottomLine.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(0.5)
        }
        lightButton.snp.makeConstraints { maker in
            maker.top.equalTo(bottomLine.snp.bottom)
            maker.leading.equalToSuperview().offset(23)
            maker.height.equalTo(84)
            maker.bottom.equalTo(preferencePanel.safeAreaLayoutGuide.snp.bottom)
        }
        darkButton.snp.makeConstraints { maker in
            maker.leading.equalTo(lightButton.snp.trailing).offset(6)
            maker.width.top.bottom.equalTo(lightButton)
        }
        autoButton.snp.makeConstraints { maker in
            maker.leading.equalTo(darkButton.snp.trailing).offset(6)
            maker.trailing.equalToSuperview().offset(-23)
            maker.width.top.bottom.equalTo(lightButton)
        }
    }
}

//MARK: Move
extension HomeSidebar {
    
    func addToWindow() {
        if superview == nil {
            Homeland.homeWindow?.addSubview(self)
            snp.remakeConstraints { maker in
                maker.leading.trailing.top.bottom.equalToSuperview()
            }

            if !isInitial {
                sidebarLayout()
                layoutIfNeeded()
                isInitial = true
            }
        }
    }
    
    func move(_ offset: CGFloat, isOpen: Bool, isFinish: Bool) {
        
        addToWindow()
        
        isHidden = false
        
        let newLeading: CGFloat = min(0, (isOpen ? originalPanelX : 0) + offset)
        
        preferencePanel.snp.updateConstraints { maker in
            maker.leading.equalTo(self).offset(newLeading)
        }
        layoutIfNeeded()
        
        let alpha = ((originalPanelX - newLeading) / originalPanelX) * 0.25
        
        dismissButton.backgroundColor = 0x000000.color(alpha)
        
        if isFinish {
            if newLeading > originalPanelX * (isOpen ? 0.8 : 0.2) {
                show(true)
            } else {
                dismiss(true)
            }
        }
    }
    
    func show(_ animated: Bool) {
        
        addToWindow()
        
        isHidden = false
        preferencePanel.snp.updateConstraints { maker in
            maker.leading.equalToSuperview()
        }
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                self.dismissButton.backgroundColor = 0x000000.color(0.25)
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
            dismissButton.backgroundColor = 0x000000.color(0.25)
        }
    }
    
    func dismiss(_ animated: Bool) {
        
        guard superview != nil else { return }
        
        preferencePanel.snp.updateConstraints { maker in
            maker.leading.equalToSuperview().offset(originalPanelX)
        }
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
                self.dismissButton.backgroundColor = .clear
                self.layoutIfNeeded()
            } completion: { _ in
                self.isHidden = true
                self.removeFromSuperview()
            }
        } else {
            layoutIfNeeded()
            dismissButton.backgroundColor = .clear
            isHidden = true
            removeFromSuperview()
        }
    }
}
