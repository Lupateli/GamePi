// Só executa a ação se a condição de cura for verdadeira
if (instance_exists(obj_personagem_bom) && obj_personagem_bom.pode_curar == true) {
    
    var valor_cura = obj_controlador.vida_maxima_bom * 0.20; // Calcula 20% da vida total
    obj_controlador.vida_bom += valor_cura;
    
    // Garante que não ultrapasse o máximo
    if (obj_controlador.vida_bom > obj_controlador.vida_maxima_bom) {
        obj_controlador.vida_bom = obj_controlador.vida_maxima_bom;
    }
    
    // Gasta a energia (você pode zerar ou apenas subtrair 50)
    obj_controlador.energia_bom -= 50;
    
    // Feedback visual (opcional)
    show_debug_message("Curou 20%!");
}