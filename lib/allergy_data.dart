List<String> respiratoryAllergies = [
    '       -Spring Allergies',
    '       -Summer Allergies',
    '       -fall Allergies',
    '       -Winter Allergies',
    '       -Hay Fever',
    '       -Pollen Allergies',
    '       -Mold Allergy',
    '       -Dust Allergies',
    '       -Dog Allergy',
    '       -Cat Allergy',
  ];
  List<String> skinAllergies = [
    '       -Contact Dermatitis',
    '       -Hives & Angioedema',
    '       -Allergy to Poison lvy',
    '       -Allergy to Oak',
    '       -Allergy to Sumac',
    '       -Insect Stings',
    '       -Sun Allergy',
    '       -Cosmetic Allergies',
    '       -Nickel Allergy'
  ];
  List<String> foodAllergies = [
    '       -Milk Allergy',
    '       -Casein Allergy',
    '       -Egg Allergy',
    '       -Wheat Allergy',
    '       -Nut Allergy',
    '       -Fish Allergy',
    '       -Shellfish Allergy',
    '       -Sulfite Sensitivity',
    '       -Soy Allergy',
  ];
  List<String> otherAllergies = [
    '       -Eye Allergies',
    '       -Pink Eye',
    '       -Drug Allergies',
    '       -Aspirin Allergy',
    '       -Penicillin Allergy',
  ];
  List<String> allergies;

  void createAllergiesList() {
    allergies = [];
    allergies.add("Respiratory Allergies:");
    allergies.addAll(respiratoryAllergies);
    allergies.add("Food Allergies:");
    allergies.addAll(foodAllergies);
    allergies.add("Skin Allergies:");
    allergies.addAll(skinAllergies);
    allergies.add("Other Allergies:");
    allergies.addAll(otherAllergies);
    
  }
