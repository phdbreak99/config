import snake
import re

def replace_all(old_word, new_word):
    pos = snake.get_cursor_position()
    print('replace_all: %s -> %s' % (old_word, new_word))
    snake.command('%%s/\\<%s\\>/%s/g' % (old_word, new_word))
    snake.set_cursor_position(pos)

@snake.key_map(",fs")
def switch_between_dff_and_rff():
    """ take the word under the cursor and switch it between dff_ and rff_
    example:
        rff_if2id_ctrl -> dff_if2id_ctrl
    """

    word = snake.get_word()

    if (word.startswith('dff_')):
        new_word = 'r' + word[1:]
    elif (word.startswith('rff_')):
        new_word = 'd' + word[1:]
    else:
        return()

    replace_all(word, new_word)

@snake.key_map(",frr")
def replace_ff_with_dff():
    """ take the word under the cursor and replace it with dff_ style
    example:
        if2id_ctrl_ff -> rff_if2id_ctrl
    """

    word = snake.get_word()

    if (word.endswith('_ff')):
        new_word = 'rff_' + word[:-3]
    else:
        return()

    replace_all(word, new_word)

@snake.key_map(",frd")
def replace_ff_with_dff():
    """ take the word under the cursor and replace it with dff_ style
    example:
        if2id_ctrl_ff -> dff_if2id_ctrl
    """

    word = snake.get_word()

    if (word.endswith('_ff')):
        new_word = 'dff_' + word[:-3]
    else:
        return()

    replace_all(word, new_word)

def test():
    print('test')
