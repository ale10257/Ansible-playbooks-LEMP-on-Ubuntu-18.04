### Ansible playbooks: install LEMP (nginx + php7.4-fpm + Mysql) + Certbot on Ubuntu 18.04

-- Клонируем репозиторий

-- Из файла hosts.yml.example создаем рабочий файл hosts.yml с верными переменными

-- При необходимости добавляем нужные расширения для php7.4-fpm в файле install_php.yml

```
        -   name: Install php-fpm 7.4
            apt:
                name:
                    - php7.4-fpm
                    ...
                    ...
                    ...
                    - php7.4-your_ext
                state: present
                update_cache: yes
```  
-- В папке с проектом запускаем команду `make init`

-- В случае необходимости отдельно запускаем команду `make create_certbot` для возможности работы по https протоколу

В результате, на удаленном узле, будет развернут LEMP сервер, также будет создан пользователь, в домашней директории которогу будут храниться сайты.

##### Для создания виртуального хоста

-- Клонируем папку **roles/example_host** c нужным названием, например, **roles/api_host**

-- В файле **roles/api_host/defaults/main.yml** прописываем верное название хоста, например, **api.example.com**

-- Переименовываем файл **roles/api_host/templates/example.com.j2** в соответствии с вашим хостом, например, **api.example.com.j2**  
**Важно: файл должен называться именно так, как ваш хост!**

-- Если нет необходимости в работе по https протоколу, в файле **roles/api_host/tasks/main.yml** удаляем строку `- import_tasks: add_certificate.yml`


-- Создаем playbook по образцу `add_host.yml.example`, например, `add_api_host.yml`, прописываем нужную роль, например:
```
    roles:
        - api_host
```

Запускаем команду: `ansible-playbook -i hosts.yml add_api_host.yml`