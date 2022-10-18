//
//  AddEventViewModel.swift
//  Presentation
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-12.
//


import Foundation
import Domain
import Data

public final class AddEventViewModel: ObservableObject {
    
    private let addEventUseCase: AddEventUseCase
    private let currentDate: Date
    
    public var didGetErrorMessage: ((String)->Void)?
    public var numberOfDay: ((String)->Void)?
    public var nameOfMonth: ((String)->Void)?
    public var nameOfDay: ((String)->Void)?
    public var selectedDate: ((Date)->Void)?
    
    public init(
        addEventUseCase: AddEventUseCase,
        currentDate: Date
    ) {
        self.addEventUseCase = addEventUseCase
        self.currentDate = currentDate
    }
    
    public func loadCurrentDate() {
        numberOfDay?(currentDate.getDay())
        nameOfMonth?(currentDate.getLongMonth())
        nameOfDay?(currentDate.getDayOfWeek())
        selectedDate?(currentDate)
    }
    
    //    public func loadData() {
    //        addEventUseCase.addEvent(event, completion: { result in
    //            switch result {
    //            case .success(let eventIdentifier):
    //                print(eventIdentifier) //TODO:
    //            case .failure(let error):
    //                self.didGetErrorMessage?(error.localizedDescription)
    //            }
    //        })
    //    }
    
    deinit {
        print("Bye \(#file)")
    }
    
}

