myhomepage_ruby
===============

This is my ruby project for the ruby course in FMI Sofia University.

The first time I started this project was when i was making my own little project in PHP .


How can you run it :
===========

* <b> Instalation </b> <br />
	```git clone https://github.com/PuloV/myhomepage_ruby``` <br />

* <b> Data Base </b> <br />
	Download <a href ="http://dev.mysql.com/downloads/" > MySQL </a> and install it .<br />

* <b> Preparation </b> <br />
	```bundle install``` <br />
	``` awesome_print ```  -  it is just for better debugging <br />

* <b> Set up your data base </b> <br />
	You can make forward engineering on MySQL WorkBenct on the file <br />
	```db.mwb ``` <br />

* <b> Run the site </b>  <br />
	In the folder you have this project just do
	``` ruby main.rb ```



======================

<p><h3> Проблеми и предстоящи неща (a.k.a TODO LIST) </h3>
	<ol>
		<li><strong><em>Новини</em></strong></li>
		<li><strong><em>Меню в новините , трябва да има иф за логнат потребител </em></strong></li>
		<li><strong><em>Колона в менютата за логнати и гости (menu_for_logged = bool)</em></strong> <br /> ( <b><i> ISSUE : </i></b> Трябва да има повтарящи се записи ако 1 линк ще се появява при потребител и гост !) </li>
		<li><strong><em>Класация на най посещавани ликове</em></strong><br /> ( <b><i> ISSUE : </i></b> За класацията на линкове показва първото име на линка ... може би е подобре да е вместо име линка ... но при дълъг линк ще стане "МНОГО КРАСИВО" ! :) )
		</li>
		<li><strong><em>По красиво Readme</em></strong></li>
		<li><strong><em>Поставяне на валидации (НЕМОЖЕ ДА СЕ ВЯРВА НА ПОТРЕБИТЕЛСКИ ВХОД)</em></strong>(<b><i>ISSUE :</i></b> <strong><em>При минимален размер на урл при добавяне на линк се чупи . Липсва валидация при едитване на линк ! </em></strong> )
		</li>
		<li><strong><em>Показване на грешки</em></strong></li>
		<li><strong><em>Повече опции относно юзерите</em></strong> (Смяна на парола и възстановяване на забравена парола ) </li>
		<li><b> ISSUE : Проблем с кирилски домейни !</b> иначе е оправена кирилицата </li>
		<li>Администраторски панел с прости функции</li>
	</ol>
	<br />
	<span><strong> Знам че трябва News (от таблицата news) да е New но е запазена дума и затова за сега така ще бъде . :) </strong></span>
	<span><strong> Знам че тестовете ми за линкове имат малко странни имена , но като комбинирам всички тестове в 1 ги подрежда лексикографски и изпълнява тестове за добавяне на линк на несъществуващ все още потребител ! </strong></span>
</p>

