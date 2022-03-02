# Database course
Exercises from the database course.
# Language:
[English](https://github.com/l0w0l-Y/database-course#eng)

[Русский](https://github.com/l0w0l-Y/database-course#ru)

## ENG
Contains all exercises for the course of database.
### Exercise 1
1. Create a database "Filmography".
2. Create tables within this database: Films, Actors, Directors.

Movie (movies): Name(name), Description(description), Year(year), Genres (genres), Country (country), Budget(budget)
Actors (actors): Surname (surname), First name (name), Date of birth (birthday), Country of birth (motherland), Number of films (number_of_movies)
Directors (producer): Surname (surname), First name (name), Date of birth (birthday), Country of birth (motherland)

For films, define Name and Year as primary key
For actors, specify a new column that will be populated with the sequence
Do the same for directors.

Implement check constraints:
on the year field in the film table, that it must be greater than 1900 and less than the current + 10 years.
budget field should not be < 10000
the number of movies field must be greater than 5.

Surname First Name and Date of Birth must be unique for the actor

For the Director table, the Country of birth field should default to USA.

Fill tables with test values, 6 records each
 
3. Change the movie table:
a) remove primary keys
b) add an identifier column (id) with a hung sequence (sequence)
c) think about how to use Alter queries to put this sequence in order. Write requests.
### Exercise 2
1. Select all directors whose best film was made in 2000.
2. Display all directors who have made more than 5 films.
3. Select movie IDs with more than 10 actors
4. Add a rating field to the movies table. Get the top 10 highest rated movies made in the USA
5. Select all the different horror films starring actors from England
6. Select actors who starred with directors from England from 2007 to 2010
7. Estimate the average budgets of films released before 2000, from 2000 to 2005, from 2005 to 2010, from 2010 to the present.
8. Get the total budget of films that were shot by directors whose last name ends in "V" or "N".
9. Get maximum movie budgets by year
10. Get all films made before 2010 that have a budget less than any film made after 2010.
11. Get directors who have made at least one film whose budget is greater than the minimum film budget for 2015 and less than the maximum budget for 2016.
12. Get a list of directors who made at least one film before 2000, or who made exactly 10 films in total.
### Exercise 3
1. Select all directors whose best film was made in 2000.
2. Display all directors who have made more than 5 films.
3. Select the identifiers of films where more than 10 actors were filmed.
4. Add a rating field to the movies table. Get the top 10 highest rated movies made in the USA.
5. Select all the different horror films that have actors from England.
6. Select all genres of films for which there are more than 5 films in the database.
7. Get the second ten films by duration.
8. Display movie genres. which were filmed by a director from England or from France
### Exercise 4
1. Select all directors whose best film was made in 2000.
2. Display all directors who have made more than 5 films.
3. Select movie IDs with more than 10 actors
4. Add a rating field to the movies table. Get the top 10 highest rated movies made in the USA
5. Select all the different horror films starring actors from England
6. Select actors who starred with directors from England from 2007 to 2010
7. Estimate the average budgets of films released before 2000, from 2000 to 2005, from 2005 to 2010, from 2010 to the present.
8. Get the total budget of films that were shot by directors whose last name ends in "V" or "N".
9. Get maximum movie budgets by year
10. Get all films made before 2010 that have a budget less than any film made after 2010.
11. Get directors who have made at least one film whose budget is greater than the minimum film budget for 2015 and less than the maximum budget for 2016.
12. Get a list of directors who made at least one film before 2000, or who made exactly 10 films in total.

## RU
Содержит все задания по курсу базы данных.
### Упражнение 1
1. Создать БД "Фильмография".
2. В рамках данной БД создать таблицы: Фильмы, Актеры, Режиссёры.

Фильм (movies): Наименование(name), Описание(description), Год(year), Жанры (genres), Страна (country), Бюджет(budget)
Актеры (actors): Фамилия (surname), Имя(name), Дата рождения(birthday), Страна рождения(motherland), Число фильмов(number_of_movies)
Режиссёры (producer): Фамилия (surname), Имя(name), Дата рождения(birthday), Страна рождения(motherland)

Для фильмов определить первичным ключом Наименование и Год
Для актеров указать новый столбец, который будет заполняться с помощью последовательности
Для режиссеров поступить аналогично

Реализовать ограничения check:
на поле год в таблице фильм, что он должен быть больше 1900 и меньше текущего + 10 лет.
поле бюджет не должен быть < 10000
поле число фильмов должно иметь значение более 5.

Фамилия Имя и Дата рождения должны быть для актера уникальными

Для таблицы Режиссёр поле Страна рождения должна иметь значение по умолчанию USA.

Заполнить таблицы тестовыми значениями по 6 записей в каждой
 
3. Изменить таблицу фильмов:
а) удалить первичные ключи 
б) добавить столбец идентификаторов (id) с навешенной последовательностью (sequence)
в) подумать, как с помощью запросов Alter привести эту последовательность в порядок. Написать запросы.
### Упражнение 2
В рамках БД "Фильмография" произвести следующие изменения:
1. Организовать связи между таблицами, добавив недостающие поля в таблицы (на один фильм может приходится множество актеров и режиссеров).
2. Добавить в таблицу режиссёров связь с их лучшим фильмом в таблице фильмы. Подумать как бы это пришлось делать, если бы ссылка предполагалась изначально.
3. Поменять для таблицы фильмы первичный ключ: добавить новое поле(movie_id) и соответстувенно новую последовательность для этого поля.
4. Изменить значение по умолчанию для поля Страна на "UK".
5. Удалить ограничение на число фильмов для актеров.
6. Поменять ограничение на бюджет фильма: поле бюджет не должен быть < 1000. 
7. Выделить жанры в отдельную таблицу, организовать межтабличную связь.
8. Изменить тип для поля страна рождения. Сделать его перечислением из следующих вариантов ("USA", "UK", "Russia", "France", "Germany")
9. Добавить проверку на поле дата рождения: она не должна превышать текущую дату.
10. Создать представлеиие, которое будет возваращать информацию об актераз, которые снимались в фильмах, которые вышли после 2000 года.
11. Обновить таблицу фильмов. Добавить в название в скобках год издания фильма.
### Упражнение 3
1. Отобрать всех режиссёров, у которых лучший фильм был снят в 2000 году. 
2. Вывести всех режиссёров, которые сняли более 5 фильмов.
3. Отобрать илентификаторы фильмов, где снималось более 10 актёров.
4. Добавить поле оценка в таблицу фильмов. Получить топ-10 фильмов с наивысшей оценкой, снятых в США.
5. Отобрать все различные фильмы ужасов, в которых снимались актёры родом из Англии.
6. Отобрать все жанры фильмов, по которым в базе данных присутствует более 5 фильмов.
7. Получить вторую десятку фильмов по продолжительности.
8. Вывести жанры фильмов. которые снимал режиссер из Англии или из Франции
### Упражнение 4
1. Отобрать всех режиссёров, у которых лучший фильм был снят в 2000 году. 
2. Вывести всех режиссёров, которые сняли более 5 фильмов.
3. Отобрать идентификаторы фильмов, где снималось более 10 актёров
4. Добавить поле оценка в таблицу фильмов. Получить топ-10 фильмов с наивысшей оценкой, снятых в США
5. Отобрать все различные фильмы ужасов, в которых снимались актёры родом из Англии
6. Отобрать актеров, которые снимались у режиссёров из Англии с 2007 по 2010 год
7. Оценить средние бюджеты фильмов, вышедших до 2000 года, с 2000 по 2005, с 2005 по 2010, с 2010 по настоящее время.
8. Получить суммарный бюджет фильмов, которы снимались режиссёрами, фамилия которых заканчивается на "V" или "N".
9. Получить максимальные бюджеты фильмов по годам
10. Получить все фильмы, снятые до 2010 года, бюджет которых меньше бюджета любого фильма снятого после 2010 года.
11. Получить режиссеров, которые сняли хотя бы один фильм бюджет которого больше минимума бюджета фильмов за 2015 год и меньше максимумального бюджета за 2016 год.
12. Получить список режиссеров, которые сняли хотя бы один фильи до 2000 года, или которые сняли всего ровно 10 фильмов.
