import React from 'react'
import { useSlate } from 'slate-react'
import Button from './button'
import Icon from './icon'
import { isLineBreakActive, insertLineBreak } from '../helpers'

export const LineBreakButton = ({ icon, ...props }) => {
  const editor = useSlate()
  return (
    <Button
      active={isLineBreakActive(editor)}
      onMouseDown={event => {
        event.preventDefault()
        insertLineBreak(editor)
      }}
      {...props}
    >
      <Icon>{icon}</Icon>
    </Button>
  )
}

export default LineBreakButton