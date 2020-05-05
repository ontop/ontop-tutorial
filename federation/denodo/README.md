
# Ontop with Denodo

NB: You might also consult the following presentation, which shows screenshots for
some of the steps described below:  
<https://github.com/ontop/ontop-examples/blob/master/cikm-2018-tutorial/4-obdi-demo.pdf>

### 1. Set up Denodo.

#### Download Denodo Express 

Download it from <https://www.denodo.com/en/denodo-platform/denodo-express>  
(register, download the platform and the licence file)

Unzip the file and run the installer.

Note: environment variable `JAVA_HOME` must be set

#### Running Denodo

```console
<DenodoInstallationPath>/bin/denodoPlatform.sh
```

- Select the 'Virtual DataPort' tab
- Start 'Virtual DataPort Server'
- Press the 'Launch' button
- Login with:  
    . Login: `admin`  
	. Password: `admin`  
	. Server: `//localhost:9999/admin`
	
### 2. Configure datasets with Denodo

NB: instead of doing the following step by step, you can also load [this SQL script](bzopendata.sql) directly within Denodo.

#### Create a database

We will create two data sources based on web APIs.  
First, a Web API with weather data.

- Administration -> Database Management -> New  
- Name the database `bzopendata` for instance (leave the rest to default values), and click on the 'OK' button
- In the left window, right-clik on the bzopendata database -> New -> Data Source -> JSON
- In the field 'Name', enter `stations`
- In the field 'Data route', select 'HTTP Client'
- Click on the 'Configure' button to enter the URL of the source:  
<http://daten.buergernetz.bz.it/services/meteo/v1/stations>
- Click on 'OK', and then press the 'Save' button to save the data source

Then add a second data source for sensor data, repeating all the operations above, but:  
- in the field 'Name', enter `sensors`,
- use the URL:
<http://daten.buergernetz.bz.it/services/meteo/v1/sensors>

### 3. Configure the datasources


Select a data source, and click on 'Create base view'
- for stations: use the default "tuple root" (`/JSONFile`)
- for sensors: use the "tuple root": `/JSONFile/JSONArray` (uncheck the checkbox 'JSON root')

Click on 'Save'.

For stations, click on the 'Execution panel' button, and then the button 'Execute'

We get only one result --> We need to flatten the data:
- In the left window, right-click on {}stations -> New -> flatten
 (to display the data sources, you may need to right-click on 'bzopendata' -> 'Refresh')
- Right click on the row 'features' ine the table -> 'Flatten array "features"'
- Click on 'Save': this creates a new view 'f_stations'

Optionally, one may want to select only certain columns in this view:
- In the left window, right-click on 'f_stations' -> New -> Selection  
- Select the 'Output' tab and choose which fields to keep in the output
- Click on 'Save': this will create a new view 'p_f_stations'

### 4. Configure Ontop-protege to use a Denodo datasource

- Install the Denodo JDBC driver:
 Within Protege: File -> Preferences -> 'JDBC Drivers' tab -> Add  
    . Description: `Denodo`  
    . Class name: `com.denodo.vdp.jdbc.Driver`  
    . Driver File (jar): browse to `<DenodoInstallationPath>/tools/client-drivers/jdbc/denodo-vdp-jdbcdriver.jar`  

- For the connection, in your Datasource manager, use:  
    . Connection url: `jdbc:vdb://localhost:9999/bzopendata`  
    . Database Username: `admin`  
    . Database Password: `admin`  
    . Driver class: `com.denodo.vdp.jdbc.Driver`

### 5. Create the ontology and mapping and and try some SPARQL queries

You can use directly the files we have prepared:
- [bzweather.obda](bzweather.obda)
- [bzweather.owl](bzweather.owl)
- [bzweather.properties](bzweather.properties)
- [bzweather.q](bzweather.q)

### 6. Setup a SPARQL endpoint with Command Line Interface

#### Configure Ontop CLI

Add the JDBC denodo driver for the Ontop CLI:

```console
cp <DenodoInstallationPath>/tools/client-drivers/jdbc/denodo-vdp-jdbcdriver.jar
<OntopInstallationPath>/jdbc
```

Run the Ontop CLI:
```console
ontop endpoint -t bzweather.owl -m bzweather.obda -p bzweather.properties --cors-allowed-origins='*'
```

#### Access the SPARQL endpoint

Open <http://localhost:8080/>

Run an example SPARQL query:

```sparql
PREFIX geo: <http://www.opengis.net/ont/geosparql#>
PREFIX sosa: <http://www.w3.org/ns/sosa/>
PREFIX : <http://example.org/weather#>
SELECT *
{
  ?station a :WeatherStation ; geo:asWKT ?wkt; :hasSensor ?sensor ; :longitude ?lon; :latitude ?lat .
  ?sensor sosa:madeObservation ?o .
  ?o sosa:hasSimpleResult ?wktLabel .
  ?o sosa:resultTime ?t .
}
LIMIT 100
```
