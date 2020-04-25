import React, { useCallback, useMemo, useState } from 'react'

import { Editable, withReact, Slate } from 'slate-react'
import { createEditor } from 'slate'
import { withHistory } from 'slate-history'

import { Toolbar } from './components'
import { initialstate } from './utils'
import { onKeyDown } from './helpers'
import { withImages, withLinks, withEmbeds } from './plugins'
import { Element, Leaf } from './renderers'

const SlateEditor = () => {
  const [value, setValue] = useState(initialstate)
  const renderElement = useCallback(props => <Element {...props} />, [])
  const renderLeaf = useCallback(props => <Leaf {...props} />, [])
  const editor = useMemo(() => withImages(withLinks(withEmbeds(withHistory(withReact(createEditor()))))), [])
  const setUpdatedValue = value => {
    // console.log(value);
    setValue(value)
  }

  return (
    <Slate editor={editor} value={value} onChange={value => setUpdatedValue(value)}>
      <Toolbar />
      <Editable
        renderElement={renderElement}
        renderLeaf={renderLeaf}
        placeholder=""
        spellCheck={true}
        autoFocus={false}
        className="slate-editor"
        onKeyDown={onKeyDown}
      />
    </Slate>
  )
}

export default SlateEditor