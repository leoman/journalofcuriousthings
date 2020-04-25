import { Editor, Node, Transforms, Range } from 'slate'
import isHotkey from 'is-hotkey'
import isUrl from 'is-url'
import imageExtensions from 'image-extensions'
import { HOTKEYS, LIST_TYPES } from '../utils'

export const resetSelection = editor => {
  const point = { path: [0, 0], offset: 0 };
  editor.selection = { anchor: point, focus: point };
  editor.history = { redos: [], undos: [] };
}

export const isMarkActive = (editor, format) => {
  const marks = Editor.marks(editor)
  return marks ? marks[format] === true : false
}

export const toggleMark = (editor, format) => {
  const isActive = isMarkActive(editor, format)

  if (isActive) {
    Editor.removeMark(editor, format)
  } else {
    Editor.addMark(editor, format, true)
  }
}

export const isBlockActive = (editor, format) => {
  const [match] = Editor.nodes(editor, {
    match: n => n.type === format,
  })
  return !!match
}

export const toggleBlock = (editor, format) => {
  const isActive = isBlockActive(editor, format)
  const isList = LIST_TYPES.includes(format)

  Transforms.unwrapNodes(editor, {
    match: n => LIST_TYPES.includes(n.type),
    split: true,
  })

  Transforms.setNodes(editor, {
    type: isActive ? 'paragraph' : isList ? 'list-item' : format,
  })

  if (!isActive && isList) {
    const block = { type: format, children: [] }
    Transforms.wrapNodes(editor, block)
  }
}

export const onKeyDown = event => {
  for (const hotkey in HOTKEYS) {
    if (isHotkey(hotkey, event)) {
      event.preventDefault()
      const mark = HOTKEYS[hotkey]
      toggleMark(editor, mark)
    }
  }
}

export const insertImage = (editor, url, selection) => {
  const text = { text: '' }
  const image = { type: 'image', url, children: [text] }
  Transforms.insertNodes(editor, image, { at: selection })
}

export const insertNewImage = (editor, selection, url) => {
  if (!url) return
  const text = { text: '' }
  const image = { type: 'image', url, children: [text] }
  Transforms.setNodes(editor, image, { at: selection })
}

export const isImageUrl = url => {
  if (!url) return false
  if (!isUrl(url)) return false
  const ext = new URL(url).pathname.split('.').pop()
  return imageExtensions.includes(ext)
}

export const insertDoubleImage = (editor, selection, url1, url2) => {
  const text = { text: '' }
  const image = { type: 'double-image', data: { url1, url2 }, children: [text] }
  Transforms.insertNodes(editor, image, { at: selection })
}

export const unWrapElement = (editor) => {
  try {
    Transforms.unwrapNodes(editor, { match: n => n.type === 'link' })
  } catch (e) {
    console.log('unWrapElement transform has failed: ', e)
  }
  resetSelection(editor)
}

export const unwrapLink = editor => {
  try {
    Transforms.unwrapNodes(editor, { match: n => n.type === 'link' })
  } catch (e) {
    console.log('Unwrap Link transform has failed: ', e)
  }
}

export const wrapLink = (editor, url, selection) => {
  if (isBlockActive(editor, 'image')) {
    unwrapLink(editor)
  }

  const isCollapsed = selection && Range.isCollapsed(selection)
  const link = {
    type: 'link',
    url,
    children: isCollapsed ? [{ text: url }] : [],
  }
  if (isCollapsed) {
    Transforms.insertNodes(editor, link)
  } else {
    Transforms.wrapNodes(editor, link, { split: true, at: selection })
    Transforms.collapse(editor, { edge: 'end' })
  }
}

export const insertNewLink = (editor, element) => {
  const url = window.prompt('Enter the URL of the link: ', element.url)
  if (!url) return
  const { selection } = editor
}

export const insertLink = (editor, url, selection) => {
  if (selection) {
    wrapLink(editor, url, selection)
  }
}

export const insertEmbed = (editor, url) => {
  const text = { text: '' }
  const embed = { type: 'video', url, children: [text] }
  Transforms.insertNodes(editor, embed)
}

export const isAlignActive = (editor, format) => {
  const [match] = Editor.nodes(editor, {
    match: n => n.inlineStyles && n.inlineStyles.textAlign === format,
  })
  return !!match
}

export const toggleAlign = (editor, format) => {
  const checkForListType = n => LIST_TYPES.includes(n.type)

  const { selection } = editor
  
  for (const [node, path] of Editor.nodes(editor, { at: selection })) {

    if(node.type) {

      const isListType = checkForListType(node)

      if(!isListType) {
        const inlineStyles = {
          ...node.inlineStyles,
          textAlign: format
        }
        try {
          Transforms.setNodes(editor, { inlineStyles }, { at: path })
        } catch (e) {
          console.log('Align transform has failed: ', e)
        }
      }

    }

  }

}

export const insertLineBreak = editor => {
  const text = { text: '' }
  const lineBreak = { type: 'line-break', children: [text] }
  Transforms.insertNodes(editor, lineBreak)
}

export const removeElement = (editor, selection) => {
  Transforms.removeNodes(editor, { at: selection })
}