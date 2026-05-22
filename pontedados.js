function obter_dados_fase_js() {
    if (parent && parent.gameData) {
        return JSON.stringify(parent.gameData);
    }
    return "";
}