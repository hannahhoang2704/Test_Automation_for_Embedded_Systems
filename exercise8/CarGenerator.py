from faker import Faker
from faker_vehicle import VehicleProvider
import random


class CarGenerator():
    def __init__(self):
        self.fake = Faker()
        self.fake.add_provider(VehicleProvider)
        self.car_make_list = ["Skoda", "Toyota", "Audi"]

    def car_info(self, car_make=None, car_plate=None) -> dict:
        if car_make is not None:
            self.car_make = car_make
        else:
            self.car_make = self.fake.vehicle_make()
        
        if car_plate is not None:
            self.car_plate = car_plate
        else:
            self.car_plate = self.fake.license_plate()
        
        car_info = {
            "make": self.car_make,
            "model": self.fake.vehicle_model(),
            "mileage": random.randint(10000, 90000),
            "year": self.fake.vehicle_year(),
            "plate": self.car_plate
        }
        print(car_info)
        return car_info

    def generate_random_car_list(self, car_nr, car_make=None, car_plate=None):
        self.car_list = []
        for i in range(car_nr):
            self.car_list.append(self.car_info(car_make, car_plate))
        return self.car_list
    
    def random_car_list_included_selected_car_make(self, car_nr):
        self.car_list = []
        for i in range(car_nr):
            self.car_make = random.choice(self.car_make_list)
            self.car_list.append(self.car_info(self.car_make))
        return self.car_list
            


car_generator = CarGenerator()
car_generator.generate_random_car_list(4)
car_generator.random_car_list_included_selected_car_make(10)