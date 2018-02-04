<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
      <meta charset="UTF-8">
      <title>네이버 지도 API - 주소로 지도 표시하기</title>
      <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=FCutdjqYcxIgr5S5ObN8&submodules=geocoder"></script>
      <script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
  </head>
  <style>	
  
	.button{
		border:1px solid #39d2fd;
		border-radius: 10px;
		background-Color: #39d2fd;
		font:12px;
		font-weight:bold;
		color:white;
		width:100;height:30;
	}
  </style>
  <body>
  	
    <div id="map" style="width:100%;height:500PX;">
    
    </div>
    
    <script>
    var addr = ${param.addr};

    var map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(37.3595316, 127.1052133),
        zoom: 10,
        zoomControl: true,
        zoomControlOptions:{
        	position: naver.maps.Position.TOP_RIGHT
        },
        mapTypeControl: true
    });

    var infoWindow = new naver.maps.InfoWindow({
        anchorSkew: true
    });

    var input = $('#address');
    
    map.setCursor('pointer');

 
    // result by latlng coordinate
    function searchAddressToCoordinate(address) {
        naver.maps.Service.geocode({
            address: address
        }, function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('잘못 검색하셨습니다.');
            }

            var item = response.result.items[0],
                addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
                point = new naver.maps.Point(item.point.x, item.point.y);

            infoWindow.setContent([
                    '<div style="padding:10px;min-width:200px;line-height:150%;">',
                    '<h4 style="margin-top:5px; text-align:center;">검색 주소 : '+ response.result.userquery +'</h4><br />',
                    addrType +' '+ item.address +'<br />',
                    '</div>'
                ].join('\n'));


            map.setCenter(point);
            infoWindow.open(map, point);
        });
    }
	
    function initGeocoder() {
        
        searchAddressToCoordinate(addr);
    }
	
    naver.maps.onJSContentLoaded = initGeocoder;
    
   	
    
    
    </script>
  </body>
</html>
