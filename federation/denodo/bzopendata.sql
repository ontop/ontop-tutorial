# Generated with Denodo Platform 7.0 update 20190903.

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
    TUPLEROOT '/JSONFile/JSONArray'
    OUTPUTSCHEMA (jsonfile = 'JSONFile' : REGISTER OF (
        scode = 'JSONFile.JSONArray.SCODE' : 'java.lang.String',
        type = 'JSONFile.JSONArray.TYPE' : 'java.lang.String',
        desc_d = 'JSONFile.JSONArray.DESC_D' : 'java.lang.String',
        desc_i = 'JSONFile.JSONArray.DESC_I' : 'java.lang.String',
        desc_l = 'JSONFile.JSONArray.DESC_L' : 'java.lang.String',
        unit = 'JSONFile.JSONArray.UNIT' : 'java.lang.String',
        date = 'JSONFile.JSONArray.DATE' : 'java.lang.String',
        value = 'JSONFile.JSONArray.VALUE' : 'java.lang.Double'
    )
    );

DROP WRAPPER JSON IF EXISTS stations CASCADE;

CREATE WRAPPER JSON stations
    DATASOURCENAME=stations
    TUPLEROOT '/JSONFile'
    OUTPUTSCHEMA (jsonfile = 'JSONFile' : REGISTER OF (
        type = 'type' : 'java.lang.String',
        name = 'name' : 'java.lang.String',
        crs = 'crs' : REGISTER OF (
            type = 'type' : 'java.lang.String',
            properties = 'properties' : REGISTER OF (
                name = 'name' : 'java.lang.String'
            )
        ),
        features = 'features' : ARRAY OF (
            features = 'features' : REGISTER OF (
                type = 'type' : 'java.lang.String',
                geometry = 'geometry' : REGISTER OF (
                    type = 'type' : 'java.lang.String',
                    coordinates = 'coordinates' : ARRAY OF (
                        coordinates = 'coordinates' : REGISTER OF (
                            field_0 = 'field_0' : 'java.lang.Double'
                        )
                    )
                ),
                properties = 'properties' : REGISTER OF (
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
DROP TYPE IF EXISTS stations_crs_properties CASCADE;

CREATE TYPE stations_crs_properties AS REGISTER OF (name:text);

DROP TYPE IF EXISTS stations_features_features_geometry_coordinates_coordinates CASCADE;

CREATE TYPE stations_features_features_geometry_coordinates_coordinates AS REGISTER OF (field_0:double);

DROP TYPE IF EXISTS stations_features_features_properties CASCADE;

CREATE TYPE stations_features_features_properties AS REGISTER OF (scode:text, name_d:text, name_i:text, name_l:text, name_e:text, alt:double, long:double, lat:double);

DROP TYPE IF EXISTS stations_crs CASCADE;

CREATE TYPE stations_crs AS REGISTER OF (type:text, properties:stations_crs_properties);

DROP TYPE IF EXISTS stations_features_features_geometry_coordinates CASCADE;

CREATE TYPE stations_features_features_geometry_coordinates AS ARRAY OF stations_features_features_geometry_coordinates_coordinates;

DROP TYPE IF EXISTS stations_features_features_geometry CASCADE;

CREATE TYPE stations_features_features_geometry AS REGISTER OF (type:text, coordinates:stations_features_features_geometry_coordinates);

DROP TYPE IF EXISTS stations_features_features CASCADE;

CREATE TYPE stations_features_features AS REGISTER OF (type:text, geometry:stations_features_features_geometry, properties:stations_features_features_properties);

DROP TYPE IF EXISTS stations_features CASCADE;

CREATE TYPE stations_features AS ARRAY OF stations_features_features;

# #######################################
# MAPS
# #######################################
# No maps
# #######################################
# BASE VIEWS
# #######################################
DROP VIEW IF EXISTS sensors CASCADE;

CREATE TABLE sensors I18N us_pst (
        scode:text, 
        type:text, 
        desc_d:text, 
        desc_i:text, 
        desc_l:text, 
        unit:text, 
        date:text, 
        value:double
    )
    CACHE OFF
    TIMETOLIVEINCACHE DEFAULT
    ADD SEARCHMETHOD sensors(
        I18N us_pst
        CONSTRAINTS (
             ADD scode NOS ZERO ()
             ADD type NOS ZERO ()
             ADD desc_d NOS ZERO ()
             ADD desc_i NOS ZERO ()
             ADD desc_l NOS ZERO ()
             ADD unit NOS ZERO ()
             ADD date NOS ZERO ()
             ADD value NOS ZERO ()
        )
        OUTPUTLIST (date, desc_d, desc_i, desc_l, scode, type, unit, value
        )
        WRAPPER (json sensors)
    );

DROP VIEW IF EXISTS stations CASCADE;

CREATE TABLE stations I18N us_pst (
        type:text, 
        name:text, 
        crs:stations_crs, 
        features:stations_features
    )
    CACHE OFF
    TIMETOLIVEINCACHE DEFAULT
    ADD SEARCHMETHOD stations(
        I18N us_pst
        CONSTRAINTS (
             ADD type NOS ZERO ()
             ADD name NOS ZERO ()
             ADD crs NOS ZERO ()
             ADD crs.type NOS ZERO ()
             ADD crs.properties NOS ZERO ()
             ADD crs.properties.name NOS ZERO ()
             ADD features NOS ZERO ()
             ADD features NOS ZERO ()
             ADD features.type NOS ZERO ()
             ADD features.geometry NOS ZERO ()
             ADD features.geometry.type NOS ZERO ()
             ADD features.geometry.coordinates NOS ZERO ()
             ADD features.geometry.coordinates NOS ZERO ()
             ADD features.geometry.coordinates.field_0 NOS ZERO ()
             ADD features.properties NOS ZERO ()
             ADD features.properties.scode NOS ZERO ()
             ADD features.properties.name_d NOS ZERO ()
             ADD features.properties.name_i NOS ZERO ()
             ADD features.properties.name_l NOS ZERO ()
             ADD features.properties.name_e NOS ZERO ()
             ADD features.properties.alt NOS ZERO ()
             ADD features.properties.long NOS ZERO ()
             ADD features.properties.lat NOS ZERO ()
        )
        OUTPUTLIST (crs, features, name, type
        )
        WRAPPER (json stations)
    );

# #######################################
# VIEWS
# #######################################
DROP VIEW IF EXISTS f_stations CASCADE;

CREATE VIEW f_stations AS SELECT type, name, crs, features_type, geometry, properties, (properties).scode AS scode, (properties).name_d AS name_d, (properties).name_i AS name_i, (properties).name_l AS name_l, (properties).name_e AS name_e, (properties).alt AS alt, (properties).long AS long, (properties).lat AS lat FROM FLATTEN stations AS v ( v.features);

ALTER VIEW f_stations
 LAYOUT (stations = [20, 20, 487, 446]);

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
