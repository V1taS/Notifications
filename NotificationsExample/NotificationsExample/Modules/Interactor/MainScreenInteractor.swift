//
//  MainScreenInteractor.swift
//  NotificationsExample
//
//  Created by Vitalii Sosin on 08.07.2022.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol MainScreenInteractorOutput: AnyObject {
    
}

/// События которые отправляем от Presenter к Interactor
protocol MainScreenInteractorInput {
    
}

/// Интерактор
final class MainScreenInteractor: MainScreenInteractorInput {
    
    // MARK: - Internal properties
    
    weak var output: MainScreenInteractorOutput?
    
    // MARK: - Private properties
    
}

// MARK: - Appearance

private extension MainScreenInteractor {
    struct Appearance {
        
    }
}
