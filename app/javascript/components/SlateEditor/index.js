import React, { useCallback, useMemo, useState } from 'react'

import { Editable, withReact, Slate } from 'slate-react'
import { createEditor } from 'slate'
import { withHistory } from 'slate-history'

import { Toolbar } from './components'
import { initialstate, exportToFormField, debounce } from './utils'
import { onKeyDown } from './helpers'
import { withImages, withLinks, withEmbeds } from './plugins'
import { Element, Leaf } from './renderers'

const debouncedExport = debounce(exportToFormField, 500)

const SlateEditor = ({ content, raw, field }) => {
  
  const editorState = content ? JSON.parse(content) : initialstate

  const [value, setValue] = useState(editorState)
  const renderElement = useCallback(props => <Element {...props} />, [])
  const renderLeaf = useCallback(props => <Leaf {...props} />, [])
  const editor = useMemo(() => withImages(withLinks(withEmbeds(withHistory(withReact(createEditor()))))), [])
  const setUpdatedValue = value => {
    debouncedExport(value, raw, field)
    setValue(value)
  }

  return (
    <Slate editor={editor} value={value} onChange={value => setUpdatedValue(value)}>
      <Toolbar />
      <Editable
        renderElement={renderElement}
        renderLeaf={renderLeaf}
        placeholder="The start of a wonderful post..."
        spellCheck={true}
        autoFocus={false}
        className="slate-editor"
        onKeyDown={onKeyDown}
      />
    </Slate>
  )
}

export default SlateEditor