namespace :tab do
  task :update do
    tasks=Rake.application.tasks.map(&:name)
    puts "#{autocomplete_script(tasks)}"
  end
end

private

def autocomplete_script(tasks)
%Q{
# RakeTabCompletion
# Tab completion for rake tasks

_RakeTabCompletion ()
{
  local cur colonprefixes

  cur=${COMP_WORDS[COMP_CWORD]}
  colonprefixes=${cur%"${cur##*:}"}

  COMPREPLY=( $(compgen -W '#{tasks.join(' ')}' -- $cur))

  # don't treat colons as seperators
  # borrowed from darcs via Maven (http://i.willcode4beer.com/other/maven2)
  local i=${#COMPREPLY[*]}
  while [ $((--i)) -ge 0 ]; do
    COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
  done

  return 0
} &&
complete -F _RakeTabCompletion rake
}
end
