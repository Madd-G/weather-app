class LocationModel {
  String? id;
  String? province;
  String? city;
  String? regency;
  String? lat;
  String? lon;

  LocationModel(
      {this.id, this.province, this.city, this.regency, this.lat, this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
      id: json['id'],
      province: json['propinsi'],
      city: json['kota'],
      regency: json['kecamatan'],
      lat: json['lat'],
      lon: json['lon']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "propinsi": province,
        "kota": city,
        "kecamatan": regency,
        "lat": lat,
        "lon": lon,
      };
}
