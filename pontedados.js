function obter_dados_fase_js() {
    if (parent && parent.gameData) {
        return JSON.stringify(parent.gameData);
    }
    return "";
}

function jogar_voltar_js() {
    console.log("[PonteJS] Tentando voltar para a trilha / página anterior...");
    try {
        if (window.parent && typeof window.parent.jogar_voltar_js === "function") {
            window.parent.jogar_voltar_js();
            return;
        }
    } catch (e) {}

    try {
        if (typeof window.jogar_voltar_js === "function") {
            window.jogar_voltar_js();
            return;
        }
    } catch (e) {}

    try {
        if (window.parent) {
            window.parent.postMessage({ type: "VOLTAR_PAGINA" }, "*");
        }
    } catch (e) {}

    try {
        if (window.parent && window.parent.history && window.parent.history.length > 1) {
            window.parent.history.back();
            return;
        }
    } catch (e) {}

    try {
        if (window.parent) {
            window.parent.location.href = "/trilha";
        }
    } catch (e) {}
}

function notificar_vitoria_js() {
    console.log("[PonteJS] Vitória! Notificando aplicação...");
    try {
        if (window.parent) {
            window.parent.postMessage({ type: "FIM_FASE", vitoria: true }, "*");
        }
    } catch (e) {
        console.error("Erro ao enviar mensagem de vitória:", e);
    }
}

function notificar_derrota_js() {
    console.log("[PonteJS] Derrota! Notificando aplicação...");
    try {
        if (window.parent) {
            window.parent.postMessage({ type: "FIM_FASE", vitoria: false }, "*");
        }
    } catch (e) {
        console.error("Erro ao enviar mensagem de derrota:", e);
    }
}
