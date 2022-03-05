import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:testflutter/coinCard.dart';

void main() {
 
  runApp(const MyApp());
  
}


class Crypto
  {
     final double USD;
     const Crypto({required this.USD});

     factory Crypto.fromJson(Map<String,dynamic> json)
     {
        return Crypto(USD: json['USD']);
        
     }
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     //_MyHomePageState _myhome = new _MyHomePageState();
      //Timer.periodic(Duration(seconds: 5), (Timer t) => _myhome._getResult());
    return MaterialApp(
      title: 'BexCrypto by Mahmut Can Gönül',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'BexCrypto App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   
   String _data="";
   double _usd = 0;
   var _currencies = <String>['BTC','ETH','XRP','LUNA','SOL','ADA','AVAX','DOT','DOGE',
   'SHIB','MATIC','CRO','DAI','ATOM','LTC','NEAR','LINK','UNI','FTT','TRX','ALGO','MANA',
   'FTM','XLM','HBAR','ICP'];
   var _prices = <double>[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
   0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
   var _firstprices = <double>[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
   0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
     
Future<Crypto> _request(String _currency)async
{
    final _response = await http.get(
     Uri.parse('https://min-api.cryptocompare.com/data/price?fsym='+_currency+'&tsyms=USD')
   );
if(_response.statusCode == 200)
{
     if(_response.body.length > 25)
     {
         throw Exception("Failed to load Cryptos");  
     }
   
   return Crypto.fromJson(jsonDecode(_response.body));
}
else
{
   throw Exception('Failed to load Cryptos');
}

}


void _getResult()async
{
   try
   {
      
       for(int i=0; i<_prices.length;i++)
     {
        if(_prices[i] > 0) // This is not a first values
        {
             _firstprices[i] = _prices[i];
        }
     }

     for(int i=0; i<_currencies.length;i++)
     {
           Crypto crypto = await _request(_currencies[i]);
           if(crypto != null)
           {
             _usd = crypto.USD;
             _prices[i] = _usd;
           }
           //_data = _usd.toString()+" USD";
           //print(_prices[i]);
     }

     setState(()
     {
          _prices;
     });
     


   }catch(e)
   {
           print(e);
   }
     
}

  void _incrementCounter(){
    setState((){
      _getResult();      
    });
  }


@override
void initState() {
    setState((){
      _getResult();
    });
    Timer.periodic(Duration(seconds: 10), (timer) => _getResult());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
            scrollDirection: Axis.vertical,
            children:[CoinCard(
               name:'Bitcoin',
               symbol:'btc',
               imageUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png',
               price:_prices[0],
               firstprice: _firstprices[0]
            ),
            CoinCard(
               name:'Ethereum',
               symbol:'eth',
               imageUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png',
               price: _prices[1],
               firstprice: _firstprices[1]
            ),
            CoinCard(
               name:'Xrp',
               symbol:'xrp',
               imageUrl:'https://cryptologos.cc/logos/xrp-xrp-logo.png',
               price: _prices[2],
               firstprice: _firstprices[2]
            ),
          CoinCard(
               name:'Terra',
               symbol:'luna',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/4172.png',
               price: _prices[3],
               firstprice: _firstprices[3]
            ),
           CoinCard(
               name:'Solana',
               symbol:'sol',
               imageUrl:'https://cryptologos.cc/logos/solana-sol-logo.png',
               price: _prices[4],
               firstprice: _firstprices[4]
            ),
            CoinCard(
               name:'Cardano',
               symbol:'ada',
               imageUrl:'https://cdn4.iconfinder.com/data/icons/crypto-currency-and-coin-2/256/cardano_ada-512.png',
               price: _prices[5],
               firstprice: _firstprices[5]
            ),
             CoinCard(
               name:'Avalanche',
               symbol:'avax',
               imageUrl:'https://miro.medium.com/max/1000/1*RK1R9BV_5-_2yXLWjuP-qw.png',
               price: _prices[6],
               firstprice: _firstprices[6]
            ),
             CoinCard(
               name:'Polkadot',
               symbol:'dot',
               imageUrl:'https://cryptologos.cc/logos/polkadot-new-dot-logo.png',
               price: _prices[7],
               firstprice: _firstprices[7]
            ),
            CoinCard(
               name:'Dogecoin',
               symbol:'doge',
               imageUrl:'https://cryptologos.cc/logos/dogecoin-doge-logo.png',
               price: _prices[8],
               firstprice: _firstprices[8]
            ),
            
            CoinCard(
               name:'Shiba Inu',
               symbol:'shib',
               imageUrl:'https://upload.wikimedia.org/wikipedia/tr/5/51/Shiba_coin_logo.png',
               price: _prices[9],
               firstprice: _firstprices[9]
            ),

            CoinCard(
               name:'Polygon',
               symbol:'matic',
               imageUrl:'https://cryptologos.cc/logos/polygon-matic-logo.png',
               price: _prices[10],
               firstprice: _firstprices[10]
            ),
            CoinCard(
               name:'Cronos',
               symbol:'cro',
               imageUrl:'https://cryptologos.cc/logos/crypto-com-coin-cro-logo.png',
               price: _prices[11],
               firstprice: _firstprices[11]
            ),
            CoinCard(
               name:'Dai',
               symbol:'dai',
               imageUrl:'https://cryptologos.cc/logos/multi-collateral-dai-dai-logo.png',
               price: _prices[12],
               firstprice: _firstprices[12]
            ),
            CoinCard(
               name:'Cosmos',
               symbol:'atom',
               imageUrl:'https://cryptologos.cc/logos/cosmos-atom-logo.png',
               price: _prices[13],
               firstprice: _firstprices[13]
            ),
            CoinCard(
               name:'Litecoin',
               symbol:'ltc',
               imageUrl:'https://cryptologos.cc/logos/litecoin-ltc-logo.png',
               price: _prices[14],
               firstprice: _firstprices[14]
            ),
            CoinCard(
               name:'NEAR Protocol',
               symbol:'near',
               imageUrl:'https://cryptologos.cc/logos/near-protocol-near-logo.png',
               price: _prices[15],
               firstprice: _firstprices[15]
            ),
            CoinCard(
               name:'Chainlink',
               symbol:'link',
               imageUrl:'https://cryptologos.cc/logos/chainlink-link-logo.png',
               price: _prices[16],
               firstprice: _firstprices[16]
            ),
            CoinCard(
               name:'Uniswap',
               symbol:'uni',
               imageUrl:'https://upload.wikimedia.org/wikipedia/commons/8/82/Uniswap_Logo.png',
               price: _prices[17],
               firstprice: _firstprices[17]
            ),
            CoinCard(
               name:'FTX Token',
               symbol:'ftt',
               imageUrl:'https://cryptologos.cc/logos/ftx-token-ftt-logo.png',
               price: _prices[18],
               firstprice: _firstprices[18]
            ),
            CoinCard(
               name:'TRON',
               symbol:'trx',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/1958.png',
               price: _prices[19],
               firstprice: _firstprices[19]
            ),
            
            CoinCard(
               name:'Algorand',
               symbol:'algo',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/4030.png',
               price: _prices[20],
               firstprice: _firstprices[20]
            ),

            CoinCard(
               name:'Decentraland',
               symbol:'mana',
               imageUrl:'https://cryptologos.cc/logos/decentraland-mana-logo.png',
               price: _prices[21],
               firstprice: _firstprices[21]
            ),

            CoinCard(
               name:'Fantom',
               symbol:'ftm',
               imageUrl:'https://cryptologos.cc/logos/fantom-ftm-logo.png',
               price: _prices[22],
               firstprice: _firstprices[22]
            ),
            CoinCard(
               name:'Stellar',
               symbol:'xlm',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/512.png',
               price: _prices[23],
               firstprice: _firstprices[23]
            ),
            CoinCard(
               name:'Hedera',
               symbol:'hbar',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/64x64/4642.png',
               price: _prices[24],
               firstprice: _firstprices[24]
            ),
            CoinCard(
               name:'Internet Computer',
               symbol:'icp',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/8916.png',
               price: _prices[25],
               firstprice: _firstprices[25]
            ),
            ]

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
