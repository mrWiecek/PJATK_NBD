printjson(
    db.people.aggregate(
        { $match: { nationality: { $eq: "Poland" }, sex: { $eq: "Female" } } },
        { $unwind: "$credit" },
        {
            $group: {
                _id: "$credit.currency",
                average_balance: { $avg: { $toDouble: "$credit.balance" } },
                total_balance: { $sum: { $toDouble: "$credit.balance" } }
            }
        }
    )
)