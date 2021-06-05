printjson(
    db.people.find(
        { "birth_date": { $gte: "2000", $lt: "2100" } },
        { "_id": 0, "first_name": 1, "last_name": 1, "location.city": 1 }
    )
.toArray())