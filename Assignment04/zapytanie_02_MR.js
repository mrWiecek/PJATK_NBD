var mapper = function() {
    this.credit.forEach(card => {
        var key = card.currency
        var val = parseFloat(card.balance)
        emit(key, val)
    });
}

var reducer = function(card, balance) {
    return Array.sum(balance)
}

const options = {
    out: {inline: 1}
}

printjson(db.people.mapReduce(mapper, reducer, options))