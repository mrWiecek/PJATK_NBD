// Część 1 – Wycieczki górskie
// Zaimportuj dane uruchamiając skrypt task2.cypher. Napisz następujące zapytania:  
//     1. Znajdź trasy którymi można dostać się z Darjeeling na Sandakphu, mające najmniejszą ilość etapów 
MATCH paths=shortestPath( (origin:town {name: "Darjeeling"})-[*..4]-(finish:peak {name: "Sandakphu"} )) RETURN paths

//     2. Znajdź mające najmniej etapów trasy którymi można dostać się z Darjeeling na Sandakphu i które mogą być wykorzystywane zimą 
MATCH paths=shortestPath( (origin {name:"Darjeeling"})-[*..4]->(finish {name:"Sandakphu"})) 
WHERE ALL (path IN RELATIONSHIPS(paths) WHERE path.winter = "true") 
RETURN paths

//     3. Uszereguj trasy którymi można dostać się z Darjeeling na Sandakphu według dystansu Znajdź wszystkie miejsca do których można dotrzeć
//       przy pomocy roweru (twowheeler) z Darjeeling latem
MATCH paths = (origin {name:"Darjeeling"})-[*..4]->(finish {name:"Sandakphu"})
RETURN reduce(total = 0, path IN relationships(paths) | total + path.distance) as distance, paths
ORDER BY distance

MATCH (origin {name:"Darjeeling"})-[:twowheeler*]->(finish) 
RETURN origin, finish

// Część 2 – Połączenia lotnicze
// Zaimportuj dane uruchamiając skrypt task3.cypher. Napisz następujące zapytania:
//     4. Uszereguj porty lotnicze według ilości rozpoczynających się w nich lotów
MATCH (airport:Airport)-[o:ORIGIN]-(flight) 
WITH count(o) as numOriginFlights, airport 
RETURN airport, numOriginFlights 
ORDER BY numOriginFlights

//     5. Znajdź wszystkie porty lotnicze, do których da się dolecieć (bezpośrednio lub z przesiadkami) z Los Angeles (LAX) wydając mniej niż 3000
MATCH (origin:Airport)<-[:ORIGIN]-(flight)-[:DESTINATION]->(finish:Airport), (flight)<-[:ASSIGN]-(ticket)
CREATE (origin)-[:ROUTE {price: ticket.price, class: ticket.class, airline: flight.airline}]->(finish)

MATCH finish = (:Airport { name:"LAX" })-[:ROUTE*1..4]->(origin)
	WITH origin, relationships(finish) AS finish 
	WHERE REDUCE(totalCost = 0, ticket IN finish|totalCost + ticket.price) < 3000
	RETURN DISTINCT origin.name

//     6. Uszereguj połączenia, którymi można dotrzeć z Los Angeles (LAX) do Dayton (DAY) według ceny biletów
MATCH paths = (:Airport {name: "LAX"}) -[:ROUTE*..4]->(:Airport {name: "DAY"})
WITH paths, reduce(totalPrice = 0, flight IN relationships(paths) |  totalPrice + flight.price)  as total
RETURN paths, total
ORDER BY total

//     7. Znajdź najtańsze połączenie z Los Angeles (LAX) do Dayton (DAY)
MATCH paths = (:Airport {name: "LAX"}) -[:ROUTE*..4]->(:Airport {name: "DAY"})
WITH paths, reduce(totalPrice = 0, flight IN relationships(paths) |  totalPrice + flight.price)  as total
Return paths, total
ORDER BY total asc
LIMIT 1

//     8. Znajdź najtańsze połączenie z Los Angeles (LAX) do Dayton (DAY) w klasie biznes
MATCH paths = (:Airport {name: "LAX"}) -[:ROUTE*..4]->(:Airport {name: "DAY"})
WHERE ALL( path in relationships(paths) WHERE path.class = 'business')
WITH paths, reduce(totalPrice = 0, flight IN relationships(paths) |  totalPrice + flight.price) as total
Return paths, total
ORDER BY total asc
LIMIT 1

//  9. Uszereguj linie lotnicze według ilości miast, pomiędzy którymi oferują połączenia
//	(unikalnych miast biorących udział w relacjach :ORIGIN i :DESTINATION węzłów typu Flight obsługiwanych przez daną linię)

// Jakie mamy dostępne linie lotnicze
MATCH (flight)<-[:ASSIGN]-(ticket)
return distinct(flight.airline)

// Tylko dwie. To można hardcodować...
CALL {
  MATCH (a:Airport)-[]-(f:Flight)
  WITH a, f
  WHERE f.airline = "19977"
  RETURN f.airline as airlineName, COUNT(distinct(a)) as count
  UNION ALL
  MATCH (a:Airport)-[]-(f:Flight)
  WITH a, f
  WHERE f.airline = "20304"
  RETURN f.airline as airlineName, COUNT(distinct(a)) as count
}
RETURN airlineName, count

//     10. Znajdź najtańszą trasę łączącą 3 różne porty lotnicze
MATCH paths = (origin:Airport)-[:ROUTE*2]->(finish:Airport)
WHERE origin <> finish
WITH paths, reduce(totalCost = 0, path in relationships(paths) | totalCost + path.price) as total
ORDER BY total ASC
LIMIT 1
RETURN paths,total

// Clean relationship
MATCH ()-[r:ROUTE]-()
DELETE r