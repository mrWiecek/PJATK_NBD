var mapper = function() {
    emit(this.nationality, { count: 1, BMI: this.weight/this.height**2 })
}

var reducer = function(nationality, values) {
    reducedValues = {count: values[0].count, minBMI: values[0].BMI, maxBMI: values[0].BMI, sumBMI: values[0].BMI}
    for (let i = 1; i < values.length; i++) {
        const currentValues = values[i];

        reducedValues.minBMI = Math.min(currentValues.BMI, reducedValues.minBMI)
        reducedValues.maxBMI = Math.max(currentValues.BMI, reducedValues.maxBMI)
        reducedValues.sumBMI += currentValues.BMI
    }

    return reducedValues
}

var finalize = function(nationality, values) {
    results = {minBMI: values.minBMI, maxBMI: values.maxBMI, avgBMI: 0}
    results.avgBMI = values.sumBMI/ values.count
    return results
}

const options = {
    out: {inline: 1},
    finalize: finalize
}

printjson(db.people.mapReduce(mapper, reducer, options))