﻿
Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;

	Если Поля.Найти("Определение") = Неопределено Тогда
		Поля.Добавить("Определение");
	КонецЕсли;
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	Представление = Данные.Определение;
	
	СтандартнаяОбработка = Ложь;
КонецПроцедуры
