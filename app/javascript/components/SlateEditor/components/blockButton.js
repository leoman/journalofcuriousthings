import React from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import { isBlockActive, toggleBlock } from '../helpers'

export const BlockButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  return (
    <Button
      active={isBlockActive(editor, format)}
      onMouseDown={event => {
        event.preventDefault()
        toggleBlock(editor, format)
      }}
      {...props}
    >
      <Icon>{icon}</Icon>
    </Button>
  )
}

export default BlockButton