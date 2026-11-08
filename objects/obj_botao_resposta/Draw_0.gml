draw_self();
draw_set_font(global.fonte_jogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle); // Texto no meio do botão
draw_set_color(c_white);

var dados = obj_controlador.pergunta_atual_dados;
if (!is_undefined(dados)) {
    var alternativas = dados[$ "alternativas"];
    if (!is_undefined(alternativas) && indice < array_length(alternativas)) {
        var alt_texto = alternativas[indice];
        
        // Área útil segura dentro do botão (respiro de 28px em cada lado e 11px acima/abaixo)
        var max_bw = sprite_width - 56;
        var max_bh = sprite_height - 22;
        var sep = 18;
        
        // Mede o texto na escala padrão 1.0
        var escala = 1.0;
        var cur_w = string_width_ext(alt_texto, sep, max_bw);
        var cur_h = string_height_ext(alt_texto, sep, max_bw);
        
        // Se ultrapassar os limites do botão, calcula a redução necessária
        if (cur_h > max_bh || cur_w > max_bw) {
            var escala_h = max_bh / max(cur_h, 1);
            var escala_w = max_bw / max(cur_w, 1);
            escala = min(escala_h, escala_w);
            
            // Refinamento iterativo seguro: garante que NUNCA ultrapasse a borda
            var iter = 0;
            while (iter < 10) {
                var test_wrap = max_bw / escala;
                var real_h = string_height_ext(alt_texto, sep, test_wrap) * escala;
                var real_w = string_width_ext(alt_texto, sep, test_wrap) * escala;
                if (real_h <= max_bh && real_w <= max_bw) {
                    break;
                }
                escala *= 0.93;
                iter++;
            }
        }
        
        var wrap_final = max_bw / escala;
        draw_text_ext_transformed(x, y, alt_texto, sep, wrap_final, escala, escala, 0);
    }
}

// Reseta o alinhamento
draw_set_halign(fa_left);
draw_set_valign(fa_top);
