import boto3

def print_all_services(services_list):
    """
    Prints all services available in aws, separated by commas
    :param service_list: list of the services
    """
    print(*services_list, sep=", ")

def print_services_by_region(services_list, session):
    """
    Prints for each aws service, in which region it is available 
    :param service_list: list of the services
           session: boto3 session
    """
    for service in services_list:
        regions = session.get_available_regions(service)
        if regions:
            print("Service: {} available in the following regions:".format(service))
            print(*regions, sep=", ")
        else:
            print("Service: {} is not available in any region".format(service))

def print_available_resources(session):
    """
    Prints all resources available in aws 
    :param session: boto3 session
    """
    print(session.get_available_resources())

def print_ec2_my_details(ec2_client):
    """
    Prints details of services under ec2 that I use
    :param ec2_client: ec2 client console
    """
    # list part of ec2 details for example
    print("My instances:")
    response = ec2_client.describe_instances()
    for each_item in response['Reservations']:
        print(each_item)
    print("\nMy route tables:")
    response = ec2_client.describe_route_tables()
    for each_item in response['RouteTables']:
        print(each_item)
    print("\nMy subnets:")
    response = ec2_client.describe_subnets()
    for each_item in response['Subnets']:
        print(each_item)
    print("\nVpcs:")
    response = ec2_client.describe_vpcs()
    for each_item in response['Vpcs']:
        print(each_item)

session = boto3.session.Session()
services_list = session.get_available_services()

print("Hello! this script will give you information about the AWS services used region wise.\nBelow is the list of all services available in AWS:")
print_all_services(services_list)
print("\nBelow is the list of all services available for each region:")
print_services_by_region(services_list, session)
print("\nList of the available resources in AWS:")
print_available_resources(session)

# create resources console, the same for other services in used
#iam_client = session.client(service_name="iam")
ec2_client = session.client(service_name="ec2")
print("\nDetails of services under ec2 that I use")
print_ec2_my_details(ec2_client)
