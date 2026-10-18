#!/bin/bash
# screen-recover.sh — самовосстановление экрана (чёрный экран на NVIDIA + aquamarine).
#
# Причина (подтверждено логами этой машины и багрепортами hyprwm/Hyprland
# #15469 / #14521): баг aquamarine 0.15.x на первом modeset при входе —
# коммиты кадров падают с "Cannot commit when a page-flip is awaiting",
# зависший page-flip держит вывод, и экран может остаться чёрным, пока
# что-нибудь не вызовет следующую удачную перерисовку.
#
# Что делает скрипт:
#   1. каждую секунду пинает перерисовку (forcerendererreload);
#   2. читает hyprland.log: если появляются НОВЫЕ ошибки коммитов, значит
#      page-flip всё ещё завис — делается принудительный modeset
#      (dpms off/on) — он надёжно сбрасывает зависший flip;
#   3. максимум два таких сброса, потом просто добивает перерисовками.
#
# Режимы: boot (exec-once после входа), wake (hypridle on-resume),
#         manual (клавиши Super+Shift+R).
# Лог: ~/.cache/screen-recover.log

HYPRLOG=""
[ -n "${XDG_RUNTIME_DIR:-}" ] && HYPRLOG=$(ls -t "${XDG_RUNTIME_DIR}"/hypr/*/hyprland.log 2>/dev/null | head -1)
LOGFILE="$HOME/.cache/screen-recover.log"
MARKER="Cannot commit when a page-flip is awaiting"
mode="${1:-boot}"

attempts=15
[ "$mode" = "wake" ] && attempts=8

mkdir -p "$(dirname "$LOGFILE")"
log() { printf '%s [%s] %s\n' "$(date '+%F %T')" "$mode" "$*" >>"$LOGFILE"; }

count_fail() {
    local c
    c=$(grep -c "$MARKER" "$HYPRLOG" 2>/dev/null)
    echo "${c:-0}"
}

log "=== старт (hyprland.log: ${HYPRLOG:-не найден}) ==="
prev=0
[ -n "$HYPRLOG" ] && prev=$(count_fail)
log "ошибок коммитов на момент старта: $prev"

sleep 1
hyprctl dispatch dpms on >/dev/null 2>&1

tries=0
streak=0
bounces=0
while [ "$tries" -lt "$attempts" ]; do
    tries=$((tries + 1))
    hyprctl dispatch forcerendererreload >/dev/null 2>&1
    sleep 1

    if [ -n "$HYPRLOG" ]; then
        now=$(count_fail)
        if [ "$now" -gt "$prev" ]; then
            streak=$((streak + 1))
            log "попытка $tries: коммит снова упал (всего: $now, подряд: $streak)"
            prev=$now
        else
            streak=0
        fi
    fi

    if [ "$streak" -ge 3 ] && [ "$bounces" -lt 2 ]; then
        bounces=$((bounces + 1))
        log "page-flip всё ещё завис — принудительный modeset (dpms off/on), сброс №$bounces"
        hyprctl dispatch dpms off >/dev/null 2>&1
        sleep 1
        hyprctl dispatch dpms on >/dev/null 2>&1
        sleep 1
        hyprctl dispatch forcerendererreload >/dev/null 2>&1
        sleep 1
        [ -n "$HYPRLOG" ] && prev=$(count_fail)
        streak=0
    fi
done

log "=== готово: попыток $tries, сбросов $bounces, ошибок всего: $(count_fail) ==="
