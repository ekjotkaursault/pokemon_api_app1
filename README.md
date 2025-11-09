# Pokémon API Flutter App  


## Project Overview  
This Flutter Web App fetches Pokémon Trading Card data from the **Pokémon TCG API** and displays it in an elegant, responsive card interface.  
Each Pokémon card shows an image + name, and users can tap to open a detailed view.  

This lab demonstrates:  
- REST API integration  
- Asynchronous programming with `FutureBuilder`  
- Stateful widget management and navigation  
- Modern UI design with gradients + rounded cards  
- Flutter Web deployment workflow (GitHub Pages)

---

## Work Attribution — My Contributions vs External Resources

###  **Work Done by Me (Ekjot Kaur):**
- Designed the **entire UI layout** (AppBar, gradients, card styling).  
- Implemented **rounded card containers** with elevation & padding.  
- Added **hover and press animations** using `AnimatedScale` and `GestureDetector`.  
- Built **navigation flow** between Pokémon list and detail pages.  
- Managed **asynchronous API calls** and integrated `FutureBuilder`.  
- Wrote **custom error handling** (e.g., “Failed to load data” message).  
- Styled the app for **modern visual appeal** using gradients and shadows.  
- Deployed the app to **GitHub Pages** (Flutter Web build process).  
- Authored this **README.md documentation** and screenshot setup.

###  **External Resources Used (with Modifications):**
| Source | Original Purpose | How It Was Used |
|--------|------------------|----------------|
| [Pokémon TCG API](https://pokemontcg.io/) | Public API for card data | Used its endpoint `/v2/cards` to fetch Pokémon details (JSON parsing done manually). |
| [Flutter Docs](https://docs.flutter.dev/) | Official documentation | Used for understanding `FutureBuilder`, `ListView.builder`, and `http` package syntax. |
| [Stack Overflow / Medium Flutter Community](https://medium.com/flutter-community) | Animation tutorials | Referred to learn hover animation logic, but fully re-implemented code with my own styling and timing values. |

>  *All core coding, API integration, and UI customization were self-written from scratch. External material was only referenced conceptually.*



##  Tech Stack
| Category | Tool |
|-----------|------|
| Framework | Flutter (Dart) |
| API | [Pokémon TCG API](https://pokemontcg.io/) |
| Deployment | GitHub Pages |
| IDE | Visual Studio Code |
| Version Control | Git + GitHub |

---
##  Features
-Fetches Pokémon data dynamically via HTTP  
-Displays rounded cards with hover + press animations  
-Gradient background and responsive design  
-Smooth navigation to Pokémon detail view  
-Fully functional Flutter Web App structure  
-Organized folder architecture for maintainability  

----


##  How to Run Locally
In Terminal, type:
git clone https://github.com/ekjotkaursault/pokemon_api_app1.git

cd pokemon_api_app1

flutter pub get

flutter run -d chrome

---

Developed By-

Ekjot Kaur
Sault College – Toronto Campus

Lab 4 – API Integration using Flutter Web (CSD228)

