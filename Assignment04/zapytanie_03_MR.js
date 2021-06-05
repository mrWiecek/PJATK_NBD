var mapper = function() {
    emit(this.job, 1)
}

var reducer = function(job, constant) {
    return 1
}

const options = {
    out: {inline: 1}
}

printjson(db.people.mapReduce(mapper, reducer, options))