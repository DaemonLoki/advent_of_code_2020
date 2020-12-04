//: [Previous](@previous)

import Foundation

let content = loadPuzzleInput(day: "4")!

/* Puzzle 1 */
let requiredFields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

func isValidPassport(creds: [(String, String)], strict: Bool = false) -> Bool {
    for field in requiredFields {
        if !creds.map({ $0.0 }).contains(field) {
            return false
        }
        
        if strict {
            guard let combo = creds.filter({ $0.0 == field }).first else { continue }
            if !doStrictValidation(creds: combo) {
            return false
            }
        }
        
    }
    
    return true
}

func getValidPassports(messyInput: String, strictMode: Bool = false) -> Int {
    let passportList = messyInput
        .components(separatedBy: "\n\n")
        .map { $0.replacingOccurrences(of: "\n", with: " ")}
        .map { $0.split(separator: " ") }
    
    var numberOfValidPassports = 0
    passportList.forEach { passportSequence in
        var pairs = [(String, String)]()
        for passportElement in passportSequence {
            let splittedElement = passportElement.split(separator: ":")
            let first = String(splittedElement[0])
            let second = String(splittedElement[1])
            pairs.append((first, second))
        }
        
        if isValidPassport(creds: pairs, strict: true) {
            numberOfValidPassports += 1
        }
    }
    return numberOfValidPassports
        
}

let passports = getValidPassports(messyInput: content)

print("Found \(passports) valid passports")

/* Puzzle 2 */
func validateFourDigits(_ yearString: String, in range: ClosedRange<Int>) -> Bool {
    if yearString.count != 4 { return false }
    
    guard let year = Int(yearString) else { return false }
    
    return range.contains(year)
}

func validateHeight(_ heightString: String) -> Bool {
    guard let value = Int(heightString.dropLast(2)) else {
        return false
    }
    
    if "m" == heightString.last {
        return (150...193).contains(value)
    } else if "n" == heightString.last {
        return (59...76).contains(value)
    }
    
    return false
}

func validateHairColor(_ color: String) -> Bool {
    guard let regex = try? NSRegularExpression(pattern: "#[a-f0-9]{6}") else { return false }
    guard let _ = regex.firstMatch(in: color, options: [], range: NSRange(location: 0, length: color.utf16.count)) else { return false }
    return true
}


func doStrictValidation(creds field: (String, String)) -> Bool {
    if field.0 == "byr" {
        return validateFourDigits(field.1, in: 1920...2002)
    } else if field.0 == "iyr" {
        return validateFourDigits(field.1, in: 2010...2020)
    } else if field.0 == "eyr" {
        return validateFourDigits(field.1, in: 2020...2030)
    } else if field.0 == "hgt" {
        return validateHeight(field.1)
    } else if field.0 == "hcl" {
        return validateHairColor(field.1)
    } else if field.0 == "ecl" {
        return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(field.1)
    } else if field.0 == "pid" {
        return field.1.count == 9
    }
    
    return true
}

let strictlyControlledPassports = getValidPassports(messyInput: content, strictMode: true)

print("Found \(strictlyControlledPassports) strictly valid passports")

//: [Next](@next)
