// SkyRush: Neon Escape - 60FPS WebGL Live Animated Engine & Concept Suite Controller

// --- THREE.JS 60FPS REAL-TIME ANIMATED CINEMATIC ENGINE ---
let scene, camera, renderer;
let towers = [], flyingCars = [], rainParticles, lightningLight;
let animatedGhostMesh;
let isEnginePlaying = true;
let engineTime = 0;
let engineCameraMode = 0; // 0: Orbit, 1: FPV, 2: Tracking
let rainEnabled = true;

const videoScenesSpecs = [
  { time: "0–10s", title: "Scene 1: Cyberpunk City Fly-Through", desc: "Camera sweeps through futuristic clouds into 2099 megacity. Flying vehicles & neon lights moving continuously.", cam: "DRONE CINEMATIC SWEEP" },
  { time: "10–20s", title: "Scene 2: Ghost Rooftop Standing & Wind Physics", desc: "Camera dives to rooftop edge. Ghost standing with glowing blue circuits, wind cape, and 360° orbit camera.", cam: "360° HERO ORBIT" },
  { time: "30–35s", title: "Scene 3: NEXUS AI Laser Lock-On", desc: "Red scanning lasers sweep across rooftop. Drones swarm into sky in real-time animation with spinning rotors.", cam: "FPV LOCK-ON CHASE" },
  { time: "35–55s", title: "Scene 4: High-Velocity Sprint & Wall-Run", desc: "Real running animation, leg muscle physics, sliding under laser gates, glass wall-run, collapsing building debris.", cam: "SHOULDER TRACKING" },
  { time: "55–75s", title: "Scene 5: 300km/h Hover Train Pursuit", desc: "Ghost jumps onto high-speed mag-rail hover train. Flying car traffic overtakes train in continuous motion.", cam: "DYNAMIC TRAIN CAM" },
  { time: "75–95s", title: "Scene 6: Robotic Spider Rooftop Attack", desc: "Giant mechanical spider moving hydraulic legs, crushing glass edge. Explosions, dynamic smoke, katana strikes.", cam: "SLOW-MOTION 360°" },
  { time: "95–110s", title: "Scene 7: Mecha Dragon Thunderstorm", desc: "Colossal mechanical dragon breaches storm clouds with flapping wings. Time freeze 360° suspended rain droplets.", cam: "IMAX BIRDS-EYE" },
  { time: "110–120s", title: "Scene 8: Anti-Gravity Wings & Title Reveal", desc: "Radiant blue energy wings activate. Supersonic flight into clouds. Title reveal: SKYRUSH: NEON ESCAPE - Run Beyond Reality.", cam: "SUPERSONIC FLY-BY" }
];

function init3DEngine() {
  const container = document.getElementById('webglContainer');
  if (!container) return;

  const width = container.clientWidth || 900;
  const height = container.clientHeight || 540;

  // Scene
  scene = new THREE.Scene();
  scene.fog = new THREE.FogExp2(0x060913, 0.015);

  // Camera
  camera = new THREE.PerspectiveCamera(60, width / height, 0.1, 1000);
  camera.position.set(0, 30, 80);

  // Renderer
  renderer = new THREE.WebGLRenderer({ antialias: true, alpha: false });
  renderer.setSize(width, height);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFSoftShadowMap;
  
  // Clear existing canvas
  const existingCanvas = container.querySelector('canvas');
  if (existingCanvas) container.removeChild(existingCanvas);
  container.appendChild(renderer.domElement);

  // Lighting
  const ambientLight = new THREE.AmbientLight(0x0b1021, 1.5);
  scene.add(ambientLight);

  const mainNeonLight = new THREE.PointLight(0x00f0ff, 3, 150);
  mainNeonLight.position.set(0, 50, 0);
  scene.add(mainNeonLight);

  const pinkNeonLight = new THREE.PointLight(0xff007f, 3, 150);
  pinkNeonLight.position.set(-50, 40, -30);
  scene.add(pinkNeonLight);

  lightningLight = new THREE.PointLight(0xa5f3fc, 0, 300);
  lightningLight.position.set(0, 100, -100);
  scene.add(lightningLight);

  // Build Cyberpunk City Spire Mesh
  towers = [];
  const towerGeo = new THREE.BoxGeometry(10, 1, 10);

  for (let i = 0; i < 45; i++) {
    const heightScale = Math.random() * 80 + 30;
    const mat = new THREE.MeshStandardMaterial({
      color: 0x090e1a,
      roughness: 0.2,
      metalness: 0.8,
      wireframe: Math.random() > 0.8
    });

    const tower = new THREE.Mesh(towerGeo, mat);
    tower.scale.set(Math.random() * 1.5 + 1, heightScale, Math.random() * 1.5 + 1);
    tower.position.set(
      (Math.random() - 0.5) * 200,
      heightScale / 2,
      (Math.random() - 0.5) * 200
    );
    scene.add(tower);
    towers.push(tower);

    // Add neon light strips to rooftop spires
    if (Math.random() > 0.4) {
      const beaconGeo = new THREE.SphereGeometry(0.8, 8, 8);
      const beaconMat = new THREE.MeshBasicMaterial({
        color: Math.random() > 0.5 ? 0x00f0ff : 0xff007f
      });
      const beacon = new THREE.Mesh(beaconGeo, beaconMat);
      beacon.position.set(tower.position.x, heightScale + 1, tower.position.z);
      scene.add(beacon);
    }
  }

  // Animated Flying Vehicles
  flyingCars = [];
  for (let i = 0; i < 25; i++) {
    const carGeo = new THREE.BoxGeometry(2, 0.8, 4);
    const carMat = new THREE.MeshBasicMaterial({ color: Math.random() > 0.5 ? 0x00f0ff : 0xffee00 });
    const car = new THREE.Mesh(carGeo, carMat);
    car.position.set(
      (Math.random() - 0.5) * 150,
      Math.random() * 50 + 20,
      (Math.random() - 0.5) * 150
    );
    car.userData = { speed: Math.random() * 0.8 + 0.4, dir: Math.random() > 0.5 ? 1 : -1 };
    scene.add(car);
    flyingCars.push(car);
  }

  // 5,000 Continuous Rain Particles
  const rainCount = 4000;
  const rainGeo = new THREE.BufferGeometry();
  const rainPos = new Float32Array(rainCount * 3);

  for (let i = 0; i < rainCount * 3; i += 3) {
    rainPos[i] = (Math.random() - 0.5) * 200;
    rainPos[i + 1] = Math.random() * 100;
    rainPos[i + 2] = (Math.random() - 0.5) * 200;
  }

  rainGeo.setAttribute('position', new THREE.BufferAttribute(rainPos, 3));
  const rainMat = new THREE.PointsMaterial({
    color: 0x00f0ff,
    size: 0.4,
    transparent: true,
    opacity: 0.7
  });

  rainParticles = new THREE.Points(rainGeo, rainMat);
  scene.add(rainParticles);

  // Ghost Animated Cyber Ninja Mesh (3D Proxy with Energy Katana)
  const ghostGroup = new THREE.Group();
  const bodyGeo = new THREE.CylinderGeometry(0.8, 0.5, 3, 8);
  const bodyMat = new THREE.MeshStandardMaterial({ color: 0x060913, metalness: 0.9, roughness: 0.1 });
  const bodyMesh = new THREE.Mesh(bodyGeo, bodyMat);
  ghostGroup.add(bodyMesh);

  // Visor
  const visorGeo = new THREE.BoxGeometry(0.9, 0.4, 0.6);
  const visorMat = new THREE.MeshBasicMaterial({ color: 0x00f0ff });
  const visorMesh = new THREE.Mesh(visorGeo, visorMat);
  visorMesh.position.set(0, 1.2, 0.3);
  ghostGroup.add(visorMesh);

  // Energy Katana Blade
  const bladeGeo = new THREE.BoxGeometry(0.1, 3.5, 0.1);
  const bladeMat = new THREE.MeshBasicMaterial({ color: 0x00f0ff });
  const bladeMesh = new THREE.Mesh(bladeGeo, bladeMat);
  bladeMesh.position.set(0.8, 0.5, -0.5);
  bladeMesh.rotation.z = -0.4;
  ghostGroup.add(bladeMesh);

  ghostGroup.position.set(0, 42, 0);
  scene.add(ghostGroup);
  animatedGhostMesh = ghostGroup;

  // Render Loop
  animate3DEngine();
}

function animate3DEngine() {
  if (!renderer) return;

  requestAnimationFrame(animate3DEngine);

  if (isEnginePlaying) {
    engineTime += 0.016;

    // Camera Motion & Camera Modes
    if (engineCameraMode === 0) {
      // 360 Orbit Camera
      camera.position.x = Math.sin(engineTime * 0.3) * 70;
      camera.position.z = Math.cos(engineTime * 0.3) * 70;
      camera.position.y = 35 + Math.sin(engineTime * 0.5) * 10;
      camera.lookAt(0, 35, 0);
    } else if (engineCameraMode === 1) {
      // FPV Chase Camera
      camera.position.set(0, 44, 12);
      camera.lookAt(0, 42, -50);
    } else {
      // Supersonic Dynamic Zoom Camera
      camera.position.set(Math.sin(engineTime * 0.8) * 40, 25, 40);
      camera.lookAt(animatedGhostMesh.position);
    }

    // Move Flying Vehicles
    flyingCars.forEach(car => {
      car.position.z += car.userData.speed * car.userData.dir;
      if (car.position.z > 100) car.position.z = -100;
      if (car.position.z < -100) car.position.z = 100;
    });

    // Animate Rain Particles
    if (rainParticles && rainEnabled) {
      const positions = rainParticles.geometry.attributes.position.array;
      for (let i = 1; i < positions.length; i += 3) {
        positions[i] -= 2.5; // Rain speed
        if (positions[i] < 0) positions[i] = 100;
      }
      rainParticles.geometry.attributes.position.needsUpdate = true;
    }

    // Animate Ghost Mesh (Sprint & Jump Pulse)
    if (animatedGhostMesh) {
      animatedGhostMesh.rotation.y += 0.01;
      animatedGhostMesh.position.y = 42 + Math.sin(engineTime * 3) * 1.5;
    }

    // Dynamic Lightning Flashes
    if (Math.random() > 0.97 && lightningLight) {
      lightningLight.intensity = Math.random() * 8 + 4;
      setTimeout(() => { if (lightningLight) lightningLight.intensity = 0; }, 80);
    }

    // Update Progress UI
    const totalDuration = 120;
    const currentSec = Math.floor((engineTime % totalDuration));
    const sceneIdx = Math.min(7, Math.floor(currentSec / 15));
    const spec = videoScenesSpecs[sceneIdx];

    const subEl = document.getElementById('liveEngineSubtitle');
    const timeEl = document.getElementById('liveEngineTimeCode');
    const titleEl = document.getElementById('liveSceneTitle');
    const badgeEl = document.getElementById('liveCameraBadge');
    const progressFill = document.getElementById('liveProgressFill');

    if (subEl) subEl.textContent = `[${spec.time}] ${spec.title}: ${spec.desc}`;
    if (timeEl) timeEl.textContent = `00:${String(currentSec).padStart(2, '0')} / 02:00`;
    if (titleEl) titleEl.textContent = spec.title;
    if (badgeEl) badgeEl.textContent = spec.cam;
    if (progressFill) progressFill.style.width = `${(currentSec / totalDuration) * 100}%`;
  }

  renderer.render(scene, camera);
}

function toggleEnginePlay() {
  isEnginePlaying = !isEnginePlaying;
  const btn = document.getElementById('livePlayBtn');
  if (btn) btn.innerHTML = isEnginePlaying ? '<i class="fa-solid fa-pause"></i>' : '<i class="fa-solid fa-play"></i>';
}

function switchCameraMode() {
  engineCameraMode = (engineCameraMode + 1) % 3;
}

function toggleRainParticles() {
  rainEnabled = !rainEnabled;
  if (rainParticles) rainParticles.visible = rainEnabled;
}

// --- CONCEPT ART GALLERY & VOICE-OVER LOGIC ---
const scenes = [
  { id: 1, title: "1. Rooftop Overlook at Sunset", tag: "PROLOGUE // NEO-KYOTO 2099", image: "assets/images/skyrush_sunset_overlook_1784885994894.png", subtitle: "The story begins in the year 2099. Gigantic megacities float above clouds.", camera: "WIDE CINEMATIC", directorCue: "Slow zoom out from Ghost visor." },
  { id: 2, title: "2. AI Drone Laser Scan", tag: "SURVEILLANCE // NEXUS REGIME", image: "assets/images/skyrush_drone_scan_1784886016470.png", subtitle: "Autonomous drones patrol skies. Holographic warnings: 'Obey NEXUS'.", camera: "FPV CHASE & LOW ANGLE", directorCue: "Red lasers sweep across rooftop." },
  { id: 3, title: "3. Skyscraper Glass Wall-Run", tag: "HIGH VELOCITY // ESCAPE", image: "assets/images/skyrush_wall_run_1784886045704.png", subtitle: "Ghost wall-runs across glass skyscraper with blue suit energy trails.", camera: "SHOULDER ACTION CAM", directorCue: "Dynamic motion blur & rain droplets." },
  { id: 4, title: "4. Rooftop Robotic Spider Attack", tag: "BOSS ENCOUNTER // MECH SPIDER", image: "assets/images/skyrush_robotic_spider_1784886072586.png", subtitle: "Giant robotic spider crushes rooftop edge. Ghost flips over monster in slow motion.", camera: "SLOW MOTION 360", directorCue: "Sparks fly as katana slashes." },
  { id: 5, title: "5. Hover Train Pursuit", tag: "HIGHWAY SPEED // MAG-RAIL", image: "assets/images/skyrush_hover_train_1784886099175.png", subtitle: "Ghost lands on hover train racing through city at 300km/h.", camera: "DYNAMIC TRACKING", directorCue: "Translucent glass tracks & flying cars." },
  { id: 6, title: "6. Mechanical Dragon In Thunderstorm", tag: "CLIMAX BOSS // MECHA DRAGON", image: "assets/images/skyrush_mechanical_dragon_1784886135815.png", subtitle: "Colossal mechanical dragon emerges from storm clouds with red optics.", camera: "IMAX SCALE", directorCue: "Lightning strikes & volumetric fog." },
  { id: 7, title: "7. Anti-Gravity Wings Activation", tag: "LIMIT BREAK // ANTI-GRAVITY", image: "assets/images/skyrush_antigravity_wings_1784886170754.png", subtitle: "Radiant blue energy wings flare out in mid-air time freeze slow motion.", camera: "360 ORBIT", directorCue: "Suspended rain droplets in neon light." },
  { id: 8, title: "8. SkyRush Poster & Title Reveal", tag: "OUTRO // COMING SOON", image: "assets/images/skyrush_hero_title_1784886209827.png", subtitle: "SKYRUSH: NEON ESCAPE - Run Beyond Reality.", camera: "HERO SHOT", directorCue: "Official key art poster." }
];

const voiceOverPhases = [
  { time: "0–10 SEC", mood: "Calm, Slow & Mysterious", sceneIndex: 0, text: "In the year... 2099... Humanity reached the stars... But in its pursuit of perfection... It surrendered... its freedom.", cue: "🎵 Soft ambient music begins. Calm, mysterious tone." },
  { time: "10–30 SEC", mood: "Suspense & AI Empire", sceneIndex: 1, text: "A city of endless light... Powered by artificial intelligence... Watched... Controlled... Ruled. They believed... No one could escape. They were wrong.", cue: "💥 Low cinematic boom. Electronic pulse begins." },
  { time: "30–60 SEC", mood: "Rising Intensity & The Rebel", sceneIndex: 2, text: "One runner... One impossible mission... One final chance... To rewrite the future. He doesn't hide... He doesn't surrender... He runs.", cue: "🥁 Fast percussion begins." },
  { time: "60–90 SEC", mood: "Epic Action Explodes", sceneIndex: 4, text: "Across impossible rooftops... Above a city that never sleeps... Beyond the reach... Of machines. Every jump... Every wall run... Every heartbeat... Could be his last.", cue: "🚨 Action music explodes!" },
  { time: "90–110 SEC", mood: "Heroic & Anti-Gravity Climax", sceneIndex: 6, text: "But legends... Are never born... By standing still. Face towering machines. Outrun deadly drones. Master anti-gravity. Defy impossible odds. Become... The last hope... For humanity.", cue: "🎻 Massive orchestral strings surge!" },
  { time: "110–120 SEC", mood: "Slow, Memorable Title Reveal", sceneIndex: 7, text: "This... Is not... Just another run. This... Is... SkyRush... Neon Escape. Run beyond fear. Leap beyond limits. Fly beyond destiny. Coming Soon. Prepare... To Run.", cue: "🔥 Final sub-bass impact." }
];

// Gallery & Modal Logic
function renderGallery() {
  const galleryGrid = document.getElementById('galleryGrid');
  if (!galleryGrid) return;
  galleryGrid.innerHTML = '';
  scenes.forEach(sc => {
    const card = document.createElement('div');
    card.className = 'art-card';
    card.innerHTML = `
      <div class="art-card-img-wrapper"><img src="${sc.image}" alt="${sc.title}" class="art-card-img"></div>
      <div class="art-card-info">
        <div class="art-card-tag">${sc.tag}</div>
        <h3 class="art-card-title">${sc.title}</h3>
        <p class="art-card-desc">${sc.subtitle}</p>
      </div>
    `;
    card.onclick = () => openModal(sc);
    galleryGrid.appendChild(card);
  });
}

function openModal(sc) {
  const modalBody = document.getElementById('modalBody');
  const imageModal = document.getElementById('imageModal');
  if (!modalBody || !imageModal) return;
  modalBody.innerHTML = `
    <div style="display:flex; flex-direction:column; gap:20px;">
      <img src="${sc.image}" alt="${sc.title}" style="width:100%; border-radius:12px; border:1px solid var(--neon-blue);">
      <div>
        <div style="color:var(--neon-blue); font-family:'Space Grotesk'; font-size:0.85rem; font-weight:700;">${sc.tag}</div>
        <h2 style="font-family:'Orbitron'; color:#fff; font-size:1.8rem;">${sc.title}</h2>
        <p style="color:var(--text-main); margin-bottom:15px;">${sc.subtitle}</p>
        <a href="${sc.image}" download class="btn-cyber btn-cyber-filled" style="text-decoration:none;"><i class="fa-solid fa-download"></i> Download 8K Image</a>
      </div>
    </div>
  `;
  imageModal.classList.add('active');
}

function closeModal() {
  const imageModal = document.getElementById('imageModal');
  if (imageModal) imageModal.classList.remove('active');
}

function scrollToSection(id) {
  const el = document.getElementById(id);
  if (el) el.scrollIntoView({ behavior: 'smooth' });
}

// Event Listeners Initialization
window.addEventListener('DOMContentLoaded', () => {
  init3DEngine();
  renderGallery();

  const livePlayBtn = document.getElementById('livePlayBtn');
  const liveCamBtn = document.getElementById('liveCamBtn');
  const modalCloseBtn = document.getElementById('modalCloseBtn');
  const imageModal = document.getElementById('imageModal');

  if (livePlayBtn) livePlayBtn.addEventListener('click', toggleEnginePlay);
  if (liveCamBtn) liveCamBtn.addEventListener('click', switchCameraMode);
  if (modalCloseBtn) modalCloseBtn.addEventListener('click', closeModal);
  if (imageModal) imageModal.addEventListener('click', (e) => { if (e.target === imageModal) closeModal(); });
});
