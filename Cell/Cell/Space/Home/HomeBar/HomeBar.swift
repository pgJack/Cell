//
//  HomeBar.swift
//  Beem
//
//  Created by Noah on 2021/8/13.
//

import UIKit

//MARK: Navigation Bar
class HomeNavigationBar: UIView {

    lazy var moreView: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        imageView.image = UIImage(systemName: "list.bullet", withConfiguration: configuration)
        return imageView
    }()
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var netIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.transform = CGAffineTransform(scaleX: 0.5, y: 0.5);
        return indicator
    }()
    
    lazy var leftItemA = UIButton()
    
    lazy var rightItemA = UIButton()
    lazy var rightItemB = UIButton()
    
    var rightItemTypes: (HomeRightItemType?, HomeRightItemType?) = (nil, nil) {
        didSet {
            rightItemA.setImage(rightItemTypes.0?.systemIcon, for: .normal)
            rightItemB.setImage(rightItemTypes.1?.systemIcon, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
}

//MARK: Tab Bar
class HomeTabBar: UIView {
    
    lazy var topLine: UIView = {
        let view = UIView()
        return view
    }()
    lazy var tabsView = UIView()
    
    var items = [HomeTabItem]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .dynamicColor(.white, .black_282828)
        shadow3D()
        barLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialItems(by homeTabs: [HomeTab]) {
        items.forEach { $0.removeFromSuperview() }
        items.removeAll()
        
        var lastItem: HomeTabItem?
        homeTabs.enumerated().forEach { (index, cItem) in
            
            let item = HomeTabItem()
            item.itemLayout()
            
            item.homeTab = cItem
            items.append(item)
            
            tabsView.addSubview(item)
            item.snp.makeConstraints { maker in
                if let rLastItem = lastItem {
                    maker.leading.equalTo(rLastItem.snp.trailing).offset(6)
                    maker.width.height.equalTo(rLastItem)
                } else {
                    maker.leading.equalTo(tabsView.snp.leading).offset(2)
                }
                maker.top.bottom.equalToSuperview()
                
                if index == homeTabs.count - 1 {
                    maker.trailing.equalTo(tabsView.snp.trailing).offset(-2)
                }
            }
            lastItem = item
        }
    }
}

//MARK: Tab Item
class HomeTabItem: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var iconView = UIImageView()
    
    lazy var dotView: UIView = {
        let view = UIView()
        view.backgroundColor = .red_F03636
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    
    lazy var badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .red_F03636
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.isHidden = true
        return view
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    lazy var itemButton = UIButton()
        
    var homeTab: HomeTab? {
        didSet {
            titleLabel.text = homeTab?.name
            iconView.image = homeTab?.icon
            iconView.highlightedImage = homeTab?.seletedIcon
        }
    }
}
