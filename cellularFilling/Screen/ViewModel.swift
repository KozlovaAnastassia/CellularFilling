//
//  ViewModel.swift
//  cellularFilling
//
//  Created by Анастасия on 14.05.2024.
//

import Foundation

protocol IViewModel {
    var numberOfRowsInSection: Int {get}
    func getDataForCell(indexPath: IndexPath) -> CellModel
    func buttonTapped()
}

final class ViewModel: IViewModel  {
    
    private var array = [CellModel]()
    private var count: Int = .zero
    private var previousCell: KindOfCell = .life
    private var lastLife: Int? = nil
    
    var numberOfRowsInSection: Int {return self.array.count}
    
    func getDataForCell(indexPath: IndexPath) -> CellModel {
        array[indexPath.row]
    }
    
    func buttonTapped() {
        let lastCell: KindOfCell
        
        if array.isEmpty {
            lastCell = getRandomCell()
        } else {
            lastCell = array[array.count - 1].cellKind
        }
        let nextCell = findNextCell(lastCell: lastCell)
        
        let cell = defineCellForArray(cell: nextCell)
        array.append(cell)
    }
    
    private func findNextCell(lastCell: KindOfCell) -> KindOfCell {
        switch lastCell {
        case .live:
            lastLife = nil
            if previousCell == lastCell {
                count += 1
            } else {
                count = .zero
            }
            previousCell = .live
            
            if count == 2 {
                return .life
            } else {
                return getRandomCell()
            }
        case .dead:
            if previousCell == lastCell {
                count += 1
            } else {
                count = .zero
            }
            if count == 2 {
                if let lastLife {
                    killLiveCell(index: lastLife)
                }
                lastLife = nil
            }
            previousCell = .dead
            return getRandomCell()
        case .life:
            count = .zero
            previousCell = .life
            lastLife = array.count - 1
            return getRandomCell()
        }
    }
    
    private func getRandomCell() -> KindOfCell {
        let randomCell = Int.random(in: 0...1)
        if randomCell == 0 {
            return .dead
        } else {
            return .live
        }
    }
    
    private func killLiveCell(index: Int) {
        array[index] = defineCellForArray(cell: .dead)
    }
    
    private func defineCellForArray(cell: KindOfCell) -> CellModel {
        switch cell {
        case .dead:
            return CellModel(
                        name: Constants.Title.deadCellName,
                        description: Constants.Title.deadCellDescription,
                        iconName: KindOfCell.dead.rawValue, 
                        cellKind: .dead,
                        smileyUniCode: Constants.UniCodes.deadCellUniCode
                    )
        case .live:
            return CellModel(
                        name: Constants.Title.liveCellName,
                        description: Constants.Title.liveCellDescription,
                        iconName: KindOfCell.live.rawValue,
                        cellKind: .live, 
                        smileyUniCode: Constants.UniCodes.liveCellUniCode
                    )
        case .life:
            return CellModel(
                        name: Constants.Title.lifeCellName,
                        description: Constants.Title.lifeCellDescription,
                        iconName: KindOfCell.life.rawValue,
                        cellKind: .life,
                        smileyUniCode: Constants.UniCodes.lifeCellUniCode
                    )
        }
    }
}
