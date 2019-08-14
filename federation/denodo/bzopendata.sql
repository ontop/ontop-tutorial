# Generated with Denodo Platform 7.0.

ENTER SINGLE USER MODE;
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# 0 ====================================================================

# #######################################
# DATABASE
# #######################################
DROP DATABASE IF EXISTS bzopendata;

CREATE DATABASE bzopendata '';

CONNECT DATABASE bzopendata;

# #######################################
# LISTENERS JMS
# #######################################
# No listeners jms
# #######################################
# DATASOURCES
# #######################################
DROP DATASOURCE JSON IF EXISTS sensors CASCADE;

CREATE DATASOURCE JSON sensors
    ROUTE HTTP 'http.CommonsHttpClientConnection,120000' GET 'http://daten.buergernetz.bz.it/services/meteo/v1/sensors'
    AUTHENTICATION OFF
    PROXY OFF;

DROP DATASOURCE JSON IF EXISTS stations CASCADE;

CREATE DATASOURCE JSON stations
    ROUTE HTTP 'http.CommonsHttpClientConnection,120000' GET 'http://daten.buergernetz.bz.it/services/meteo/v1/stations'
    AUTHENTICATION OFF
    PROXY OFF;

# #######################################
# DATABASE CONFIGURATION
# #######################################
ALTER DATABASE bzopendata
  CHARSET DEFAULT;

# #######################################
# WRAPPERS
# #######################################
DROP WRAPPER JSON IF EXISTS sensors CASCADE;

CREATE WRAPPER JSON sensors
    DATASOURCENAME=sensors
    TUPLEROOT '/JSONFile'
    OUTPUTSCHEMA (jsonfile = 'JSONFile' : REGISTER OF (
        jsonarray = 'JSONArray' : ARRAY OF (
            jsonarray = 'JSONArray' : REGISTER OF (
                scode = 'SCODE' : 'java.lang.String',
                type = 'TYPE' : 'java.lang.String',
                desc_d = 'DESC_D' : 'java.lang.String',
                desc_i = 'DESC_I' : 'java.lang.String',
                desc_l = 'DESC_L' : 'java.lang.String',
                unit = 'UNIT' : 'java.lang.String',
                date = 'DATE' : 'java.lang.String',
                value = 'VALUE' : 'java.lang.Double'
            )
        )
    )
    );

DROP WRAPPER JSON IF EXISTS stations CASCADE;

CREATE WRAPPER JSON stations
    DATASOURCENAME=stations
    TUPLEROOT '/JSONFile/features'
    OUTPUTSCHEMA (jsonfile = 'JSONFile' : REGISTER OF (
        name = 'name' : 'java.lang.String',
        type_0 = 'type' : 'java.lang.String',
        crs = 'crs' : REGISTER OF (
            type = 'type' : 'java.lang.String',
            properties = 'properties' : REGISTER OF (
                name = 'name' : 'java.lang.String'
            )
        ),
        type = 'JSONFile.features.type' : 'java.lang.String',
        geometry = 'JSONFile.features.geometry' : REGISTER OF (
            type = 'type' : 'java.lang.String',
            coordinates = 'coordinates' : ARRAY OF (
                coordinates = 'coordinates' : REGISTER OF (
                    field_0 = 'field_0' : 'java.lang.Double'
                )
            )
        ),
        properties = 'JSONFile.features.properties' : REGISTER OF (
            scode = 'SCODE' : 'java.lang.String',
            name_d = 'NAME_D' : 'java.lang.String',
            name_i = 'NAME_I' : 'java.lang.String',
            name_l = 'NAME_L' : 'java.lang.String',
            name_e = 'NAME_E' : 'java.lang.String',
            alt = 'ALT' : 'java.lang.Double',
            long = 'LONG' : 'java.lang.Double',
            lat = 'LAT' : 'java.lang.Double'
        )
    )
    );

# #######################################
# STORED PROCEDURES
# #######################################
# No stored procedures
# #######################################
# TYPES
# #######################################
DROP TYPE IF EXISTS sensors_jsonarray_jsonarray CASCADE;

CREATE TYPE sensors_jsonarray_jsonarray AS REGISTER OF (scode:text, type:text, desc_d:text, desc_i:text, desc_l:text, unit:text, date:text, value:double);

DROP TYPE IF EXISTS stations_crs_properties CASCADE;

CREATE TYPE stations_crs_properties AS REGISTER OF (name:text);

DROP TYPE IF EXISTS stations_geometry_coordinates_coordinates CASCADE;

CREATE TYPE stations_geometry_coordinates_coordinates AS REGISTER OF (field_0:double);

DROP TYPE IF EXISTS stations_properties CASCADE;

CREATE TYPE stations_properties AS REGISTER OF (scode:text, name_d:text, name_i:text, name_l:text, name_e:text, alt:double, long:double, lat:double);

DROP TYPE IF EXISTS sensors_jsonarray CASCADE;

CREATE TYPE sensors_jsonarray AS ARRAY OF sensors_jsonarray_jsonarray;

DROP TYPE IF EXISTS stations_crs CASCADE;

CREATE TYPE stations_crs AS REGISTER OF (type:text, properties:stations_crs_properties);

DROP TYPE IF EXISTS stations_geometry_coordinates CASCADE;

CREATE TYPE stations_geometry_coordinates AS ARRAY OF stations_geometry_coordinates_coordinates;

DROP TYPE IF EXISTS stations_geometry CASCADE;

CREATE TYPE stations_geometry AS REGISTER OF (type:text, coordinates:stations_geometry_coordinates);

# #######################################
# MAPS
# #######################################
# No maps
# #######################################
# BASE VIEWS
# #######################################
DROP VIEW IF EXISTS sensors CASCADE;

CREATE TABLE sensors I18N us_pst (
        jsonarray:sensors_jsonarray
    )
    CACHE OFF
    TIMETOLIVEINCACHE DEFAULT
    ADD SEARCHMETHOD sensors(
        I18N us_pst
        CONSTRAINTS (
             ADD jsonarray NOS ZERO ()
             ADD jsonarray NOS ZERO ()
             ADD jsonarray.scode NOS ZERO ()
             ADD jsonarray.type NOS ZERO ()
             ADD jsonarray.desc_d NOS ZERO ()
             ADD jsonarray.desc_i NOS ZERO ()
             ADD jsonarray.desc_l NOS ZERO ()
             ADD jsonarray.unit NOS ZERO ()
             ADD jsonarray.date NOS ZERO ()
             ADD jsonarray.value NOS ZERO ()
        )
        OUTPUTLIST (jsonarray
        )
        WRAPPER (json sensors)
    );

DROP VIEW IF EXISTS stations CASCADE;

CREATE TABLE stations I18N us_pst (
        name:text, 
        type_0:text, 
        crs:stations_crs, 
        type:text, 
        geometry:stations_geometry, 
        properties:stations_properties
    )
    CACHE OFF
    TIMETOLIVEINCACHE DEFAULT
    ADD SEARCHMETHOD stations(
        I18N us_pst
        CONSTRAINTS (
             ADD name NOS ZERO ()
             ADD type_0 NOS ZERO ()
             ADD crs NOS ZERO ()
             ADD crs.type NOS ZERO ()
             ADD crs.properties NOS ZERO ()
             ADD crs.properties.name NOS ZERO ()
             ADD type NOS ZERO ()
             ADD geometry NOS ZERO ()
             ADD geometry.type NOS ZERO ()
             ADD geometry.coordinates NOS ZERO ()
             ADD geometry.coordinates NOS ZERO ()
             ADD geometry.coordinates.field_0 NOS ZERO ()
             ADD properties NOS ZERO ()
             ADD properties.scode NOS ZERO ()
             ADD properties.name_d NOS ZERO ()
             ADD properties.name_i NOS ZERO ()
             ADD properties.name_l NOS ZERO ()
             ADD properties.name_e NOS ZERO ()
             ADD properties.alt NOS ZERO ()
             ADD properties.long NOS ZERO ()
             ADD properties.lat NOS ZERO ()
        )
        OUTPUTLIST (crs, geometry, name, properties, type, type_0
        )
        WRAPPER (json stations)
    );

# #######################################
# VIEWS
# #######################################
DROP VIEW IF EXISTS f_sensors CASCADE;

CREATE VIEW f_sensors
    PRIMARY KEY ( 'scode' , 'type' , 'date' ) AS SELECT scode AS scode, type AS type, desc_d AS desc_d, desc_i AS desc_i, desc_l AS desc_l, unit AS unit, date AS date, value AS value FROM FLATTEN sensors AS v ( v.jsonarray);

ALTER VIEW f_sensors
 LAYOUT (sensors = [20, 20, 227, 206]);

DROP VIEW IF EXISTS f_stations CASCADE;

CREATE VIEW f_stations
    PRIMARY KEY ( 'scode' ) AS SELECT stations.name AS name, stations.type_0 AS type_0, stations.crs AS crs, stations.type AS type, stations.geometry AS geometry, stations.properties AS properties, (stations.properties).scode AS scode, (stations.properties).name_d AS name_d, (stations.properties).name_i AS name_i, (stations.properties).name_l AS name_l, (stations.properties).name_e AS name_e, (stations.properties).long AS long, (stations.properties).lat AS lat, (stations.geometry).coordinates AS coordinates FROM stations;

ALTER VIEW f_stations
 LAYOUT (stations = [20, 20, 270, 186]);

# #######################################
# ASSOCIATIONS
# #######################################
# No associations
# #######################################
# WEBSERVICES
# #######################################
# No web services
# #######################################
# WIDGETS
# #######################################
# No widgets
# #######################################
# WEBCONTAINER WEB SERVICE DEPLOYMENTS
# #######################################
# No deployed web services
# #######################################
# WEBCONTAINER WIDGET DEPLOYMENTS
# #######################################
# No deployed widgets
# #######################################
# Closing connection with database bzopendata
# #######################################
CLOSE;




# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EXIT SINGLE USER MODE;
