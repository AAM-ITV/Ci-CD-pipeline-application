application build ci/cd pipeline App42PaaS-Java-MySQL for jenkins

how to assemble? - you need to configure a pipeline task for this repository, in the Jenkins settings select pipeline from scm, specify your dockerhub repository, or any other. In this example, the application is built in the Yandex cloud infrastructure using the terraform tool, you need to specify your data from the cloud
