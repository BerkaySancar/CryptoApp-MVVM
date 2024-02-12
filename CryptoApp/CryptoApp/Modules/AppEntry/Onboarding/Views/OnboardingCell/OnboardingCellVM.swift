//
//  OnboardingCellVM.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

final class OnboardingCellVM: BaseCellViewModel {
    
    private var model: OnboardModel?
    
    init(model: OnboardModel) {
        self.model = model
    }
    
    var title: String {
        model?.title ?? ""
    }
    
    var imageName: String {
        model?.imageName ?? ""
    }
}
