class User:
    def __init__(self, name=None, email=None, password=None, phone=None, 
                 birthdate=None, gender=None, zone=None, street=None, 
                 barangay=None, building=None):
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
        self.birthdate = birthdate
        self.gender = gender
        self.zone = zone
        self.street = street
        self.barangay = barangay
        self.building = building

    def to_dict(self):
        return {
            'name': self.name,
            'email': self.email,
            'phone': self.phone,
            'birthdate': self.birthdate,
            'gender': self.gender,
            'zone': self.zone,
            'street': self.street,
            'barangay': self.barangay,
            'building': self.building
        }