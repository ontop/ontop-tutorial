SPARQL endpoint deployment using Ontop Tomcat/RDF4J bundle
==========================================================

## Apache Tomcat setup

Procedure:

1. Download and unzip the Tomcat bundle `ontop-tomcat-bundle-[version].zip` from [GitHub](https://github.com/ontop/ontop/releases) or [SourceForge](https://sourceforge.net/projects/ontop4obda/files/)
2. Copy the driver file of H2 [`jdbc/h2-1.4.196.jar`](jdbc/h2-1.4.196.jar) to the `lib` directory of tomcat  
3. Start tomcat from the *`bin` folder* using the commands: 
	* On Mac/Linux: using the terminal run `sh catalina.sh run`.
	* On Windows: click on the executable `startup.bat`.
4. Connect to RDF4J Workbench at http://localhost:8080/rdf4j-workbench/ .
5. You will be automatically redirected to the repositories view .

## Setting up a Ontop Virtual RDF Repository using the RDF4J Workbench

1. The files needed are under the [input](input) directory:
	- the OWL ontology file [input/university-complete.ttl](input/university-complete.ttl)
	- the mapping file [input/university-complete.obda](input/university-complete.obda)
	- the properties file [input/university-complete.properties](input/university-complete.properties) 

2. Click on *New repository*
  * Select *Ontop Virtual RDF Store* from the list.
  * Give an ID to your new repository (ex: `Session1Repo`)
  * Give optionally also a descriptive title (ex: Universities Repository)
  * Click on *Next*.

3. On the next page:
  * Type in the path of the ontology file *university-complete.ttl* using the separator '/' (ex: `C:/Users/Me/ontop-tutorial/endpoint/input/university-complete.ttl`)
  * Type in the path of the obda file *university-complete.obda* using the separator '/' (ex: `C:/Users/Me/ontop-v3-tutorial/endpoint/input/university-complete.obda`)
  * Keep the default options.
  * Click on *Create*.

6. The *Summary* page contains your newly created repository's SPARQL endpoint URL (as Location).

## Querying 

1. We can query the newly created repository by clicking on the *Query* submenu .
2. Run the following query clicking on *Execute*:

```sparql
PREFIX : <http://example.org/voc#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT DISTINCT ?prof ?lastName {
  ?prof a :FullProfessor ; foaf:lastName ?lastName .
}
```

## Querying the SPARQL endpoint with curl

```console
curl  -H 'Accept: application/json' \
-G http://localhost:8080/rdf4j-server/repositories/Session1Repo \
--data-urlencode query='
PREFIX : <http://example.org/voc#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT DISTINCT ?prof ?lastName {
  ?prof a :FullProfessor ; foaf:lastName ?lastName .
}
'
```
