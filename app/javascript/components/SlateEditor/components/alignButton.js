import React from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import { isAlignActive, toggleAlign } from '../helpers'

export const AlignButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  return (
    <Button
      active={isAlignActive(editor, format)}
      onMouseDown={event => {
        event.preventDefault()
        toggleAlign(editor, format)
      }}
      {...props}
    >
      <Icon>{icon}</Icon>
    </Button>
  )
}

export default AlignButton