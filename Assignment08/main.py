from riak import RiakClient
from typing import Dict

"""
Napisz program, który 
    1. Wrzucić do bazy dokument
    2. pobierze go 
    3. i wypisze, 
    4. zmodyfikuje go, 
    5. następnie pobierze 
    6. i wypisze, 
    7. a na końcu usunie go 
    8. i spróbuje pobrać z bazy.
"""
    
def addDocument(bucket: str, key:str, value:Dict):
    document = bucket.new(key, data=value)
    document.store()
    return document

def modifyDocument(document, data: Dict[str, str]):
    document.data[data["key"]] = data['value']
    document.store()
    return document

def deleteDocument(document):
    document.delete()
    return document


if __name__ == "__main__":

    # Setup connection, bucket and document
    client = RiakClient(pb_port=8087)
    bucket = client.bucket('s23433')
    documentKey = "ocean"
    documentValue= {
        'name' : "Ocean Protocol" ,
        'value' :  7,
        'valueMultiplier' : 10 ,
        'updatedData' : 20210605
    }
    
    # Add new document
    print('Adding new document...')
    oceanDocument = addDocument(bucket, documentKey, documentValue)
    print(f'Added Document: {oceanDocument.data}\n')

    # Modify newly added document
    print('Modyfing document...')
    oceanDocumentProperty = {"key": "value", "value": 15}
    oceanDocument = modifyDocument(oceanDocument, oceanDocumentProperty)
    print(f'Updated Document: {oceanDocument.data}\n')

    # Delete updated document
    print('Deleting document...')
    oceanDocument = deleteDocument(oceanDocument)
    print(f'Deleted Document: {oceanDocument.data}\n')
