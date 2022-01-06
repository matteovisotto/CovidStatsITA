//
//  InfoViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Informazioni"
        setupUI()
    }
    
    
    private func setupUI() {
        self.view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        textView.font = .systemFont(ofSize: 18)
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.text = "Questa applicazione vuole fornire un rapido accesso al bollettino giornaliero relativo ai dati italiani sulla pandemia di Covid-19. \nI dati visualizzati provengono dal repository ufficiale disponibile all'indirizzo https://github.com/pcm-dpc/COVID-19 e vengono aggiornati ad ogni avvio dell'applicazione. Per maggiori informazioni sui dati contenuti si rimanda al link sopra citato\n\nE' visualizzabile il bollettino giornaliero in piama pagina con possibilità di accedere ai dati giorno per giorno da inizio pandemia. Vengono inoltre forniti i dati relativi alla singola regione dalle quali è possibile visualizzare i nuovi positivi per ogni singola provincia.\n\nSi ricorda che i dati contenuti non vengono in alcun modo modificati o manipolati ed è sempre possibile verificarne l'uguaglianza con quanto pubblicato dall'unità di monitoraggio."
    }

}
