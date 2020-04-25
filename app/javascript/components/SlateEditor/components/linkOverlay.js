import React, { useState, useEffect } from 'react'
import Overlay from './overlay'

export const LinkOverlay = ({ showLinkOverlay, handleSubmit, handleClose }) => {
  const [showOverlay, setShowOverlay] = useState(showLinkOverlay)
  const [url, setUrl] = useState('')
  const onChangeUrl = event => setUrl(event.target.value)
  const submit = (event) => {
    event.preventDefault()
    setShowOverlay(false)
    handleSubmit(url)
    handleClose()
    setUrl('')
  }
  const closeOverlay = (event) => {
    event.preventDefault()
    setShowOverlay(false)
    handleClose()
  }

  useEffect(() => {
    setShowOverlay(showLinkOverlay)
  }, [showLinkOverlay])
  
  return (
    <>
      <Overlay showOverlay={showOverlay}>
        <form onSubmit={submit}>
          <div className="title">
            Add a link
          </div>
          <div>
            <label>URL</label>
            <input type="text" value={url} onChange={onChangeUrl} />
          </div>
          <div>
            <button type="submit" className="btn --submit">Submit</button>
            <button className="btn" onClick={closeOverlay}>Close</button>
          </div>
        </form>
      </Overlay>
    </>
  )
}

export default LinkOverlay