import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:testflutter/coinCard.dart';

void main() {
  runApp(const MyApp());
  //Timer.periodic(Duration(seconds: 5), (Timer t) => _MyHomePageState._getResult());
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
   'SHIB','MATIC','CRO','DAI','ATOM','LTC','NEAR','LINK','UNI','FTT','TRX'];
   var _prices = <double>[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,
   0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
     
Future<Crypto> _request(String _currency)async
{
    final _response = await http.get(
     Uri.parse('https://min-api.cryptocompare.com/data/price?fsym='+_currency+'&tsyms=USD')
   );
if(_response.statusCode == 200)
{
  return Crypto.fromJson(jsonDecode(_response.body));
}
else
{
   throw Exception('Failed to load BTC');
}

}


void _getResult()async
{
     for(int i=0; i<_currencies.length;i++)
     {
           Crypto crypto = await _request(_currencies[i]);
           _usd = crypto.USD;
           _prices[i] = _usd;
           //_data = _usd.toString()+" USD";
           //print(_data);
     }
     
}

  
  void _incrementCounter(){
    setState((){
      _getResult();      
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
            scrollDirection: Axis.vertical,
            children:[CoinCard(
               name:'Bitcoin',
               symbol:'btc',
               imageUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png',
               price:_prices[0]
            ),
            CoinCard(
               name:'Ethereum',
               symbol:'eth',
               imageUrl:'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/600px-ETHEREUM-YOUTUBE-PROFILE-PIC.png',
               price: _prices[1]
            ),
            CoinCard(
               name:'Xrp',
               symbol:'xrp',
               imageUrl:'https://cryptologos.cc/logos/xrp-xrp-logo.png',
               price: _prices[2]
            ),
          CoinCard(
               name:'Terra',
               symbol:'luna',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/4172.png',
               price: _prices[3]
            ),
           CoinCard(
               name:'Solana',
               symbol:'sol',
               imageUrl:'https://cryptologos.cc/logos/solana-sol-logo.png',
               price: _prices[4]
            ),
            CoinCard(
               name:'Cardano',
               symbol:'ada',
               imageUrl:'https://cdn4.iconfinder.com/data/icons/crypto-currency-and-coin-2/256/cardano_ada-512.png',
               price: _prices[5]
            ),
             CoinCard(
               name:'Avalanche',
               symbol:'avax',
               imageUrl:'https://miro.medium.com/max/1000/1*RK1R9BV_5-_2yXLWjuP-qw.png',
               price: _prices[6]
            ),
             CoinCard(
               name:'Polkadot',
               symbol:'dot',
               imageUrl:'https://cryptologos.cc/logos/polkadot-new-dot-logo.png',
               price: _prices[7]
            ),
            CoinCard(
               name:'Dogecoin',
               symbol:'doge',
               imageUrl:'https://cryptologos.cc/logos/dogecoin-doge-logo.png',
               price: _prices[8]
            ),
            
            CoinCard(
               name:'Shiba Inu',
               symbol:'shib',
               imageUrl:'https://upload.wikimedia.org/wikipedia/tr/5/51/Shiba_coin_logo.png',
               price: _prices[9]
            ),

            CoinCard(
               name:'Polygon',
               symbol:'matic',
               imageUrl:'https://cryptologos.cc/logos/polygon-matic-logo.png',
               price: _prices[10]
            ),
            CoinCard(
               name:'Cronos',
               symbol:'cro',
               imageUrl:'https://cryptologos.cc/logos/crypto-com-coin-cro-logo.png',
               price: _prices[11]
            ),
            CoinCard(
               name:'Dai',
               symbol:'dai',
               imageUrl:'https://cryptologos.cc/logos/multi-collateral-dai-dai-logo.png',
               price: _prices[12]
            ),
            CoinCard(
               name:'Cosmos',
               symbol:'atom',
               imageUrl:'https://cryptologos.cc/logos/cosmos-atom-logo.png',
               price: _prices[13]
            ),
            CoinCard(
               name:'Litecoin',
               symbol:'ltc',
               imageUrl:'https://cryptologos.cc/logos/litecoin-ltc-logo.png',
               price: _prices[14]
            ),
            CoinCard(
               name:'NEAR Protocol',
               symbol:'near',
               imageUrl:'https://cryptologos.cc/logos/near-protocol-near-logo.png',
               price: _prices[15]
            ),
            CoinCard(
               name:'Chainlink',
               symbol:'link',
               imageUrl:'https://cryptologos.cc/logos/chainlink-link-logo.png',
               price: _prices[16]
            ),
            CoinCard(
               name:'Uniswap',
               symbol:'uni',
               imageUrl:'https://upload.wikimedia.org/wikipedia/commons/8/82/Uniswap_Logo.png',
               price: _prices[17]
            ),
            CoinCard(
               name:'FTX Token',
               symbol:'ftt',
               imageUrl:'https://cryptologos.cc/logos/ftx-token-ftt-logo.png',
               price: _prices[18]
            ),
            CoinCard(
               name:'TRON',
               symbol:'trx',
               imageUrl:'https://s2.coinmarketcap.com/static/img/coins/200x200/1958.png',
               price: _prices[19]
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
