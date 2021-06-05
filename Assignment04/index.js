// // MapReduce

// 1. Średnią wagę i wzrost osób w bazie z podziałem na płeć 
// (tzn. osobno mężczyzn, osobno kobiet);

// var mapper = function() {
//     emit(this.sex, {count: 1, height: parseFloat(this.height), weight: parseFloat(this.weight)})
// }

// var reducer = function(sex, values) {
//     reducedVals = {count: 0, height: 0, weight: 0}
//     values.forEach(val => {
//         reducedVals.count += val.count
//         reducedVals.height += val.height
//         reducedVals.weight += val.weight
//     })
//     return reducedVals
// }

// var finalize = function(sex, reducedVals) {
//     averagedVals = {avgHeight: 0, avgWeight: 0}
//     averagedVals.avgHeight = reducedVals.height/reducedVals.count
//     averagedVals.avgWeight = reducedVals.weight/reducedVals.count

//     return averagedVals
// }

// const options = {
//     out: {inline: 1},
//     finalize: finalize
// }

// printjson(db.people.mapReduce(mapper, reducer, options))

// 2. Łączną ilość środków pozostałych na kartach kredytowych osób w bazie, 
//w podziale na waluty;

// var mapper = function() {
//     this.credit.forEach(card => {
//         var key = card.currency
//         var val = parseFloat(card.balance)
//         emit(key, val)
//     });
// }

// var reducer = function(card, balance) {
//     return Array.sum(balance)
// }


// const options = {
//     out: {inline: 1}
// }

// printjson(db.people.mapReduce(mapper, reducer, options))

// 3. Listę unikalnych zawodów;

// var mapper = function() {
//     emit(this.job, 1)
// }

// var reducer = function(job, constant) {
//     return 1
// }


// const options = {
//     out: {inline: 1}
// }

// printjson(db.people.mapReduce(mapper, reducer, options))

// 4. Średnie, minimalne i maksymalne BMI (waga/wzrost^2) dla osób w bazie, 
// w podziale na narodowości;

// var mapper = function() {
//     emit(this.nationality, { count: 1, BMI: this.weight/this.height**2 })
// }

// var reducer = function(nationality, values) {
//     reducedValues = {count: values[0].count, minBMI: values[0].BMI, maxBMI: values[0].BMI, sumBMI: values[0].BMI}
//     for (let i = 1; i < values.length; i++) {
//         const currentValues = values[i];

//         reducedValues.minBMI = Math.min(currentValues.BMI, reducedValues.minBMI)
//         reducedValues.maxBMI = Math.max(currentValues.BMI, reducedValues.maxBMI)
//         reducedValues.sumBMI += currentValues.BMI
//     }

//     return reducedValues
// }

// var finalize = function(nationality, values) {
//     results = {minBMI: values.minBMI, maxBMI: values.maxBMI, avgBMI: 0}
//     results.avgBMI = values.sumBMI/ values.count
//     return results
// }

// const options = {
//     out: {inline: 1},
//     finalize: finalize
// }

// printjson(db.people.mapReduce(mapper, reducer, options))

// 5. Średnia i łączna ilość środków na kartach kredytowych
// kobiet narodowości polskiej 
// w podziale na waluty.

// var mapper = function() {
//     this.credit.forEach(card => {
//         emit(card.currency, parseFloat(card.balance))
//     });
    
// }

// var reducer = function(currency, balances) {
//     return {count: balances.length, totalBalance: Array.sum(balances)}
// }

// var finalize = function(nationality, values) {
//     return {totalBalance: values.totalBalance, avgBalance: values.totalBalance/values.count}
// }

// const options = {
//     query: {sex: "Female", nationality: "Poland"},
//     out: {inline: 1},
//     finalize: finalize
// }

// printjson(db.people.mapReduce(mapper, reducer, options))