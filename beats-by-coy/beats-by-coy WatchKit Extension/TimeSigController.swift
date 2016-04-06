//
//  TimeSigController.swift
//  beats-by-coy
//
//  Created by Luke Coy on 3/9/16.
//  Copyright © 2016 Don't Believe Me, Just Watch. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class TimeSigController: WKInterfaceController {
    
    var signaturePicker: WKInterfacePicker?
    
    @IBOutlet var upperSignature: WKInterfaceButton!
    
    @IBOutlet var lowerSignature: WKInterfaceButton!
    @IBOutlet var upperPicker: WKInterfacePicker!
    @IBOutlet var lowerPicker: WKInterfacePicker!
    
    var timer = MetronomeTimer.instance
    
    var selectedSignature: WKInterfaceButton? {
        willSet(val) {
            selectedSignature?.setBackgroundColor(UIColor.blackColor())
        }
        
        didSet {
            selectedSignature?.setBackgroundColor(UIColor.blueColor())
            if selectedSignature == upperSignature {
                signaturePicker = upperPicker;
            } else if selectedSignature == lowerSignature{
                signaturePicker = lowerPicker;
            } else {
                signaturePicker = nil;
            }

        }
    }
    
    func createPickerItem(n: integer_t) -> WKPickerItem {
        let pickerItem = WKPickerItem()
        pickerItem.title = String(n)
        pickerItem.caption = String(n)
        return pickerItem
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        upperSignature.setTitle(String(timer.timeSignature.beatsPerBar));
        lowerSignature.setTitle(String(timer.timeSignature.noteValue));
        upperPicker.setItems((1...12).map(createPickerItem));
        lowerPicker.setItems((1...12).map(createPickerItem));
        upperPicker.setHidden(true)
        lowerPicker.setHidden(true)
        
        print("YO?!?!?!")
    }

    
    @IBAction func onUpperTap() {
        selectSignature(upperSignature)
    }
    
    
    @IBAction func onLowerTap() {
        selectSignature(lowerSignature)
    }
    
    @IBAction func onUpperSet(value: Int) {
        selectedSignature?.setTitle(String(value + 1));
        
        timer.timeSignature.beatsPerBar = value + 1;
    }
    @IBAction func onLowerSet(value: Int) {
        selectedSignature?.setTitle(String(value + 1));
        
        timer.timeSignature.noteValue = value + 1;
    }
    
    func selectSignature(button: WKInterfaceButton?) {
        signaturePicker?.setHidden(true);
        signaturePicker?.resignFocus();
        
        if selectedSignature == button {
            selectedSignature = nil;
        } else {
            selectedSignature = button
        }
        
        signaturePicker?.setHidden(false)
        signaturePicker?.focus();
        if selectedSignature == upperSignature {
            signaturePicker?.setSelectedItemIndex(timer.timeSignature.beatsPerBar - 1)

        } else if selectedSignature == lowerSignature {
            signaturePicker?.setSelectedItemIndex(timer.timeSignature.noteValue - 1)
            
        }
 
    }
    
} 
