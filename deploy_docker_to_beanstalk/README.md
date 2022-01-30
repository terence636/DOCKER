[Important: Commit git changes before deploy to beanstalk. E.g. any changes to dockerfile, source files need to git commit first or else the changes will not
be reflected]

1. To deploy to aws elastic beanstalk you just need Dockerfile
2. Try to run beanstalk locally from the cli to ensure Dockerfile is all good and able to lauch app
  - Realised that it needs to have "EXPOSE <PORT>" statement in order to deploy to beanstalk
  - eb local run --port 8080
  - eb local status
  - eb local open (after eb run, open app at browser)
3. Check aws configure to ensure deploy to the right aws profile
4. Run **eb init** to initialized the environment configuration
5. Run **eb create** to deploy app to beanstalk
6. Run **eb deploy** to update any changes to your app
7. Run **eb list** to list out all deploy beanstalk app
8. Run **eb eliminate --force** to kill the app
9. Run **eb logs** to view logs details of deployment
10. After terminating the beanstalk environment, as for S3 need to delete the policy first before u can delete the S3 itself
