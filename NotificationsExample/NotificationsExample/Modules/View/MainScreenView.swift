//
//  MainScreenView.swift
//  NotificationsExample
//
//  Created by Vitalii Sosin on 08.07.2022.
//

import UIKit
import Notifications

/// События которые отправляем из View в Presenter
protocol MainScreenViewOutput: AnyObject {}

/// События которые отправляем от Presenter ко View
protocol MainScreenViewInput: AnyObject {}

/// Псевдоним протокола UIView & MainScreenViewInput
typealias MainScreenViewProtocol = UIView & MainScreenViewInput

/// View для экрана
final class MainScreenView: MainScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenViewOutput?
  
  // MARK: - Private properties
  
  private let notifications = Notifications()
  private let neutralButton = UIButton()
  private let negativeButton = UIButton()
  private let positiveButton = UIButton()
  private let customButton = UIButton()
  private let buttonsStack = UIStackView()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private func
  
  private func configureLayout() {
    let appearance = Appearance()
    [neutralButton, negativeButton, positiveButton, customButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      buttonsStack.addArrangedSubview($0)
    }
    
    buttonsStack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(buttonsStack)
    
    NSLayoutConstraint.activate([
      neutralButton.heightAnchor.constraint(equalToConstant: appearance.heightButton),
      negativeButton.heightAnchor.constraint(equalToConstant: appearance.heightButton),
      positiveButton.heightAnchor.constraint(equalToConstant: appearance.heightButton),
      customButton.heightAnchor.constraint(equalToConstant: appearance.heightButton),
      
      buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: appearance.insets),
      buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor,
                                             constant: -appearance.insets),
      buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                           constant: -appearance.insets),
    ])
  }
  
  private func applyDefaultBehavior() {
    let appearance = Appearance()
    backgroundColor = .systemGray
    
    buttonsStack.axis = .vertical
    buttonsStack.spacing = appearance.spacing
    
    neutralButton.layer.cornerRadius = appearance.cornerRadius
    neutralButton.backgroundColor = .systemGray3
    neutralButton.setTitle(appearance.neutralButtonTitle, for: .normal)
    neutralButton.addTarget(self, action: #selector(neutralButtonAction),
                            for: .touchUpInside)
    
    negativeButton.layer.cornerRadius = appearance.cornerRadius
    negativeButton.backgroundColor = appearance.redColor
    negativeButton.setTitle(appearance.negativeButtonTitle, for: .normal)
    negativeButton.addTarget(self, action: #selector(negativeButtonAction),
                             for: .touchUpInside)
    
    positiveButton.layer.cornerRadius = appearance.cornerRadius
    positiveButton.backgroundColor = .systemGreen
    positiveButton.setTitle(appearance.positiveButtonTitle, for: .normal)
    positiveButton.addTarget(self, action: #selector(positiveButtonAction),
                             for: .touchUpInside)
    
    customButton.layer.cornerRadius = appearance.cornerRadius
    customButton.backgroundColor = .systemOrange
    customButton.setTitle(appearance.customButtonTitle, for: .normal)
    customButton.addTarget(self, action: #selector(customButtonAction),
                           for: .touchUpInside)
  }
  
  @objc
  func neutralButtonAction() {
    let appearance = Appearance()
    
    notifications.showAlertWith(
      model: NotificationsModel(
        text: appearance.buttonTitle,
        style: .neutral,
        timeout: appearance.timeout,
        glyph: true,
        throttleDelay: appearance.throttleDelay,
        action: {}
      )
    )
  }
  
  @objc
  func negativeButtonAction() {
    let appearance = Appearance()
    
    notifications.showAlertWith(
      model: NotificationsModel(
        text: appearance.buttonTitle,
        style: .negative,
        timeout: appearance.timeout,
        glyph: true,
        throttleDelay: appearance.throttleDelay,
        action: {}
      )
    )
  }
  
  @objc
  func positiveButtonAction() {
    let appearance = Appearance()
    
    notifications.showAlertWith(
      model: NotificationsModel(
        text: appearance.buttonTitle,
        style: .positive,
        timeout: appearance.timeout,
        glyph: true,
        throttleDelay: appearance.throttleDelay,
        action: {}
      )
    )
  }
  
  @objc
  func customButtonAction() {
    let appearance = Appearance()
    
    notifications.showAlertWith(
      model: NotificationsModel(
        text: appearance.buttonTitle,
        style: .custom(backgroundColor: .systemOrange,
                       glyph: textToImage(text: appearance.textToImage),
                       colorGlyph: nil),
        timeout: appearance.timeout,
        glyph: true,
        throttleDelay: appearance.throttleDelay,
        action: {}
      )
    )
  }
  
  private func textToImage(text: String) -> UIImage? {
    let nsString = (text as NSString)
    let font = UIFont.systemFont(ofSize: Appearance().systemFontSize)
    let stringAttributes = [NSAttributedString.Key.font: font]
    let imageSize = nsString.size(withAttributes: stringAttributes)
    
    UIGraphicsBeginImageContextWithOptions(imageSize, false, .zero)
    UIColor.clear.set()
    UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
    nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}

// MARK: - Appearance

private extension MainScreenView {
  struct Appearance {
    let redColor = UIColor.init(red: 240 / 255, green: 73 / 255, blue: 73 / 255, alpha: 1)
    let heightButton: CGFloat = 64
    let insets: CGFloat = 16
    let spacing: CGFloat = 16
    let cornerRadius: CGFloat = 16
    let neutralButtonTitle = "Neutral"
    let negativeButtonTitle = "Negative"
    let positiveButtonTitle = "Positive"
    let customButtonTitle = "Custom"
    let buttonTitle = "Hello world"
    let timeout: Double = 2
    let throttleDelay: Double = 0.5
    let systemFontSize: CGFloat = 44
    let textToImage = "🐶"
  }
}
