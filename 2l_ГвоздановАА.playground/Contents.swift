import Foundation

// 1 и 2 задача. решаются однотипно. лучше универсальную функцию для любого делителя.
// Проверим работу в 4 задаче :)
func devision (num: Int, kef: Int) -> Bool {
    if num % kef == 0 {
        return true
    } else {
        return false
    }
}

// 3 задача. Возрастающий массив из 100 чисел
var myArr: [Int] = []
for num: Int in stride(from: 1001, through: 1100, by: 1) {
    myArr.append(num)
}

// 4 задача: Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
// повторяем пока значение счетчика не будет меньше количества элементов.
var i: Int = 0
repeat {
    if (devision(num: myArr[i], kef: 2) || devision(num: myArr[i], kef: 3)){
        myArr.remove(at: i)
    } else {
        i=i+1
    }
} while i < myArr.count

print(myArr) //визуально проверяем результат

//5 Задача Написать функцию, которая добавляет в массив новое число Фибоначчи,
//и добавить при помощи нее 100 элементов (подробности на странице урока).
//На уроке прозвучало что лучше Float80 Пока не понимаю почему, типы данных надо подтянуть

func fibonachi(n1: Float80, n2: Float80) -> Float80 {
    return n1+n2
}
var arrFib: [Float80] = []
arrFib.append(0)    //Заполняем массив, двумя первыми числами
arrFib.append(1)
repeat{
    //вызываем функцию со значениеями препоследнего и последнего элемента массива
    arrFib.append(fibonachi(n1: arrFib[arrFib.count-2], n2: arrFib[arrFib.count-1]))
}while arrFib.count < 100 // вызываем пока количество элементов массива не заполнится

print(arrFib) //Проверяем результат визуально

// 6 задача Заполнить массив из 100 элементов различными простыми числами
// вспомогательно будем использовать функцию из 1 и 2 задачи.
func primeNum(numIn: Int) -> Bool {
    for num: Int in stride(from: 2, to: numIn, by: 1) {
        if devision(num: numIn, kef: num) {
            return false
        }
    }
    return true
}

var numArr: [Int] = []
numArr.append(2) // Добавим первое простое число
i=3
repeat {
    if primeNum(numIn: i) {
        numArr.append(i)
    }
    i=i+1
} while numArr.count < 100

print(numArr) //Проверяем результат визуально


