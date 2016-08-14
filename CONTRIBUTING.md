# Vanessa Flow

порядок коллективной разработки

## Подготовка окружения разработчика

* `git clone`
* `./tools/init.sh`
* откройте конфигуратор с базой 1С `.\build\ib\`

## Доработка

* `git branch feature/new-feature`
* используем vanessa-behavior
* пишет код, создаем метаданные
* `./tools/test.sh`
* `git pull my-fork feature/new-feature`
* создаёте `pull request` средствами GitHub

## Быстрые исправления

* `git branch hotfix/i-find-bug`
* используем vanessa-behavior
* исправляем неявное поведение
* `./tools/test.sh`
* `git pull my-fork hotfix/i-find-bug`
* создаёте `pull request` средствами GitHub

## CI-CD

использование `Jenkinsefile` позволяет произвести следующее

* инициировать автоматические проверки pull request'ов
* проверить автоматически функционал и стиль кодирования

в связи с чем, если Ваш pull-request не прошел проверку, то

* добейтесь `зеленой сборки`
* исправльте проблемы качества и технического долга
