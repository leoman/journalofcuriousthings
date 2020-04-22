import React from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import { isMarkActive, toggleMark } from '../helpers'

export const MarkButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  return (
    <Button
      active={isMarkActive(editor, format)}
      onMouseDown={event => {
        event.preventDefault()
        toggleMark(editor, format)
      }}
      {...props}
    >
      <Icon>{icon}</Icon>
    </Button>
  )
}

export default MarkButton;