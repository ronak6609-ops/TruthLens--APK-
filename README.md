<div align="center">

# 🔍 TruthLens

### *Detect Reality in the Age of AI*

[![Live Demo](https://img.shields.io/badge/🌐%20Live%20Demo-Visit%20Website-6366f1?style=for-the-badge&logoColor=white)](https://truth-lens-ronak.vercel.app/)
[![Backend API](https://img.shields.io/badge/⚡%20Backend%20API-Railway-0B0D0E?style=for-the-badge&logo=railway&logoColor=white)](https://truthlens-backend-production-a5a7.up.railway.app)
[![Download APK](https://img.shields.io/badge/📱%20Android%20App-Download%20APK-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://github.com/ronak6609-ops/TruthLens--APK-/releases/download/v1/TruthLensv2.apk)
[![GitHub Repo](https://img.shields.io/badge/GitHub-TruthLens-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ronak6609-ops/TruthLens--APK-)

<br/>

![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![PyTorch](https://img.shields.io/badge/PyTorch-EE4C2C?style=flat-square&logo=pytorch&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)
![Railway](https://img.shields.io/badge/Railway-0B0D0E?style=flat-square&logo=railway&logoColor=white)
![Vercel](https://img.shields.io/badge/Vercel-000000?style=flat-square&logo=vercel&logoColor=white)
![REST API](https://img.shields.io/badge/REST%20API-FF6C37?style=flat-square&logo=postman&logoColor=white)

<br/>

> **TruthLens** is a production-grade, multi-modal AI detection platform built to combat the growing threat of synthetic media.  
> From deepfake videos to AI-generated text — TruthLens sees through it all.

<br/>

---

</div>

## 📖 Table of Contents

- [About](#-about)
- [Core Capabilities](#-core-capabilities)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
  - [Backend Setup](#backend-setup)
  - [Flutter App Setup](#flutter-app-setup)
- [API Endpoints](#-api-endpoints)
- [Deployment](#-deployment)
- [Performance & Optimizations](#-performance--optimizations)
- [Future Roadmap](#-future-roadmap)
- [Contributing](#-contributing)
- [License](#-license)
- [Developer](#-developer)

---

## 🧠 About

In an era where AI-generated content is becoming indistinguishable from reality, **TruthLens** provides a unified, intelligent platform to detect synthetic and manipulated media across all modalities.

TruthLens leverages state-of-the-art deep learning models — powered by **PyTorch** and **Transformers** — to analyze images, videos, audio clips, and text, delivering accurate authenticity verdicts in real time through a clean web interface and a native Android application.

Whether you're a journalist, researcher, content moderator, or everyday user, TruthLens gives you the tools to **verify before you trust**.

---

## ✨ Core Capabilities

| 🔬 Detection Module | 📌 Description |
|---|---|
| 🖼️ **AI Image Detection** | Identifies AI-generated images produced by diffusion models and GANs |
| 🎬 **Fake Video Detection** | Detects deepfake and synthetically manipulated video content |
| 🔊 **AI Audio Detection** | Flags AI-cloned or synthetically generated voice and audio |
| 📝 **Fake News / Text Detection** | Classifies AI-generated or misleading textual content |

<br/>

- ⚡ **Real-time inference** via a high-performance FastAPI backend
- 🌐 **Web interface** accessible from any modern browser
- 📱 **Native Android app** built with Flutter for on-the-go detection
- 🔗 **REST API** for seamless third-party integration
- ☁️ **Cloud-deployed** on Railway with zero cold-start optimizations

---

## 🛠️ Tech Stack

### Frontend

| Technology | Role |
|---|---|
| ![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white) | Structure & Markup |
| ![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white) | Styling & Responsive Design |
| ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black) | Interactivity & API Communication |

### Mobile

| Technology | Role |
|---|---|
| ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) | Cross-platform Android Application |

### Backend & AI/ML

| Technology | Role |
|---|---|
| ![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white) | High-performance REST API Framework |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white) | Core Backend Language |
| ![PyTorch](https://img.shields.io/badge/PyTorch-EE4C2C?style=flat-square&logo=pytorch&logoColor=white) | Deep Learning & Model Inference |
| ![Transformers](https://img.shields.io/badge/🤗%20Transformers-FFD21E?style=flat-square) | Pre-trained NLP & Vision Models |

### Deployment & Infrastructure

| Technology | Role |
|---|---|
| ![Railway](https://img.shields.io/badge/Railway-0B0D0E?style=flat-square&logo=railway&logoColor=white) | Backend Hosting & Deployment |
| ![Vercel](https://img.shields.io/badge/Vercel-000000?style=flat-square&logo=vercel&logoColor=white) | Frontend Hosting |

---

## 🗂️ Project Structure

```
TruthLens/
│
├── frontend/                   # Web Interface
│   ├── index.html              # Landing page
│   ├── css/
│   │   └── style.css           # Global styles
│   └── js/
│       └── main.js             # API calls & UI logic
│
├── backend/                    # FastAPI Application
│   ├── main.py                 # App entry point & route definitions
│   ├── models/                 # AI/ML model loaders & inference logic
│   │   ├── image_detector.py
│   │   ├── video_detector.py
│   │   ├── audio_detector.py
│   │   └── text_detector.py
│   ├── utils/                  # Helper utilities
│   └── requirements.txt        # Python dependencies
│
├── flutter_app/                # Android Application
│   ├── lib/
│   │   ├── main.dart           # App entry point
│   │   ├── screens/            # UI screens
│   │   └── services/           # API service layer
│   └── pubspec.yaml            # Flutter dependencies
│
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Python **3.9+**
- Flutter **3.x+**
- pip / virtualenv

---

### Backend Setup

```bash
# 1. Clone the repository
git clone https://github.com/ronak6609-ops/TruthLens--APK-.git
cd TruthLens--APK-/backend

# 2. Create and activate a virtual environment
python -m venv venv
source venv/bin/activate        # On Windows: venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt

# 4. Run the FastAPI development server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

The backend will be live at: `http://localhost:8000`  
Interactive API docs: `http://localhost:8000/docs`

---

### Flutter App Setup

```bash
# 1. Navigate to the Flutter app directory
cd flutter_app

# 2. Install Flutter dependencies
flutter pub get

# 3. Run on a connected Android device or emulator
flutter run
```

> 📦 **Prefer a quick start?**  
> Download the pre-built APK directly:  
> **[⬇️ TruthLens v2 — Android APK](https://github.com/ronak6609-ops/TruthLens--APK-/releases/download/v1/TruthLensv2.apk)**

---

## 📡 API Endpoints

Base URL: `https://truthlens-backend-production-a5a7.up.railway.app`

| Method | Endpoint | Description | Input |
|---|---|---|---|
| `POST` | `/detect/image` | Detect AI-generated image | `multipart/form-data` — image file |
| `POST` | `/detect/video` | Detect fake/deepfake video | `multipart/form-data` — video file |
| `POST` | `/detect/audio` | Detect AI-generated audio | `multipart/form-data` — audio file |
| `POST` | `/detect/text` | Detect AI-generated or fake text | `application/json` — `{ "text": "..." }` |
| `GET` | `/health` | API health check | — |

### Example Request

```bash
curl -X POST "https://truthlens-backend-production-a5a7.up.railway.app/detect/text" \
  -H "Content-Type: application/json" \
  -d '{"text": "Paste your suspicious content here."}'
```

### Example Response

```json
{
  "label": "AI-Generated",
  "confidence": 0.94,
  "model": "TruthLens-TextDetector",
  "processing_time_ms": 312
}
```

---

## ☁️ Deployment

| Service | Platform | URL |
|---|---|---|
| 🌐 Web Frontend | Vercel | [truth-lens-ronak.vercel.app](https://truth-lens-ronak.vercel.app/) |
| ⚡ Backend API | Railway | [truthlens-backend-production-a5a7.up.railway.app](https://truthlens-backend-production-a5a7.up.railway.app) |
| 📱 Android App | GitHub Releases | [Download APK v2](https://github.com/ronak6609-ops/TruthLens--APK-/releases/download/v1/TruthLensv2.apk) |

**Deployment Notes:**
- The FastAPI backend is containerized and deployed on **Railway** with automatic builds on push.
- The frontend is deployed on **Vercel** with continuous deployment from the main branch.
- CORS is configured to allow requests from the production frontend domain.

---

## ⚡ Performance & Optimizations

- 🔁 **Async inference** — FastAPI's async request handling ensures non-blocking I/O during model inference
- 🧩 **Model caching** — Pre-trained models are loaded once at startup and reused across requests
- 📦 **Lightweight Flutter APK** — Optimized build with only essential dependencies for a minimal install size
- 🌍 **CDN-backed frontend** — Static assets served via Vercel's global edge network for low-latency delivery
- 🔒 **Input validation** — File type and size validation at the API layer to prevent malformed requests

---

## 🗺️ Future Roadmap

- [ ] 🍎 **iOS Support** — Extend the Flutter app to support Apple devices
- [ ] 📊 **Detection Dashboard** — Analytics panel for tracking detection history
- [ ] 🔐 **User Authentication** — JWT-based auth with personal detection history
- [ ] 🌍 **Multilingual Text Detection** — Support for non-English AI-generated text
- [ ] 🧪 **Confidence Explainability** — Visual heatmaps and attention maps for image/video detections
- [ ] 🔌 **Browser Extension** — One-click detection from any webpage
- [ ] 📦 **Batch Processing API** — Analyze multiple files in a single API call
- [ ] 🤝 **Webhook Support** — Event-driven notifications for async detection jobs

---

## 🤝 Contributing

Contributions are welcome and appreciated! Here's how to get involved:

```bash
# 1. Fork the repository
# 2. Create your feature branch
git checkout -b feature/your-feature-name

# 3. Commit your changes
git commit -m "feat: add your feature description"

# 4. Push to your branch
git push origin feature/your-feature-name

# 5. Open a Pull Request
```

**Guidelines:**
- Follow existing code style and project structure
- Write clear, descriptive commit messages
- Open an issue before working on large features
- Ensure all API changes are reflected in documentation

---

## 📄 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute this project with proper attribution.

---

## 👨‍💻 Developer

<div align="center">

### Ronak Solanki

[![GitHub](https://img.shields.io/badge/GitHub-ronak6609--ops-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ronak6609-ops)

*Building AI tools that help people navigate a world of synthetic media.*

</div>

---

<div align="center">

## 🌐 Live Links

| 🚀 Platform | 🔗 Link |
|---|---|
| Web App | [truth-lens-ronak.vercel.app](https://truth-lens-ronak.vercel.app/) |
| Backend API | [truthlens-backend-production-a5a7.up.railway.app](https://truthlens-backend-production-a5a7.up.railway.app) |
| GitHub | [github.com/ronak6609-ops/TruthLens--APK-](https://github.com/ronak6609-ops/TruthLens--APK-) |
| Android APK | [Download TruthLens v2](https://github.com/ronak6609-ops/TruthLens--APK-/releases/download/v1/TruthLensv2.apk) |

<br/>

---

<sub>Built with ❤️ by <a href="https://github.com/ronak6609-ops">Ronak Solanki</a> · Powered by PyTorch & FastAPI · Deployed on Railway & Vercel</sub>

<br/>

**⭐ If TruthLens helped you, consider starring the repo — it means a lot!**

</div>
