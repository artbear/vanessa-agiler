#!groovy
node("slave") {
    stage "Получение исходных кодов"
    //git url: 'https://github.com/silverbulleters/vanessa-agiler.git'
    
    checkout scm
    if (env.DISPLAY) {
        println env.DISPLAY;
    } else {
        env.DISPLAY=":1"
    }
    env.RUNNER_ENV="production";

    if (isUnix()) {sh 'git config --system core.longpaths'} else {bat "git config --system core.longpaths"}

    if (isUnix()) {sh 'git submodule update --init'} else {bat "git submodule update --init"}
    
    stage "Контроль технического долга"

    if (env.QASONAR) {
        println env.QASONAR;

    } else {
        echo "QA runner not installed"
    }

    stage "Подготовка конфигурации и окружения"

    def srcpath = "./src/cf/";
    if (env.SRCPATH){
        srcpath = env.SRCPATH;
    }

    def v8version = "";
    if (env.V8VERSION) {
        v8version = "--v8version ${env.V8VERSION}"
    }
    def command = "oscript -encoding=utf-8 tools/init.os init-dev ${v8version} --src "+srcpath
    timestamps {
        if (isUnix()){
            sh "${command}"
        } else {
            bat "chcp 1251\n${command}"
        }
    }

    stage "Сборка поставки"
	
    echo "build catalogs"
    command = """oscript -encoding=utf-8 tools/runner.os compileepf ${v8version} --ibname /F"./build/ib" ./ ./build/out/ """
    if (isUnix()) {sh "${command}"} else {bat "chcp 1251\n${command}"}       
    
    stage "Проверка поведения BDD"
    def testsettings = "VBParams.json";
    if (env.PATHSETTINGS) {
        testsettings = env.PATHSETTINGS;
    }
    command = """oscript -encoding=utf-8 tools/runner.os vanessa ${v8version} --ibname /F"./build/ib" --path ./tools/vanessa-behavior/vanessa-behavior.epf --pathsettings ./tools/JSON/${testsettings} """
    def errors = []
    try{
        if (isUnix()){
            sh "${command}"
            
        } else {
            env.VANESSA_commandscreenshot='nircmd.exe savescreenshot '
            bat "chcp 1251\n${command}"
        }
    } catch (e) {
         errors << "BDD status : ${e}"
    }

    command = """allure generate ./build/out/allurereport -o ./build/htmlpublish"""
    if (isUnix()){ sh "${command}" } else {bat "chcp 1251\n${command}"}
    publishHTML(target:[allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: './build/htmlpublish', reportFiles: 'index.html', reportName: 'Allure report'])

    if (errors.size() > 0) {
        currentBuild.result = 'UNSTABLE'
        for (int i = 0; i < errors.size(); i++) {
            echo errors[i]; 
        }
    } else {
        //step([$class: 'ArtifactArchiver', artifacts: '**/build/out/*.cf', fingerprint: true])
    }

    stage "Публикация релизов"

    echo "stable if master, pre-release if have release, nigthbuild if develop"

}