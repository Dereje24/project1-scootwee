// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
var directionsService = new google.maps.DirectionsService
var directionsDisplay = new google.maps.DirectionsRenderer
var icon = new google.maps.MarkerImage("http://maps.google.com/mapfiles/ms/micons/blue.png",
 new google.maps.Size(32, 32), new google.maps.Point(0, 0),
 new google.maps.Point(16, 32));
var map_id;
var login;
var map;
var show;
var markers=[];
var center;
var user_map;
var show_history;
var history=[]

$(document).on('turbolinks:load',function(){
  function get_current_location(){

     if (navigator.geolocation) {
       getposition= function(position){
         $('input[name="lat"]').val(position.coords.latitude);
           $('input[name="lng"]').val(position.coords.longitude);
       }

        navigator.geolocation.getCurrentPosition(getposition);
        }
    else {
      alert('GEO LOCATION NOT SUPPORTED');
    }

   }
   function get_current_location_sign_up(){

      if (navigator.geolocation) {
        getposition= function(position){
          $('input[name="user[lat]"]').val(position.coords.latitude);
            $('input[name="user[lng]"]').val(position.coords.longitude);
        }

         navigator.geolocation.getCurrentPosition(getposition);
         }
     else {
       alert('GEO LOCATION NOT SUPPORTED');
     }

    }
function reservation_map(){
var position={lat: parseFloat($('input[name="local_lat"]').val()),lng: parseFloat($('input[name="local_lng"]').val())}
  map = new google.maps.Map(user_map, {
    center:position,
    zoom:12.5
  });
  marker=new google.maps.Marker({
    position:position,
    map:map,
    icon:icon,
    title:'Pickup'
  });
  var x=document.cookie.split(';');
  var lat = x[0].split('=')
  var lng= x[1].split('=')
  center =new google.maps.Marker({
    position:{lat: parseFloat(lat[1]),lng: parseFloat(lng[1])},
    map:map,
    title:'Your actual position'
  });
  directionsDisplay.setMap(map);
  marker.addListener('click', function() {
    center.setVisible(false)
    marker.setVisible(false)
    directionsService.route({
origin: center.getPosition(),
destination: marker.getPosition(),
unitSystem: google.maps.DirectionsUnitSystem.METRIC,
travelMode: google.maps.DirectionsTravelMode.WALKING
}, function(result, status){
if (status == google.maps.DirectionsStatus.OK){
directionsDisplay.setDirections(result);
}
});
  });
$('#drop').on('click',function(){
  $('#myModal').modal('show')
});
$('#dropit').on('click',function(){
  $('#drop_form').submit();
});
}
  function map(){
    var list=$('#list');
    var bounds = new google.maps.LatLngBounds();
      var x=document.cookie.split(';');

      var lat = x[0].split('=')
      var lng= x[1].split('=')


    $.ajax({
        url: '/map',
        method: 'GET',
        success: function(data){
          map = new google.maps.Map(map_id, {
            center:{lat: parseFloat(lat[1]),lng: parseFloat(lng[1])},
            zoom:12.5
          });
          center =new google.maps.Marker({
            position:{lat: parseFloat(lat[1]),lng: parseFloat(lng[1])},
            map:map,
            title:'Your actual position'
          });
            directionsDisplay.setMap(map);
          data.data.forEach(function(el,index){
            console.log(el)
            var pt = new google.maps.LatLng( el.position.lat, el.position.lng);

            bounds.extend(pt);
            // console.log(pt.getLatitude())
            marker=new google.maps.Marker({
              position:pt,
              map:map,
              icon:icon,
              title:el.position.name,
              id:index
            })
            markers.push(marker)
            list.append(`<div id='bike_list${index}' class='locals'><p>name: ${el.position.name} Adress: ${el.position.street} ${el.position.city} ${el.position.state} ${el.position.zip_code} distance:${Math.round(el.position.distance)} miles <a class='display_road' data-id=${index}>show</a> <a class='reserve' data-id=${index}>Reserve</a></p></div>`)
            bikes=$(`#bike_list${index}`)
            el.vehicles.forEach(function(vl){
              bikes.append(`<p class='bikes'><img src='https://thescooterfarm.com/wp-content/uploads/2017/07/Chilli-Pro-Scooter-Reaper-Wave1.jpg' style='width:100px;height:100px' > ${vl.description} rent it today for 5$ <a a class='rent' data-id=${el.position.id}#${vl.id}>Pick!</a></p>`)
            });
            marker.addListener('click', function() {
              var i=this.id
              console.log(i)
              $('.bikes').hide(300)
              $(`#bike_list${i} .bikes`).show(300)
            });
            });
          $('a.display_road').on('click',function(e){
            var i=$(this).attr('data-id')
            markers.forEach(function(mk){
              mk.setVisible(true);
            });
          center.setVisible(false)
          markers[i].setVisible(false)
          directionsService.route({
    origin: center.getPosition(),
    destination: markers[i].getPosition(),
    unitSystem: google.maps.DirectionsUnitSystem.METRIC,
    travelMode: google.maps.DirectionsTravelMode.WALKING
    }, function(result, status){
    if (status == google.maps.DirectionsStatus.OK){
    directionsDisplay.setDirections(result);
    }
    });
        });
        $('a.reserve').on('click',function(e){
          var i=$(this).attr('data-id')
          $('.bikes').hide(300)
          $(`#bike_list${i} .bikes`).show(300)

        });
        $('a.rent').on('click',function(e){
          var i=$(this).attr('data-id').split('#')
          $('.info').empty()
          $('.info').append($(this).parent()[0])
          $('.info .rent').remove()
          $('input[name="local_id"]').val(`${i[0]}`)
          $('input[name="vehicle_id"]').val(`${i[1]}`)
          $('#myModal').modal('show')

        });
        $('#reserve').on('click',function(){
          $('#reservation_form').submit();
        });

        },
        error: function(data){
          console.log('error')
          console.log(data)}
        });


  }
  function history(){
    $.ajax({
      url:'/history',
      method:'GET',
      success:function(data){
        console.log(data)

        data.data.forEach(function(el,index){
          $('table').append(`<tr> <td>${el.vehicle.description}</td><td>${el.local_start.street} ${el.local_start.city}
${el.local_start.state} ${el.local_start.zip_code}</td><td>${el.local_end.street} ${el.local_end.city}
${el.local_end.state} ${el.local_end.zip_code}</td><td>${el.rental.created_at}</td><td>${el.rental.drop_date}</td><td><a class='map_show' data-id=${index}>Show</a></td></tr>`)
        });
        $('.map_show').on('click',function(){
          var i=$(this).attr('data-id')
          $('.new').remove();
          $(this).closest('tr').after(`<tr class="new"><td colspan="6"><div class='col-lg-6'><p>${data.data[i].vehicle.description} <br>Pickked in ${data.data[i].local_start.street} ${data.data[i].local_start.city} ${data.data[i].local_start.state} ${data.data[i].local_start.zip_code}<br>Dropped in:${data.data[i].local_end.street} ${data.data[i].local_end.city} ${data.data[i].local_end.state}  ${data.data[i].local_start.zip_code} </p></div><div class='col-lg-6' id='history_map' style='height:200px'></div> </td></tr>`);
          var position={lat: parseFloat(data.data[i].local_start.lat),lng: parseFloat(data.data[i].local_start.lng)}
var destination={lat: parseFloat(data.data[i].local_end.lat),lng: parseFloat(data.data[i].local_end.lng)}
          map=new google.maps.Map(document.getElementById('history_map'),{
            center:position,
            zoom:12
          });
          center=new google.maps.Marker({
            position:position,
            map:map
          });
          directionsDisplay.setMap(map);

          directionsService.route({
    origin: center.getPosition(),
    destination: destination,
    unitSystem: google.maps.DirectionsUnitSystem.METRIC,
    travelMode: google.maps.DirectionsTravelMode.WALKING
    }, function(result, status){
    if (status == google.maps.DirectionsStatus.OK){
    directionsDisplay.setDirections(result);
    }
    });

        })
      },
      error:function(){
        console.log("nope")
      }
    });
  }
  map_id=document.getElementById('map');
  login=document.getElementById('login');
  sign_up=document.getElementById('signup');
  user_map=document.getElementById('user#map');
show_history=document.getElementById('show_history');
  if(login ){
  get_current_location();}
  if(sign_up ){
  get_current_location_sign_up();}
  if(map_id){
  map();
}
if(user_map){
reservation_map();
}
if(show_history){
  history();
}

});
