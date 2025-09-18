#!/bin/bash

# liquibase --version

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

echo "ENV: $DB_ENV"
echo "DB_NAME: $DB_NAME"

# args=
declare -a args=()

case "$1" in
  update | update-dryrun| rollback-count | rollback-count-dryrun | rollback-tag | rollback-tag-dryrun | tag | history)
    command="$1"
  ;;
  *) echo "Invalid option" ; exit 1 ;;
esac

root="non-prod-new/$DB_ENV/$DB_NAME"

shift

while [ -n "$1" ]; do
  case "$1" in
  ddl | dml | sp)
    sql_command_type="$1"
  ;;
  --count)

    if [[ "$command" == "rollback-count" || "$command" == "rollback-count-dryrun" ]]; then
      echo ">>> count $1";
      shift # to move $1 to the next argument
      echo "count (after shift) $1";
      # args+=("--count=$1")
      rollback_count="$1"
    fi
    
    ;;
  --label)

    if [[ "$command" == "rollback-count" || "$command" == "rollback-count-dryrun" ]]; then
      echo ">>> labels $1";
      shift # to move $1 to the next argument
      echo "labels (after shift) $1";
      label_filter="$1"

      # args+=("--label-filter=$1")
    fi
    
    ;;
  --tag)

    if [[ "$command" == "rollback-tag" || "$command" == "rollback-tag-dryrun" ]]; then
      echo ">>> tag $1";
      shift # to move $1 to the next argument
      echo "tag (after shift) $1";
      # args+=("--tag=$1")
    fi
    
    ;;
  *)
    echo "Other Argument: $1"    
    ;;
  esac

  args+=("$1")

  shift
done

# echo "Size : ${#args[@]}"

# # join items in array
# OLD_IFS=$IFS

# IFS=" "

# joined_args="${args[*]}"

# IFS=$OLD_IFS

# echo "Joined string: $joined_args"

# exit 1

echo ":: ---------------------------------------------------------------------"
echo " SQL command type [$sql_command_type]"
echo " Args [$args]"
echo ":: ---------------------------------------------------------------------"

case "$sql_command_type" in
  ddl)
    check_folder_exist "$root/ddl"

    cp "$root/liquibase.properties" "./$root/ddl/"
    cd "$root/ddl"
  ;;
  dml)
    check_folder_exist "$root/dml"

    cp "$root/liquibase.properties" "./$root/dml/"
    cd "$root/dml"
  ;;
  sp)
    check_folder_exist "$root/stored_procedure"

    cp "$root/liquibase.properties" "./$root/stored_procedure/"
    cd "$root/stored_procedure"
  ;;
  *) echo "Invalid option" ; exit 1 ;;
esac

echo ":: ---------------------------------------------------------------------"
echo " run $command"
echo ":: ---------------------------------------------------------------------"

case "$command" in
  update)

    # status
    liquibase status

    # validate
    liquibase validate

    liquibase update --log-level DEBUG --log-file="/output/update.log"

  ;;
  update-dryrun)

    # status
    liquibase status

    # validate
    liquibase validate

    liquibase update-sql --output-file /output/sql-migration.review.sql
    liquibase future-rollback-sql --output-file /output/sql-rollback.review.sql
  ;;
  rollback-count)
    echo "rollback-count"

    liquibase validate

    liquibase rollback-count --count="$rollback_count" --label-filter="$label_filter"

    # liquibase rollback-count --count="$ROLLBACK_COUNT"

    # liquibase rollback-count --count="$ROLLBACK_COUNT" --label-filter="${CHANGESET_LABEL}"'
  ;;
  rollback-count-dryrun)
    echo "rollback-count-dryrun"

    liquibase validate

    liquibase rollback-count-sql --count="$rollback_count" --label-filter="$label_filter" --output-file /output/sql-rollback.preview.sql
  ;;
  rollback-tag)
    echo "rollback-tag"
  ;;
  rollback-tag-dryrun)
    echo "rollback-tag-dryrun"
  ;;
  tag)
    echo "tag"
  ;;
  history)
    echo "history"
  ;;
  *) echo "Invalid option" ; exit 1 ;;
esac

echo ":: ---------------------------------------------------------------------"
echo " done"
echo ":: ---------------------------------------------------------------------"