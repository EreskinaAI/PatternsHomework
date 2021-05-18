import Foundation

// Abstract factory pattern

// Задача: Производство духов CHANEL/GIVENCHY оригинал/подделка

/// Создаем завод по производству парфюма
class Factory { }

/// Описание парфюма Chanel
class Chanel {
    /// название
    var name: String?
    /// объем флакона
    var volume: String?
    ///страна происхождения
    var originCountry: String?
}

/// Описание парфюма Givenchy
class Givenchy {
    /// название
    var name: String?
    /// объем флакона
    var volume: String?
    ///страна происхождения
    var originCountry: String?
    
}

/// Оригинальный тип производства Chanel
class OriginalChanel: Chanel {
    override init() {
        super.init()
        
        self.name = "CHANEL № 5"
        self.volume = "50 мл"
        self.originCountry = "France"
    }
}

// Оригинальный тип производства Givenchy
class OriginalGivenchy: Givenchy {
    override init() {
        super.init()
        
        self.name = "GIVENCHY IRRESISTIBLE"
        self.volume = "50 мл"
        self.originCountry = "France"
        
    }
}

/// Подделка Chanel
class FakelChanel: Chanel {
    override init() {
        super.init()
        
        self.name = "CHANEL"
        self.volume = "25 мл"
        self.originCountry = "China"
    }
}

/// Подделка Givenchy
class FakeGivenchy: Givenchy {
    override init() {
        super.init()
        
        self.name = "GIVENCHY"
        self.volume = "25 мл"
        self.originCountry = "China"
    }
}

/// Оригнальный завод по производству парфюма
class OriginalFactory: Factory {
    
    /// Производим
    /// - Returns: экземпляр оригинальных Chanel
    func produceChanel() -> Chanel {
        let chanel = OriginalChanel()
        return chanel
    }
    
    /// Производим
    /// - Returns: кземпляр оригинальных Givenchy
    func produceGivenchy() -> Givenchy {
        let givenchy = OriginalGivenchy()
        return givenchy
    }
}

/// Китайский завод по производству парфюма
class FakeFactory: Factory {
    
    /// Производим
    /// - Returns: экземпляр поддельных Chanel
    func produceChanel() -> Chanel {
        let chanel = FakelChanel()
        return chanel
    }
    
    /// Производим
    /// - Returns: экземпляр поддельных Givenchy
    func produceGivenchy() -> Givenchy {
        let givenchy = FakeGivenchy()
        return givenchy
    }
}

/// Переменная(индикатор) подделки, организующая подмену фабрики
var fake: Bool = true

/// Определяем тип фабрики
/// - Returns: оригинальный/фейковый завод по производству
func getFactory() -> Factory {
    if fake {
        return FakeFactory()
    }
    
    return OriginalFactory()
}

// USAGE

let factory1 = getFactory()

var chanel = Chanel()
var givenchy = Givenchy()

if let factory = factory1 as? FakeFactory {
    chanel = factory.produceChanel()
    givenchy = factory.produceGivenchy()
}

if let factory = factory1 as? OriginalFactory {
    chanel = factory.produceChanel()
    givenchy = factory.produceGivenchy()
}


print("1- Bottle \(chanel.volume ?? "") of \(chanel.name ?? "") is produced in \(chanel.originCountry ?? "")")
print("2- Bottle \(givenchy.volume ?? "") of \(givenchy.name ?? "") is produced in \(givenchy.originCountry ?? "")")


fake = false
let factory2 = getFactory()

if let factory = factory2 as? OriginalFactory {
    chanel = factory.produceChanel()
    givenchy = factory.produceGivenchy()
}

if let factory = factory2 as? FakeFactory {
    chanel = factory.produceChanel()
    givenchy = factory.produceGivenchy()
}

print("3- Bottle \(chanel.volume ?? "") of \(chanel.name ?? "") is produced in \(chanel.originCountry ?? "")")
print("4- Bottle \(givenchy.volume ?? "") of \(givenchy.name ?? "") is produced in \(givenchy.originCountry ?? "")")


// Builder pattern

// Задача: Нужно приготовить кофе из 2 сортов. За приготовление каждого из них отвечает определенная марка кофемашины (использование зерен определенного сорта). Бариста обслуживает клиента, сварив ему определенный сорт кофе

/// Кофе
class Coffee {
    
    /// Сорт кофе
    var coffeeSort = ""
}

/// Универсальная кофемашина
class CoffeeMachine {
    let coffee = Coffee()

    /// Варим кофе
    /// - Returns: определенный сорт кофе
    func makeCoffee() -> Coffee {
        return self.coffee
    }
}

/// Кофемашина, которая использует(засыпает) зерна Арабики
class CoffeMachineMiele: CoffeeMachine {

    func fillUpBeans() {
        self.coffee.coffeeSort = "Arabica"
    }
}

/// Кофемашина, которая использует(засыпает) зерна Либерики
class CoffeMachiNespresso: CoffeeMachine {

    func fillUpBeans() {
        self.coffee.coffeeSort = "Liberica"
    }
}

/// Бариста, который будет готовить кофе
class Barista {

    var machine = CoffeeMachine()
    
    /// Выбирает на какой кофемашине готовить кофе
    /// - Parameter amachine: марка кофемашины
    func chooseMachine(amachine: CoffeeMachine) {
        self.machine = amachine
    }
    
    /// Приготовление кофе
    /// - Returns: готовый кофе
    func makeCoffee() -> Coffee {
        return self.machine.makeCoffee()
    }
    
    /// Обслуживание в зависимости от выбора кофемашины
    func service() {
        
        if let machine1 = machine as? CoffeMachineMiele {
            machine1.fillUpBeans()
        } else if let machine1 = machine as? CoffeMachiNespresso {
            machine1.fillUpBeans()
        }
    }
}

// USAGE

let coffeMachineMiele = CoffeMachineMiele()
let coffeMachiNespresso = CoffeMachiNespresso()
let barista = Barista()

barista.chooseMachine(amachine: coffeMachineMiele)
barista.service()
let coffee = barista.makeCoffee()
print("1-Your coffee cooked from the best sorts of \(coffee.coffeeSort)"  )

barista.chooseMachine(amachine: coffeMachiNespresso)
barista.service()
let anotherCoffee = barista.makeCoffee()
print("2-Your coffee cooked from the best sorts of \(anotherCoffee.coffeeSort)"  )

