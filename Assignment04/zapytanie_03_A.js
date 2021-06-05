printjson(
    db.people.aggregate(
        { $group: { _id: null, value: { $addToSet: "$job" } } },
        { $project: { jobs: "$value", _id: 0 } }
    )
)