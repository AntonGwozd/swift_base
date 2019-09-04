//Задача 5 урока
import Cocoa
import Foundation

enum carCommand {   //Перечисление команд автомобиля
    case startCar, drownCar, openWindow, closeWindow, putBag, takeBag, superSpeed, trailerDrop
}

//Протокол машины
protocol Car: class {
    var avtoMark: String {get}                              //Марка автомобиля строка
    var avtoEast: Int {get}                                 //Год выпуска
    var maxBagValue: Double {get}                           //Объем багажника-кузова
    var currentBagValue: Double {get set}                   //Текущий объем багажника
    var motorStart: Bool {get set}                          //Состояние двигателя
    var windowOpen: Bool {get set}                          //Состояние окон
    func carDirrect(command: carCommand, bagValue: Double)  //Функция управления машиной
    func extDirect(command: carCommand)                     //Функция расширенного управления машиной
}

// Расширение протола машины
extension Car {
    func carDirrect(command: carCommand, bagValue: Double = 0.0){   //Функция управления машиной
        switch command {
        case carCommand.startCar:                                   //Запуск двигателя
            if self.motorStart == true {
                print ("\(self.avtoMark): Двигатель уже запущен")
            }   else {
                print ("\(self.avtoMark): Двигатель будет запущен")
            }
            self.motorStart = true
        case carCommand.drownCar:                                   //Остановка двигателя
            if self.motorStart == true {
                print ("\(self.avtoMark): Двигатель будет остановлен")
            }   else {
                print ("\(self.avtoMark): Двигатель уже остановлен")
            }
            self.motorStart = false
        case carCommand.openWindow:                                 //Открытие окон
            if self.windowOpen == true {
                print ("\(self.avtoMark): Окна уже открыты")
            }   else {
                print ("\(self.avtoMark): Окна будут открыты")
            }
            self.windowOpen = true
        case carCommand.closeWindow:                                //Закрытие окон
            if self.windowOpen == true {
                print ("\(self.avtoMark): Окна будут закрыты")
            }   else {
                print ("\(self.avtoMark): Окна уже закрыты")
            }
            self.windowOpen = false
        case carCommand.putBag:                                     //Загрузка груза
            if ((self.currentBagValue + bagValue) < maxBagValue) {
                print("\(avtoMark): погруженно \(bagValue)")
                self.currentBagValue = self.currentBagValue + bagValue
            } else {
                print("\(avtoMark): Нельзя погрузить столько в машину")
            }
        case carCommand.takeBag:                                    //Разгрузка груза
            if ((self.currentBagValue - bagValue)<0) {
                print("\(avtoMark): Столько груза нет в машине")
            } else {
                print("\(avtoMark): рагруженно \(bagValue)")
                self.currentBagValue = self.currentBagValue - bagValue
            }
        default:
            extDirect(command: command)
        }
    }
}

// Класс спортивного автомобиля
class SportCar: Car {
    var avtoMark: String        //Марка автомобиля строка
    var avtoEast: Int           //Год выпуска
    var maxBagValue: Double     //Объем багажника-кузова
    var currentBagValue: Double //Текущий объем багажника
    var motorStart: Bool        //Состояние двигателя
    var windowOpen: Bool        //Состояние окон
    let speedTo100: Int         //Время разгона до 100
    
    init(avtoMark: String, avtoEast: Int, maxBagValue: Double, currentBagValue: Double, motorStart: Bool,  windowOpen: Bool, speedTo100: Int){
        self.avtoMark = avtoMark
        self.avtoEast = avtoEast
        self.maxBagValue = maxBagValue
        self.currentBagValue = currentBagValue
        self.motorStart = motorStart
        self.windowOpen = windowOpen
        self.speedTo100 = speedTo100
    }
    func extDirect(command: carCommand){
        switch command {
        case carCommand.superSpeed:     //включим максимальное ускорение, никакого действия просто логика и принт
            if self.motorStart == true {
                print("\(avtoMark): включено максимальное ускорение")
            } else {
                print("\(avtoMark): максимальное ускорение при выключенном двигателе не возможно")
            }
        default:
            print("\(avtoMark): Не допустимое действие")
        }
    }
}

//Класс грузовика
class TruckCar: Car {
    var avtoMark: String        //Марка автомобиля строка
    var avtoEast: Int           //Год выпуска
    var maxBagValue: Double     //Объем багажника-кузова
    var currentBagValue: Double //Текущий объем багажника
    var motorStart: Bool        //Состояние двигателя
    var windowOpen: Bool        //Состояние окон
    var trailerLenght: Double
    
    init(avtoMark: String, avtoEast: Int, maxBagValue: Double, currentBagValue: Double, motorStart: Bool,  windowOpen: Bool, trailerLenght: Double){
        self.avtoMark = avtoMark
        self.avtoEast = avtoEast
        self.maxBagValue = maxBagValue
        self.currentBagValue = currentBagValue
        self.motorStart = motorStart
        self.windowOpen = windowOpen
        self.trailerLenght = trailerLenght
    }
    
    func extDirect(command: carCommand){
        switch command {
        case carCommand.trailerDrop:        //Отцепить багажник
            if self.trailerLenght > 0.0 {
                self.trailerLenght = 0.0
                print("\(avtoMark): Трейлер отцеплен")
            } else {
                print("\(avtoMark): Нет же трейлера")
            }
        default:
            print("\(avtoMark): Не допустимое действие")
        }
    }
}

//Расширения классов
extension SportCar: CustomStringConvertible {
    var description: String {
        return("==================================\nМарка автомобиля: \(avtoMark)\nГод выпуска: \(avtoEast)\nВремя разгона до 100: \(speedTo100)\nОбъем багажника всего: \(maxBagValue), из них груза: \(currentBagValue)\n"+(motorStart ? "Двигатель запущен\n" : "Двигатель остановлен\n")+(windowOpen ? "Окна открыты\n" : "Окна закрыты\n")+"==================================\n")
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        return("==================================\nМарка автомобиля: \(avtoMark)\nГод выпуска: \(avtoEast) \nОбъем кузова всего: \(maxBagValue), из них груза: \(currentBagValue)\n" + (trailerLenght>0 ? ("Длина прицепа: \(trailerLenght)\n") : "") + (motorStart ? "Двигатель запущен\n" : "Двигатель остановлен\n") + (windowOpen ? "Окна открыты\n" : "Окна закрыты\n")+"==================================\n")
    }
}


//Блок создания объектов, применения действий, вывод в консоль.
var nissan = SportCar(avtoMark: "Nissan", avtoEast: 2007, maxBagValue: 300, currentBagValue: 0, motorStart: false, windowOpen: false, speedTo100: 9)
var toyota = SportCar(avtoMark: "Tuyota", avtoEast: 2018, maxBagValue: 350, currentBagValue: 0, motorStart: false, windowOpen: false, speedTo100: 8)
print (nissan.description)
print (toyota.description)
nissan.carDirrect(command: .startCar)
nissan.carDirrect(command: .superSpeed)
toyota.carDirrect(command: .putBag, bagValue: 100)
toyota.carDirrect(command: .openWindow)

var manTruck = TruckCar(avtoMark: "Man", avtoEast: 2011, maxBagValue: 3000, currentBagValue: 1000, motorStart: false, windowOpen: false, trailerLenght: 13.5)
var volvoTruck = TruckCar(avtoMark: "Volvo", avtoEast: 2007, maxBagValue: 2000, currentBagValue: 0, motorStart: false, windowOpen: false, trailerLenght: 0)
print(manTruck.description)
print(volvoTruck.description)
manTruck.carDirrect(command: .startCar)
manTruck.carDirrect(command: .trailerDrop)
volvoTruck.carDirrect(command: .openWindow)
volvoTruck.carDirrect(command: carCommand.putBag, bagValue: 5000)

