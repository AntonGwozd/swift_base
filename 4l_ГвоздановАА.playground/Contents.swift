// Задача 4 урока.

import Cocoa
import Foundation

enum carCommand {   //Перечисление команд автомобиля
    case startCar, drownCar, openWindow, closeWindow, putBag, takeBag, superSpeed, trailerDrop
}

class Car {
    static var carQuant: Int = 0
    static func prinCountCar() {
        print ("Всего сейчас существует \(carQuant) экз. класса")
    }
    let avtoMark: String            //Марка автомобиля строка
    let avtoEast: Int               //Год выпуска
    let maxBagValue: Double         //Объем багажника/кузова
    var currentBagValue: Double {   //Текущий объем багажника
        didSet{
            print(avtoMark + ": текущий объем багажника " + String(currentBagValue))
        }
    }
    var motorStart: Bool {          //Запущен ли двигатель
        willSet {
            if newValue == motorStart {
                if motorStart == true {
                    print ("\(avtoMark): Двигатель уже запущен")
                } else {
                    print("\(avtoMark): Двигатель уже заглушен")
                }
            } else {
                if newValue == true {
                    print("\(avtoMark): Двигатель будет запущен")
                } else {
                    print("\(avtoMark): Двигатель будет заглушен")
                }
            }
        }
    }
    var windowOpen: Bool {            //Открыты ли окна
        willSet {
            if newValue == windowOpen {
                if windowOpen == true {
                    print ("\(avtoMark): Окна уже открыты")
                } else {
                    print("\(avtoMark): Окна уже закрыты")
                }
            } else {
                if newValue == true {
                    print("\(avtoMark): Окна будут открыты")
                } else {
                    print("\(avtoMark): Окна будут закрыты")
                }
            }
        }
    }
    
    init(avtoMark: String, avtoEast: Int, maxBagValue: Double, currentBagValue: Double, motorStart: Bool,  windowOpen: Bool){
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
    
    func carDirrect(command: carCommand, bagValue: Double = 0.0) {
        print("Управление из родительского класса не возможно")
    }
}

class SportCar : Car {
    let speedTo100: Int
    init?(avtoMark: String, avtoEast: Int, maxBagValue: Double, currentBagValue: Double, motorStart: Bool,  windowOpen: Bool, speedTo100: Int) {
        self.speedTo100 = speedTo100
        super.init(avtoMark: avtoMark, avtoEast: avtoEast, maxBagValue: maxBagValue, currentBagValue: currentBagValue, motorStart: motorStart, windowOpen: windowOpen)
    }
    
    override func carDescription() {
        print("==================================")
        print("Марка автомобиля: \(avtoMark)")
        print("Год выпуска: \(avtoEast)")
        print("Объем багажника всего: \(maxBagValue), из них груза: \(currentBagValue)")
        print("Разгон до 100: \(speedTo100)c")
        print(motorStart ? "Двигатель запущен" : "Двигатель остановлен")
        print(windowOpen ? "Окна открыты" : "Окна закрыты")
    }
    
    override func carDirrect(command: carCommand, bagValue: Double = 0.0){  //Функция управления спорткаром
        switch command {
        case carCommand.startCar:           //Запуск двигателя
            self.motorStart = true
        case carCommand.drownCar:           //Остановка двигателя
            self.motorStart = false
        case carCommand.openWindow:         //Открытие окон
            self.windowOpen = true
        case carCommand.closeWindow:        //Закрытие окон
            self.windowOpen = false
        case carCommand.superSpeed:         //включим максимальное ускорение, никакого действия просто логика и принт
            if self.motorStart == true {
                print("\(avtoMark): включено максимальное ускорение")
            } else {
                print("\(avtoMark): максимальное ускорение при выключенном двигателе не возможно")
            }
        case carCommand.putBag:             //Загрузка груза
            if ((self.currentBagValue + bagValue) < maxBagValue) {
                print("\(avtoMark): погруженно \(bagValue)")
                self.currentBagValue = self.currentBagValue + bagValue
            } else {
                print("\(avtoMark): Нельзя погрузить столько в машину")
            }
        case carCommand.takeBag:            //Разгрузка груза
            if ((self.currentBagValue - bagValue)<0) {
                print("\(avtoMark): Столько груза нет в машине")
            } else {
                print("\(avtoMark): рагруженно \(bagValue)")
                self.currentBagValue = self.currentBagValue - bagValue
            }
        default:
            print("\(avtoMark): Не допустимое действие")
        }
        
    }
}

class TrunkCar : Car {
    var trailerLenght: Double
    init?(avtoMark: String, avtoEast: Int, maxBagValue: Double, currentBagValue: Double, motorStart: Bool, windowOpen: Bool, trailerLenght: Double = 0) {
        self.trailerLenght = trailerLenght
        super.init(avtoMark: avtoMark, avtoEast: avtoEast, maxBagValue: maxBagValue, currentBagValue: currentBagValue, motorStart: motorStart, windowOpen: windowOpen)
    }
    override func carDescription() {
        print("==================================")
        print("Марка автомобиля: \(avtoMark)")
        print("Год выпуска: \(avtoEast)")
        print("Объем кузова всего: \(maxBagValue), из них груза: \(currentBagValue)")
        trailerLenght>0 ? print("Длина прицепа: \(trailerLenght)") :
        print(motorStart ? "Двигатель запущен" : "Двигатель остановлен")
        print(windowOpen ? "Окна открыты" : "Окна закрыты")
    }
    
    override func carDirrect(command: carCommand, bagValue: Double = 0.0){  //Функция управления грузовиком
        switch command {
        case carCommand.startCar:           //Запуск двигателя
            self.motorStart = true
        case carCommand.drownCar:           //Остановка двигателя
            self.motorStart = false
        case carCommand.openWindow:         //Открытие окон
            self.windowOpen = true
        case carCommand.closeWindow:        //Закрытие окон
            self.windowOpen = false
        case carCommand.trailerDrop:        //Отцепить багажник
            if self.trailerLenght > 0.0 {
                self.trailerLenght = 0.0
                print("\(avtoMark): Трейлер отцеплен")
            } else {
                print("\(avtoMark): Нет же трейлера")
            }
        case carCommand.putBag:             //Загрузка груза
            if ((self.currentBagValue + bagValue) < maxBagValue) {
                print("\(avtoMark): погруженно \(bagValue)")
                self.currentBagValue = self.currentBagValue + bagValue
            } else {
                print("\(avtoMark): Нельзя погрузить столько в машину")
            }
        case carCommand.takeBag:            //Разгрузка груза
            if ((self.currentBagValue - bagValue)<0) {
                print("\(avtoMark): Столько груза нет в машине")
            } else {
                print("\(avtoMark): рагруженно \(bagValue)")
                self.currentBagValue = self.currentBagValue - bagValue
            }
        default:
            print("\(avtoMark): Не допустимое действие")
        }
        
    }
}

//Инициируем спорт кар
var honda = SportCar(avtoMark: "Honda", avtoEast: 2007, maxBagValue: 500, currentBagValue: 0, motorStart: false, windowOpen: false, speedTo100: 9)
honda?.carDescription()
//honda.carDirrect(command: carCommand.startCar)
honda?.carDirrect(command: carCommand.superSpeed)

//Еще один спорт кар
var nissan = SportCar(avtoMark: "Nissan", avtoEast: 2008, maxBagValue: 100, currentBagValue: 0, motorStart: true, windowOpen: true, speedTo100: 11)
nissan?.carDescription()
nissan?.carDirrect(command: carCommand.openWindow)
nissan?.carDirrect(command: carCommand.putBag, bagValue: 120)
nissan?.carDescription()


//Инициируем грузовик
var kamaz = TrunkCar(avtoMark: "Камаз", avtoEast: 1984, maxBagValue: 3000, currentBagValue: 500, motorStart: false, windowOpen: true, trailerLenght: 13.5)
kamaz?.carDescription()
kamaz?.carDirrect(command: carCommand.putBag, bagValue: 1000)
kamaz?.carDirrect(command: carCommand.superSpeed)
kamaz?.carDirrect(command: carCommand.trailerDrop)

var manTruck = TrunkCar(avtoMark: "Man", avtoEast: 2017, maxBagValue: 3000, currentBagValue: 0, motorStart: false, windowOpen: true, trailerLenght: 10)
manTruck?.carDescription()
manTruck?.carDirrect(command: carCommand.putBag, bagValue: 2000)
manTruck?.carDirrect(command: carCommand.openWindow)
manTruck?.carDirrect(command: carCommand.trailerDrop)

//Проверка счетчика
Car.prinCountCar()

kamaz = nil

Car.prinCountCar()
