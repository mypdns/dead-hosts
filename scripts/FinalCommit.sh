#!/bin/bash

# ***********************************************************
# Remove our inactive and invalid domains from PULL_REQUESTS
# ***********************************************************

grep -Ev "^($|#)" ${GIT_DIR}/output/domains.txt/domains/ACTIVE/list > tempdomains.txt
mv tempdomains.txt ${GIT_DIR}/PULL_REQUESTS/domains.txt

dead="${GIT_DIR}/output/domains.txt/domains/INACTIVE/list"
inactive="${GIT_DIR}/PULL_REQUESTS/inactive.txt"

if [ -f "$dead" ]
then
 cat "${dead}" | grep -Ev "^($|#)" >> "${inactive}"
 sort -u -f "${inactive}" -o "${inactive}"
fi

exit ${?}
