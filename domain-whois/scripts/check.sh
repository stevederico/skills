#!/usr/bin/env bash
# Check domain availability across TLDs via direct WHOIS/RDAP
# Usage: check.sh <domain>
# Requires: whois, curl

DOMAIN=$(echo "$1" | tr '[:upper:]' '[:lower:]')
DOMAIN="${DOMAIN%%.*}" # strip TLD if provided

if [ -z "$DOMAIN" ]; then
  echo "Usage: check.sh <domain>"
  exit 1
fi

if ! echo "$DOMAIN" | grep -qE '^[a-z0-9]([a-z0-9-]*[a-z0-9])?$'; then
  echo "Invalid domain name. Use alphanumeric and hyphens only."
  exit 1
fi

tmpdir=$(mktemp -d)

check_whois() {
  local tld="$1"
  local server="$2"
  local fqdn="${DOMAIN}.${tld}"
  local result lower

  result=$(whois -h "$server" "$fqdn" 2>/dev/null)
  lower=$(echo "$result" | tr '[:upper:]' '[:lower:]')

  if echo "$lower" | grep -qiE 'domain name:|registrar:|creation date:|registry domain|registered on:|nserver:|name server:'; then
    echo "${fqdn}|Taken"
  elif echo "$lower" | grep -qiE 'no match|not found|no data found|no entries found|no object found|status: free|status: available|is available|domain not found'; then
    echo "${fqdn}|Available"
  else
    echo "${fqdn}|Unknown"
  fi
}

check_rdap() {
  local tld="$1"
  local fqdn="${DOMAIN}.${tld}"
  local http_code

  http_code=$(curl -s -o /dev/null -w "%{http_code}" -A "Claude-Agent" \
    "https://pubapi.registry.google/rdap/domain/${fqdn}" 2>/dev/null)

  if [ "$http_code" = "404" ]; then
    echo "${fqdn}|Available"
  elif [ "$http_code" = "200" ]; then
    echo "${fqdn}|Taken"
  else
    echo "${fqdn}|Unknown"
  fi
}

# Run all WHOIS checks in parallel
check_whois com whois.verisign-grs.com > "$tmpdir/com" &
check_whois net whois.verisign-grs.com > "$tmpdir/net" &
check_whois org whois.pir.org > "$tmpdir/org" &
check_whois io whois.nic.io > "$tmpdir/io" &
check_whois co whois.registry.co > "$tmpdir/co" &
check_whois xyz whois.nic.xyz > "$tmpdir/xyz" &
check_whois ai whois.nic.ai > "$tmpdir/ai" &
check_whois shop whois.nic.shop > "$tmpdir/shop" &
check_whois site whois.nic.site > "$tmpdir/site" &
check_whois tech whois.nic.tech > "$tmpdir/tech" &

# RDAP for .dev and .app
check_rdap dev > "$tmpdir/dev" &
check_rdap app > "$tmpdir/app" &

wait

# Collect and sort results (available first, then taken, then unknown)
for f in "$tmpdir"/*; do
  line=$(cat "$f")
  case "$line" in *"|Available") echo "$line" ;; esac
done
for f in "$tmpdir"/*; do
  line=$(cat "$f")
  case "$line" in *"|Taken") echo "$line" ;; esac
done
for f in "$tmpdir"/*; do
  line=$(cat "$f")
  case "$line" in *"|Unknown") echo "$line" ;; esac
done

rm -rf "$tmpdir"
