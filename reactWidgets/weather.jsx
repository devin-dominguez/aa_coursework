var React = require('react');


//api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}

var Weather = React.createClass({
  getInitialState: function() {
    return {};
  },

  getWeatherInfo: function() {
    var self = this;
      navigator.geolocation.getCurrentPosition(function (pos) {
        var lat = pos.coords.latitude;
        var lon = pos.coords.longitude;
        var apiKey = "645c5d39c7603f17e23fcaffcea1a3c1";
        var url = "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon +
        "&APPID=" + apiKey;
        var xmlhttp = new XMLHttpRequest();

        xmlhttp.onreadystatechange = function() {
          if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            if (xmlhttp.status == 200) {
              var response = JSON.parse(xmlhttp.responseText);
              var temp = Math.round((response.main.temp - 273.15) * 1.8 + 32);
              var weather = response.weather[0].description;
              self.setState({ temperature: temp, weather: weather});
            } else {
              console.log("ERORRRRR");
            }
          }
        };

        xmlhttp.open("GET", url, true);
        xmlhttp.send();
      });
  },

  componentDidMount: function() {
      this.getWeatherInfo();
  },

  render: function() {
    return (
      <div>
        <span>Temperature: {this.state.temperature} </span>
        <br></br>
        <span>Weather: {this.state.weather} </span>
      </div>
    );
  }

});

module.exports = Weather;
