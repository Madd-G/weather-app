String getWeatherIcon(String condition) {
  if (condition == 'Berawan') {
    return '☁️';
  }
  else if (condition == 'Hujan Ringan') {
    return '🌧';
  }
  else if (condition == 'Hujan Petir') {
    return '🌩';
  } else if (condition == 'Cerah Berawan') {
    return '🌤️️';
  }
  else if (condition == 'Asap') {
    return '🌫️️';
  } else if (condition == 'Cerah') {
    return '☀️ ';
  }
  else {
    return '☀️';
  }
}
