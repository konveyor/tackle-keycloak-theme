
#!/usr/bin/env bash
#
# Copyright © 2021 the Konveyor Contributors (https://konveyor.io/)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


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