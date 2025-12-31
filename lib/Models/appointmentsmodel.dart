class AppointmentModel {
  final int id;
  final int doctorId;
  final int patientId;
  final String appointmentDate;
  final String appointmentTime;
  final String status;
  final String? notes;
  final String createdAt;

  const AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    this.notes,
    required this.createdAt,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'],
        doctorId: json['doctor_id'],
        patientId: json['patient_id'],
        appointmentDate: json['appointment_date'],
        appointmentTime: json['appointment_time'],
        status: json['status'],
        notes: json['notes'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toMap() {
    return {
      'doctor_id': doctorId,
      'patient_id': patientId,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'status': status,
      'notes': notes,
      'created_at': createdAt,
    };
  }
}
