#!/bin/bash

INFILE="image-list.txt"
OUTFILE="DELETE-manifest-instructions.sh"
HOST="https://my.docker.registry.com/v2"

cd . > ${OUTFILE}

for i in `cat ${INFILE}`; do

        NAME=`echo $i | awk -F: '{ print $1 }'`
        VERSIONS=`echo $i | awk -F: '{ print $2 }'`

        #CURL_OUT=`curl -s ${HOST}${NAME}/tags/list`
        #VERSIONS="A,B"
        #EXISTING_VERSIONS=(A B C)

        curl -s ${HOST}${NAME}/tags/list | jq -r -c '.tags[]' | while read ev; do

                FOUND=`echo "${VERSIONS}" | grep "${ev}"`

                #echo "VERSION: ${VERSIONS}, EV: ${ev}, FOUND: ${FOUND}"

                if [ "${FOUND}" == "" ]; then

                        echo "Deleting Tag ${NAME}:$ev"
                        DIGEST=`curl -v ${HOST}${NAME}/manifests/${ev} -H "Accept: application/vnd.docker.distribution.manifest.v2+json" 2>&1 | grep Docker-Content-Digest | awk '{print ($3)}'
                        echo curl -s -X DELETE ${HOST}${NAME}/manifests/${DIGEST} >> ${OUTFILE}

                fi

        done

done
                                                                                                                                                             1,1        Anfang
echo "delete commands written to ${OUTFILE}"
