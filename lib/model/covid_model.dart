class CovidModel {
  final String? country;
  final int? totalConfirmed;
  final int? totalDeaths;
  final int? totalRecovered;
  final int? newConfirmed;
  final int? newDeaths;
  final int? newRecovered;
  final String? dateTime;

  CovidModel({
    this.country,
    this.totalConfirmed,
    this.totalDeaths,
    this.totalRecovered,
    this.newConfirmed,
    this.newDeaths,
    this.newRecovered,
    this.dateTime,
  });

  factory CovidModel.fromJson(Map<String, dynamic> data) {
    return CovidModel(
      country: data["Country"] as String?,
      totalConfirmed: data["TotalConfirmed"] as int?,
      totalDeaths: data["TotalDeaths"] as int?,
      totalRecovered: data["TotalRecovered"] as int?,
      newConfirmed: data["NewConfirmed"] as int?,
      newDeaths: data["NewDeaths"] as int?,
      newRecovered: data["NewRecovered"] as int?,
      dateTime: data['Date'] as String?,
    );
  }
}
