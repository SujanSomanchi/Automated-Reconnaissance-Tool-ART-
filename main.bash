#!/bin/bash

# Function to generate domain names
generate_domain_names() {
  local keyword=$1
  local suffixes=(com in org gov net edu biz info io co uk us ca au)

  for suffix in "${suffixes[@]}"; do
    echo "${keyword}.${suffix}"
  done
}

# Function to search for related domains using Google
search_related_domains() {
  local keyword=$1
  local dork="inurl:$keyword|inurl:$keyword.edu"
  local encoded_dork=$(echo "$dork" | sed 's/ /%20/g')
  local results=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36" "https://www.google.com/search?q=$encoded_dork")
  local domains=$(echo "$results" | grep -oP 'https?://\K[^/"]+' | sort -u)

  echo "Domains related to the keyword '$keyword':"
  for domain in $domains; do
    echo "$domain"
  done
}

# Get the keyword from the user
read -p "Enter a keyword: " keyword

# Generate and display domain names
echo "Domain names with the keyword '${keyword}':"
generate_domain_names "${keyword}"

# Search for related domains using Google
search_related_domains "${keyword}"

echo "Enter one of the domain: "
read dom

echo "Enter 1 for Google dorking"
echo "Enter 2 for Nmap all port scanning"
echo "Enter 3 for Nmap aggressive scanning"
echo "Enter 4 to check for firewall"
echo "Enter 5 for the OS version"
echo "Enter 6 for all of the above"
read num

case $num in
  1)
    google_dorking() {
      local keyword=$1

      # inURL dorking
      echo "inURL: ${keyword}"
      curl -s "https://www.google.com/search?q=inurl:${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'

      # intitle dorking
      echo "intitle: ${keyword}"
      curl -s "https://www.google.com/search?q=intitle:${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'

      # site dorking
      echo "site: ${keyword}"
      curl -s "https://www.google.com/search?q=site:${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'

      # indexing dorking
      echo "indexing: ${keyword}"
      curl -s "https://www.google.com/search?q=filetype:pdf+${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'
    }

    google_dorking "${keyword}"
    ;;

  2)
    echo "Nmap all port scanning"
    nmap -p1-20 -sV -sC -oA nmap_results $dom
    ;;

  3)
    echo "Performing aggressive Nmap scanning..."
    nmap -p- -sV -sC -A -top-ports 20 -oA nmap_results_aggressive $dom
    ;;

  4)
    echo "Checking for firewalls..."
    nmap -sS -p 1-65535 $dom | grep "filtered"
    ;;

  5)
    echo "Detecting OS..."
    nmap -O -p- -sV $dom | grep| grep "OS"
    ;;

  6)
    google_dorking() {
      local keyword=$1

      # inURL dorking
      echo "inURL: ${keyword}"
      curl -s "https://www.google.com/search?q=inurl:${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'

      # intitle dorking
      echo "intitle: ${keyword}"
      curl -s "https://www.google.com/search?q=intitle:${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'

      # site dorking
      echo "site: ${keyword}"
      curl -s "https://www.google.com/search?q=site:${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'

      # indexing dorking
      echo "indexing: ${keyword}"
      curl -s "https://www.google.com/search?q=filetype:pdf+${keyword}" | grep -oP '(?<=<a href=")[^"]' | sed -r '#s|&sa=U&ved=.||g' | sed -r '#s|&amp;|&|g'
    }

    google_dorking "${keyword}"

    echo "Nmap all port scanning"
    nmap -p1-20 -sV -sC -oA nmap_results $dom

    echo "Performing aggressive Nmap scanning..."
    nmap -p- -sV -sC -A -top-ports 20 -oA nmap_results_aggressive $dom

    echo "Checking for firewalls..."
    nmap -sS -p 1-65535 $dom | grep "filtered"

    echo "Detecting OS..."
    nmap -O -p- -sV $dom | grep "OS"
    ;;

  *)
    echo "Invalid option"
    ;;
esac