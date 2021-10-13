class Incident {
  final String? reporterName;
  final String? victimName;
  final String? victimAddress;
  final String? victimPhoneNumber;
  final String? repoterPhoneNumber;
  final String? victimGender;
  final String? reporterGender;
  final DateTime? reportDate;
  final String? descriptionIncident;
  final String? additionalInfo;

  Incident({
    this.reporterName,
    this.victimName,
    this.victimAddress,
    this.victimPhoneNumber,
    this.repoterPhoneNumber,
    this.victimGender,
    this.reporterGender,
    this.reportDate,
    this.descriptionIncident,
    this.additionalInfo
  });
}