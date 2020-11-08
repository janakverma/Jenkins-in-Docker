# dev-automation = working repo

"master/main"                = Never touch this branch.
    | 
"Development"                = this branch should be identical to :Master/Main":  like PREPROD before PROD   
    |
"feature/your-working-task"  = is where you branch out from feature (above branch), and start working on your scripts. 


Merge pattern:
        step 1: "feature/your-working-task"  to  Development           # Only after review
        step 2: "feature"   to Master                                  # Only after review 

########################################################################
NOTE: Never work on Master/main branch, Or merge into master/main branch   - ALWAYS LIMIT TO DEVELOPMENT BRANCH
########################################################################


step1:
from master --> git checkout development
step2:
You are now on development branch now.
     create a working branch with feature/task-name
