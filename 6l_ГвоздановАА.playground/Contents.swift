import UIKit

//Протокол человека с возрастом и именем
protocol manAgeANDName {
    var name: String {get set}
    var age: Int {get set }
}

//Клас пациенты
class Pacient: manAgeANDName {
    var name: String
    var age: Int
    var diag: String
    
    init(name: String, age: Int, diag: String) {
        self.name = name
        self.age = age
        self.diag = diag
    }
}

//Клас Клиенты автосервиса
class ClientAvto: manAgeANDName {
    var name: String
    var age: Int
    var modelAvto: String
    
    init(name: String, age: Int, modelAvto: String) {
        self.name = name
        self.age = age
        self.modelAvto = modelAvto
    }
}

//Стуктура универсальная для обработки очереди FIFO
struct Struc_FIFO<T: manAgeANDName> {
    
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeFirst()
    }
    
    //Функция подсчета возраста
    func ageCalculate(){
        var allAge = 0
        for pacient in elements {
            allAge = allAge + pacient.age
        }
        print("Сумарный возраст в очереди : \(allAge)")
    }
    
    //subscript возвращающий имя клиента по индексу в очереди
    subscript(index: Int) -> String? {
        get {
            guard index < elements.count else { return nil }
            return (elements[index].name)
        }
    }
    
    //Вернем всех до Age лет.
    func beforeAge(ageConst: Int, clouser: (Int, Int) -> Bool) -> Array<T> {
        var newArray: [T] = []
        for element in elements {
            if clouser(element.age, ageConst) {
                newArray.append(element)
            }
        }
        return newArray
    }
    
    //Вернем клиентов массив клиентов по фамилии
    func returnName(nameConst: String, clouser: (String,String) -> Bool) -> Array<T> {
        var newArray: [T] = []
        for element in elements {
            if clouser(element.name, nameConst) {
                newArray.append(element)
            }
        }
        return newArray
    }
    
}

var queueClient = Struc_FIFO<Pacient>()     //Очередь пациентов

queueClient.push(Pacient(name: "Иванов", age: 26, diag: "Простуда"))
queueClient.push(Pacient(name: "Петров", age: 18, diag: "Кашель"))
queueClient.push(Pacient(name: "Сидоров", age: 23, diag: "Насморк"))
queueClient.push(Pacient(name: "Кузнецов", age: 32, diag: "Простуда"))
queueClient.push(Pacient(name: "Иванов", age: 54, diag: "Геморой"))
queueClient.push(Pacient(name: "Белов", age: 43, diag: "Насморк"))
queueClient.ageCalculate()
queueClient.pop()
queueClient.ageCalculate()
//Проверка работы сабскрипта
print(queueClient[8] ?? "Пациента с таким индексом нет")
print(queueClient[1] ?? "Пациента с таким индексом нет")

var queueDealer = Struc_FIFO<ClientAvto>()      //Очередь клиентов сервиса
queueDealer.push(ClientAvto(name: "Петров", age: 18, modelAvto: "Форд"))
queueDealer.push(ClientAvto(name: "Иванов", age: 26, modelAvto: "Ниссан"))
queueDealer.push(ClientAvto(name: "Сидоров", age: 23, modelAvto: "Хонда"))
queueDealer.push(ClientAvto(name: "Белов", age: 43, modelAvto: "Вольво"))
queueDealer.ageCalculate()
queueDealer.pop()
queueDealer.ageCalculate()
//Проверка работы сабскрипта
print(queueClient[10] ?? "Клеинта с таким индексом нет")
print(queueClient[0] ?? "Клиента с таким индексом нет")

// Замыкания
// Попробуем сделать фильтр по возрасту
//let begAge: (Int, Int) -> Bool = { (age: Int, ageConst: Int) -> Bool in
//    return age < ageConst
//}
//
//var cli25 = queueClient.beforeAge(ageConst: 25, clouser: begAge)
var cli35 = queueClient.beforeAge(ageConst: 35) { $0 < $1 }
print (cli35.count)

// а теперь возврат по фамилии.

var cliOtbor = queueClient.returnName(nameConst: "Петров") { $0 == $1}
print (cliOtbor.count)
