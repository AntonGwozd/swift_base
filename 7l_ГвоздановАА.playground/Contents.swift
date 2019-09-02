//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

// Для решения используем ранее созданный класс автомобиля. обрабатываем ошибки повторных операций, ошибки погрузки разгрузки.
// Для обработки ошибок есть входныя функция управления, которая вызывает уже внутреннюю функцию, которая обратывает команды и по необходимости генерит ошибки.

import UIKit

enum carCommand {   //Перечисление команд автомобиля
    case startCar, drownCar, openWindow, closeWindow, putBag, takeBag
}

enum carError: Error {     //Перечисление ошибок
    case doubleStart, overBag, doubleStop, unknownErrror, windowError, zeroBag
}

class Car {
    static var carQuant: Int = 0
    static func prinCountCar() {
        print ("Всего сейчас существует \(carQuant) экз. класса")
    }
    let avtoMark: String            //Марка автомобиля строка
    let avtoEast: Int               //Год выпуска
    let maxBagValue: Int         //Объем багажника/кузова
    var currentBagValue: Int {   //Текущий объем багажника
        didSet{
            print(avtoMark + ": текущий объем багажника " + String(currentBagValue))
        }
    }
    var motorStart: Bool           //Запущен ли двигатель
    var windowOpen: Bool           //Открыты ли окна

    
    init(avtoMark: String, avtoEast: Int, maxBagValue: Int, currentBagValue: Int, motorStart: Bool,  windowOpen: Bool){
        Car.carQuant += 1
        self.avtoMark = avtoMark
        self.avtoEast = avtoEast
        self.maxBagValue = maxBagValue
        self.currentBagValue = currentBagValue
        self.motorStart = motorStart
        self.windowOpen = windowOpen
    }
    
    deinit {
        Car.carQuant -= 1
    }
    
    func carDescription() {                 //Функция описания автомобиля
        print("Вызов описания родительского класса, не приемлем")
    }
    
    private func internalCarDirrect(command: carCommand, bagValue: Int = 0) throws -> String {  //Функция управления, возвращаем текстовый ответ.
        switch command {
        case carCommand.startCar:           //Запуск двигателя
            if self.motorStart {
                throw carError.doubleStart
            } else {
                self.motorStart = true
                return ("Двигатель запущен")
            }
        case carCommand.drownCar:           //Остановка двигателя
            if !self.motorStart {
                throw carError.doubleStop
            } else {
                self.motorStart = false
                return ("Двигатель Остановлен")
            }
        case carCommand.openWindow:         //Открытие окон
            if self.windowOpen {
                throw carError.windowError
            } else {
                self.windowOpen = true
                return ("Окна открыты")
            }
        case carCommand.closeWindow:        //Закрытие окон
            if !self.windowOpen {
                throw carError.windowError
            } else {
                self.windowOpen = false
                return ("Окна закрыты")
            }
        case carCommand.putBag:             //Загрузка груза
            if ((self.currentBagValue + bagValue) <= maxBagValue) {
                self.currentBagValue = self.currentBagValue + bagValue
                return ("\(avtoMark): погруженно \(bagValue)")
            } else {
                throw carError.overBag
            }
        case carCommand.takeBag:            //Разгрузка груза
            guard (self.currentBagValue - bagValue) >= 0 else {
                throw carError.zeroBag
            }
            self.currentBagValue = self.currentBagValue - bagValue
            return ("\(avtoMark): разгружено \(bagValue)")
        }
    }
    
    func carDirrect(command: carCommand, bagValue: Int = 0) -> String {
        do {
            let respond = try internalCarDirrect(command: command, bagValue: bagValue)
            return (respond)
        } catch carError.doubleStart {
            return ("Ошибка запуска двигателя. Двигатель уже запущен")
        } catch carError.doubleStop {
            return ("Ошибка остановки двигателя. Двигатель уже остановлен")
        } catch carError.overBag {
            return ("Ошибка погрузки. столько груза погрузить нельзя")
        } catch carError.windowError {
            return ("Ошибка операции с окном")
        } catch carError.zeroBag {
            return ("Ошибка разгрузки. недостаточно груза в багажнике")
        } catch let error {
            return (error.localizedDescription)
        }
    }
}

var honda = Car(avtoMark: "Honda", avtoEast: 2007, maxBagValue: 300, currentBagValue: 0, motorStart: false, windowOpen: false)
print(honda.carDirrect(command: carCommand.startCar))
print(honda.carDirrect(command: carCommand.startCar))
print(honda.carDirrect(command: carCommand.closeWindow))
print(honda.carDirrect(command: carCommand.putBag, bagValue: 500))
print(honda.carDirrect(command: carCommand.putBag, bagValue: 300))
print(honda.carDirrect(command: carCommand.takeBag, bagValue: 500))
