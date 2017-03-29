"==============================================================================
" Helper Functions
"==============================================================================
" True if:
" - File is owned by root (or there is an error determining this)
" - File is in a directory somewhere within a tmp directory
function! CheckIfRootOrTemp()
  let l:file_full_path = expand('%:p')
  let l:file_owner_id = +system('stat -c %u '.l:file_full_path)

  if l:file_owner_id != 0 && !v:shell_error && l:file_full_path !~ '/tmp/'
    return 0
  else
    return 1
  endif
endfunction
