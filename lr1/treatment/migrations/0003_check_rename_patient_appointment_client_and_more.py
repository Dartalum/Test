# Generated by Django 4.2.6 on 2023-11-08 11:22

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("treatment", "0002_t"),
    ]

    operations = [
        migrations.CreateModel(
            name="Check",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("date", models.DateField()),
                ("problem", models.TextField()),
                ("sum", models.TextField()),
            ],
        ),
        migrations.RenameField(
            model_name="appointment",
            old_name="patient",
            new_name="client",
        ),
        migrations.RenameModel(
            old_name="Patient",
            new_name="Client",
        ),
        migrations.DeleteModel(
            name="MedicalRecord",
        ),
        migrations.AddField(
            model_name="check",
            name="client",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE, to="treatment.client"
            ),
        ),
    ]
