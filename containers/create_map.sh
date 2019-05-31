#!/usr/bin/env bash

dockerfiles='dockerfiles'
mapped_dockerfiles_file='mapped_dockerfiles_file'


image_parent_is_mapped () {
  #collect mapped images from previous levels
  local image2check=$1
  local image2check_parent=$(cat $image2check | grep -v '^#' |  grep 'FROM ${CONTRAIL_REGISTRY}' |  cut -f2 -d/  | cut -f1 -d: )
  for mapped_dockerimage in $(cat  $dir/$mapped_dockerfiles_file 2>/dev/null | cut -f2 -d ' ' )
  do
    if [[ "$mapped_dockerimage" == "$image2check_parent" ]]
    then    echo 1
    fi
   done
}

function new_level()  {
current_level=$1
has_next_level=0

for x in $(cat $dir/$dockerfiles | cut -d' ' -f1  )
do

#TODO avoid variables t and tt

t=$(cat $(echo $x | cut -d' ' -f1 )| grep 'FROM ${CONTRAIL_REGISTRY}')
from=${t:-}
tt=$(image_parent_is_mapped $x)
pim=${tt:-}
#check if dependencies are empty or are matched in $mapped_dorckerfiles
if [[ $from == '' ]] || [[ $pim == 1 ]] ; then
#remove appropriate line from $dockerfiles and write image adress to $mapped_dockerfiles and level.N files
    grep -s "^$x"  $dir/$dockerfiles  >> $dir/level.$current_level
    grep -v "^$x" $dir/$dockerfiles >> $dir/$dockerfiles.tmp
    mv $dir/dockerfiles.tmp $dir/$dockerfiles
fi
done

cat $dir/level.$current_level >> $dir/$mapped_dockerfiles_file

#break loop when all dockerfiles are mapped
 if [ $(cat $dir/$dockerfiles| wc -l ) -eq 0 ]; then
    has_next_level=1
 fi
echo $has_next_level
}

function create_dockerfiles_map() {
find * -name "Dockerfile" >> $dir/tmpdf
for i in $(cat $dir/tmpdf)
do
    image_name=$(echo $i  | sed -e 's/^/contrail-/g' | sed -e 's/\//-/g' | sed -e 's/-Dockerfile//g')
    echo $i $image_name >> $dir/$dockerfiles
done
rm -f $dir/tmpdf
}


# main func
rm -rf container_map_tmp.*
dir=$(mktemp -d container_map_tmp.XXX)
level=0
create_dockerfiles_map
br=0
while [[ $br == 0 ]]
do
br=$(new_level $level)
level=$((level+1))
done