#!/usr/bin/env bash
#
# Script to create a minimal WebGL demo with Three.js
# written by Andrea Giani

set -e

APP_NAME="webgl-demo-cube"
echo "==> WebGL: $APP_NAME"

# Cleaning and creating structure
rm -rf "$APP_NAME"
mkdir -p "$APP_NAME/js" && cd "$APP_NAME"

# Creating index.html
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>WebGL Cube Demo</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
</head>
<body>
  <canvas id="canvas"></canvas>
  <script src="js/app.js"></script>
</body>
</html>
EOF

# Creatinh WebGL script
cat > js/app.js <<EOF
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer({ canvas: document.getElementById('canvas') });
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const colors = [0xff0000, 0x00ff00, 0x0000ff, 0xffff00, 0xff00ff, 0x00ffff]; // Sei colori diversi
const materials = colors.map(color => new THREE.MeshBasicMaterial({ color }));
const geometry = new THREE.BoxGeometry();
const cube = new THREE.Mesh(geometry, materials);
scene.add(cube);

camera.position.z = 5;

function animate() {
  requestAnimationFrame(animate);
  cube.rotation.x += 0.01;
  cube.rotation.y += 0.01;
  renderer.render(scene, camera);
}
animate();
EOF

echo "==> Setup completed! Open index.html in the browser to see the WebGL demo."

#xdg-open index.html	# Only Linux
start index.html  	# For CMD/PowerShell on Windows

