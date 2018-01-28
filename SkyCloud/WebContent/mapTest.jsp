<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
  <head>
      <meta charset="UTF-8">
      <title>네이버 지도 API - 주소로 지도 표시하기</title>
      <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=FCutdjqYcxIgr5S5ObN8&submodules=geocoder"></script>
      <script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
  </head>
  <style>	
  .search {
    position: absolute;
    z-index: 1000;
    top: 20px;
    left: 20px;
	}
	
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
    <div class="search">
            <input id="address" type="text" placeholder="지번주소를 입력해주세요" >
            <input id="submit" type="button" class="button"  value="주소 검색">
        </div>
    </div>
    
    <script>
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
        map.addListener('click', function(e) {
            searchCoordinateToAddress(e.coord);
        });
        
        input.on('keydown', function(e) {
            var keyCode = e.which;

            if (keyCode === 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
            }
        });

        $('#submit').on('click', function(e) {
            e.preventDefault();

            searchAddressToCoordinate($('#address').val());
        });

        searchAddressToCoordinate('정자동 178-1');
    }

    naver.maps.onJSContentLoaded = initGeocoder;
      </script>
  </body>
</html>
