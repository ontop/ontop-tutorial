Tutorial "Ontology-Based Data Access with Ontop"
=====================================================================================================

Requirements
------------

* [Java 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* Latest version of Ontop from [GitHub](https://github.com/ontop/ontop/releases) or [SourceForge](https://sourceforge.net/projects/ontop4obda/files/)
* H2 with preloaded datasets [h2.zip](./h2.zip)
* [Git](https://git-scm.com/)

Clone this repository
---------------------

Before start, please clone this repository in order to download all the files

```console
git clone https://github.com/ontop/ontop-tutorial.git
```

Program
-------

1. [Basics of OBDA System Modeling and Usage](basic)
    * [Mapping the first data source](basic/university-1.md)
    * [Mapping the second data source](basic/university-2.md)
2. [Deploying an Ontop SPARQL endpoint](endpoint)
    * [Using Ontop CLI](endpoint/endpoint-cli.md)
    * [Using Ontop Docker image](endpoint/endpoint-docker.md)
    * [Using Ontop Tomcat bundle](endpoint/endpoint-tomcat.md)    
3. [Interacting with an Ontop SPARQL endpoint](interact)
    * [Command Line Tools (curl, http)](interact/cli.md)
4. [Mapping Engineering](mapping)
    * [Role of primary keys](mapping/primary-keys.md)
    * [Role of foreign keys](mapping/foreign-keys.md)
    * [Choice of the URI templates](mapping/uri-templates.md)
    * [Bonus: existential reasoning](mapping/existential.md)
5. [Federating multiple databases](federation)
    * [Ontop with Dremio](federation/dremio/README.md)
    * [Ontop with Denodo](federation/denodo/README.md)
6. [Ontop API](api)
