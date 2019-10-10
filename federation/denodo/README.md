
# Ontop with Denodo

NB: You might also consult the following presentation, which shows screenshots for
some of the steps described below:\
<https://github.com/ontop/ontop-examples/blob/master/cikm-2018-tutorial/4-obdi-demo.pdf>

### 1. Set up Denodo.

#### Download Denodo Express 

Download it from <https://www.denodo.com/en/denodo-platform/denodo-express> \
(register, download the platform and the licence file)

Unzip the file and run the installer.

Note: environment variable `JAVA_HOME` must be set

#### Running Denodo

```console
/Applications/DenodoPlatform7.0/bin/DenodoPlatform.sh
```

- Select 'Virtual DataPort' tab
- Start 'Virtual DataPort Server'
- Press 'LAUNCH' button
- Login with 'admin' 'admin'

### 2. Configure datasets in Dremio

NB: instead of doing the following step by step, you can also load `bzopendata.sql` directly to Denodo

#### Create database

-> Administration -> Database Management -> New
Call the database e.g. bzopendata (leave the rest to the defaults)

Right-clik bzopendata database -> New -> Data Source -> JSON
Data route 'HTTP Client' -> Configure button

#### Connect datasources

(press Save icon for each source)

- Weather Stations \
    name: stations \
    Web API: http://daten.buergernetz.bz.it/services/meteo/v1/stations
    
- Sensor Data  \
    name: sensors \
    Web API: http://daten.buergernetz.bz.it/services/meteo/v1/sensors

### 3. Configure datasources

Open the datasources in a web browser to understand their structure.

For each datasource: Create base view
- for stations: use default Tuple root
- for sensors: use Tuple root: `/JSONFile/JSONArray` (click on checkbox JSON root)

For stations, try to run 'Execution panel' button, then Execute

We get only one result --> We need to flatten the data:
- Right click {}stations -> New -> flatten
- Enlarge window with data
- Right click features -> Flatten array 'features'
- Save the result, which creates a new view f_stations

Selection:
- Right click f_stations -> New -> Selection  
- Select Output tab and specify what to keep in the output
- Unfold properties and right-click each subfield and select 'Project field ...'

### 4. Configure Ontop-protege to use a Denodo datasource

Install the Denodo JDBC driver:
- Protege -> Preferences -> JDBC Drivers tab -> Add
- Description: Denodo
- Class name: `com.denodo.vdp.jdbc.Driver`
- Driver File (jar): browse to `/.../DenodoPlatform7.0/tools/client-drivers/jdbc/denodo-vdp-jdbcdriver.jar`

For the connection in your Datasource manager use:

- Connection url: `jdbc:vdb://localhost:9999/bzopendata`
- Database Username: `admin`
- Database Password: `admin`
- Driver class: `com.denodo.vdp.jdbc.Driver`

### 5. Create the ontology and mapping and and try some SPARQL queries

You can use directly the files we have prepared

```
.
├── bzweather.obda
├── bzweather.owl
├── bzweather.properties
└── bzweather.q
```

### 6. Setup a SPARQL endpoint with Command Line Interface

#### Configure Ontop CLI

Add the JDBC denodo driver for the Ontop CLI:

```console
cp /.../DenodoPlatform7.0/tools/client-drivers/jdbc/denodo-vdp-jdbcdriver.jar
/.../ontop-3.0.0-beta-3/jdbc
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

<!-- 5.3 Visualize the results using a simple webpage using YASGUI (which is part of
    the endpoint) -->

