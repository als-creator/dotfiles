# ============================================================
# AI-агенты (как в omarchy: opencode + herdr); conf.d/ — загружается сам
# ============================================================

if status is-interactive
    if type -q opencode
        alias ai 'opencode'      # Запустить AI-агента в текущем терминале
    end

    if type -q herdr
        alias agent 'herdr'      # Менеджер агентов (как Super+Ctrl+Return)
    end
end