import requests
import sys

def main():
    if len(sys.argv) < 2:
        print("Missing command line argument")
        sys.exit()
    elif len(sys.argv) > 2:
        print("Too many command line arguments")
        sys.exit()
    
    try:
        amount = float(sys.argv[1])
    except ValueError:
        print("Command-line argument is not a number")
        sys.exit()
    try:
        response = requests.get("https://api.coindesk.com/v1/bpi/currentprice.json")
    except requests.RequestException:
        sys.exit()
    else:
        o = response.json()
        # 1. Get the rate from the JSON
        price = o["bpi"]["USD"]["rate"]
        # 2. Remove commas
        price = price.replace(",", "")
        # 3. Convert to float
        price = float(price)

        print("$", f"{(price * amount):,.4f}", sep="")

main()