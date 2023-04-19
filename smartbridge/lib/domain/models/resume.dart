class Resume {
  final int resumeID;
  final int userID;
  final String schedule;
  final int lowerSalary;
  final int upperSalary;
  final String industry;
  final int experienceYears;
  final bool isDisabled;
  final String employment;
  final String companyType;
  final String qualification;
  final String about;
  final String experience;
  final String education;
  final String phone;
  final String telegram;
  final bool isActive;
  final String updatedAt;
  final String geoName;
  final String specName;
  final int region;
  final int specialization;
  final String name;
  final String surname;
  final String? patronymic;
  final String email;

  Resume(
      this.resumeID,
      this.userID,
      this.schedule,
      this.lowerSalary,
      this.upperSalary,
      this.industry,
      this.experienceYears,
      this.isDisabled,
      this.employment,
      this.companyType,
      this.qualification,
      this.about,
      this.experience,
      this.education,
      this.phone,
      this.telegram,
      this.isActive,
      this.updatedAt,
      this.geoName,
      this.specName,
      this.region,
      this.specialization,
      this.name,
      this.surname,
      this.patronymic,
      this.email
      );

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      json['resume_id'],
      json['user_id'],
      json['schedule'],
      json['lower_salary'],
      json['upper_salary'],
      json['industry'],
      json['experience_years'],
      json['is_disabled'],
      json['employment'],
      json['company_type'],
      json['qualification'],
      json['about'],
      json['experience'],
      json['education'],
      json['phone'],
      json['telegram'],
      json['is_active'],
      json['updated_at'],
      json['geoname'],
      json['spec_name'],
      json['region'],
      json['specialization'],
      json['first_name'],
      json['second_name'],
      json['patronymic'],
      json['email']
    );
  }

  Map toJson() => { 
      'schedule': schedule,
      'lower_salary': lowerSalary,
      'upper_salary': upperSalary,
      'industry': industry,
      'experience_years': experienceYears,
      'is_disabled': isDisabled,
      'employment': employment,
      'company_type': companyType,
      'qualification': qualification,
      'about': about,
      'experience': experience,
      'education': education,
      'phone': phone,
      'telegram': telegram,
      'is_active': isActive,
      'region': region,
      'specialization': specialization,
      'first_name': name,
      'second_name': surname,
      'patronymic': patronymic,
      'email': email
      };

  static List<Resume> getListFromJson(Map<String, dynamic> json) {
    var resumesJson = json['resumes'] as List;
    List<Resume> resumeList =
        resumesJson.map((i) => Resume.fromJson(i)).toList();
    return resumeList;
  }
}
