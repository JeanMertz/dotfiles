
set -x MYVIMRC  ~/.config/vim/vimrc

# set PAGER to vimpager
set -x VIMPAGER_RC ~/.config/vim/vimpagerrc
set -x PAGER vimpager

function less
  $PAGER
end

function zless
  $PAGER
end
