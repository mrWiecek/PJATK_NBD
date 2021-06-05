printjson(
    db.people.insertOne(
        {
            "sex": "Male",
            "first_name": "Mateusz",
            "last_name": "Więckowski",
            "job": "CEO",
            "email": "mw@google.gov.pl",
            "location": {
                "city": "Olympus Mons",
                "address": {
                    "streetname": "No Oxygen",
                    "streetnumber": "03661"
                }
            },
            "description": "To the moon!",
            "height": "192.68",
            "weight": "88.37",
            "birth_date": "1995-05-23T16:10:58Z",
            "nationality": "Marsian",
            "credit": [
                {
                    "type": "jcb",
                    "number": "4017957170327",
                    "currency": "EUR",
                    "balance": "10000000.86"
                }
            ]
        },
    )
)