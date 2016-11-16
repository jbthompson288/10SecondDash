//
//  NSRange.swift
//  10SecondDash
//
//  Created by JB Thompson on 11/10/16.
//  Copyright © 2016 JB Thompson. All rights reserved.
//

import Foundation

extension NSRange {
    func range(for str: String) -> Range<String.Index>? {
        guard location != NSNotFound else { return nil }
        
        guard let fromUTFIndex = str.utf16.index(str.utf16.startIndex, offsetBy: location, limitedBy: str.utf16.endIndex) else { return nil }
        guard let toUTFIndex = str.utf16.index(fromUTFIndex, offsetBy: length, limitedBy: str.utf16.endIndex) else { return nil }
        guard let fromIndex = String.Index(fromUTFIndex, within: str) else { return nil }
        guard let toIndex = String.Index(toUTFIndex, within: str) else { return nil }
        
        return fromIndex ..< toIndex
    }
}


//NO LONGER NEEDED - TOOK OUT OF AVATARVIEWCONTROLLER
// MARK: - Text Field Limit Method (NO LONGER NEEDED)

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let currentText = textField.text ?? ""
//        guard let stringRange = range.range(for: currentText) else { return false }
//
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//
//        return updatedText.characters.count <= 3
//    }

  
