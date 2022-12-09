function gh
echo "extended with 1password cli"
export OP_PLUGIN_ALIASES_SOURCED=1
op plugin run -- gh $argv
end
