#!/bin/bash

install()
{
  echo "-------------------- Installing dotnet tool --------------------"
  # dotnet tool install --global dotnet-sonarscanner

  # use Coverlet
  # dotnet tool install --global coverlet.console
  echo "----------------------------------------------------------------"
}

test()
{
  dotnet --version
  dotnet --list-sdks

  # Go to /src dir
  cd /src
  pwd
  ls -ltr

  # dotnet restore <path/to/csproj> '-p:TargetFrameworks=net8.0' '-p:PackTargetFramework=net8.0'
  # dotnet build <path/to/csproj>

  # Run test
  echo "----------------------------------------------------------------"
  echo "Start run unit test"
  echo "----------------------------------------------------------------"

  # JUnit test result report
  # dotnet test --no-build --no-restore --logger:"junit;LogFilePath=test-result.xml" || true

  if [ -f "$BUILDER_CSPROJ" ]; then
    echo "---------- File exist --> $BUILDER_CSPROJ"
    echo "---------- Test result dir --> /src/$PRODUCT_NAME"

    mkdir -p "/src/$PRODUCT_NAME" && echo "---------- /src/$PRODUCT_NAME folder created"
    
    echo "----------"

    # TRX results
    dotnet test $BUILDER_CSPROJ -c Release --no-restore \
      --logger "trx;LogFileName=/src/$PRODUCT_NAME/unittest-results.trx" \
      --collect:"XPlat Code Coverage;Format=opencover" \
      -v normal \
      /p:CollectCoverage=true \
      /p:CoverletOutput="/src/$PRODUCT_NAME/coverage-result.xml" \
      /p:CoverletOutputFormat=opencover \
      || { echo "dotnet test error!!!"; true; }
  else
    echo "The file does not exist or is not a regular file --> $BUILDER_CSPROJ"
  fi

  echo " After run test ========================================================================================================="
  pwd
  ls -ltr

  echo "/src/$PRODUCT_NAME ========================================================================================================="
  cd /src/$PRODUCT_NAME
  ls -ltr

  # add to sonar
  # code...
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
  echo "Strings are equal" 

  pwd
  ls -ltr 

  # install
  test
else
  echo "Strings are not equal"
fi