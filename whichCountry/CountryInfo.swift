import UIKit
import CoreTelephony

class CountryInfo: NSObject
{
	private var currency:String?
	private var theCarrier:CTCarrier?
	
	private lazy var currencyData:Dictionary<String, String> = Dictionary<String, String>();
	
	var CARRIER:CTCarrier?
	{
		get{return theCarrier;}
			
		set
		{
			theCarrier = newValue;
			configureCurrentcy();
		}
	}

	var CURRENCY:String?
	{
		return currency;
	}
	
	override var description: String
	{
		//return "\(type(of: self))"
		return "Carrier Name: " + theCarrier!.carrierName! + " -- Mobile country Code: " + theCarrier!.mobileCountryCode! + " -- Network Code: " + theCarrier!.mobileNetworkCode! + " -- ISO Code: " +  theCarrier!.isoCountryCode!.uppercased();
	}
	
	private func configureCurrentcy()
	{
		if(currencyData.count <= 0) {
			populateCurrencyDictionary()
		}
		
		guard (theCarrier != nil) && (theCarrier?.isoCountryCode != nil) else {
			currency = "Unknown";
			return;
		}
		
		currency = currencyData[theCarrier!.isoCountryCode!.uppercased()]
	}
	
	private func populateCurrencyDictionary()
	{
		let filePath:String? = Bundle.main.path(forResource: "currency", ofType: "csv")
	
		do{
			let fileText = try String(contentsOf: URL(fileURLWithPath: filePath!))
	
			let arrCountries:Array<String> = fileText.components(separatedBy: "\n");
	
			for country in arrCountries
			{
				if(country.characters.count <= 0)
				{continue;}
	
				let arrCurrencyTokens:Array<String> = country.components(separatedBy: ":");
	
				currencyData[arrCurrencyTokens[arrCurrencyTokens.startIndex]] = arrCurrencyTokens[1];
			}
		}
		catch let error as NSError {
			print(error)
		}
	}//End populateCurrencyDictionary
}
