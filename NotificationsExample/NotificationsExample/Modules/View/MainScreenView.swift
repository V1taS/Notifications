//
//  MainScreenView.swift
//  NotificationsExample
//
//  Created by Vitalii Sosin on 08.07.2022.
//

import UIKit

/// События которые отправляем из View в Presenter
protocol MainScreenViewOutput: AnyObject {
  
}

/// События которые отправляем от Presenter ко View
protocol MainScreenViewInput: AnyObject {
  
}

/// Псевдоним протокола UIView & MainScreenViewInput
typealias MainScreenViewProtocol = UIView & MainScreenViewInput

/// View для экрана
final class MainScreenView: MainScreenViewProtocol {
  
  // MARK: - Public properties
  
  // MARK: - Internal properties
  
  weak var output: MainScreenViewOutput?
  
  // MARK: - Private properties
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Public func
  
  // MARK: - Internal func
  
  // MARK: - Private func
  
  private func configureLayout() {
    
  }
  
  private func applyDefaultBehavior() {
    backgroundColor = .red
  }
}

// MARK: - Appearance

private extension MainScreenView {
  struct Appearance {
    
  }
}
