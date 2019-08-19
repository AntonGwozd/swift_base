// Задача 3 урока.
// нет принципиальной разницы между машиной и грузовиком с точки зрения описания структуры.
// поэтому тип автомобиля вынесем в переменую carType
// если бы по условиям различий было бы больше, имело бы смысл сделать класс AUTO и два класса с наследованием от него и в них уже выделить различия
// в рамках этой задачи различия реализуются исключительно в описательном виде внутри description

import Cocoa
import Foundation

enum carCommand {   //Перечисление команд автомобиля
    case startCar, drownCar, openWindow, closeWindow, putBag, takeBag
}

enum carTypes {     //Перечисление типов автомобиля
    case car, truck
}

struct car {
    let carType: carTypes           //Тип автомобиля
    let avtoMark: String            //Марка автомобиля строка
    let avtoEast: Int               //Год выпуска
    let maxBagValue: Double         //Объем багажника
    var currentBagValue: Double {   //Текущий объем багажника
        didSet{
            print(avtoMark + ": текущий объем багажника " + String(currentBagValue))
        }
    }
    var motorStart: Bool {          //Запущен ли двигатель
        willSet {
            if newValue == motorStart {
                if motorStart == true {
                    print (avtoMark+": Двигатель уже запущен")
                } else {
                    print(avtoMark+": Двигатель уже заглушен")
                }
            } else {
                if newValue == true {
                    print(avtoMark+": Двигатель будет запущен")
                } else {
                    print(avtoMark+": Двигатель будет заглушен")
                }
            }
        }
    }
    var windowOpen: Bool {            //Открыты ли окна
        willSet {
            if newValue == windowOpen {
                if windowOpen == true {
                    print (avtoMark+": Окна уже открыты")
                } else {
                    print(avtoMark+": Окна уже закрыты")
                }
            } else {
                if newValue == true {
                    print(avtoMark+": Окна будут открыты")
                } else {
                    print(avtoMark+": Окна будут закрыты")
                }
            }
        }
    }
    
    mutating func carDirrect(command: carCommand, bagValue: Double = 0.0){  //Функция управления.
        switch command {
        case carCommand.startCar:           //Запуск двигателя
            self.motorStart = true
        case carCommand.drownCar:           //Остановка двигателя
            self.motorStart = false
        case carCommand.openWindow:         //Открытие окон
            self.windowOpen = true
        case carCommand.closeWindow:        //Закрытие окон
            self.windowOpen = false
        case carCommand.putBag:             //Загрузка груза
            if ((self.currentBagValue + bagValue) < maxBagValue) {
                print(avtoMark + ": погруженно " + String(bagValue))
                self.currentBagValue = self.currentBagValue + bagValue
            } else {
                print(avtoMark + ": Нельзя погрузить столько в машину")
            }
        case carCommand.takeBag:            //Разгрузка груза
            if ((self.currentBagValue - bagValue)<0) {
                print(avtoMark + ": Столько груза нет в машине")
            } else {
                print(avtoMark + ": рагруженно " + String(bagValue))
                self.currentBagValue = self.currentBagValue - bagValue
            }
        }
    }
    
    func carDescription() {                 //Функция описания автомобиля
        print("==================================")
        print("Марка " + (carType == carTypes.car ? "автомобиля: " : "грузовика :") + avtoMark)
        print("Год выпуска: " + String(avtoEast))
        print("Объем " + (carType == carTypes.car ? "багажника: " : "кузова :") + " всего: " + String(maxBagValue) + ", из них груза: " + String(currentBagValue))
        switch motorStart {
        case true:
            print("Двигатель запущен")
        case false:
            print("Двигатель остановлен")
        }
        switch windowOpen {
        case true:
            print("Окна открыты")
        case false:
            print("Окна закрыты")
        }
    }
}

// Инициируем легковой автомобиль
var nissan = car(carType: carTypes.car, avtoMark: "Nissan", avtoEast: 2001, maxBagValue: 500.0, currentBagValue: 0.0, motorStart: false, windowOpen: false)
print(nissan.carDescription())
nissan.carDirrect(command: carCommand.startCar)
print(nissan.carDescription())
nissan.carDirrect(command: carCommand.putBag, bagValue: 100.0)
print(nissan.carDescription())
nissan.carDirrect(command: carCommand.takeBag, bagValue: 700.0)
print(nissan.carDescription())

// Инициируем грузовой автомобиль
var manTruck = car(carType: carTypes.truck, avtoMark: "Man", avtoEast: 2007, maxBagValue: 1500.0, currentBagValue: 0.0, motorStart: false, windowOpen: false)
print(manTruck.carDescription())
manTruck.carDirrect(command: carCommand.startCar)
print(manTruck.carDescription())
manTruck.carDirrect(command: carCommand.putBag, bagValue: 850.0)
print(manTruck.carDescription())
manTruck.carDirrect(command: carCommand.putBag, bagValue: 900.0)
print(manTruck.carDescription())

