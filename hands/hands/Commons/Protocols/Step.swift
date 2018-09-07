//
//  Step.swift
//  hands
//
//  Created by 山浦功 on 2018/09/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol Step {
    
    associatedtype Input
    associatedtype Output
    
    func perform(_ input: Input, complication: @escaping (_ output: Output) -> Void )
}

struct StepT<Input, Output>: Step {
    
    private let perform: (Input, @escaping (Output) -> Void) -> Void
    
    init<P: Step>(_ step: P) where P.Input == Input, P.Output == Output {
        perform = step.perform
    }
    
    func perform(_ input: Input, complication: @escaping (Output) -> Void) {
        self.perform(input, complication)
    }
}
