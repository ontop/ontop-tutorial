# Interact with an Ontop SPARQL Endpoint

An Ontop Endpoint is accessible by the standard [HTTP protocol](https://www.w3.org/TR/sparql11-protocol/)

## URL of the Ontop SPARQL Endpoint

If the endpoint is created by RDF4J Workbench (using Tomcat or Jetty),
the URL looks like:
`http://localhost:8080/rdf4j-server/repositories/<repo_name>`

If the endpoint is created by the Ontop CLI or Docker, the URL looks like:
`http://localhost:8080/sparql`

### Http Request

You can use POST or GET requests:

For example, with POST:

```http
POST http://localhost:8080/sparql
Content-Type: application/sparql-query
Accept: application/json

PREFIX : <http://example.org/voc#>
SELECT DISTINCT ?teacher {
  ?teacher a :Teacher .
}
```

### Using Curl

The above request can be send with cURL command:

```console
curl --request POST \
  --url http://localhost:8080/sparql \
  --header 'accept: application/json' \
  --header 'content-type: application/sparql-query' \
  --data 'PREFIX : <http://example.org/voc#> SELECT DISTINCT ?teacher {?teacher a :Teacher .}'
```