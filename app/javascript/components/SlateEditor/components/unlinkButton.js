import React from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import { isBlockActive, unWrapElement } from '../helpers'

export const UnLinkButton = ({ format, icon, ...props }) => {
  const editor = useSlate()
  return (
    <Button
      active={isBlockActive(editor, format)}
      onMouseDown={event => {
        event.preventDefault()
        const { selection } = editor
        if (selection) unWrapElement(editor, selection)
      }}
      {...props}
    >
      <Icon>{icon}</Icon>
    </Button>
  )
}

export default UnLinkButton