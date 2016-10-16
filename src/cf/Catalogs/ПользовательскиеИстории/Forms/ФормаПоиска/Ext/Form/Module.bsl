﻿
&НаКлиенте
Процедура ЧеткостьПоискаРегулирование(Элемент, Направление, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если Направление > 0 Тогда
		ЧеткостьПоиска = ЧеткостьПоиска + 5;
		
	Иначе
		ЧеткостьПоиска = ЧеткостьПоиска - 5;
		
	КонецЕсли;
	
	Если ЧеткостьПоиска < 0 Тогда
		ЧеткостьПоиска = 100;
		
	ИначеЕсли ЧеткостьПоиска > 100 Тогда
		ЧеткостьПоиска = 0;
		
	КонецЕсли;
	
	ВыполнитьПоискНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура РезультатПоискаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.РезультатПоиска.ТекущиеДанные;
	
	Закрыть(ТекущиеДанные.НайденнаяСсылка);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПоиск(Команда)
	ВыполнитьПоискНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВыполнитьПоискНаСервере() 
	Если ПустаяСтрока(СтрокаПоиска) Тогда
		Возврат;
	КонецЕсли;
	
	РезультатПоискаНаСервере = РеквизитФормыВЗначение("РезультатПоиска");
	
	РезультатПоискаНаСервере.Очистить();
	
	СписокПоиска = ПолнотекстовыйПоиск.СоздатьСписок();
	
	СписокПоиска.СтрокаПоиска = СтрокаПоиска;
	СписокПоиска.ПорогНечеткости = 100 - ЧеткостьПоиска;
	
	ОбластьПоиска = Новый Массив;
	
	ОбластьПоиска.Добавить(Метаданные.Справочники[ИмяСправочника]);
	
	СписокПоиска.ОбластьПоиска = ОбластьПоиска;
	
	РазмерПорции = 10;
	
	СписокПоиска.РазмерПорции = РазмерПорции;
	
	Читаем = Истина;
	
	Попытка
		СписокПоиска.ПерваяЧасть();
		
	Исключение
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Не удалось выполнить поиск первой части.";
		Сообщение.Сообщить();	
		
		Читаем = Ложь;
		
	КонецПопытки;
	
	Счетчик = 0;
	
	Пока Читаем Цикл
		Если СписокПоиска.Количество() = 0 Тогда
			Читаем = Ложь;
		КонецЕсли;
		
		Для Каждого Строка Из СписокПоиска Цикл
			ПоложениеРазделителя = СтрНайти(Строка.Описание, ":");
			Если ПоложениеРазделителя > 0 Тогда
				СинонимИзОписания = Лев(Строка.Описание, ПоложениеРазделителя - 1);
				Если СинонимИзОписания = СинонимПоляПоиска Тогда
					НоваяСтрока = РезультатПоискаНаСервере.Добавить();
					
					НоваяСтрока.НайденнаяСсылка = Строка.Значение;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
		Попытка
			СписокПоиска.СледующаяЧасть(Счетчик);
			
		Исключение
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Не удалось выполнить поиск следующей части.";
			Сообщение.Сообщить();	
			
			Читаем = Ложь;
			
		КонецПопытки;
		
		Счетчик = Счетчик + РазмерПорции;
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(РезультатПоискаНаСервере, "РезультатПоиска");
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	СформироватьСтрокуПоиска(Параметры.ИсходнаяСтрокаПоиска);
	ЗаполнитьДополнительныеПоляПоиска(Отказ);
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДополнительныеПоляПоиска(Отказ)
	ТипЗначенияТекущегоСправочника = ТипЗнч(Параметры.ТекущийСправочник);
	Если Не Справочники.ТипВсеСсылки().СодержитТип(ТипЗначенияТекущегоСправочника) Тогда
		Отказ = Истина;
		
		Возврат;
	КонецЕсли;

	ИмяСправочника = Параметры.ТекущийСправочник.Метаданные().Имя;
	
	Если ТипЗначенияТекущегоСправочника = Тип("СправочникСсылка.ПользовательскиеИстории") Тогда
		СинонимПоляПоиска = "Заголовок";
		
	ИначеЕсли Ложь
		Или ТипЗначенияТекущегоСправочника = Тип("СправочникСсылка.Персоны")
		Или ТипЗначенияТекущегоСправочника = Тип("СправочникСсылка.КлючевыеДействия")
		Или ТипЗначенияТекущегоСправочника = Тип("СправочникСсылка.Функциональности")
		Тогда
		
		СинонимПоляПоиска = "Определение";
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СформироватьСтрокуПоиска(Знач ИсходнаяСтрокаПоиска)
	ИсходнаяСтрокаПоиска = ОбщегоНазначенияКлиентСервер.УбратьЛишниеПробелыИТабы(ИсходнаяСтрокаПоиска) + " ";
	
	Пробел = Новый Структура;
	
	Пробел.Вставить("Обычный", " ");
	Пробел.Вставить("Неразрывный", Символы.НПП);
	
	Оператор = " И "; 

	ПервоеСлово = Истина;
	
	СокращеннаяСтрокаПоиска = "";
	Пока Не ПустаяСтрока(ИсходнаяСтрокаПоиска) Цикл
		ПоложениеПробела = СтрНайти(ИсходнаяСтрокаПоиска, Пробел.Обычный);
		Если ПоложениеПробела = 0 Тогда
			ПоложениеПробела = СтрНайти(ИсходнаяСтрокаПоиска, Пробел.Неразрывный);
			Если ПоложениеПробела = 0 Тогда
				Прервать;
			КонецЕсли;
		КонецЕсли;
		
		ТекущееСлово = Лев(ИсходнаяСтрокаПоиска, ПоложениеПробела - 1);
		Если СтрДлина(ТекущееСлово) > 3 Тогда
			Если ПервоеСлово Тогда
				СокращеннаяСтрокаПоиска = ТекущееСлово;
				
				ПервоеСлово = Ложь;
				
			Иначе
				СокращеннаяСтрокаПоиска = СокращеннаяСтрокаПоиска	 + Пробел.Обычный + Оператор + Пробел.Обычный + ТекущееСлово;
				
			КонецЕсли;
		КонецЕсли;
		
		ИсходнаяСтрокаПоиска = Сред(ИсходнаяСтрокаПоиска, ПоложениеПробела + 1);
	КонецЦикла;

	СтрокаПоиска = СокращеннаяСтрокаПоиска;
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНеНайденныйОбъектИнфобазы(Команда)
	СоздатьНеНайденныйОбъектИнфобазыНаСервере();
КонецПроцедуры

&НаСервере
Процедура СоздатьНеНайденныйОбъектИнфобазыНаСервере()
	НовыйЭлемент = Справочники[ИмяСправочника].СоздатьЭлемент();
	
	НовыйЭлемент.УстановитьНовыйКод();
	
	Если ТипЗнч(НовыйЭлемент) = Тип("СправочникОбъект.ПользовательскиеИстории") Тогда
		НовыйЭлемент.Заголовок = Параметры.ИсходнаяСтрокаПоиска;
		
	Иначе
		НовыйЭлемент.Определение = Параметры.ИсходнаяСтрокаПоиска;
		
	КонецЕсли;

	НовыйЭлемент.Записать();

	РезультатПоискаНаСервере = РеквизитФормыВЗначение("РезультатПоиска");
	
	РезультатПоискаНаСервере.Очистить();
	
	НоваяСтрока = РезультатПоискаНаСервере.Добавить();
	
	НоваяСтрока.НайденнаяСсылка = НовыйЭлемент.Ссылка;

	ЗначениеВРеквизитФормы(РезультатПоискаНаСервере, "РезультатПоиска");
	
	ОбщегоНазначенияВызовСервера.ОбновитьИндексПолнотекстовогоПоиска();
КонецПроцедуры