﻿
Функция ПолучитьШаблонФичи() Экспорт
	Шаблон =	
	"# encoding: utf-8
	|# language: ru
	|
	|@userstory_#Номер
	|
	|Функционал: #Заголовок
	|	Как #Роль
	|	Хочу #НеобходимыйФункционал
	|	Чтобы #КлючевоеДействие
	|
	|Сценарий:
	|	Допустим
	|	Когда
	|	Тогда	";
	
	Возврат Шаблон;
КонецФункции

Процедура УбратьСКонцовПробелы(Текст) Экспорт
	Текст = СокрЛП(Текст);
КонецПроцедуры
