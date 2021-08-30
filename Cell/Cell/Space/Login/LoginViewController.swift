//
//  LoginViewController.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit

class LoginViewController: BaseViewController {
    
    let existButton: UIButton = {
        let button = UIButton()
        button.setTitle(Translate("Exist Account"), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.theme_black_dy, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Translate("New Account"), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.theme_black_dy, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dock?.setBarItemColor(.white)
        dock?.setBarBackgroundColor(.theme_black_dy)
        
        view.backgroundColor = .theme_black_dy
        
        view.addSubview(loginButton)
        view.addSubview(existButton)
        loginButton.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.width.equalTo(200)
            maker.height.equalTo(44)
        }
        existButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(loginButton.snp.bottom).offset(20)
            maker.width.equalTo(200)
            maker.height.equalTo(44)
        }
        existButton.rx.tap.bind { [weak self] _ in
            self?.dock?.pushViewController(SoulViewController(), animated: true)
        }.disposed(by: disposeBag)
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
        .lightContent
    }
}
