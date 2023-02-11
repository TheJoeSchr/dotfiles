  " ---------------- FIRENVIM --------------
  let g:firenvim_config = {
      \ 'globalSettings': {
      \  },
      \ 'localSettings': {
          \ '.*': {
              \ 'cmdline': 'firenvim',
              \ 'priority': 0,
              \ 'selector': 'textarea',
              \ 'takeover': 'never',
          \ },
      \ }
  \ }
  let fc = g:firenvim_config['localSettings']
  if exists('g:started_by_firenvim')
    " make it light
    set background=light
    colorscheme edge
    " let g:airline_solarized_bg='light'
    " guifont to hack and larger
    set guifont=Hack Nerd Font Mono:18

    " Firenvim has a setting named takeover that can be set to always, empty, never, nonempty or once. When set to always, Firenvim will always take over elements for you. When set to empty, Firenvim will only take over empty elements. When set to never, Firenvim will never automatically appear, thus forcing you to use a keyboard shortcut in order to make the Firenvim frame appear. When set to nonempty, Firenvim will only take over elements that aren't empty. When set to once, Firenvim will take over elements the first time you select them, which means that after :q'ing Firenvim, you'll have to use the keyboard shortcut to make it appear again. Here's how to use the takeover setting:
    " let fc['.*'] = { 'takeover': 'always' }
    " Don't use with rich text editors (.g. Gmail, Outlook, Slack…) as a general rule,
    let fc['.*'] = { 'takeover': 'nonempty', 'selector': 'textarea:not([readonly]), div[role="textbox"]'}

    " Automatically save changes to the page
    " https://github.com/glacambre/firenvim#automatically-syncing-changes-to-the-page
    au TextChanged * ++nested write
    au TextChangedI * ++nested write

    " Slow on large files. This more sophisticated approach will throttle writes:
    " let g:timer_started = v:false
    function! My_Write(timer) abort
      let g:timer_started = v:false
      write
    endfunction

    function! Delay_My_Write() abort
      if g:timer_started
        return
      end
      let g:timer_started = v:true
      call timer_start(10000, 'My_Write')
    endfunction
    
    au TextChanged * ++nested call Delay_My_Write()
    au TextChangedI * ++nested call Delay_My_Write()
  endif

