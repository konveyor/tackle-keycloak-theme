FROM quay.io/keycloak/keycloak:12.0.3

ADD target/tackle-keycloak-theme-*.jar /opt/jboss/keycloak/standalone/deployments
