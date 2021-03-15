[QueryItem="station_sensor"]
PREFIX : <http://example.org/weather#>
SELECT *
{
 ?station a :WeatherStation ; :hasSensor ?sensor .
}
LIMIT 10

[QueryItem="station_temperature"]
PREFIX : <http://example.org/weather#>
SELECT *
{
 ?station a :WeatherStation ; :hasSensor ?sensor .
 ?sensor a :TemperatureSensor .
}
LIMIT 10

[QueryItem="temperature_today"]
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX : <http://example.org/weather#>
SELECT *
{
 ?station a :WeatherStation ; :hasSensor ?sensor .
 ?sensor a :TemperatureSensor ; :hasMeasurement ?m .
 ?m :hasDate "2018-07-03"^^xsd:date
}
LIMIT 10

[QueryItem="last_update"]
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX : <http://example.org/weather#>
SELECT *
{
 ?station a :WeatherStation ; :hasSensor ?sensor .
 ?sensor :lastUpdate ?ts .
}
LIMIT 10

[QueryItem="station_and_observation"]
PREFIX geo: <http://www.opengis.net/ont/geosparql#>
PREFIX sosa: <http://www.w3.org/ns/sosa/>
PREFIX : <http://example.org/weather#>
SELECT *
{
  ?station a :WeatherStation ; :hasSensor ?sensor ; :longitude ?lon; :latitude ?lat .
  ?sensor sosa:madeObservation ?o .
  ?o sosa:hasSimpleResult ?v .
  ?o sosa:resultTime ?t .
}
LIMIT 100
