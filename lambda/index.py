import json

import pandas as pd


def handler(event, context):
    df = pd.DataFrame({"id": [1, 2], "value": ["foo", "boo"]})
    print(df)

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "This is a container lambda."
        })
    }
