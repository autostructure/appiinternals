#!/usr/bin/env groovy
// Jenkinsfile
// Build and test a Maven project

node {
  deleteDir()

  def mvnHome = tool 'M3'

  env.PUPPET_INSTALL_VERSION = "1.8.0"
  env.PUPPET_INSTALL_TYPE = "agent"

  // def server = Artifactory.newServer url: 'http://artifactory.azcender.com:8081/artifactory', username: 'admin', password: 'password'
  def server = Artifactory.server('artifactory')

  def artifactoryMaven = Artifactory.newMavenBuild()

  artifactoryMaven.tool = 'M3' // Tool name from Jenkins configuration
  artifactoryMaven.deployer releaseRepo:'libs-release-local', snapshotRepo:'libs-snapshot-local', server: server
  artifactoryMaven.resolver releaseRepo:'libs-release', snapshotRepo:'libs-snapshot', server: server

  def buildInfo = Artifactory.newBuildInfo()

  checkout scm

  // docker.image('docker-local.docker.azcender.com/puppet-tester').inside('--user root --name ruby --privileged') {
  //   stage('Start Docker Service') {
  //     sh 'service docker start'
  //   }

  sh 'echo $PATH'

  withRvm('ruby-2.3.2') {
    stage('Ruby Gems') {
      // sh 'gem uninstall hiera-puppet'
      sh 'gem install bundler --no-ri --no-rdoc'
      sh 'bundle install'
      // sh 'bundle update'
    }

    stage('Do Puppet Code Validation') {
      sh 'bundle exec rake validate'
    }

    stage('Do Puppet Code Lint') {
      sh 'bundle exec rake lint'
    }

    stage('Do Puppet OS Specs') {
     sh 'bundle exec rake spec'
    }

    stage('Do Puppet Acceptance') {
     sh 'bundle exec rspec spec/acceptance'
    }
  }
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

def withRvm(version, cl) {
    withRvm(version, "executor-${env.EXECUTOR_NUMBER}") {
        cl()
    }
}

def withRvm(version, gemset, cl) {
    RVM_HOME='$HOME/.rvm'
    paths = [
        "$RVM_HOME/gems/$version@$gemset/bin",
        "$RVM_HOME/gems/$version@global/bin",
        "$RVM_HOME/rubies/$version/bin",
        "$RVM_HOME/bin",
        "${env.PATH}"
    ]

    def path = paths.join(':')

    // withEnv(["PATH=${env.PATH}:$RVM_HOME", "RVM_HOME=$RVM_HOME"]) {
    withEnv(["PATH=$path:$RVM_HOME", "RVM_HOME=$RVM_HOME"]) {
        sh "set +x; source $RVM_HOME/scripts/rvm; rvm use --create --install --binary $version@$gemset"
    }

    withEnv([
        "PATH=$path",
        "GEM_HOME=$RVM_HOME/gems/$version@$gemset",
        "GEM_PATH=$RVM_HOME/gems/$version@$gemset:$RVM_HOME/gems/$version@global",
        "MY_RUBY_HOME=$RVM_HOME/rubies/$version",
        "IRBRC=$RVM_HOME/rubies/$version/.irbrc",
        "RUBY_VERSION=$version"
        ]) {
            // 'gem install bundler'
            cl()
        }
    }
