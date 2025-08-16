def test(String specificFile, String logger)
{
	try {	
    sh 'dotnet test ${specificFile} --no-build --no-restore --logger:"${logger}"'
	}
  catch (Exception ex) {
    throw ex
  }
}