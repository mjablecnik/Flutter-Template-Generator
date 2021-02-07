#!/bin/bash

ftg_dir_path=$(echo "$(dirname $0)/.." | sed -e 's/\/bin\/\.\.\/scripts\/\.\.//;')

sandbox_path=${ftg_dir_path}/sandbox
project_path=
project_name=ftg_project_template
ftg_project_name=ftg_project_template

template_path=${ftg_dir_path}/templates
file_path=${ftg_dir_path}/files
use_default=false

state_manager=
folders_organization=
project_type=

new_state_manager=
new_folders_organization=

_contains () {  # Check if space-separated list $1 contains line $2
  echo "$1" | tr ' ' '\n' | grep -F -x -q "$2"
}


while (( "$#" )); do

  if [[ ${1} == '-p' || ${1} == '--project-path' ]]; then
    project_path=${2}
    project_name=$(basename ${project_path})
  fi
  
  shift
done

setup_project () {
  local project_list=$(ls ${sandbox_path} -l | grep '^d' | awk "{print \$(NF)}")
  if [[ -z ${project_path} ]]; then
    echo "What project you want to convert?"
    select project_name in ${project_list};
    do
      echo "You picked ${ftg_project_name} (${REPLY})"
      project_path=${sandbox_path}/${ftg_project_name}
      echo ""
      break
    done
  fi
}

write_state_manager () {
  echo ""
  echo "Write state management:"
  read -p "(None) " state_manager
  echo ""

  new_state_manager=true
  
  if [[ -z ${state_manager} ]]; then
    echo "This cannot be empty."
    exit 1
  fi
}

setup_state_manager () {
  local state_managers_list=$(ls ${template_path} -l | grep '^d' | grep -v none | awk "{print \$(NF)}")

  echo "Select package for state management:"
  select state_manager in ${state_managers_list} "None" "Add new";
  do
    echo "You picked ${state_manager} (${REPLY})"
    echo ""
    break
  done

  if [[ ${state_manager} == "Add new" ]]; then
    write_state_manager
  fi
  
}

write_folders_organization () {
    echo ""
    echo "Write folders organization:"
    read -p "(default) " folders_organization
    echo ""

    new_folders_organization=true
  
    if [[ -z ${folders_organization} ]]; then
      folders_organization=default
    fi
}

setup_folders_organization () {
  if [[ ${new_state_manager} == true ]]; then
    write_folders_organization
  else
    local folders_organization_list=$(ls ${template_path}/${state_manager} -l | grep '^d' | awk "{print \$(NF)}")
    if [[ -z ${folders_organization_list} ]]; then
      write_folders_organization
    else
      echo "Select your folders organization:"
      select folders_organization in ${folders_organization_list} "Add new";
      do
        echo "You picked ${folders_organization} (${REPLY})"
        echo ""
        break
      done

      if [[ ${folders_organization} == "Add new" ]]; then
        write_folders_organization
      fi
    fi
  fi
}

write_project_type () {
    echo ""
    echo "Write project type:"
    read -p "(basic)" project_type
    echo ""
    new_folders_organization=true

    if [[ -z ${project_type} ]]; then
      project_type=basic
    fi
}

setup_project_type () {

  if [[ ${new_folders_organization} == true ]]; then
    write_project_type
  else
    local project_type_list=$(ls ${template_path}/${state_manager}/${folders_organization} -l | grep '^d' | awk "{print \$(NF)}")
    if [[ -z ${project_type_list} ]]; then
      write_project_type
    else
      echo "Select project type:"
      select project_type in ${project_type_list} "Add new";
      do
        echo "You picked ${project_type} (${REPLY})"
        echo ""
        break
      done

      if [[ ${folders_organization} == "Add new" ]]; then
        write_project_type
      fi
    fi
  fi
}

print_result () {
  echo ""
  echo "Generated template with arguments:"
  echo ""
  echo "    Project name is:" ${project_name}
  echo "    Project path is:" ${project_path}
  echo "    State manager:" ${state_manager}
  echo "    Folders organization is:" ${folders_organization}
  echo "    Project type is:" ${project_type}
  echo ""
}

generate_template () {
  local selected_template_path=${template_path}/${state_manager}/${folders_organization}/${project_type}

  rm -rf ${selected_template_path}
  mkdir -p ${selected_template_path}

  cp -r ${project_path}/lib ${selected_template_path}
  cp ${project_path}/pubspec.yaml ${selected_template_path}

  if [[ -d ${project_path}/test ]]; then
    cp -r ${project_path}/test ${selected_template_path}
  fi

  if [[ -d ${project_path}/integration_test ]]; then
    cp -r ${project_path}/integration_test ${selected_template_path}
  fi

  if [[ -d ${project_path}/README.md ]]; then
    cp -r ${project_path}/README.md ${selected_template_path}
  fi

  cd ${selected_template_path}

  ack -l "${project_name}" | xargs perl -pi -E "s/${project_name}/${ftg_project_name}/g"
  sed -i '/description: /c\description: {{project_description}}' pubspec.yaml
}

setup_project
setup_state_manager
setup_folders_organization
setup_project_type

generate_template
print_result
