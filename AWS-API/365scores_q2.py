import boto3

session = boto3.session.Session()
regions = session.get_available_regions('rds')

print(regions)

for region in regions:
    print("{}: ".format(region))
    session.get_available_services()