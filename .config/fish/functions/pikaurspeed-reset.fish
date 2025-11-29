function pikaurspeed-reset --description "Resets all env variables that pikaurspeed sets"
    set -e BUILD_ENV_SETUP
    set -e CFLAGS
    set -e CXXFLAGS
    set -e RUSTFLAGS
    set -e MAKEFLAGS
    set -e USE_CCACHE
    set -e CCACHE_DIR
end
