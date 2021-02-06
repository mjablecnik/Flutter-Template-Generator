#!/bin/bash

if [[ -n ${FTG_CONFIG} ]]; then
  config_file=${FTG_CONFIG}
else
  config_file=$(dirname $0)/../config
fi

template_path=$(dirname $0)/../templates
file_path=$(dirname $0)/../files
use_default=false

source ${config_file}

_contains () {  # Check if space-separated list $1 contains line $2
  echo "$1" | tr ' ' '\n' | grep -F -x -q "$2"
}

declare -A licenses=( 
  ["GNU GPLv3"]="gpl-3.0" 
  ["GNU LGPLv3"]="lgpl-3.0"
  ["Mozilla Public License 2.0"]="mpl-2.0"
  ["Apache License 2.0"]="apache-2.0"
  ["MIT License"]="mit"
)

while (( "$#" )); do

  if [[ ${1} == '-n' || ${1} == '--name' ]]; then
    project_name=${2}

  elif [[ ${1} == '-d' || ${1} == '--description' ]]; then
    project_description=${2}

  elif [[ ${1} == '-a' || ${1} == '--author' ]]; then
    project_author=${2}

  elif [[ ${1} == '-s' || ${1} == '--state-management' ]]; then
    state_manager=${2}

  elif [[ ${1} == '-o' || ${1} == '--folders-organization' ]]; then
    folders_organization=${2}

  elif [[ ${1} == '-p' || ${1} == '--project-type' ]]; then
    project_type=${2}

  elif [[ ${1} == '-g' || ${1} == '--git' ]]; then
    git_setup=true

  elif [[ ${1} == '-v' || ${1} == '--flutter-version' ]]; then
    fvm_setup=true
    flutter_version=${2}

  elif [[ ${1} == '-l' || ${1} == '--license' ]]; then
    project_license=${2}

  elif [[ ${1} == '-h' || ${1} == '--help' ]]; then
    echo "
    Flags:
        -n --name
        -d --description
        -a --author
        -s --state-management
        -o --folders-organization
        -p --project-type
        -g --git
        -v --flutter-version
        -l --license
        -h --help
    "
  fi
  
  shift
done

echo ""


setup_project_name () {
  if [[ -z ${project_name} ]]; then
    echo "Write project name:"
    read project_name
    echo ""
  
    if [[ -z ${project_name} ]]; then
      echo "This cannot be empty."
      exit 1
    fi
  else
    echo "Project name is: " ${project_name} 
    echo ""
  fi
}

setup_description () {
  if [[ -z ${project_description} ]]; then
    echo "Write description:"
    read project_description
    echo ""
  
    if [[ -z ${project_description} ]]; then
      echo "This cannot be empty."
      exit 1
    fi
  else
    echo "Description is: " ${project_description} 
    echo ""
  fi
}

setup_author_name () {
  if [[ -z ${project_author} ]]; then
    echo "Write author name:"
    read project_author
    echo ""
  
    if [[ -z ${project_author} ]]; then
      echo "This cannot be empty."
      exit 1
    fi
  else
    echo "Author name is: " ${project_author} 
    echo ""
  fi
}

setup_state_manager () {
  local state_managers_list=$(ls ${template_path} -l | grep '^d' | grep -v none | awk "{print \$(NF)}")

  if [[ -z ${state_manager} ]]; then
    echo "Select package for state management:"
    select state_manager in ${state_managers_list} "None";
    do
      echo "You picked ${state_manager} (${REPLY})"
      echo ""
      break
    done
  else
    echo "Package for state management is: " ${state_manager} 
    echo ""
  fi
  
  if ! _contains "${state_managers_list}" "${state_manager}"; then
    echo "Selected wrong number."
    exit 1
  fi
}

setup_folder_organization () {
  local folder_organization_list=$(ls ${template_path}/${state_manager} -l | grep '^d' | awk "{print \$(NF)}")
  if [[ -z ${folder_organization_list} ]]; then
    use_default=true
    folders_organization=default
  else
    if [[ -z ${folders_organization} ]]; then
      echo "Select your folders organization:"
      select folders_organization in ${folder_organization_list};
      do
        echo "You picked ${folders_organization} (${REPLY})"
        echo ""
        break
      done
    else
      echo "Folders organization is: " ${folders_organization} 
      echo ""
    fi
    
    if ! _contains "${folder_organization_list}" "${folders_organization}"; then
      echo "Selected wrong number."
      exit 1
    fi
  fi
}

setup_project_type () {
  local project_type_list=$(ls ${template_path}/${state_manager}/${folders_organization} -l | grep '^d' | awk "{print \$(NF)}")

  if [[ -z ${project_type} ]]; then
    echo "Select project type:"
    select project_type in ${project_type_list};
    do
      echo "You picked ${project_type} (${REPLY})"
      echo ""
      break
    done
  else
    echo "Project type is: " ${project_type} 
    echo ""
  fi
  
  if ! _contains "${project_type_list}" "${project_type}"; then
    echo "Selected wrong number."
    exit 1
  fi
}

setup_git () {
  if [[ -z ${git_setup} ]]; then
    read -p "Do you want to setup git? [Y/n]" git_setup
    if [[ -z ${git_setup} || ${git_setup} == Y || ${git_setup} == y ]]; then
      git_setup=true
    else 
      git_setup=false
    fi
  fi
  echo ""
}

setup_fvm () {
  if [[ -z ${fvm_setup} ]]; then
    read -p "Do you want to setup fvm? [Y/n]" fvm_setup
    if [[ -z ${fvm_setup} || ${fvm_setup} == Y || ${fvm_setup} == y ]]; then
      fvm_setup=true
    else 
      fvm_setup=false
    fi
  fi
  echo ""
  if [[ ${fvm_setup} == true ]]; then
    setup_flutter_version
  fi
}

setup_flutter_version () {
  if [[ -z ${flutter_version} ]]; then
    echo "Write Flutter version for setup fvm:"
    read flutter_version
    echo ""
  
    if [[ -z ${flutter_version} ]]; then
      echo "This cannot be empty."
      exit 1
    fi
  else
    echo "Flutter version is: " ${flutter_version} 
    echo ""
  fi
}

setup_license () {
  if [[ -z ${project_license} ]]; then
    echo "Select license:"
    select project_license in "${!licenses[@]}";
    do
      echo "You picked ${project_license} (${REPLY})"
      echo ""
      break
    done
  else
    echo "License is: " ${project_license} 
    echo ""
  fi
  project_license_tag=${licenses[${project_license}]}
}

print_result () {
  echo "Project name is:" ${project_name}
  echo "Description is:" ${project_description}
  echo "Author is:" ${project_author}
  echo "State manager:" ${state_manager}
  echo "Folders organization is:" ${folders_organization}
  echo "Project type is:" ${project_type}
}

generate () {
  selected_template_path=${template_path}/${state_manager}/${folders_organization}/${project_type}
  
  flutter create ${project_name}
  cd ${project_name}
  rm -rf lib test pubspec.* README.md
  
  if [[ ${git_setup} == true ]]; then
    git init
  fi
  
  cp -r ${selected_template_path}/lib .
  cp ${file_path}/gitignore .gitignore
  cp ${selected_template_path}/pubspec.yaml .
  cp ${file_path}/README.md .

  if [[ ${fvm_setup} == true ]]; then
    mkdir .fvm
    cp ${file_path}/fvm_config.json .fvm/fvm_config.json
  fi
  
  ack -l "ftg_project_template" | xargs perl -pi -E "s/ftg_project_template/${project_name}/g"
  ack -l "\{\{project_description\}\}" | xargs perl -pi -E "s/\{\{project_description\}\}/${project_description}/g"
  ack -l "\{\{project_author\}\}" | xargs perl -pi -E "s/\{\{project_author\}\}/${project_author}/g"
  ack -l "\{\{project_license\}\}" | xargs perl -pi -E "s/\{\{project_license\}\}/${project_license}/g"
  ack -l "\{\{project_license_tag\}\}" | xargs perl -pi -E "s/\{\{project_license_tag\}\}/${project_license_tag}/g"
  ack -l "\{\{flutter_version\}\}" | xargs perl -pi -E "s/\{\{flutter_version\}\}/${flutter_version}/g"
  
  flutter pub get
  
  if [[ ${git_setup} == true ]]; then
    git add .gitignore .metadata *
    git commit -m init
  fi
}


setup_project_name 
setup_description 
setup_author_name 
setup_state_manager
if [[ ${use_default} == false ]]; then
  setup_folder_organization
fi
if [[ ${use_default} == false ]]; then
  setup_project_type
fi
setup_git
setup_fvm #todo
setup_license


generate
echo ""
print_result


