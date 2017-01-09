import UIKit
import CoreTelephony

typealias carrierChangeNotification = ((CTCarrier) -> Swift.Void);

class ViewController: UIViewController
{
	@IBOutlet weak var lblMCC: UILabel!
	@IBOutlet weak var lblMNC: UILabel!
	@IBOutlet weak var lblCountry: UILabel!
	@IBOutlet weak var lblCurrency: UILabel!

	lazy var myCountryInfo:CountryInfo = CountryInfo();
	
	var m_CarrierNotification:carrierChangeNotification?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		m_CarrierNotification = carrierChanged;
		
		configureCountryInfo();
	}

	private func configureCountryInfo()
	{
		let netInfo:CTTelephonyNetworkInfo = CTTelephonyNetworkInfo();
		netInfo.subscriberCellularProviderDidUpdateNotifier = m_CarrierNotification!;
		
		myCountryInfo.CARRIER = netInfo.subscriberCellularProvider;
		
		print(NSLocale.current);
	}

	func carrierChanged(newCarrier:CTCarrier) -> Swift.Void
	{
		myCountryInfo.CARRIER = newCarrier;
	}

	@IBAction func onGetCountryInfo(_ sender: UIButton)
	{
		lblMCC.text = myCountryInfo.CARRIER?.mobileCountryCode;
		lblMNC.text = myCountryInfo.CARRIER?.mobileNetworkCode;
		lblCountry.text = myCountryInfo.CARRIER?.isoCountryCode?.uppercased();
		lblCurrency.text = myCountryInfo.CURRENCY?.uppercased();
	}
}

