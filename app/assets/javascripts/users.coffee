# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
markers=[]
map = map
position = position
marker1 = marker1
directionsService = new google.maps.DirectionsService
directionsDisplay = new google.maps.DirectionsRenderer

marker = (lat , lng) ->
  p1= {lat: lat, lng: lng}
  marker=new google.maps.Marker  {
      position:p1
      map:map
      title:'I am a marker1'
    }
  marker.push(marker)

$(document).on 'ready', ->
    position =  {lat: -34.397, lng: 150.644}
    p =  {lat: -33.397, lng: 150.644}
    map = new google.maps.Map document.getElementById('map'), {
      center:position
      zoom:7
    }
    marker = new google.maps.Marker  {
      position:position
      map:map
      title:'I am a marker'
    }
    marker1 = new google.maps.Marker  {
        position:p
        map:map
        title:'I am a marker1'
      }
    directionsDisplay.setMap map
    directionsService.route {
        origin: position
        destination: p
        unitSystem: google.maps.DirectionsUnitSystem.METRIC
        travelMode: google.maps.DirectionsTravelMode.DRIVING
      }, (result,status) ->
        directionsDisplay.setDirections result
    $.ajax({
        url: '/map'
        method: 'GET'

        success: (data) ->
          console.log('SUCCES')
          console.log(data)
        error: (data) ->
          console.log('error')
          console.log(data)
        })
    geo = navigator.geolocation.getCurrentPosition success
  success= (data) ->
    console.log(data.coords.latitude)


console.log('aaaa')
