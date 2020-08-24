//
//  ImpostazioniViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class ImpostazioniViewController: UIViewController {
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Impostazioni"
        setupUI()
        registerComponents()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerComponents() {
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.cellIdentifier)
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: LabelTableViewCell.cellIdentifier)
    }
    
    private func setupUI() {
        if #available(iOS 13.0, *) {
            self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        } else {
            self.tableView = UITableView(frame: .zero, style: .grouped)
        }
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.tableHeaderView = SettingsTableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        
        let footerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let appBundle = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        footerLabel.text = "Versione " + appVersion + " ("+appBundle+")"
        footerLabel.textAlignment = .center
        footerLabel.font = .systemFont(ofSize: 12)
        tableView.tableFooterView = footerLabel
    }
    
    @objc private func didProvinceSettingChangeState(uiSwitch: UISwitch){
        UserDefaults.standard.set(uiSwitch.isOn, forKey: "loadProvince")
    }
    
}

extension ImpostazioniViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.cellIdentifier, for: indexPath) as! SwitchTableViewCell
            cell.setCell(cellDescription: "Province al caricamento", target: self, selector: #selector(didProvinceSettingChangeState(uiSwitch:)), forEvent: .valueChanged, withDefaultState: UserDefaults.standard.bool(forKey: "loadProvince"))
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.cellIdentifier, for: indexPath) as! LabelTableViewCell
        cell.setCell(cellDescription: "Informazioni", accessoryType: .disclosureIndicator)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "Generali"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if(section == 0){
            return "Abilitando questa opzione potrebbero presentarsi rallentamenti all'avvio dell'applicazione. Se disabilitata i dati verranno caricati solo su richiesta."
        }
        return nil
    }
    
}
