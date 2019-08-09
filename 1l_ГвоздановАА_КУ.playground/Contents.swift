import Foundation
var x1: Double
var x2: Double


print("Решаем квадратное уровнение a*x2 + b*x + c = 0")

// Первый, старший
print("Введите первый (старший) коэффициент:")
var str = readLine()
let a = Double(str!)
if a == 0 || a == nil {
    print("не допустимое значение, работа программы прервана")
} else {
    // Второй
    print("Введите второй коэффициент:")
    str = readLine()
    let b = Double(str!)
    if b == nil {
        print("не допустимое значение, работа программы прервана")
    } else {
        //Третий
        print("Введите третий коэффициент:")
        str = readLine()
        let с = Double(str!)
        if с == nil {
            print("не допустимое значение, работа программы прервана")
        } else {
            //вычисляем дискриминант
            var disk: Double
            disk = b!*b!-4*a!*с!
            if disk < 0 {
                print("у данного уравнения нет корней")
            } else if disk == 0 {
                x1 = (b!/(2*a!))*(-1)
                print ("Корень данного уравнения: " + String(x1))
            } else {
                x1 = ((-b!)+sqrt(disk))/(2*a!)
                x2 = ((-b!)-sqrt(disk))/(2*a!)
                print("Корни уравнения, х1 = "+String(x1)+", x2 = " + String(x2))
            }
        }
    }
}
