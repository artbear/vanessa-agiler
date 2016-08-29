﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура;
	
	Если СинхронизацияИнициированаИзФормыЭлемента(ПараметрыВыполненияКоманды) Тогда
		ПараметрыФормы.Вставить("ТекущийЭлемент", ПараметрКоманды);

	Иначе
		ПараметрыФормы.Вставить("ТекущийЭлемент", ПараметрКоманды);

	КонецЕсли;

	ОткрытьФорму("Справочник.ПользовательскиеИстории.Форма.ФормаСинхронизации", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры

&НаКлиенте
Функция СинхронизацияИнициированаИзФормыЭлемента(ПараметрыВыполненияКоманды) 
	Результат = СтрНайти(ПараметрыВыполненияКоманды.Источник.ИмяФормы, "ФормаЭлемента") > 0;
	
	Возврат Результат;
КонецФункции
