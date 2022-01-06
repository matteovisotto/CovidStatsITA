//
//  DateSelectorController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 24/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

protocol DateSelectorDelegate {
    func dateSelector(didSelectDate date: Date)
}

protocol DateSelectorDataSource {
    func dateSelectorAvailableDates(presentDataIn: DateSelectorController) -> [Date]
    func dateSelectorPreselectedDate() -> Date
}

class DateSelectorController: UIViewController {
    
    open var delegate: DateSelectorDelegate? = nil
    open var dataSource: DateSelectorDataSource? = nil
    
    private var date: [Date] = []
    private var datePicker = UIDatePicker()
    private var containerView = UIView()
    private var confirmButton = UIButton()

    private var selectedDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        setupUI()
        date.removeAll()
        date = self.dataSource?.dateSelectorAvailableDates(presentDataIn: self) ?? []
        self.datePicker.calendar = Calendar.current
        self.datePicker.locale = Calendar.current.locale
        self.datePicker.timeZone = Calendar.current.timeZone
        self.datePicker.datePickerMode = .date
        self.datePicker.minimumDate = self.date.first ?? Date()
        self.datePicker.maximumDate = self.date.last ?? Date()
       
        self.datePicker.addTarget(self, action: #selector(didChangeDataPickerValue), for: .valueChanged)
        self.selectedDate = self.dataSource?.dateSelectorPreselectedDate() ?? self.date.last!
        self.datePicker.setDate(self.selectedDate, animated: true)
    }
    

    private func setupUI() {
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: self.view.frame.width-35).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30).isActive = true
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        if #available(iOS 13.0, *) {
            containerView.backgroundColor = .systemBackground
        } else {
            containerView.backgroundColor = .white
        }
        
        self.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        datePicker.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        datePicker.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10).isActive = true
        confirmButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.layer.borderColor = UIColor.gray.cgColor
        confirmButton.setTitleColor(UIColor.gray, for: .normal)
        confirmButton.setTitle("OK", for: .normal)
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        confirmButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
    }
    
    @objc private func didTapOkButton() {
        self.delegate?.dateSelector(didSelectDate: self.selectedDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didChangeDataPickerValue(datePicker: UIDatePicker) {
        self.selectedDate = datePicker.date
    }
    
}
