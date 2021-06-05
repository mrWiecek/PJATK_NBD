var mapper = function() {
    emit(this.sex, {count: 1, height: parseFloat(this.height), weight: parseFloat(this.weight)})
}

var reducer = function(sex, values) {
    reducedVals = {count: 0, height: 0, weight: 0}
    values.forEach(val => {
        reducedVals.count += val.count
        reducedVals.height += val.height
        reducedVals.weight += val.weight
    })
    return reducedVals
}

var finalize = function(sex, reducedVals) {
    averagedVals = {avgHeight: 0, avgWeight: 0}
    averagedVals.avgHeight = reducedVals.height/reducedVals.count
    averagedVals.avgWeight = reducedVals.weight/reducedVals.count

    return averagedVals
}

const options = {
    out: {inline: 1},
    finalize: finalize
}

printjson(db.people.mapReduce(mapper, reducer, options))