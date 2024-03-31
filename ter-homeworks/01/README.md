### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?

В файле personal.auto.tfvars

3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.

"result": "7VNm5GsIvw1nzT9y"

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.

Исправил строку resource "docker_image" { на resource "docker_image" "nginx"{
Была допущена ошибка в именовании контейнера - 1nginx, что не допускается, т.к. имя должно начинаться с буквы или символа подчёркивания.
Также ошибки в строке name  = "example_${random_password.random_string_FAKE.resulT}" , исправил на name  = "example_${random_password.random_string.result}"

5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.

Исправленный фрагмент:
```
resource "docker_image" "nginx"{
  name         = "nginx:latest"
  keep_locally = true
}


resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```


Docker ps:
```
nike@whirlwind:~/learn/netology/homeworks/ter-homeworks/01$ docker ps

CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES

170a1dcfc9b4   92b11f67642b   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:9090->80/tcp   example_7VNm5GsIvw1nzT9y
```

6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.

Опасность данного ключа в том, что изменения применяются без вопросов, что может повлечь проблемы типа потери данных или уничтожения какого-то ресурса.
Пригодиться он может при использовании в разработке или тестировании, где частые итерации в порядке вещей и затрагивание чего-то глобального маловероятно, также это применимо в автоматизированном тестировании.

Docker ps:
```
nike@whirlwind:~/learn/netology/homeworks/ter-homeworks/01$ docker ps

CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS         PORTS                  NAMES

d17dd6dc302f   92b11f67642b   "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds   0.0.0.0:9090->80/tcp   hello_world
```
8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
```
{
  "version": 4,
  "terraform_version": "1.5.7",
  "serial": 11,
  "lineage": "4eab2d2d-5ef5-eba9-88c8-093224100d93",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )

Образ не был удалён, т.к. в main.tf явно указана директива хранения локально.
```
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
```

