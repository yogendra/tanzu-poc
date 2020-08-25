#!/usr/bin/env bash
# Copyright 2020 The TKG Contributors.
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
SCRIPT_ROOT=$( cd `dirname $0`; pwd)
source $SCRIPT_ROOT/.env


TKG_DIR=${HOME}/.tkg
BOM_DIR=${TKG_DIR}/bom
TKG_CUSTOM_IMAGE_REPOSITORY=$LOCAL_REGISTRY

for TKG_BOM_FILE in "$BOM_DIR"/*.yaml; do
    # Get actual image repository from BoM file
    actualImageRepository=$(yq r "$TKG_BOM_FILE" imageConfig.imageRepository | tr -d '"')

    # Iterate through BoM file to create the complete Image name
    # and then pull, retag and push image to custom registry
    yq r --tojson "$TKG_BOM_FILE" images | jq -c '.[]' | while read -r i; do
        # Get imagePath and imageTag
        imagePath=$(jq .imagePath <<<"$i" | tr -d '"')
        imageTag=$(jq .tag <<<"$i" | tr -d '"')

        # create complete image names
        actualImage=$actualImageRepository/$imagePath:$imageTag
        customImage=$TKG_CUSTOM_IMAGE_REPOSITORY/$imagePath:$imageTag

        echo "Migrating image $actualImage => $customImage"
        docker pull $actualImage
        docker tag  $actualImage $customImage
        docker push $customImage
    done
done



if  grep TKG_CUSTOM_IMAGE_REPOSITORY:  $TKG_DIR/config.yaml
then 
    echo "Replace TKG_CUSTOM_IMAGE_REPOSITORY in config"
    sed -i '' "s/TKG_CUSTOM_IMAGE_REPOSITORY: .*$/TKG_CUSTOM_IMAGE_REPOSITORY: $TKG_CUSTOM_IMAGE_REPOSITORY/g" $TKG_DIR/config.yaml
else 
    echo "Add  TKG_CUSTOM_IMAGE_REPOSITORY to config"
    echo "TKG_CUSTOM_IMAGE_REPOSITORY: $TKG_CUSTOM_IMAGE_REPOSITORY" >> ${TKG_DIR}/config.yaml
fi


