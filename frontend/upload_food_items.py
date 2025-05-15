import csv
import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firebase
cred = credentials.Certificate('serviceAccountKey.json')  # Replace with your correct path
firebase_admin.initialize_app(cred)
db = firestore.client()

# Upload CSV data
with open('Dataset.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        doc_data = {
            'foodId': row['FoodID'],
            'name': row['Name'],
            'kcal': float(row['Kcal(g)']) if row['Kcal(g)'] else 0.0,
            'fat': float(row['Fat(g)']) if row['Fat(g)'] else 0.0,
            'carb': float(row['Carb(g)']) if row['Carb(g)'] else 0.0,
            'fiber': float(row['Fiber(g)']) if row['Fiber(g)'] else 0.0,
            'protein': float(row['Protine']) if row['Protine'] else 0.0,
            'imageUrl': row['URL']
        }
        db.collection('food_items').add(doc_data)

print("✅ Upload complete.")