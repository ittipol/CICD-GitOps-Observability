#!/bin/bash

echo ":: ---------------------------------------------------------------------"
echo "Initial arguments: $@"
echo "Number of arguments: $#"
echo ":: ---------------------------------------------------------------------"

check_folder_exist() {
  local directory="$1"

  if [ -d "$directory" ]; then
    echo "Directory '$directory' exists."
  else
    echo "Directory '$directory' does not exist."
    exit 1
  fi
}

check_file_exist() {
  local file="$1"

  if [ -f "$file" ]; then
    echo "$file exists and is a regular file."
  else
    echo "$file does not exist or is not a regular file."
  fi
}

echo "ENV: $DB_ENV"
# echo "DB_NAME: $DB_NAME"

declare -a args=()

case "$1" in
  update | update-dryrun | rollback-count | rollback-count-dryrun | rollback-tag | rollback-tag-dryrun | tag | history)
    command="$1"
    shift # Move to next args
    database_name="$1"
    shift
    project_name="$1"
    shift
  ;;
  version)
    liquibase --version ; exit 1
  ;;
  *) echo "Invalid option" ; exit 1 ;;
esac

echo "database_name: $database_name"
echo "project_name: $project_name"

root="$(pwd)/non-prod-new/$DB_ENV/$database_name"
check_folder_exist "$root"

if [[ -n "$project_name" ]]; then
  check_folder_exist "$root/$project_name"
fi

check_file_exist "$root/liquibase.properties"
check_file_exist "$root/liquibase.changelog.yml"

while [ -n "$1" ]; do
  case "$1" in
  # ddl | dml | sp | none)
  #   sql_command_type="$1"
  # ;;
  --count)

    if [[ "$command" == "rollback-count" || "$command" == "rollback-count-dryrun" ]]; then
      echo ">>> count $1";
      shift
      echo "count (after shift) $1";

      rollback_count="$1"

      args+=("--count=$1")
    fi
    
    ;;
  --label)

    if [[ "$command" == "rollback-count" || "$command" == "rollback-count-dryrun" ]]; then
      echo ">>> labels $1";
      shift
      echo "labels (after shift) $1";

      label_filter="$1"

      args+=("--label-filter=$1")
    fi
    
    ;;
  --tag)

    if [[ "$command" == "rollback-tag" || "$command" == "rollback-tag-dryrun"  || "$command" == "tag" ]]; then
      echo ">>> tag $1";
      shift
      echo "tag (after shift) $1";

      tag_version="$1"

      args+=("--tag=$1")
    fi
    
    ;;
  --check-version)

    if [[ "$command" == "tag" ]]; then
      echo ">>> tag check version $1";
      shift
      echo "tag check version (after shift) $1";

      check_tag_version="$1"

      args+=("--check-tag-version=$1")
    fi
    
    ;;
  --show-only-tag)

    if [[ "$command" == "history" ]]; then
      echo ">>> show only tag $1";
      shift
      echo "show only tag (after shift) $1";

      show_only_tag="$1"

      args+=("--show_only_tag=$1")
    fi
    
    ;;
  --filter-tag-version)

    if [[ "$command" == "history" ]]; then
      echo ">>> filter tag version $1";
      shift
      echo "filter tag version (after shift) $1";

      filter_tag_version="$1"

      args+=("--filter-tag-version=$1")
    fi
    
    ;;
  *)
    echo "Other Argument: $1"
    args+=("$1")
    ;;
  esac

  shift
done

echo "Size : ${#args[@]}"

OLD_IFS=$IFS
IFS=" "
joined_args="${args[*]}"
IFS=$OLD_IFS

echo "Joined string: $joined_args"

# exit 1

if [[ -n "$project_name" ]]; then

  echo ":: ---------------------------------------------------------------------"
  echo " project_name [$project_name]"
  echo ":: ---------------------------------------------------------------------"
  
  mkdir -p "$root/change/$project_name"
  cp "$root/liquibase.properties" "$root/change/"
  cp "$root/liquibase.changelog.yml" "$root/change/"
  cp -rf "$root/$project_name/." "$root/change/$project_name"

  cd "$root/change"

  found_file=$(find . -type f -name "*.sql" -print0)

  if [[ -z "$found_file" ]]; then
    echo "Error: File 'sql file' not found."
    exit 1
  else
    echo "File(s) found:"
    echo "$found_file" | xargs -0 -I {} echo "  - {}"
  fi

else
  cd "$root"
fi

# echo ":: ---------------------------------------------------------------------"
# echo " SQL command type [$sql_command_type]"
# echo " Args [$joined_args]"
# echo ":: ---------------------------------------------------------------------"

# case "$sql_command_type" in
#   ddl)
#     check_folder_exist "$root/ddl"

#     # cp "$root/liquibase.properties" "./$root/ddl/"
#     # cd "$root/ddl"

#     mkdir -p "$root/change/ddl"
#     cp "$root/liquibase.properties" "$root/change/"
#     cp "$root/liquibase.changelog.yml" "$root/change/"
#     cp -rf "$root/ddl/." "$root/change/ddl"
#   ;;
#   dml)
#     check_folder_exist "$root/dml"
#     # check_file_exist "$root/liquibase.properties"

#     # cp "$root/liquibase.properties" "./$root/dml/"
#     # cd "$root/dml"

#     mkdir -p "$root/change/dml"
#     cp "$root/liquibase.properties" "$root/change/"
#     cp "$root/liquibase.changelog.yml" "$root/change/"
#     cp -rf "$root/dml/." "$root/change/dml"
#   ;;
#   sp)
#     check_folder_exist "$root/stored_procedure"
#     # check_file_exist "$root/liquibase.properties"

#     cp "$root/liquibase.properties" "./$root/stored_procedure/"
#     cd "$root/stored_procedure"
#   ;;
#   none)
#     # check_folder_exist "$root"
#     # check_file_exist "$root/liquibase.properties"

#     cd "$root"
#   ;;
#   *) echo "Invalid option" ; exit 1 ;;
# esac

echo ":: ---------------------------------------------------------------------"
echo " run [$command]"
echo ":: ---------------------------------------------------------------------"

case "$command" in
  update)

    liquibase validate || exit 1

    liquibase update --log-level DEBUG --log-file="/output/update.log" || exit 1
  ;;
  update-dryrun)

    liquibase validate || exit 1

    echo ":: ---------------------------------------------------------------------"
    echo " After validate..."
    echo ":: ---------------------------------------------------------------------"

    liquibase update-sql --output-file /output/sql-migration.review.sql
    liquibase future-rollback-sql --output-file /output/sql-rollback.review.sql
  ;;
  rollback-count)

    liquibase validate || exit 1

    liquibase rollback-count --count="$rollback_count" --label-filter="$label_filter" || exit 1
  ;;
  rollback-count-dryrun)

    liquibase validate || exit 1

    liquibase rollback-count-sql --count="$rollback_count" --label-filter="$label_filter" --output-file /output/sql-rollback.preview.sql
  ;;
  rollback-tag)

    liquibase validate || exit 1

    liquibase rollback --tag="$tag_version" --log-file=/output/rollback-tag.log --log-level=DEBUG || exit 1
  ;;
  rollback-tag-dryrun)

    liquibase validate || exit 1

    echo ":: ---------------------------------------------------------------------"
    echo " After validate..."
    echo ":: ---------------------------------------------------------------------"

    liquibase rollback-sql --output-file /output/sql-rollback.preview.sql --tag="$tag_version"
  ;;
  tag)

    echo "check_tag_version >>>>>>>>> $check_tag_version"

    liquibase history --format=TEXT --show-tags=true --tag-filter="$tag_version" | grep -i "Applied 1 changeset" && { echo "The tag '$tag_version' already exist, cannot create tag"; exit 1; } || echo "The tag '$tag_version' does NOT exist"

    if [[ "$check_tag_version" != "true" ]]; then
      liquibase tag "$tag_version"
    fi

  ;;
  history)

    echo "show_only_tag >>>>>>>>> $show_only_tag"

    if [[ "$show_only_tag" == "true" ]]; then          

      if [[ -n $filter_tag_version ]]; then
        echo "The variable 'filter_tag_version' is not empty."
        liquibase history --format=TEXT --show-tags=true --tag-filter="$filter_tag_version" --output-file /output/history.filter-tag.log
      else
        echo "The variable 'filter_tag_version' is empty."
        liquibase history --format=TABULAR --show-tags=true --output-file /output/history.tag-list.log
      fi      

    else
      liquibase history --format=TEXT --output-file /output/history.text.log
      liquibase history --format=TABULAR --output-file /output/history.tabular.log
    fi
  ;;
  status)    

    liquibase validate || exit 1

    liquibase status
  ;;
  *) echo "Invalid option" ; exit 1 ;;
esac

echo ":: ---------------------------------------------------------------------"
echo " done"
echo ":: ---------------------------------------------------------------------"