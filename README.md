#  Catholic Daily App

A simple, elegant Catholic companion app built with Flutter that provides daily liturgical information, saints, readings, and spiritual resources — all offline-friendly and lightweight.

---

##  Features

-  **Daily Liturgical Data**
  - Season
  - Celebration
  - Liturgical Color (calculated locally)

-  **Saint of the Day**
  - Loaded from a local JSON dataset
  - Works offline

-  **Dynamic Theme**
  - Background color automatically matches the liturgical color of the day

-  **Daily Scripture (Coming Soon)**
-  **Daily Mass Readings (Planned)**
-  **Rosary Mysteries by Day (Planned)**

---

##  Architecture

The app follows a simple modular structure:

lib/
┣ models/
┣ services/
┣ data/
┣ screens/
┗ main.dart


### Core Logic

| Component | Responsibility |
|--------|----------------|
LiturgicalService | Calculates liturgical season + color locally |
Saints JSON | Stores saints for each calendar day |
HomePage | Displays today's data |
Models | Structured data types |

---

##  Local Data

Saints are stored locally:

lib/data/saints.json


Format:

```json
[
  {
    "id":"1",
    "month_name":"January",
    "month_num":"1",
    "saint_day":"1",
    "saint_date":"1/1",
    "saint_name":"Mary, Mother of God"
  }
]
This ensures:

offline support

instant load speed

no API dependency

 Getting Started
1️⃣ Clone project
git clone https://github.com/YOUR_USERNAME/catholic-daily.git
cd catholic-daily
2️⃣ Install dependencies
flutter pub get
3️⃣ Run app
flutter run
