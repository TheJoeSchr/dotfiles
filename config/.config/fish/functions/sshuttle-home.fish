function sshuttle-home --wraps='sshuttle -vDNHr ' --description 'alias sshuttle-home sshuttle -vDNHr routerwien.ddns.net -x routerwien.ddns.net:2222'
  sshuttle -vDNHr routerwien.ddns.net -x routerwien.ddns.net:22 -x routerwien.ddns.net:2222 $argv;
end
