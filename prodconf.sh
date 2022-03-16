#!/usr/bin/env bash

templates=$(find . -name "*.template.yml" -exec grep -l ansible_ssh_common_args {} \;)
for template in $templates
do
  file=$(echo $template | sed 's|\(.*\)\.template\(\.yml\)|\1\2|')
  echo "prodify $file"
  yq -i eval-all 'select(fileIndex==0).ansible_ssh_common_args = select(fileIndex==1).ansible_ssh_common_args | select(fileIndex==0)' $file $template
done
generic_templates="provider1_techno1 provider1_techno2 provider2_techno3"
for template in $generic_templates
do
  templatefile=group_vars/${template}.template.yml
  fields=$(yq eval -M ".$template | keys" $templatefile | cut -d ' ' -f 2)
  for f in $(find . -type f -name "*${template}.yml")
  do
    echo "prodify $f"
    yq -i eval-all "select(fileIndex==0) *?+ select(fileIndex==1).${template}" $f $templatefile
    for field in $fields
    do
      if $(grep -q $field $f)
      then
        echo "  unify $field"
        yq -i eval ".$field |= unique" $f
      fi
    done
  done
done

for f in $(find . -name '*.template.yml' -not -path "./group_vars/*")
do
  if [ -f $f ]
  then
    echo "prodify $f"
    yq -i eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' $(echo $f | sed 's|\(.*\)\.template\(\.yml\)|\1\2|') $f
  fi
done
