## Описание

Приложение для инициализации окружения разработки </br>

###### env 01

```
stack: express - typescript
bundler: webpack
```

###### env 02

```
stack: react - typescript - postcss
testing: jest - react-testing-library - cypress
bundler: webpack
```

## Установка

```
npm install -g @ihvoschevskiy/environments
```

## Использование

```
envs
```

## Скрипты

```
add.sh создает сущности Component, Layout, Page
  - создает директории в соответсвии со структурой проекта;
  - создает файлы *.tsx и *.css внутри директории;
  - добавляет шаблонный код в указанные файлы;

  # использование
    -c Button
    -c Button -l Header Footer -p AboutPage
```

```
math.sh производит расчет значений clamp функции css
  - на вход принимает min и max значения вьюпорта в px;
  - преобразует полученные значения в rem;
  - использует линейную регрессию для расчета среднего значения функции clamp;
```

```
commit.sh упращает работу с issue ветками
  - перед коммитом запускает скрипты lint и prettier;
  - делает коммит issue ветки;
  - делает merge issue ветки в dev ветку;
  - удаляет issue ветку;
```

```
rm_gitkeep.sh удаляет файлы .gitkeep из проекта
  - если файл .gitkeep единственный в директории, он остается;
  - если в директории с файлом .gitkeep есть любой другой файл или директория, он удаляется;
```

## Использование скриптов

запустить `run.sh`, находящийся в корне проекта
