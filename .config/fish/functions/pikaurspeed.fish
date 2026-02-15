# Provides a wrapper for the pikaur command to ensure that builds
# are optimized with CPU-specific flags and ccache.

function pikaurspeed --wraps pikaur --description "Wrapper for pikaur to set build optimizations."
    set -l is_sync_op false
    for arg in $argv
        if string match -r -- '^-.*S' "$arg"
            set is_sync_op true
            break
        end
    end

    if $is_sync_op
        if not set -q BUILD_ENV_SETUP
            # scope build setup to only this function
            begin
                echo "Setting up optimized build environment for pikaur..." >&2
                set -gx BUILD_ENV_SETUP 1
                set -gx CFLAGS "-O2 -march=native -flto"
                set -gx CXXFLAGS "-O2 -march=native -flto"
                set -gx RUSTFLAGS "-C opt-level=2 -C target-cpu=native -C lto=fat"
                set -gx MAKEFLAGS "-j$(nproc)"
                set -gx USE_CCACHE 1
                set -gx CCACHE_DIR "$HOME/.cache/ccache"

                if command -sq ccache
                    if not test -d "$CCACHE_DIR"
                        mkdir -p "$CCACHE_DIR"
                    end

                    ccache -M 10G # allocate 10GB cache
                end

                printf "✅ Environment configured for optimized builds.\n" >&2
                printf "  BUILD_ENV_SETUP: %s\n" "$BUILD_ENV_SETUP" >&2
                printf "  CFLAGS:    %s\n" "$CFLAGS" >&2
                printf "  CXXFLAGS:  %s\n" "$CXXFLAGS" >&2
                printf "  RUSTFLAGS: %s\n" "$RUSTFLAGS" >&2
                printf "  MAKEFLAGS: %s\n" "$MAKEFLAGS" >&2
                printf "  USE_CCACHE: %s\n" "$USE_CCACHE" >&2
                printf "  CCACHE_DIR: %s\n" "$CCACHE_DIR" >&2
                command pikaur $argv

                set -e BUILD_ENV_SETUP
                set -e CFLAGS
                set -e CXXFLAGS
                set -e RUSTFLAGS
                set -e MAKEFLAGS
                set -e USE_CCACHE
                set -e CCACHE_DIR
                printf "✅ Environment cleaned.\n" >&2
                printf "  BUILD_ENV_SETUP: %s\n" "$BUILD_ENV_SETUP" >&2
                printf "  CFLAGS:    %s\n" "$CFLAGS" >&2
                printf "  CXXFLAGS:  %s\n" "$CXXFLAGS" >&2
                printf "  RUSTFLAGS: %s\n" "$RUSTFLAGS" >&2
                printf "  MAKEFLAGS: %s\n" "$MAKEFLAGS" >&2
                printf "  USE_CCACHE: %s\n" "$USE_CCACHE" >&2
                printf "  CCACHE_DIR: %s\n" "$CCACHE_DIR" >&2
            end
        end
    else
        command pikaur $argv
    end
end
