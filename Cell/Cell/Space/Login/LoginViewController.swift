//
//  LoginViewController.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit

class LoginViewController: BaseViewController {
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Translate("Login"), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.theme, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CellSkipper.ship?.setBarAlpha(0)
        
        view.backgroundColor = .theme
        title = nil
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.width.height.equalTo(200)
        }
        loginButton.rx.tap.bind { _ in
            
            let soul = Soul(new: UUID().uuidString, account: "123", code: "123")
            let cell = Cell(new: UUID().uuidString, spell: "123", of: soul)
            
            cell.name = "烟雨客"
            cell.iconUrl = URL.init(string: "https://img1.baidu.com/it/u=3229045480,3780302107&fm=26&fmt=auto&gp=0.jpg")
            
            Soul.awakedSoul = soul
            Cell.alivedCell = cell
            CellSkipper.coreBag?.sync()
            
            CellSkipper.navigator?.open(Compass.entangle.oceanPath)
        }.disposed(by: disposeBag)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}
