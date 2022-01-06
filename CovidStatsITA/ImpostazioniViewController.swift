//
//  ImpostazioniViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit
import MessageUI

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
    
    @objc private func didMidvalueSettingChangeState(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "italiaMidValue")
    }
    
}

extension ImpostazioniViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.cellIdentifier, for: indexPath) as! SwitchTableViewCell
            cell.setCell(cellDescription: "Province al caricamento", target: self, selector: #selector(didProvinceSettingChangeState(uiSwitch:)), forEvent: .valueChanged, withDefaultState: UserDefaults.standard.bool(forKey: "loadProvince"))
            return cell
       /* } else if(indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.cellIdentifier, for: indexPath) as! SwitchTableViewCell
            cell.setCell(cellDescription: "Mostra media", target: self, selector: #selector(didMidvalueSettingChangeState(sender:)), forEvent: .valueChanged, withDefaultState:
                true)
            //Add as default state UserDefaults.standard.bool(forKey: "italiaMidValue")
            cell.isUserInteractionEnabled = false
            cell.switchControl.isEnabled = false
            return cell*/
        }else{
            if(indexPath.row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.cellIdentifier, for: indexPath) as! LabelTableViewCell
                cell.setCell(cellDescription: "Contatta lo sviluppatore", accessoryType: .disclosureIndicator)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.cellIdentifier, for: indexPath) as! LabelTableViewCell
                cell.setCell(cellDescription: "Informazioni", accessoryType: .disclosureIndicator)
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section == 1){
            if(indexPath.item == 0){
                let mailComposeViewController = configureMailController()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    
                }
            } else if(indexPath.row == 1){
                let infoVC = InfoViewController()
                navigationController?.pushViewController(infoVC, animated: false)
            }
        }
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

extension ImpostazioniViewController: MFMailComposeViewControllerDelegate {
    //Function to send an email
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["matteo.visotto@mail.polimi.it"])
        mailComposerVC.setSubject("[CovidStatsITA]")
        mailComposerVC.setMessageBody("", isHTML: true)
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
