//
//  LobbyExpirationViewController.swift
//  FF
//
//  Created by ed1d1a8d on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LobbyExpirationViewController: UIViewController {

    let lobbyLabel = FLabel(text: "Adjust Lobby Timer",
                            font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium),
                            color: UIColor.black)

    let text1 = FLabel(text: "When you leave the lobby you will no longer match with other users.",
                       font: UIFont.systemFont(ofSize: 20, weight: .medium),
                       color: UIColor.black)
    let text2 = FLabel(text: "Tap the timer below adjust the how long you want to stay in the lobby.",
                       font: UIFont.systemFont(ofSize: 20, weight: .medium),
                       color: UIColor.black)

    let expirationPickerContainer = FView(baseColor: UIColor.white)
    let expirationPicker: UIDatePicker = UIDatePicker()
    var expirationPicked: TimeInterval

    let onDismissCallback: ((Date) -> Void)?

    init(oldExpirationDate: Date, onDismissCallback: ((Date) -> Void)?) {
        self.expirationPicked = oldExpirationDate.timeIntervalSinceNow
        self.onDismissCallback = onDismissCallback
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(LobbyViewController.dismissSelf))
        self.navigationItem.rightBarButtonItem = cancelButton

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage() //remove pesky 1 pixel line

        self.view.backgroundColor = UIColor.white

        self.view.addSubview(self.lobbyLabel)

        self.view.addSubview(self.text1)
        self.view.addSubview(self.text2)

        self.expirationPicker.datePickerMode = .countDownTimer
        self.expirationPicker.countDownDuration = self.expirationPicked
        self.expirationPicker.addTarget(self, action: #selector(expirationPickerValueChanged), for: .valueChanged)
        self.expirationPickerContainer.addSubview(self.expirationPicker)
        self.view.addSubview(self.expirationPickerContainer)

        addConstraints()
    }

    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.lobbyLabel, sides: [.left, .right], padding: 35))
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.lobbyLabel, side: .top, padding: 0))

        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.lobbyLabel, lowerView: self.text1, spacing: 10))
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.text1, lowerView: self.text2, spacing: 10))
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.text2, lowerView: self.expirationPickerContainer, spacing: 10))

        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.text1, sides: [.left, .right], padding: 35))
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.text2, sides: [.left, .right], padding: 35))

        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.expirationPickerContainer, sides: [.left, .bottom, .right], padding: 0))
    }

    @objc func expirationPickerValueChanged(_ sender: UIDatePicker) {
        self.expirationPicked = sender.countDownDuration
    }

    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
        self.onDismissCallback?(Date.init(timeIntervalSinceNow: self.expirationPicked))
    }
}
