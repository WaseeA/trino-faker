Trino Plugin
============

[![Build Status](https://github.com/nineinchnick/trino-example-plugin/actions/workflows/release.yaml/badge.svg)](https://github.com/nineinchnick/trino-example-plugin/actions/workflows/release.yaml)

This is a [Trino](http://trino.io/) plugin that provides a connector.

# Quick Start

To run a Docker container with the connector, run the following:
```bash
docker run \
  -d \
  --name basic-project \
  -p 8080:8080 \
  nineinchnick/trino-example-plugin:0.1
```

Then use your favourite SQL client to connect to Trino running at http://localhost:8080

## Usage

Download one of the ZIP packages, unzip it and copy the `basic-project-0.1` directory to the plugin directory on every node in your Trino cluster.
Create a `example_connector.properties` file in your Trino catalog directory and set all the required properties.

```
connector.name=example_connector
```

After reloading Trino, you should be able to connect to the `example_connector` catalog.

## Build

Run all the unit tests:
```bash
mvn test
```

Creates a deployable zip file:
```bash
mvn clean package
```

Unzip the archive from the target directory to use the connector in your Trino cluster.
```bash
unzip target/*.zip -d ${PLUGIN_DIRECTORY}/
mv ${PLUGIN_DIRECTORY}/basic-project-* ${PLUGIN_DIRECTORY}/basic-project
```

## Debug

To test and debug the connector locally, run the `ExampleQueryRunner` class located in tests:
```bash
mvn test-compile exec:java -Dexec.mainClass="archetype.it.ExampleQueryRunner" -Dexec.classpathScope=test
```

And then run the Trino CLI using `trino --server localhost:8080 --no-progress` and query it:
```
trino> show catalogs;
 Catalog
---------
 example_connector
 system
(2 rows)

trino> show tables from example_connector.default;
   Table
------------
 single_row
(1 row)

trino> select * from example_connector.default.single_row;
 id |     type      |  name
----+---------------+---------
 x  | default-value | my-name
(1 row)
```
