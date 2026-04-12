const modulos = [
  { nombre: "Manifiesto Ético", url: "docs/manifiesto.md" },
  { nombre: "EnsDeLiz Core", url: "ledl_core.py" },
  { nombre: "Visualización Cortical", url: "docs/cortical.md" }
];

const lista = document.getElementById("modulo-lista");
modulos.forEach(mod => {
  const item = document.createElement("li");
  item.innerHTML = `<a href="${mod.url}">${mod.nombre}</a>`;
  lista.appendChild(item);
});
