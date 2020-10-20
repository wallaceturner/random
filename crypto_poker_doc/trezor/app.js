var TrezorConnect = window.TrezorConnect;


 function trezorGetXPubKey() {
         console.log('TrezorConnect', TrezorConnect);
		 TrezorConnect.manifest({
    email: 'developer@xyz.com',
    appUrl: 'http://your.application.com'
});
//"m/49'/0'/3'"
var path = document.getElementById('path').value;
TrezorConnect.getPublicKey({
    path: path,
    coin: document.getElementById('coin').value
}).then((response)=>{
	console.log(response);
	document.getElementById("response").innerHTML = JSON.stringify(response, undefined, 2);
	
});

		 
        
     }