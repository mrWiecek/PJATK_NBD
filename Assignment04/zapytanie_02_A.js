printjson(
    db.people.aggregate(
    { $unwind: "$credit" },
    { $group: { _id: "$credit.currency", value: { $sum: { $toDouble: "$credit.balance" } } } },
    {
        $project: {
            currency
                : "$_id", amount: "$value", _id: 0
        }
    }
))