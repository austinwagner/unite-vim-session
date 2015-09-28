function! unite#sources#session#define()
    return s:source
endfunction

let s:source={
\   'name': 'session',
\   'description': 'sessions from xolox-session plugin',
\   'default_action': 'load',
\   'action_table': {},
\}

function! s:source.gather_candidates(args, context)
    let sessions=xolox#session#get_names(0)
    let candidates=map(copy(sessions), "{
\       'word': v:val,
\       'kind': 'common'
\   }")

    return candidates
endfunction

let s:source.action_table.load={
\   'description': 'load this session'
\}

function! s:source.action_table.load.func(candidate)
    call xolox#session#open_cmd(a:candidate.word, '', 'OpenSession')
endfunction

let s:source.action_table.delete={
\   'description': 'delete this session',
\   'is_invalidate_cache': 1,
\   'is_quit': 0,
\   'is_selectable': 1,
\}

function! s:source.action_table.delete.func(candidates)
    for candidate in a:candidates
        if input('Delete session ' . candidate.word . '? ') =~? 'y\%[es]'
            call xolox#session#delete_cmd(candidates.word, '')
        endif
    endfor
endfunction

let s:source.action_table.save={
\   'description': 'overwrite this session'
\}

function! s:source.action_table.save.func(candidate)
    call xolox#session#save_cmd(a:candidate.word, '', 'SaveSession')
endfunction
