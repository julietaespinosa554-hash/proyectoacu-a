
const formulario = document.getElementById("form-evento");
const lista = document.getElementById("lista-eventos");
const mensaje = document.getElementById("mensaje");

let eventos = [
    {
        nombre: "Cumpleaños de Martina",
        tipo: "Cumpleaños",
        fecha: "2026-11-15",
        hora: "20:00",
        lugar: "Salón Los Aromos",
        invitados: 60,
        estado: "Planificado"
    },
    {
        nombre: "Casamiento de Sofía y Tomás",
        tipo: "Casamiento",
        fecha: "2026-11-22",
        hora: "19:30",
        lugar: "Quinta El Sol",
        invitados: 100,
        estado: "Confirmado"
    },
    {
        nombre: "Evento empresarial",
        tipo: "Corporativo",
        fecha: "2026-12-05",
        hora: "18:00",
        lugar: "Centro de Convenciones",
        invitados: 25,
        estado: "Planificado"
    }
];

function escapar(texto) {
    const caracteres = {
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        '"': "&quot;",
        "'": "&#39;"
    };

    return String(texto).replace(
        /[&<>"']/g,
        caracter => caracteres[caracter]
    );
}

function mostrarEventos() {
    lista.innerHTML = "";

    eventos.sort((a, b) => a.fecha.localeCompare(b.fecha));

    eventos.forEach(evento => {
        const fecha = new Date(evento.fecha + "T12:00:00");

        const fechaTexto = fecha.toLocaleDateString("es-AR", {
            day: "2-digit",
            month: "short",
            year: "numeric"
        });

        const articulo = document.createElement("article");
        articulo.className = "evento";

        articulo.innerHTML = `
            <div>
                <h3>${escapar(evento.nombre)}</h3>
                <p>📅 ${fechaTexto} · ${escapar(evento.hora)} hs</p>
                <p>📍 ${escapar(evento.lugar)}</p>
                <span class="etiqueta">
                    ${escapar(evento.tipo)} · ${escapar(evento.estado)}
                </span>
            </div>

            <div class="invitados">
                <strong>${evento.invitados}</strong>
                <small>invitados</small>
            </div>
        `;

        lista.appendChild(articulo);
    });

    actualizarEstadisticas();
}

function actualizarEstadisticas() {
    const hoy = new Date();
    hoy.setHours(0, 0, 0, 0);

    const proximos = eventos.filter(evento => {
        const fecha = new Date(evento.fecha + "T12:00:00");
        return fecha >= hoy;
    }).length;

    const invitados = eventos.reduce(
        (total, evento) => total + Number(evento.invitados),
        0
    );

    document.getElementById("total-eventos").textContent =
        eventos.length;

    document.getElementById("proximos-eventos").textContent =
        proximos;

    document.getElementById("total-invitados").textContent =
        invitados;
}

formulario.addEventListener("submit", function(e) {
    e.preventDefault();

    const nuevoEvento = {
        nombre: document.getElementById("nombre").value.trim(),
        tipo: document.getElementById("tipo").value,
        fecha: document.getElementById("fecha").value,
        hora: document.getElementById("hora").value,
        lugar: document.getElementById("lugar").value.trim(),
        invitados: Number(
            document.getElementById("invitados").value
        ),
        estado: document.getElementById("estado").value
    };

    if (
        !nuevoEvento.nombre ||
        !nuevoEvento.tipo ||
        !nuevoEvento.fecha ||
        !nuevoEvento.hora ||
        !nuevoEvento.lugar ||
        nuevoEvento.invitados < 1
    ) {
        mensaje.textContent = "Completá todos los campos correctamente.";
        return;
    }

    const fechaElegida = new Date(nuevoEvento.fecha + "T00:00:00");
    const hoy = new Date();
    hoy.setHours(0, 0, 0, 0);

    if (fechaElegida < hoy) {
        mensaje.textContent = "La fecha no puede estar en el pasado.";
        return;
    }

    eventos.push(nuevoEvento);

    mostrarEventos();
    formulario.reset();

    mensaje.textContent =
        "Evento agregado correctamente a la lista. " +
        "Todavía no está guardado en una base de datos.";
});

formulario.addEventListener("reset", function() {
    mensaje.textContent = "";
});

const fechaInput = document.getElementById("fecha");
const hoy = new Date();

fechaInput.min =
    hoy.getFullYear() + "-" +
    String(hoy.getMonth() + 1).padStart(2, "0") + "-" +
    String(hoy.getDate()).padStart(2, "0");

mostrarEventos();
