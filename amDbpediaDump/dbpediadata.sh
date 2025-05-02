# Step 1: Get the SPARQL query for the collection
query=$(curl -s -H "Accept:text/sparql" https://databus.dbpedia.org/purplebee/collections/am_chapter)

# Step 2: Run the query to get download URLs in CSV format
files=$(curl -s -X POST \
  -H "Accept: text/csv" \
  --data-urlencode "query=${query}" \
  https://databus.dbpedia.org/sparql \
  | tail -n +2 | sed 's/\r$//' | sed 's/"//g')

# Step 3: Download each file using wget
while IFS= read -r file; do
  echo "Downloading: $file"
  wget "$file"
done <<< "$files"
