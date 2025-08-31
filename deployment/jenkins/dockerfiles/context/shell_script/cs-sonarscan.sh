#!/bin/bash

PROJECT_KEY="Cs-App"

SCAN_DIR="/path/to/scan"

SRC_PROJ="/path/to/csproj"
SRC_DIR=$(dirname $SRC_DIR)

TEST_PROJ="/path/to/test.csproj"
TEST_DIR=$(dirname $TEST_PROJ)

mkdir -p "$SCAN_DIR/coverage-result"

dotnet sonarscanner begin /k:"$PROJECT_KEY" \
    /d:sonar.login="squ_e61135a9e0e9ddd0b8d4fcaa27b6f0b0d5a9cded" /d:sonar.host.url="http://localhost:9000" \
    /d:sonar.sourceEncoding=UTF-8 \
    /d:sonar.inclusions="**/*.cs" \
    /d:sonar.exclusions=**/*dependency-check*,**/test/**,**/*.spec.cs,**/test/*,**/BuildingBlocks/**,**/*UnitTests* \
    /d:sonar.dotnet.excludeTestProjects=true \
    /d:sonar.cs.opencover.reportsPaths="$SCAN_DIR/coverage-result/coverage.opencover.xml" \
    /d:sonar.cs.vstest.reportsPaths="$SCAN_DIR/coverage-result/unittest-results.trx"

dotnet build $SRC_PROJ -p:TargetFrameworks=net8.0 -p:PackTargetFramework=net8.0 -c Release --no-restore --no-incremental

if [ -f "$TEST_PROJ" ]; then
dotnet test $TEST_PROJ -c Release --no-restore \
        --logger "trx;LogFileName=$SCAN_DIR/coverage-result/unittest-results.trx" \
        --collect:"XPlat Code Coverage;Format=opencover" \
        -v normal \
        /p:CollectCoverage=true \
        /p:CoverletOutputFormat=opencover \
        /p:CoverletOutput="$SCAN_DIR/coverage-result/coverage.opencover.xml"

cp -rf "$(find $TEST_DIR/TestResults/** -name "coverage.opencover.xml" | head -1)" "$SCAN_DIR/coverage-result/coverage.opencover.xml"
fi

dotnet sonarscanner end /d:sonar.login="squ_e61135a9e0e9ddd0b8d4fcaa27b6f0b0d5a9cded"

echo -e "===========================\n"
echo "$TEST_DIR/TestResults"