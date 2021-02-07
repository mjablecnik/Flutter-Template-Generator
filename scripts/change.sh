#!/bin/bash

ftg_dir_path=$(echo "$(dirname $0)/.." | sed -e 's/\/bin\/\.\.\/scripts\/\.\.//;')
sandbox_path=${ftg_dir_path}/sandbox

ftg_project_name=ftg_project_template

mkdir -p ${sandbox_path}
cd ${sandbox_path}

if [[ -d ${sandbox_path}/${ftg_project_name} ]]; then
  echo "Sandbox directory already contain some project."
  read -p "Do you realy want to continue? Project in the sandbox directory will be replaced! [y/N] " -n 1 -r

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf ${sandbox_path}/${ftg_project_name}
  else 
    exit 0
  fi
fi

bash $(dirname $0)/generate.sh --name ${ftg_project_name} \
    --description "FTG project template." \
    --author "${USER}" \
    --flutter-version "stable" \
    --license "MIT License" \
    --disable-config \
    --disable-git \


echo ""
echo ""
echo "Your template you can change in this directory:"
echo ""
echo "      ${project_dir}"
echo ""
