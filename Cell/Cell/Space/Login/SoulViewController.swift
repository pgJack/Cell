//
//  SoulViewController.swift
//  Cell
//
//  Created by Noah on 2021/8/30.
//

import UIKit

private let kSoulListCellID = "soul_list_cell"

class SoulViewController: BaseViewController {
    
    let soulList: UITableView = {
        let list = UITableView()
        list.estimatedRowHeight = 60;
        list.rowHeight = UITableView.automaticDimension
        list.separatorStyle = .none
        list.backgroundColor = .clear
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(soulList)
        soulList.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }
        soulList.delegate = self
        soulList.dataSource = self
    }
}

extension SoulViewController: UITableViewDelegate, UITableViewDataSource {
    
    var souls: [Soul] { Soul.finder(Soul.pureRequest, viewContext: CellSkipper.coreBag) }
    func cells(of soul: Soul) -> [Cell] {
        Cell.alivedCells(of: soul)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        souls.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        souls[section].cells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let soul = souls[section]
        return (soul.soulAccount ?? "") +  (soul.awake ? " - awaked" : "")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: kSoulListCellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: kSoulListCellID)
        }
        
        if let sCell = souls[indexPath.section].cells?[indexPath.row] as? Cell  {
            cell!.textLabel?.text = sCell.name
            cell!.detailTextLabel?.text = sCell.cellId
            cell!.accessoryType = sCell.alive ? .checkmark : .none
        }
        return cell!
    }
}
