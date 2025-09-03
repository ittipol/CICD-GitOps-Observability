#!/bin/bash

echo $#
echo $1

flag="$1"
test="test"

PROJECT_KEY="Cs-App"
TOKEN="squ_e61135a9e0e9ddd0b8d4fcaa27b6f0b0d5a9cded"

SRC_PROJ="path/to/csproj"
SRC_DIR=$(dirname $SRC_DIR)

TEST_PROJ="/path/to/tests.csproj"
TEST_DIR=$(dirname $TEST_PROJ)

SCAN_DIR="/results"

install()
{
  echo "-------------------- Installing dotnet tool --------------------"
  dotnet tool install --global dotnet-sonarscanner

  # use Coverlet
  # dotnet tool install --global coverlet.console
  echo "----------------------------------------------------------------"
}

test()
{
  # dotnet --version
  # dotnet --list-sdks

  # dotnet restore $SRC_PROJ -p:TargetFrameworks=net8.0 -p:PackTargetFramework=net8.0

  # dotnet restore <path/to/csproj> -p:TargetFrameworks=net8.0 -p:PackTargetFramework=net8.0
  # dotnet build <path/to/csproj>

  # Run test
  echo "----------------------------------------------------------------"
  echo "Start run unit test"
  echo "----------------------------------------------------------------"

  # JUnit test result report
  # dotnet test --no-build --no-restore --logger:"junit;LogFilePath=test-result.xml" || true
  # ==================

  if [ -f "$SRC_PROJ" ]; then
    echo "---------- SRC_PROJ --> $SRC_PROJ"
    echo "---------- TEST_PROJ --> $TEST_PROJ"
    
    echo "sonarscanner *******************************************"
    
    # dotnet sonarscanner begin /k:"$PROJECT_KEY" \
    #     /d:sonar.login="$TOKEN" /d:sonar.host.url="http://sonarqube:9000" \
    #     /d:sonar.sourceEncoding=UTF-8 \
    #     /d:sonar.inclusions="**/*.cs" \
    #     /d:sonar.exclusions=**/*dependency-check*,**/test/**,**/*.spec.cs,**/test/*,**/BuildingBlocks/**,**/*UnitTests* \
    #     /d:sonar.dotnet.excludeTestProjects=true \
    #     /d:sonar.cs.opencover.reportsPaths="$SCAN_DIR/coverage-result/coverage-opencover-result.xml" \
    #     /d:sonar.cs.vstest.reportsPaths="$SCAN_DIR/coverage-result/unittest-results.trx"

    # build
    # dotnet build $SRC_PROJ -p:TargetFrameworks=net8.0 -p:PackTargetFramework=net8.0 -c Release --no-restore --no-incremental

    if [ -f "$TEST_PROJ" ]; then

    # echo "::::: Run_Test (restore) *******************************************"

    # dotnet restore $TEST_PROJ -p:TargetFrameworks=net8.0 -p:PackTargetFramework=net8.0

    echo "::::: Run_Test (run) *******************************************"

    # TRX results

    # test with no-restore
    # dotnet test $TEST_PROJ -c Release --no-restore \
    #   --logger "trx;LogFileName=$SCAN_DIR/coverage-result/unittest-results.trx" \
    #   -v normal \
    #   /p:CollectCoverage=true \
    #   /p:CoverletOutputFormat=opencover \
    #   /p:CoverletOutput="$SCAN_DIR/coverage-result/coverage-opencover-result.xml"

    # restore
    dotnet test $TEST_PROJ -c Release \
      --logger "trx;LogFileName=$SCAN_DIR/coverage-result/unittest-results.trx" \
      -v normal \
      /p:CollectCoverage=true \
      /p:CoverletOutputFormat=opencover \
      /p:CoverletOutput="$SCAN_DIR/coverage-result/coverage-opencover-result.xml"
    fi

    # dotnet sonarscanner end /d:sonar.login="$TOKEN"
  else
    echo "The file does not exist or is not a regular file --> $BUILDER_CSPROJ"
  fi

  echo "----------------------------------------------------------------"
  echo " After run test"
  echo "----------------------------------------------------------------"

  cd $SCAN_DIR/coverage-result && ls -l

  # cd $TEST_DIR
  # ls -l

  echo "Done *******************************************"
}

echo "----------------------------------------------------------------"
echo "Start..."
echo "----------------------------------------------------------------"

# export NUGET_PACKAGES="/nuget/packages"
# export PATH="$PATH:/root/.dotnet/tools"

# cd /root/.dotnet
# pwd
# ls -l | grep -i "common"
# echo "###############################################"

# echo "PRODUCT_NAME: $PRODUCT_NAME"
# echo "BUILDER_CSPROJ: $BUILDER_CSPROJ"

# if [[ $# -lt 2 ]]; then
#   echo "Illegal number of parameters" >&2
#   exit 1
# fi

if [ "$flag" = "$test" ]; then
  # echo "-----"
  # install
  test
else
  echo "Strings are not equal"
fi