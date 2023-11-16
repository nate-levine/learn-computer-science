import json
import requests
import sys

if len(sys.argv) != 2:
    sys.exit()

# Query ITunes with the requests API. It requests 50 tracks from the specified artist
response = requests.get("https://itunes.apple.com/search?entity=song&limit=50&term=" + sys.argv[1])
# Print the response in JSON format
# Format data more clearly with the JSON package, and indent each sub-list by 2
    # print(json.dumps(response.json(), indent=2))
# Store the respone in JSON format
o = response.json()
for result in o["results"]:
    print(result["trackName"])