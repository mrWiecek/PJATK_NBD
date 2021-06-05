var mapper = function() {
    this.credit.forEach(card => {
        emit(card.currency, parseFloat(card.balance))
    });
}

var reducer = function(currency, balances) {
    return {count: balances.length, totalBalance: Array.sum(balances)}
}

var finalize = function(currency, values) {
    return {totalBalance: values.totalBalance, avgBalance: values.totalBalance/values.count}
}

const options = {
    query: {sex: "Female", nationality: "Poland"},
    out: {inline: 1},
    finalize: finalize
}

printjson(db.people.mapReduce(mapper, reducer, options))