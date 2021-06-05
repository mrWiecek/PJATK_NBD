import scala.annotation.tailrec

object Zadanie1 extends App {
  val weekDays = List("Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota", "Niedziela")

  // Zadanie 1
    // a
  def list2string(days: List[String]) = {
    var weekDaysStr: String = ""

    for (day <- days) {
      if (day == days.last)
        weekDaysStr += day
      else
        weekDaysStr += day + ";"
    }
    weekDaysStr
  }

    // b
  def list2string_PDays(days: List[String]) = {
    var weekDaysStr: String = ""
    val daysStartWithP: List[String] = days.filter(_.startsWith("P"))

    for (day <- daysStartWithP) {
      if (day == daysStartWithP.last)
        weekDaysStr += day
      else
        weekDaysStr += day + ";"
    }

    weekDaysStr
  }

    //c
  def list2string_while(days: List[String]) = {
    var weekDaysStr: String = ""
    var i: Int = 0      

    while (i <= days.length - 1) {
      if (i == days.length - 1) {
        weekDaysStr += days(i)
        i += 1
      }
      else
        weekDaysStr += days(i) + ";"
        i += 1
    }
    weekDaysStr
  }

  // Zadanie 2
    // a
  def list2string_recurence(days: List[String]): String = {
    if (days.length == 1)
      days.head
    else
      days.head + ";" + list2string_recurence(days.tail)
  }

    // b
  def list2string_recurence_reversed(days: List[String]): String = {
    if (days.length == 1)
      days.last
    else
      days.last + ";" + list2string_recurence_reversed(days.slice(0, days.length-1))
  }

  // Zadanie 3
  def list2string_recurence_tail(days: List[String]): String = {
    @tailrec
    def iter(days: List[String], result: String): String = {
      if (days.length == 1) result + days.head
      else {
        iter(days.tail, result + days.head + ";")
    }
  }
    iter(days, "")
  }

  // Zadanie numer 4
  def list2string_fold_left(days: List[String]): String = {
    val concatDays: (String, String) => String = (s1, s2) => s1 + ";" + s2
    val daysString = days.fold("")(concatDays)
    daysString.tail
  }

    def list2string_fold_right(days: List[String]): String = {
    val concatDays: (String, String) => String = (s1, s2) => s1 + ";" + s2
    val daysString = days.foldRight("")(concatDays)
    daysString.slice(0, daysString.length() -1)
  }

  def list2string_fold_left_pdays(days: List[String]): String = {
    val concatDays: (String, String) => String = (s1, s2) => s1 + ";" + s2
    val daysString = days.filter(_.startsWith("P")).fold("")(concatDays)
    daysString.tail
  }

  // Zadanie numer 5
  val store = Map(
    "Apple" -> 0.5, 
    "Orange" -> 2.0,
    "Banana" -> 1.0,
    "Grapes" -> 4.0,
    "Pineapple" -> 5.0
  )

  val storeWDiscount = store.map { case (product, value) => product -> value*0.9}
  
  // Zadanie numer 6
  def tupleManyTypes(inputTuple: (String, Int, Double)) = {
    inputTuple.productIterator.foreach(x => println(x))
  }

  // Zadanie numer 7
  def mapOption(store: Map[String, Double]) ={
    val result = store.get("Apple")
    if (result.isDefined) {
        print(result.get) 
    }
  }

  // Test lists
  val testList = List(0, 2, 4 ,45 , 5, 0, 6, 6)
  val testListFloat = List(0.4f, 2.4f, 4.7f ,45.6f , 5.8f, 0.0f, 6.3f, 6.7f)

  // Zadanie 8
  def cleanZeros(input: List[Int]): List[Int] = input match {
    case Nil => Nil
    case head :: tail =>
      if (head == 0) 
        cleanZeros(tail)
      else
        head :: cleanZeros(tail)
  }

  // Zadanie 9
  def increaseByOne(input: List[Int]): List[Int] = {
    input.map(x => x+1)
  }

  // Zadanie 10
  def filterModulus(input: List[Float]): List[Double] = {
    input.filter(num => num >= -12 && num <= 5).map(num => num.abs)
  }


  // Implementation
  // Zadanie 1
  println(list2string(weekDays))
  println(list2string_PDays(weekDays))
  println(list2string_recurence(weekDays))
  // Zadanie 2
  println(list2string_recurence_reversed(weekDays))
  println(list2string_recurence_tail(weekDays))
  // Zadanie 4
  println(list2string_fold_left(weekDays))
  println(list2string_fold_right(weekDays))
  println(list2string_fold_left_pdays(weekDays))
  // Zadanie 5
  println(store.keys)
  println(store.values)
  println(storeWDiscount.keys)
  println(storeWDiscount.values)
  // Zadanie 6
  tupleManyTypes("Life, the Universe and Everything", 42, 3.1415)
  // Zadanie 7
  mapOption(store)
  println()

  // Zadanie 8
  println(cleanZeros(testList))
  // Zadanie 9
  println(increaseByOne(testList))
  // Zadanie 10
  println(filterModulus(testListFloat))
}