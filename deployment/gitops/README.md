# Git

## Add GitHub Credentials In Jenkins

### Generate GitHub Token
1. Navigate to Settings > Developer Settings > Personal access tokens > Tokens (classic)
2. Click Generate new token (classic)
3. Input Note
4. Select Expiration
5. Select scopes
    - Check "repo" checkbox 
6. Click Generate token

### Add GitHub Credentials
1. Navigate to Manage Jenkins Credentials > System > Global credentials (unrestricted) > Add Credentials
2. Select "Username with password"
3. Input Username (GitHub username, email)
4. Check "Treat username as secret" checkbox
5. Input Password (GitHub Token)
6. Input ID
7. Input Description
8. Click Create