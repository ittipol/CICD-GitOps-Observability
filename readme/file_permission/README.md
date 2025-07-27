# Linux file permission

| Octal | Binary | Permission | Description |
|:-------------:|:--------------:|:--------------:|:--------------|
| 0     | 000        | ---           | No access  |
| 1     | 001        | --x           | Execute only  |
| 2     | 010        | -w-           | Write only  |
| 3     | 011        | -wx           | write and Execute  |
| 4     | 100        | r--           | Read only  |
| 5     | 101        | r-x           | Read and Execute  |
| 6     | 110        | rw-           | Read and Write  |
| 7     | 111        | rwx           | Read, Write and Execute  |

### Symbolic
- User (u): The owner of the file or directory
- Group (g): Users belonging to the group associated with the file or directory
- Others (o): All other users on the system

**e.g.,**
``` bash
chmod 644 ./data.txt

chmod u+x ./script.sh

chmod g-r ./app/
```