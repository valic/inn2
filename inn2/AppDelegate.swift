//
//  AppDelegate.swift
//  inn2
//
//  Created by Мялин Валентин on 20.10.14.
//  Copyright (c) 2014 mialin. All rights reserved.
//

import Cocoa

// расширение для добавления функциональности
extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "ru_UA_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
}
//123


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var inputINN: NSTextField!
    @IBOutlet weak var labelStatus: NSTextField!
    @IBOutlet weak var outDataOfBirth: NSTextField!
    @IBOutlet weak var outImageSex: NSImageView!

    @IBOutlet weak var testOut: NSTextField!
    @IBOutlet weak var checkINN: NSButton!
    @IBAction func checkINN(sender: AnyObject) {

        var mas = [Int] ()
        var outINN = String()
        var errorsScalar = String()
        
        func checkState () ->Bool // проверка чекбокса
        {
            if checkINN.state == 1
            { return true }
            else
            {return false}
            
       }
        let checkStateBoolean = checkState()
        
        func clearView() // очитка полей ( вида )
        {
            outDataOfBirth.stringValue = ""
            outImageSex.image = nil
           // labelStatus.stringValue = ""
        }
        clearView()
        
        
        var test = inputINN.integerValue // для тестирования
        testOut.integerValue = test
        
        
        
        // Разобрать в масив
        for scalar in inputINN.stringValue        {
            
            if scalar == "0" || scalar == "1" || scalar == "2" || scalar == "3" || scalar == "4" || scalar == "5" || scalar == "6" || scalar == "7" || scalar == "8" || scalar == "9" //быдло код но пока не знаю как написать лучще
            {
            mas.append(String(scalar).toInt()!)
            outINN += String(scalar)
            }
            else
            {
                errorsScalar += String(scalar) + "," // ошибочные символы
            }
            
        }
        
        inputINN.stringValue = outINN //выводим измененую строку ИНН, тепеь только числа
        if errorsScalar != "" {
        labelStatus.stringValue = "Удалены недопустимые символы \(errorsScalar)"
        }
        if mas.count != 10
        {
            clearView()
            labelStatus.stringValue += " ИНН должен быть длиною 10 символов."
        }
        else
        {
        
        // Функция расчета контролього числа
        func control() ->Int
        {
            var controlFigure = [Int] ()
            controlFigure.append(mas[0]*(-1))
            controlFigure.append(mas[1]*5)
            controlFigure.append(mas[2]*7)
            controlFigure.append(mas[3]*9)
            controlFigure.append(mas[4]*4)
            controlFigure.append(mas[5]*6)
            controlFigure.append(mas[6]*10)
            controlFigure.append(mas[7]*5)
            controlFigure.append(mas[8]*7)
            return ((controlFigure.reduce(0, +))%11)%10
        }
            
           
            
        if mas[9] != control() && !checkStateBoolean
        {
                clearView()
                labelStatus.stringValue += "ИНН введен не правильно"
        }
        else
        {
            // Пол
            if mas[7]%2==0 {
                
                outImageSex.image = NSImage(named:"woman125.png")
            }
            else
            {
                outImageSex.image = NSImage(named:"business57.png")
            }
            
            
        var tesy = NSImage(named:"woman125.png")
        
        // создаем переменую, с типом календаря
        
        let myCalendar: NSCalendar = NSCalendar ( calendarIdentifier:NSGregorianCalendar )!
        let components = NSDateComponents()
        components.day = (mas[0].description + mas[1].description + mas[2].description + mas[3].description + mas[4].description).toInt()!-1
        var date = myCalendar.dateByAddingComponents(components, toDate: NSDate(dateString:"1900-01-01"), options: nil)
        
       
            outDataOfBirth.stringValue = NSDateFormatter.localizedStringFromDate(date!, dateStyle: .MediumStyle, timeStyle: .NoStyle)
            
    
    
    
    
    
    
    
    
            }
        }
    }
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Вставьте код для инициализации приложения
        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Вставьте код здесь снести вашу заявку
        println(inputINN.integerValue)
    }


}

