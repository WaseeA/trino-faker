ARG TRINO_VERSION
FROM nineinchnick/trino-core:$TRINO_VERSION

ARG VERSION

ADD target/basic-project-$VERSION/ /usr/lib/trino/plugin/example_connector/
ADD catalog/example_connector.properties /etc/trino/catalog/example_connector.properties
