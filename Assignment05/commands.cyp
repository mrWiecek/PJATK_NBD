// 1. Wszystkie filmy
MATCH (movies:Movie ) RETURN movies 
// 2. Wszystkie filmy, w których grał Hugo Weaving
MATCH (person:Person {name: "Hugo Weaving"})-[:ACTED_IN]->(movies) RETURN movies
// 3. Reżyserzy filmów, w których grał Hugo Weaving 
MATCH (person:Person {name: "Hugo Weaving"})-[:ACTED_IN]->(movies)<-[:DIRECTED]-(directors) RETURN directors
// 4. Wszystkie osoby, z którymi Hugo Weaving grał w tych samych filmach
MATCH (person:Person {name: "Hugo Weaving"})-[:ACTED_IN]->(movies)<-[:ACTED_IN]-(actors) RETURN actors
// 5. Wszystkie filmy osób, które grały w Matrix
MATCH (movie:Movie {title: "The Matrix"})<-[:ACTED_IN]-(matrixActors)-[:ACTED_IN]->(matrixActorsMovies) RETURN matrixActorsMovies
// 6. Listę aktorów (aktor = osoba, która grała przynajmniej w jednym filmie) wraz z ilością filmów, w których grali
MATCH (person:Person)-[:ACTED_IN]->(movies) WITH person, count(movies) as cntMovies WHERE cntMovies > 1 RETURN person, cntMovies
// 7. Listę osób, które napisały scenariusz filmu, które wyreżyserowały wraz z tytułami takich filmów (koniunkcja – ten sam autor scenariusza i reżyser)
MATCH (person:Person)-[:WROTE]->(screenPlayMovie)<-[:DIRECTED]-(person:Person) RETURN person, screenPlayMovie
// 8. Listę filmów, w których grał zarówno Hugo Weaving jak i Keanu Reeves
MATCH (person1:Person {name: "Keanu Reeves"})-[:ACTED_IN]->(movie)<-[:ACTED_IN]-(person2:Person {name: "Hugo Weaving"}) RETURN movie
// 9. (za 0.2pkt) Zestaw zapytań powodujących uzupełnienie bazy danych o film Captain America: 
// The First Avenger wraz z uzupełnieniem informacji o reżyserze, scenarzystach i odtwórcach głównych ról 
// (w oparciu o skrócone informacje z IMDB - http://www.imdb.com/title/tt0458339/) + zapytanie pokazujące dodany
CREATE (captainAmerica:Movie {title:'Captain America: The First Avenger', released:2011, tagline:"When patriots become heroes"})

CREATE (evans:Person {name:'Chris Evans', born:1981})
CREATE (jackson:Person {name:'Samuel L. Jackson', born:1948})
CREATE (atwell:Person {name:'Hayley Atwell', born:1982})
CREATE (stan:Person {name:'Sebastian Stan', born:1882})
CREATE (johnston:Person {name: "Joe Johnston", born: 1950})
CREATE (markus:Person {name: "Christopher Markus", born: 1970})
CREATE (mcfeely:Person {name:"Stephen McFeely", born:1970})
CREATE
(evans)-[:ACTED_IN {roles:['Steve Rogers']}]->(captainAmerica),
(jackson)-[:ACTED_IN {roles:['Nick Fury']}]->(captainAmerica),
(atwell)-[:ACTED_IN {roles:['Peggy Carter']}]->(captainAmerica),
(stan)-[:ACTED_IN {roles:["James Buchanan 'Bucky' Barnes"]}]->(captainAmerica),
(johnston)-[:DIRECTED]->(captainAmerica),
(markus)-[:WROTE]->(captainAmerica),
(mcfeely)-[:WROTE]->(captainAmerica)

MATCH (movie:Movie {title: "Captain America: The First Avenger"})-[:ACTED_IN]-(actors) RETURN actors


CREATE (evans:Person {name:'Chris Evans', born:1981})
CREATE (evans)-[:ACTED_IN {roles:['Steve Rogers']}]->(captainAmerica)