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
    var isInitial = false

    lazy var dismissButton = UIButton()
    
    lazy var preferencePanel: UIView = {
        let view = UIView()
        view.backgroundColor = .dynamicColor(.white, .black_282828)
        return view
    }()
    
    lazy var muteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "profile_notice_icon"), for: .normal)
        button.setImage(UIImage.init(named: "profile_disturb_icon"), for: .selected)
        return button
    }()
    
    lazy var avatarView = UIImageView()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    lazy var editIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "profile_edit_icon")
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
        view.backgroundColor = .dynamicColor(.gary_DAE0E3, .black_282828)
        return view
    }()
    
    lazy var lightButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle("Light", for: .normal)
        button.setTitleColor(.gary_8C959E , for: .normal)
        button.setTitleColor(.theme, for: .selected)
        button.setImage(UIImage(named: "profile_light_icon"), for: .normal)
        button.setImage(UIImage(named: "profile_light_icon_h"), for: .selected)
        return button
    }()
    
    lazy var darkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle("Dark", for: .normal)
        button.setTitleColor(.gary_8C959E , for: .normal)
        button.setTitleColor(.theme, for: .selected)
        button.setImage(UIImage(named: "profile_dark_icon"), for: .normal)
        button.setImage(UIImage(named: "profile_dark_icon_h"), for: .selected)
        return button
    }()
    
    lazy var autoButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle("Auto", for: .normal)
        button.setTitleColor(.gary_8C959E , for: .normal)
        button.setTitleColor(.theme, for: .selected)
        button.setImage(UIImage(named: "profile_auto_icon"), for: .normal)
        button.setImage(UIImage(named: "profile_auto_icon_h"), for: .selected)
        return button
    }()
    
    let edgePan = UIScreenEdgePanGestureRecognizer()
    
    lazy var contentPan: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        addGestureRecognizer(pan)
        return pan
    }()
}
