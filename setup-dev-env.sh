
#!/usr/bin/env bash

KcVersion=12.0.3
wget https://github.com/keycloak/keycloak/releases/download/$KcVersion/keycloak-$KcVersion.tar.gz -P workspace/
tar xvzf workspace/keycloak-*.tar.gz -C workspace/

xmlstarlet ed \
-L \
-N s=urn:jboss:domain:14.0 \
-N su=urn:jboss:domain:keycloak-server:1.1 \
-u '/s:server/s:profile/su:subsystem/su:theme/su:staticMaxAge' -v "-1" \
-u '/s:server/s:profile/su:subsystem/su:theme/su:cacheThemes' -v "false" \
-u '/s:server/s:profile/su:subsystem/su:theme/su:cacheTemplates' -v "false" \
-u '/s:server/s:profile/su:subsystem/su:theme/su:dir' -v "$(pwd)/src/main/resources/theme" \
workspace/keycloak-*/standalone/configuration/standalone.xml

cp -r workspace/keycloak-*/themes/* src/main/resources/theme/

echo "You can start the server using ./workspace/keycloak-$KcVersion/bin/standalone.sh"