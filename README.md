# gtrd-site

#### install
для фронтенда на машине должен быть node >= 6, устанавливается nodejs

дальше из приложения gtrd-site
-- вызвать npm install - будет скачано 100+ мб
-- mvn install -U -Dmaven.artifact.threads=1
 

#### Database
- config connection profile in file: [src/connectionProfiles.local.yaml](https://github.com/QProgS/testBe5app/blob/master/src/connectionProfiles.local.yaml) 
- create file src/profile.local with name of connection, for example: "test_local"
- create database

```sh
mvn be5:create-db
или если нужно только обновить
mvn be5:sync
```

#### Frontend
Фронтенд собирается в src/main/webapp/

```sh
//установить зависимости
npm install
//Режим разработки
npm start
//На своей машине быстрее собрать незжатый 
npm run build
//На сервере собирается
npm run build-min
```
Можно также взять готовый фронтенд из https://github.com/DevelopmentOnTheEdge/be5-react/tree/master/dist/compressed

#### Update production

```sh
mvn -DBE5_PROFILE=pbx3 clean install -Pwar 
```
Подменить в war ```src/profile.local``` свой профиль на pbx3  
Подменить war на ```docker.dote.ru:/servers/gtrd-be5/docker.in/webapps/ROOT.war```  

#### Run Test Be5 application!
Просто запустите main метод

```java
public class Be5TestAppMain
{
    public static void main(String... args)
    {
        new EmbeddedJetty().run();
    }
}
```

Или
 
```sh
mvn clean install jetty:run -Djetty.http.port=8200
```

#### Authentication
Login: Administrator  
Password: 12345

Если вы воспользовались вторым вариантом запуска тогда нужно настроить debug
#### Debug, Hot Swapping With Maven, Jetty and IntelliJ
[Hot Swapping With Maven, Jetty and IntelliJ](https://gist.github.com/naaman/1053217)
```text
1)In VM Parameters, enter:
  -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=4000
2)add Add New Configuration -> Remote 
```

#### Dev
Для обновления yaml проекта без перезапуска настройте dev.yaml    
[Быстрое обновление dev.yaml](https://github.com/DevelopmentOnTheEdge/be5/wiki/%D0%91%D1%8B%D1%81%D1%82%D1%80%D0%BE%D0%B5-%D0%BE%D0%B1%D0%BD%D0%BE%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-dev.yaml)
