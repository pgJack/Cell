//
//  ChatListViewController.swift
//  Cell
//
//  Created by Noah on 2021/8/28.
//

import UIKit
import Kingfisher

private let kChatListCellID = "chat_list_cell"

class ChatListCell: UITableViewCell {
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

extension ChatListCell {
    
    func layoutCell() {
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)
        
        iconView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(22)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(iconView.snp.trailing).offset(22)
            maker.trailing.equalToSuperview().offset(-48)
            maker.top.equalToSuperview().offset(6)
            maker.centerY.equalToSuperview()
        }
    }
}

class ChatListViewController: BaseViewController {
    
    var chats = [Chat]() {
        didSet {
            chatList.reloadData()
        }
    }
    
    let chatList: UITableView = {
        let list = UITableView()
        list.estimatedRowHeight = 60;
        list.rowHeight = UITableView.automaticDimension
        list.separatorStyle = .none
        list.backgroundColor = .clear
        list.register(ChatListCell.self, forCellReuseIdentifier: kChatListCellID)
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatList.delegate = self
        chatList.dataSource = self
    }
}

extension ChatListViewController {
    
    func layoutChatList() {
        view.addSubview(chatList)
        chatList.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
        
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { chats.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatListCellID, for: indexPath) as! ChatListCell
        let chat = chats[indexPath.row]
        cell.iconView.kf.setImage(with: chat.iconUrl)
        cell.nameLabel.text = chat.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
