#!/bin/bash
# Hosts file generator for Badd Boyz Hosts
# Created by: Mitchell Krog (mitchellkrog@gmail.com)
# Copyright: Mitchell Krog - https://github.com/mitchellkrogza
# Repo Url: https://github.com/mitchellkrogza/Badd-Boyz-Hosts
# MIT License

# **********************************
# Setup input bots and referrer lists
# **********************************
GIT_DIR="$(git rev-parse --show-toplevel)"

input1="${GIT_DIR}/PULL_REQUESTS/domains.txt"

INACTIVE_LIST="${GIT_DIR}/PULL_REQUESTS/inactive.txt"

printf "\nImport rpz.mypdns.cloud from https://www.mypdns.org/\n"

printf "\nThe test file contains: $(wc -l < ${input1}) records\n"

#printf "\n\n\nImport sql\n"

#mysql --batch --raw --host="${RPZ_DB_SERVER}" --user="${RPZ_DB_USER}" --password="${RPZ_DB_PASS}" --database="${RPZ_DB}" -N -q -e "SELECT \`name\` FROM ${RPZ_DB_TABLE} WHERE \`domain_id\`=$RPZ_DOMAIN_ID AND name NOT REGEXP '^[*]\.';" | sed 's/\.mypdns\.cloud//;/\.mypdns\.cloud/d;/^name$/d' >> "${input1}"

#printf "\n\n\nDone importing sql\n"

#printf "\n\n\nThe test file contains: $(wc -l < ${input1}) records\n"

#dig axfr @axfr.ipv4.mypdns.cloud -p 5353 rpz.mypdns.cloud >> "${input1}"

#printf "\n\n\nThe test file contains: $(wc -l < ${input1}) records\n\n\n"

# **************************************************************************
# Sort lists alphabetically and remove duplicates before cleaning Dead Hosts
# **************************************************************************


PrepareLists () {
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/adware/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/adware/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_ad_servers/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/phishing_army_blocklist_extended/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/fademind_extras/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_scam/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_drugs/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_youtube/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/xorcan/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/psh/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/ad_servers/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/hjk/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/fsa/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/mmt/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/emd/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/exp/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/pup/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts/grm/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/suspiciousdomains_high/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/fademind_add_spam/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_hjk/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_grm/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/fademind_antipopads/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/BBcan177_MS-2/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/yoyo.org/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/dg-ads/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_abuse/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/mvps/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/malwaredomains/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_psh/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_exp/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_torrent/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_fraud/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_redirect/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_tracking/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/joewein/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/CoinBlockerLists/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_gambling/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_crypto/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_emd/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/malwaredomainlist/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/abuse.ch/urlhaus/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/windowsspyblocker/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/BBcan177_MS-4/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/disconnect-me/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_malware/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_spam/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/adaway/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_fsa/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_mmt/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_ransomware/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_piracy/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/cedia/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/fademind_blocklists-facebook/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_phishing/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_ransomeware/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/spamhaustech/coinblocker/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/badd_boyz_hosts/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_phising/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_porn/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/mitchellkrogza/the-big-list-of-hacked-malware-web-sites/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/mitchellkrogza/phishing.database/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/mitchellkrogza/badd_boyz_hosts/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/mitchellkrogza/Ultimate.Hosts.Blacklist/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_facebook/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/blocklist_ads/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/fademind_add_risk/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/notrack/malware/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/notrack/blocklists/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/openfish/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/hphosts_pup/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/suspiciousdomains_low/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/dg-malicious/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/bambenekconsulting/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/windowsspyblocker_extra/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/suspiciousdomains_medium/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/Import-External-Sources/hosts-sources/master/data/someonewhocares/domain.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/adware/inactive_wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/bait_sites/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/bait_sites/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/coin-blocker/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/coin-blocker/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/dns-servers/empty_dns.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/fake-news/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/fake-news/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/gambling/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/gambling/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/ip-network-blocking/ip4.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/ip-network-blocking/ip6.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/malicious/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/malicious/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/phishing/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/phishing/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/porno-sites/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/porno-sites/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/redirector/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/redirector/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/scamming/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/scamming/inactive.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/scamming/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/sharked-domains/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/sharked-domains/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/spyware/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/spyware/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/tracking/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/tracking/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/typosquatting/wildcard.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/whitelist/domains.list' >> ${input1}
    wget -qO- 'https://raw.githubusercontent.com/mypdns/matrix/master/source/whitelist/wildcard.list' >> ${input1}

    # Let UHBW do the sort from now on
    sort -u -f "${input1}" -o "${input1}"
    # dos2unix "${input1}"
    printf "\n\nDone importing external sources\n\n"
 }
PrepareLists

# ***********************************
# Deletion of all whitelisted domains
# ***********************************

WhiteListing () {
    if [[ "$(git log -1 | tail -1 | xargs)" =~ "ci skip" ]]
    then
        hash uhb_whitelist >> "${input1}"
        uhb_whitelist -f "${input1}" -o "${input1}" \
            -w "${INACTIVE_LIST}" -wc \
            --standard-sorting
    fi
}

WhiteListing

printf "\nThe test file contains: $(wc -l < ${input1}) records\n"

exit ${?}

# MIT License

# Copyright (c) 2017, 2018, 2019 Mitchell Krog - mitchellkrog@gmail.com
# https://github.com/mitchellkrogza

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
