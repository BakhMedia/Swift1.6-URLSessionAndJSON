# URLSessionAndJSON
### Урок 6.

Мы часто приводим в пример социальные сети такие как **Instagram**, **Vk**, **Facebook**. Сегодня поговорим об еще одной их особенности. Все эти приложения связаны с сервером. То есть вы можете зайти используя браузер на ноутбуке, а можете и с помощью приложения на мобильном телефоне. И там и там вы увидите один и тот же контент. Эта информация для отображения берется именно с сервера или как говорят «с облака». Наше [приложение](https://github.com/BakhMedia/Swift1.5-UITableViewAndDelegate) на экране «**Лента**» сейчас показывает то что мы заранее в него заложили в массиве items. Сегодня мы разберем каким образом получать информацию с сервера, мы заранее его подготовили для Вас ссылочка будет в описании можете использовать её для своих упражнений. Сервер наш будет развиваться, но те ссылки которые мы вам дадим в уроках изменяться не будут — учитесь на здоровье🤓. Скачать нашу заготовку можно [здесь](https://github.com/BakhMedia/Swift1.5-UITableViewAndDelegate) и погнали 😎.


Сначала разберем как получить какую-то информацию с сервера. Вот наша ссылочка: [http://triangleye.com/bakh/lessons/swift/s6/](http://triangleye.com/bakh/lessons/swift/s6/) . Она есть в описании и можете сейчас поставить на паузу и просто кликнув перейти по этой ссылке, вы увидите странную страницу, в которой на первый взгляд ничего не понятно. Это довольно распространенный формат для обмена информацией и называется **JSON**. Но не будем спешить, обо всем по порядку.
``` json
[{"id":"1","link":"https:\/\/www.youtube.com\/watch?v=FYT_XH0Rykk","title":"\u00d3\u00f0\u00ee\u00ea\u00e8 \u00ef\u00f0\u00ee\u00e3\u00f0\u00e0\u00ec\u00ec\u00e8\u00f0\u00ee\u00e2\u00e0\u00ed\u00e8\u00ff \u00ef\u00ee Swift (iOS) \u00e8 Java (Android) \u00f1 \u00f1\u00e0\u00ec\u00ee\u00e3\u00ee \u00ed\u00e0\u00f7\u00e0\u00eb\u00e0","cover":"https:\/\/i.ytimg.com\/vi\/FYT_XH0Rykk\/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLDO6yRoNfJ1vR_RN52BaaCkmBubAw","creation_time":"1532403898"},{"id":"2","link":"https:\/\/www.youtube.com\/watch?v=sD5_7Y-KMLU","title":"1 \u00d3\u00f0\u00ee\u00ea \u00ef\u00f0\u00ee\u00e3\u00f0\u00e0\u00ec\u00ec\u00e8\u00f0\u00ee\u00e2\u00e0\u00ed\u00e8\u00ff \u00ef\u00ee Swift (iOS\/iPhone) \u00e4\u00eb\u00ff \u00ed\u00ee\u00e2\u00e8\u00f7\u00ea\u00ee\u00e2. \u00c2\u00fb\u00e2\u00ee\u00e4 \u00e8 \u00cf\u00ee\u00e7\u00e8\u00f6\u00e8\u00ee\u00ed\u00e8\u00f0\u00ee\u00e2\u00e0\u00ed\u00e8\u00e5.","cover":"https:\/\/i.ytimg.com\/vi\/sD5_7Y-KMLU\/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLD1C6KJxg5bU9hDdPWtYI_Lf-Udfg","creation_time":"1532405113"}] 
```
Давайте сделаем так чтобы наше приложение получило эту строку и выведем её в лог. Затем уже покажем что делать с json.
Не большое отступление чтобы посмотреть и понять структуру  json формата, очень удобно использовать json-formater`ы и валидаторы. Я привык использовать [https://jsonformatter.org](https://jsonformatter.org) в левую часть вставляем наш json. нажимаем Format и в правой части появляется удобное представление этого формата:
Видим 2 объекта, в каждом 5 параметров: id, link, title, cover, creationTime.2. Добавим в **FeedViewController** код в функцию viewDidLoad со следующим содержанием.
``` swift
let url = URL(string: "http://triangleye.com/bakh/lessons/swift/s6/")!
var request = URLRequest(url: url)
request.httpMethod = "GET"
URLSession.shared.dataTask(with: request) {data, response, error in
    if (error != nil) {
        print("Server error is", error ?? "unknow")
        return
    }
    print("Server returns: ", String(data: data!, encoding: String.Encoding.utf8) ?? "")
}.resume()
```
Разберем по строкам:
- первая строка — создадим переменную типа URL, указав нашу ссылку;
- вторая строка — еще одна переменная **URLRequest**, она создается от нашего url;
- в третьей строке указываем тип запроса. Мы используем **GET**. Есть и другие типы **POST**, **PUT** и другие, о всех них мы поговорим отдельно;
- следующая строка посложнее, но в ней мы как раз и используем заветный класс URLSession. Обращаемся к его инстансу и задаем задачу для нашего request. Далее определяем три переменные которые должна вернуть наша задача (dataTask): **data** — ответ от сервера или как говорят тело ответа; **response** — метаданные ответа от сервера, типа **URLResponse**, пока не будем разбирать эту переменную; **error** — ошибка ответа сервера, грубо говоря если в ней что-то есть, значит есть и ошибка. Вообще в программировании почти на любом языке принято что если код ошибки равен ноль, то ошибки нет и всё хорошо. Если же код больше или меньше ноля, то произошла ошибка.
- далее мы как раз проверим пустая ли ошибка. Здесь хочу обратить внимание на слово nil. Это слово означает отсутствие значения. Важно понимать это НЕ ноль, а именно отсутствие значения или не определенность. То есть если мы напишем var i:Int = 0, а это означает что переменная i равна нулю. Если же вместо 0 мы напишем nil, то переменная i не имеет значения. Этот концепт отсутствия значения у переменной важно понимать для будущего. В нашем коде мы проверяем а имеет ли значение переменная error и если она равна nil, то значит она не определена и ошибки нет. Если же она отлична, то есть не равна, значит произошла ошибка. при использовании if два знака равно (==) означает что мы проверяем равна ли переменная. Восклицательный знак же здесь означает отрицание, то есть условие выполнится если переменная НЕ равна тому с чем мы её сравниваем и код будет выполняться только в этом случае.
- далее по коду мы описываем что же сделать приложению если с сервером произошла какая-либо ошибка. Ошибки могут быть самые разные и не обязательно что это ошибка программистов сервера или мобильного приложения. К примеру ошибка может быть вызвана если у вас элементарно нет интернета, в тоннеле на машине едете к примеру🛰. В этом случае наш **dataTask** вернет ошибку «по таймауту». Поэтому мы сообщаем что просто выведи в лог что именно за ошибка случилась с помощью функции print и в следующей строке напишем ключевое слово return, означающее выход из текущей функции.
- мы проверили вернулась ли нам ошибка от сервера, описали что делать в случае ошибки. Теперь же напишем что делать приложению если ошибки не случилось. Мы пока просто выведем в лог что же нам отдал сервер по нашей ссылке и будем надеется что мы увидим там те же данные что мы видели и в браузере🤞.
- последняя строка самая простая на первый взгляд, но она то и запускает весь код который мы написали выше. просто закроем скобку и обратившись к нашему **dataTask** вызовем его метод **resume()**. В этот момент **iOS** отправит запрос на сервер и будет ждать ответа.

Однако если сейчас попробуем запустить приложение, то увидим следующее сообщение в логах:
```
App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.
Cannot start load of Task <********-****-****-****-************>.<1> since it does not conform to ATS policy
Task <********-****-****-****-************>.<1> finished with error - code: -1022
Server error is Error Domain=NSURLErrorDomain Code=-1022 "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection." UserInfo={NSUnderlyingError=0x60800044d710 {Error Domain=kCFErrorDomainCFNetwork Code=-1022 "(null)"}, NSErrorFailingURLStringKey=http://triangleye.com/bakh/lessons/swift/s6/, NSErrorFailingURLKey=http://triangleye.com/bakh/lessons/swift/s6/, NSLocalizedDescription=The resource could not be loaded because the App Transport Security policy requires the use of a secure connection.}
```

3. Это сообщение означает что наше приложение не запрашивает доступ для сетевых запросов и операционная система **iOS** ей отказывает в этом запросе. Однако по тексту мы видим подсказку что мы можем сконфигурировать эти права в файле **Info.plist**. Наведем на **Information Property List** и нажмём плюсик. Иногда не с первого раза нажимается. Должна появится новая строка с возможностью ввода текста. Наберем **App Transport Security Settings**, **Xcode** предложит нам его в вариантах. Нажмем еще один плюсик теперь около новой строки, появится новая и туда напишем **Allow Arbitrary Loads**. Выставим его значение в **YES**. 

![Image1](https://raw.githubusercontent.com/BakhMedia/Swift1.6-URLSessionAndJSON/master/images/1.gif "Image1")


Теперь запуская наше приложение в логах мы увидим что-то в духе этого:
```
Server returns:  Optional("[{\"id\":\"1\",\"link\":\"https:\\/\\/www.youtube.com\\/watch?v=FYT_XH0Rykk\",\"title\":\"\\u00d3\\u00f0\\u00ee\\u00ea\\u00e8 \\u00ef\\u00f0\\u00ee\\u00e3\\u00f0\\u00e0\\u00ec\\u00ec\\u00e8\\u00f0\\u00ee\\u00e2\\u00e0\\u00ed\\u00e8\\u00ff \\u00ef\\u00ee Swift (iOS) \\u00e8 Java (Android) \\u00f1 \\u00f1\\u00e0\\u00ec\\u00ee\\u00e3\\u00ee \\u00ed\\u00e0\\u00f7\\u00e0\\u00eb\\u00e0\",\"cover\":\"https:\\/\\/i.ytimg.com\\/vi\\/FYT_XH0Rykk\\/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLDO6yRoNfJ1vR_RN52BaaCkmBubAw\",\"creation_time\":\"1532403898\"},{\"id\":\"2\",\"link\":\"https:\\/\\/www.youtube.com\\/watch?v=sD5_7Y-KMLU\",\"title\":\"1 \\u00d3\\u00f0\\u00ee\\u00ea \\u00ef\\u00f0\\u00ee\\u00e3\\u00f0\\u00e0\\u00ec\\u00ec\\u00e8\\u00f0\\u00ee\\u00e2\\u00e0\\u00ed\\u00e8\\u00ff \\u00ef\\u00ee Swift (iOS\\/iPhone) \\u00e4\\u00eb\\u00ff \\u00ed\\u00ee\\u00e2\\u00e8\\u00f7\\u00ea\\u00ee\\u00e2. \\u00c2\\u00fb\\u00e2\\u00ee\\u00e4 \\u00e8 \\u00cf\\u00ee\\u00e7\\u00e8\\u00f6\\u00e8\\u00ee\\u00ed\\u00e8\\u00f0\\u00ee\\u00e2\\u00e0\\u00ed\\u00e8\\u00e5.\",\"cover\":\"https:\\/\\/i.ytimg.com\\/vi\\/sD5_7Y-KMLU\\/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLD1C6KJxg5bU9hDdPWtYI_Lf-Udfg\",\"creation_time\":\"1532405113\"}]")
```

4. Что ж это как раз наша строка, с небольшой разницей по сравнению с тем что мы видели в браузере кликая на ссылку. Отлично! Наше приложение только что получило информацию с сервера. Чуть-чуть разберемся. Наш сервер работает по протоколу **http**, а наше приложение используя **http-клиент** подключилось к нему и получило определенную информацию. Это не единственный способ взаимодействия с сервером, но мы пока остановимся на этом. Позднее мы поговорим и о шифрованном соединении https и о способе передачи данных через сокеты wss.
5. Время написать класс **Feed**, в котором будут хранится данные наших элементов. Создадим файл **Feed.swift**. В нем будет следующий код:
``` swift
class Feed {

    public var cover: String
    public var link: String
    public var title: String

    init(data d: [String:Any]) {
        self.cover = d["cover"] as! String
        self.link = d["link"] as! String
        self.title = d["title"] as! String
    }

}
```


![Image4](https://raw.githubusercontent.com/BakhMedia/Swift1.6-URLSessionAndJSON/master/images/4.gif "Image4")



Разберем, как обычно по строкам:
первая строка — объявляем класс **Feed**
следующие 3 — объявляем переменные cover, link, title. Эти переменные будут браться из прилетевшего с сервера json`a. cover — обложка, адрес картинки, link — ссылка на ролик в ютюб, title —  его заголовок.
строка init … — описывает как как будет инициализироваться, а именно она будет создаваться из массива [String:Any] который мы получим из **JSON**.
Далее 3 строки просто достаем наши данные из этого массива

6. Раньше список наш строился из массива String. По логике теперь он будет строится из массива переменных Feed. В FeedViewController добавим новую переменную feeds:
``` swift
private var feeds: [Feed] = []
```
Поменяем наши функции UITableViewDataSource. Раньше в одной функции мы получали количество так: return items.count. меняем на return feeds.count. Во второй функции мы задавали заголовок для нашего элемента в этой строке:
cell.setTitle(title: items[indexPath.row])
Заменим её на:
``` swift
cell.setTitle(title: feeds[indexPath.row].title)
```
Раньше назначали просто строку из массива items. Теперь же берем объект **Feed** из массива feeds и обращаемся к его переменной title, которую описали в файле **Feed.swift**.

![Image5](https://raw.githubusercontent.com/BakhMedia/Swift1.6-URLSessionAndJSON/master/images/5.gif "Image5")

7. Отлично! Теперь добавим обработку ответа от сервера. Вставим этот текст:
``` swift
    let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
    if let responseJSON = responseJSON as? [Any] {
        print(responseJSON)
        self.feeds.removeAll()
        for f in responseJSON {
            self.feeds.append(Feed(data: f as! [String:Any]))
        }
        DispatchQueue.main.async {
            self.feedList.reloadData()
        }
    } else {
        print("json error")
        // TODO: if server not json format response return standrd error
    }
```

![Image2](https://raw.githubusercontent.com/BakhMedia/Swift1.6-URLSessionAndJSON/master/images/2.gif "Image2")

Разберем этот кусок, как мы любим построчно и по-русски😆:
- первая строка — создаем переменную **responseJSON** и приравниваем её к страшной конструкции. Что такое try? Мы выпустим отдельный теоретический разбор этого слова, пока же скажем что это защита от ошибок в приложении. **JSONSerialization** — стандартный класс в swift для сериализации json\`a. Сериализация — грубо говоря это процедура чтения какого-либо формата. Ну и скармливая нашу переменную data функции **jsonObject** пытаемся получить наш объект.
- Далее проверим получилось ли у нас сериализовать 
- и если да, то выведем его в лог чтоб посмотреть как он выглядит в сериализованном виде:
- уже более структурировано в отличие от того что мы видели в браузере, и уже можно разобрать по строкам, что хранится в нашем объекте: cover, creation_time, id, link, title. То что передал нам сервер и интересующие нас переменные мы используем в объекте Feed.
- remove — значит удалить, all — значит всё. removeAll() — функция очищает наш массив, на всякий случай, неизвестно куда наш код перекочует в будущем.
- далее пройдемся по полученном из json массиву и разложим все наши feed`ы в массив feeds.
- ну и осталось просто обновить содержимое нашей таблицы. Так как это действие связано с UI (UserInterface), а мы сейчас находимся в асинхронном действии, а именно запросе к серверу, то нам надо выполнять его в определённом стеке задач, а именно в главном. Это делается чтобы интерфейс приложения не подвисало.

8. Запустим наше приложение, увидим что теперь в нашем списке отображаются новые элементы, которые приходят к нам с сервера. То есть на момент прохождения урока у Вас уже могут быть совсем другие элементы.
9. Немного подитожим. Сегодня мы с вами увидели что такое JSON и как с ним работать на swift. Посмотрели простой пример использования URLSession и как работает асинхронный запрос http. Так же создали свой тип переменной Feed и сделали массив этих переменных, стало понятно что создать свой тип переменной довольно просто, а сделать массив этих переменных еще проще. В следующем уроке мы с вами сделаем наш список feed`ов симпатичнее и вставим в него картинки, также по нажатию будет открывать ссылку на ютюб.


**Сейчас попробуйте по памяти все повторить, желательно 2-3 раза.**






