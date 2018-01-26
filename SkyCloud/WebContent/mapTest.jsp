<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
  <head>
      <meta charset="UTF-8">
      <title>���̹� ���� API - �ּҷ� ���� ǥ���ϱ�</title>
      <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=FCutdjqYcxIgr5S5ObN8&submodules=geocoder"></script>
      <script src="/web-study-01/jquery-3.2.1.min.js"></script>
  </head>
  <style>	
  .search {
    position: absolute;
    z-index: 1000;
    top: 20px;
    left: 20px;
	}
  </style>
  <body>
  	
    <div id="map" style="width:100%;height:500PX;">
    <div class="search" style="">
            <input id="address" type="text" placeholder="�˻��� �ּ�" value="������ 6">
            <input id="submit" type="button" value="�ּ� �˻�">
        </div>
    </div>
    
    <script>
    var map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(37.3595316, 127.1052133),
        zoom: 10,
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
                return alert('�߸� �˻��ϼ̽��ϴ�.');
            }

            var item = response.result.items[0],
                addrType = item.isRoadAddress ? '[���θ� �ּ�]' : '[���� �ּ�]',
                point = new naver.maps.Point(item.point.x, item.point.y);

            infoWindow.setContent([
                    '<div style="padding:10px;min-width:200px;line-height:150%;">',
                    '<h4 style="margin-top:5px; text-align:center;">�˻� �ּ� : '+ response.result.userquery +'</h4><br />',
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

        searchAddressToCoordinate('���ڵ� 178-1');
    }

    naver.maps.onJSContentLoaded = initGeocoder;
      </script>
  </body>
</html>
