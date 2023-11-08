from django.db import models


# Модель для описания пациентов
class Client(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField()
    address = models.TextField()

    def __str__(self):
        return f'{self.first_name} {self.last_name}'


# Модель для описания медицинских записей
class Check(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    date = models.DateField()
    problem = models.TextField()
    sum = models.TextField()

    def __str__(self):
        return f'{self.client} on {self.date}'


# Модель для описания сотрудников учреждения
class Staff(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    position = models.CharField(max_length=100)

    def __str__(self):
        return f'{self.first_name} {self.last_name}'


# Модель для описания услуг, предоставляемых учреждением
class Service(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    cost = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f'{self.name}'


# Модель для описания расписания приема пациентов
class Schedule(models.Model):
    staff = models.ForeignKey(Staff, on_delete=models.CASCADE)
    day_of_week = models.CharField(max_length=10)
    start_time = models.TimeField()
    end_time = models.TimeField()

    def __str__(self):
        return f'{self.staff} on {self.day_of_week}'


# Модель для описания забронированных приемов пациентов
class Appointment(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    staff = models.ForeignKey(Staff, on_delete=models.CASCADE)
    date = models.DateField()
    time = models.TimeField()

    def __str__(self):
        return f'Meet {self.client} with {self.staff}'
