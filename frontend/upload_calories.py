import csv
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase
cred = credentials.Certificate('serviceAccountKey.json')  # Update with your correct path
firebase_admin.initialize_app(cred)
db = firestore.client()

# Read and upload the selected fields from the CSV
with open('calories.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        doc_data = {
            'name': row['Shrt_Desc'],
            'calories_kcal': float(row['Energ_Kcal']) if row['Energ_Kcal'] else 0.0,
            'protein_g': float(row['Protein_(g)']) if row['Protein_(g)'] else 0.0,
            'fat_g': float(row['Lipid_Tot_(g)']) if row['Lipid_Tot_(g)'] else 0.0,
            'carbohydrates_g': float(row['Carbohydrt_(g)']) if row['Carbohydrt_(g)'] else 0.0,
            'fiber_g': float(row['Fiber_TD_(g)']) if row['Fiber_TD_(g)'] else 0.0,
        }
        db.collection('food_items').add(doc_data)

print("✅ Upload complete.")
