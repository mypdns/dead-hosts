#!/bin/bash

GIT_DIR="$(git rev-parse --show-toplevel)"

# ***********************************************************
# Remove our inactive and invalid domains from PULL_REQUESTS
# ***********************************************************

grep -Ev "^($|#)" "${GIT_DIR}/output/domains.txt/domains/ACTIVE/list" > tempdomains.txt
mv tempdomains.txt ${GIT_DIR}/PULL_REQUESTS/domains.txt

dead="${GIT_DIR}/output/domains.txt/domains/INACTIVE/list"
inactive="${GIT_DIR}/PULL_REQUESTS/inactive.txt"

if [ -f "$dead" ]
then
 # cat "${dead}" | grep -Ev "^($|#)" >> "${inactive}"
 grep -Ev "^($|#)|${dead}" >> "${inactive}"
 sort -u -f "${inactive}" -o "${inactive}"
fi

if [ -f '${GIT_DIR}/PULL_REQUESTS/domains.txt']
then
    sort -u -f '${GIT_DIR}/PULL_REQUESTS/domains.txt' -o '${GIT_DIR}/PULL_REQUESTS/domains.txt'
fi

exit ${?}
