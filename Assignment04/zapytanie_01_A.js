printjson(
    db.people.aggregate(
        { $group: { _id: "$sex", avg_weight: { $avg: { $toDouble: "$weight" } }, avg_height: { $avg: { $toDouble: "$height" } } } },
        { $project: { sex: "$_id", avg_weight: "$avg_weight", avg_height: "$avg_height", _id: 0 } }
    )
)