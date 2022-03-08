import Foundation

extension String {
	public var compress: String {
		guard var previous = self.first else {
			return ""
		}
		
		var count = 0
		var result = ""
		
		self.forEach { c in
			if c != previous {
				result += "\(count)\(previous)"
				previous = c
				count = 0
			}
			count += 1
		}
		
		return result + "\(count)\(self.last!)"
	}
}

assert("AAABBAAC".compress == "3A2B2A1C")
assert("AAABBAAAACCC".compress == "3A2B4A3C")