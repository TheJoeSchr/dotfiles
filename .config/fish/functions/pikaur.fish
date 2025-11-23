# Provides a wrapper for the pikaur command to ensure that builds
# are optimized with CPU-specific flags and ccache.

function pikaur --wraps pikaur --description "Wrapper for pikaur to set build optimizations."
  set -l is_sync_op false
  for arg in $argv
    if string match -r -- '^-.*S' "$arg"
      set is_sync_op true
      break
    end
  end

  if $is_sync_op
    if not set -q BUILD_ENV_SETUP
      echo "Setting up optimized build environment for pikaur..." >&2
      set -gx BUILD_ENV_SETUP 1
      set -gx CFLAGS "-O2 -march=native -flto"
      set -gx CXXFLAGS "-O2 -march=native -flto"
      set -gx RUSTFLAGS "-C opt-level=2 -C target-cpu=native -C lto=fat"
      set -gx MAKEFLAGS "-j(nproc)"
      set -gx USE_CCACHE 1
      set -gx CCACHE_DIR "$HOME/.ccache"

      if command -sq ccache
        ccache -M 10G # allocate 10GB cache
      end

      printf "✅ Environment configured for optimized builds.\n" >&2
      printf "Using %s threads and CPU-specific optimizations:\n" "$MAKEFLAGS" >&2
      printf "  CFLAGS:    %s\n" "$CFLAGS" >&2
      printf "  CXXFLAGS:  %s\n" "$CXXFLAGS" >&2
      printf "  RUSTFLAGS: %s\n" "$RUSTFLAGS" >&2
    end
  end

  command pikaur $argv
end
