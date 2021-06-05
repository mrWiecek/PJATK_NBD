printjson(
    db.people.aggregate(
        {
            $project: {
                "bmi": { $divide: [{ $toDouble: "$weight" }, { $pow: [{ $toDouble: "$height" }, 2] }] },
                nationality: 1
            }
        },
        { $group: { _id: "$nationality", avg_bmi: { $avg: "$bmi" }, max_bmi: { $max: "$bmi" }, min_bmi: { $min: "$bmi" } }, }
    )
)