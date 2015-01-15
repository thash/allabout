$ cat users.json | jq '.users[] | select(.age < 25)'
{
  "name": "Alice",
  "age": 24,
  "lang": "Ruby"
}
