import React, { useState, useEffect } from 'react'
import { useSlate } from 'slate-react'
import { isBlockActive, removeElement } from '../helpers'
import Button from './button'
import Icon from './icon'

export const DeleteButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  const [elementSelection, setElementSelection] = useState(null)

  const { selection } = editor

  useEffect(() => {
    setElementSelection(selection)
    console.log(selection);
  }, [selection])

  return (
    <>
      <Button
        active={true}
        onMouseDown={event => {
          event.preventDefault()
          if (elementSelection) removeElement(editor, elementSelection)
        }}
        {...props}
      >
        <Icon>{icon}</Icon>
      </Button>
    </>
  )
}

export default DeleteButton