//
//  HomeSidebar.swift
//  Beem
//
//  Created by Noah on 2021/8/15.
//

import UIKit

private let kHomeSideBarBufferWidth: CGFloat = 30

class HomeSidebarCell: UITableViewCell {
    lazy var iconView = UIImageView()
    lazy var nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeSidebar: UIView {
    
    let panelWidth: CGFloat = 288
    var originalPanelX: CGFloat { -panelWidth }
    var isInitial = false {
        didSet {
            
            sidebarLayout()
            layoutIfNeeded()
            shadow3D()
        }
    }

    lazy var dismissButton = UIButton()
    
    lazy var preferencePanel: UIView = {
        let view = UIView()
        view.backgroundColor = .dynamicColor(.white, .black_282828)
        return view
    }()
    
    lazy var muteButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        button.setImage(UIImage(systemName: "bell.fill", withConfiguration: configuration), for: .normal)
        button.setImage(UIImage(systemName: "bell.slash", withConfiguration: configuration), for: .selected)
        return button
    }()
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray_DAE0E3
        imageView.layer.cornerRadius = 36
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    lazy var editIconView: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 17, weight: .bold)
        imageView.image = UIImage(systemName: "pencil", withConfiguration: configuration)
        return imageView
    }()
    
    lazy var profileButton = UIButton()
    
    lazy var actionTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .opaqueSeparator
        return view
    }()
    
    lazy var lightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitle(Translate("Light"), for: .normal)
        button.setTitleColor(.gray_8C959E , for: .normal)
        button.setTitleColor(.theme_white_dy, for: .selected)
        button.setImage(UIImage(systemName: "sun.max"), for: .normal)
        button.setImage(UIImage(systemName: "sun.max.fill"), for: .selected)
        button.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    
    lazy var darkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitle(Translate("Dark"), for: .normal)
        button.setTitleColor(.gray_8C959E , for: .normal)
        button.setTitleColor(.theme_white_dy, for: .selected)
        button.setImage(UIImage(systemName: "moon"), for: .normal)
        button.setImage(UIImage(systemName: "moon.fill"), for: .selected)
        button.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    
    lazy var autoButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitle(Translate("Auto"), for: .normal)
        button.setTitleColor(.gray_8C959E , for: .normal)
        button.setTitleColor(.theme_white_dy, for: .selected)
        button.setImage(UIImage(systemName: "bolt.badge.a"), for: .normal)
        button.setImage(UIImage(systemName: "bolt.badge.a.fill"), for: .selected)
        button.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    
    let edgePan = UIScreenEdgePanGestureRecognizer()
    
    lazy var contentPan: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        addGestureRecognizer(pan)
        return pan
    }()
    
    func updateSkinButtons(_ mode: UIUserInterfaceStyle) {
        lightButton.isSelected = mode == .light
        lightButton.tintColor = mode == .light ? .theme_white_dy : .gray_8C959E
        
        darkButton.isSelected = mode == .dark
        darkButton.tintColor = mode == .dark ? .theme_white_dy : .gray_8C959E

        autoButton.isSelected = mode == .unspecified
        autoButton.tintColor = mode == .unspecified ? .theme_white_dy : .gray_8C959E
    }
}
