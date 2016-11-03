#!/usr/bin/env groovy
// Jenkinsfile
// Build and test a Maven project

node('docker') {
  def mvnHome = tool 'M3'

  // def server = Artifactory.newServer url: 'http://artifactory.azcender.com:8081/artifactory', username: 'admin', password: 'password'
  def server = Artifactory.server('artifactory')

  def artifactoryMaven = Artifactory.newMavenBuild()

  artifactoryMaven.tool = 'M3' // Tool name from Jenkins configuration
  artifactoryMaven.deployer releaseRepo:'libs-release-local', snapshotRepo:'libs-snapshot-local', server: server
  artifactoryMaven.resolver releaseRepo:'libs-release', snapshotRepo:'libs-snapshot', server: server

  def buildInfo = Artifactory.newBuildInfo()

  stage('Build') {
    checkout scm
  }

  // stage('Build') {
  //   git 'https://github.com/autostructure/java-sample.git'
  // }

  // stage('Artifactory configuration') {
  //   def server = Artifactory.newServer url: 'http://artifactory:8081/artifactory', username: 'admin', password: 'password'

  //   def artifactoryMaven = Artifactory.newMavenBuild()

  //   artifactoryMaven.tool = 'M3' // Tool name from Jenkins configuration
  //   artifactoryMaven.deployer releaseRepo:'libs-release-local', snapshotRepo:'libs-snapshot-local', server: server
  //   artifactoryMaven.resolver releaseRepo:'libs-release', snapshotRepo:'libs-snapshot', server: server

  //   def buildInfo = Artifactory.newBuildInfo()
  // }

  //stage('Test') {

   //dir('my-app') {
   //  sh "${mvnHome}/bin/mvn -B -Dmaven.test.failure.ignore verify"
   //  step([$class: 'JUnitResultArchiver', testResults: "**/TEST-*.xml"])
   //}

  //  def buildInfoVerify = artifactoryMaven.run pom: 'pom.xml', goals: 'verify'
  //  step([$class: 'JUnitResultArchiver', testResults: "**/TEST-*.xml"])

  //  buildInfo.append(buildInfoVerify)
  //}

  // stage('Package') {
  //   // Run Maven:
  //   def buildInfoInstall = artifactoryMaven.run pom: 'pom.xml', goals: 'clean install'

  //   buildInfo.append(buildInfoInstall)

  //   // Publish the build-info to Artifactory:
  //   server.publishBuildInfo buildInfo
  // }

  // stage('Build Container') {
  //   // docker.withServer('tcp://docker0.autostructure.io:2375') {
  //     def image = docker.build('docker-local.docker.azcender.com/my-web-app:latest')

  //     image.push()
  //   // }
  // }
}
