object Zadanie2 extends App {
    
    // Zadanie 1
    def checkIfWorkDay(weekDay: String) = {
        val workDays = List("poniedziałek", "wtorek", "środa", "czwartek", "piątek")
        val weekendDay = List("sobota", "niedziela")
        val day: String = weekDay.toLowerCase()

        day match {
            case day: String if workDays.contains(day) => "Work"
            case day: String if weekendDay.contains(day) => "Weekend"
            case _ => "No such day"
        }
    }

    // Zadanie 2
    class BankAccount(val initialBalance: Int = 0) {
        private var _balance = initialBalance

        def currentBalance = _balance

        def deposit(amount: Int) {
            _balance += amount
        }
        def withdraw(amount: Int) {
            _balance -= amount
        }
    }

    // Zadanie 3
    case class GreetPerson( firstname: String, lastname: String) {}

    val mateusz = GreetPerson("Mateusz", "Smith")
    val karolina = GreetPerson("Karolina", "Kennedy")
    val bartosz = GreetPerson("Bartosz", "Prefect")
    val ewa = GreetPerson("Ewa", "Dent")

    def greeting(person: GreetPerson): String = {
            val name = person.firstname

            name match {
                case "Mateusz" => s"Hello $name! How are you today?"
                case "Karolina" =>  s"Hello, Ms $name! How is your day?"
                case "Bartosz" =>  s"Welcome back. Tell me $name is everything alright?"
                case "Ewa" =>  s"Greeting $name. Wish you a good day."
                case _ => s"Hello $name"
            }
        }

    // Zadanie 4
    def triple(number: Int, f: (Int) => Int) = {
        f(f(f(number)))
    }

    // Zadanie 5
    class Person( val firstname: String, val lastname: String, val tax: Double) {}
    
    trait Student extends Person { 
        override val tax: Double = 0 
    }
    
    trait Professor extends Employee { 
        override val tax: Double = 0.1 * salary: Double
    }
    
    trait Employee extends Person { 
        var salary: Double = 100; 
        override val tax: Double =  0.2 * salary: Double
    }


    // Implementation

    // Zadanie 1

    println(checkIfWorkDay("sobota"))
    println(checkIfWorkDay("PonieDziałek"))
    println(checkIfWorkDay("POniedzialls"))
    println('\n')

    // Zadanie 2

    val MyBankAccount = new BankAccount(1000)
    println(MyBankAccount.currentBalance)
    MyBankAccount.deposit(200)
    println(MyBankAccount.currentBalance)
    MyBankAccount.withdraw(700)
    println(MyBankAccount.currentBalance)
    println(MyBankAccount.initialBalance)

    // Zadanie 3
    
    println(greeting(mateusz))
    println(greeting(karolina))
    println(greeting(bartosz))
    println(greeting(ewa))
    
    // Zadanie 4

    println(triple(5, x => x*2))
    println(triple(2, x => x+2))

    // Zadanie 5
    
    val marcin = new Person("Marcin", "Rozenek", 13) with Professor
    val maciej = new Person("Maciej", "Nowak", 14) with Employee
    val robert = new Person("Robert", "Kral", 15) with Student
    val bill = new Person("Bill", "Gates", 16) with Student with Employee
    val maria = new Person("Maria", "Huffington", 17) with Employee with Student
 
    println("Student tax: 0.0\nProfessor tax: 10.0\nEmployee tax: 20.0\n")
    println(s"Student: ${robert.tax}")
    println(s"Profesor: ${marcin.tax}")
    println(s"Employee: ${maciej.tax}")
    println(s"Student -> Employee: ${bill.tax}")
    println(s"Employee -> Student: ${maria.tax}")
}