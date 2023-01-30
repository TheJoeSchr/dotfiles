function myasp --wraps='bash -c "source common.sh; aurgitmake_install pikaur"' --description 'alias myay bash -c "source common.sh; aurgitmake_install pikaur"'
  bash -c "source ~/archlinux/common.sh; aurgitmake_install $argv" 
end
