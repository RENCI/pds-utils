from tx.functional.either import Left, Right    

def isBundle(bundle):
    return isinstance(bundle, dict) and "resourceType" in bundle and bundle["resourceType"] == "Bundle"

    
def bundle(records, type = "searchset"):
    key = "request" if type == "batch" else "resource"
    return {
        "resourceType": "Bundle",
        "type": type,
        "entry": list(map(lambda record: {
            key: record
        }, records))
    }


def unbundle(bundle):
    if isBundle(bundle):
        if bundle["type"] == "batch":
            return Right(list(map(lambda a : a["request"], bundle.get("entry", []))))
        else:
            return Right(list(map(lambda a : a["resource"], bundle.get("entry", []))))
    else:
        return Left(str(bundle) + " is not a bundle")


