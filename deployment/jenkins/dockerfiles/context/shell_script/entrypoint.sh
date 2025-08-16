#!/bin/bash

test()
{
  dotnet --version
  dotnet --list-sdks

  cd /src
  pwd
  ls -ltr

  dotnet restore
  dotnet build

  dotnet test --no-build --no-restore --logger:"junit;LogFilePath=test-result.xml" || true

  echo "========================================================================================================="
  pwd
  ls -ltr
}

echo "PRODUCT_NAME: $PRODUCT_NAME"
echo "BUILDER_CSPROJ: $BUILDER_CSPROJ"

echo $#
echo $1

flag="$1"
test="test"

# if [[ $# -lt 2 ]]; then
#   echo "Illegal number of parameters" >&2
#   exit 1
# fi

if [ "$flag" = "$test" ]; then
  echo "Strings are equal."
  test
else
  echo "Strings are not equal."
fi