import React, { useState, useEffect } from 'react'
import Overlay from './overlay'

export const ImageOverlay = ({ showImageOverlay, handleSubmit, handleClose, url = '' }) => {
  const [showOverlay, setShowOverlay] = useState(showImageOverlay)
  const [image, setImage] = useState(url)
  const onChangeImage = event => setImage(event.target.value)
  const submit = (event) => {
    event.preventDefault()
    setShowOverlay(false)
    handleSubmit(image)
    handleClose()
    setImage('')
  }
  const closeOverlay = (event) => {
    event.preventDefault()
    setShowOverlay(false)
    handleClose()
  }

  useEffect(() => {
    setShowOverlay(showImageOverlay)
  }, [showImageOverlay])
  
  return (
    <>
      <Overlay showOverlay={showOverlay}>
        <form onSubmit={submit}>
          <div className="title">
            Add an image
          </div>
          <div>
            <label>Image URL</label>
            <input type="text" value={image} onChange={onChangeImage} />
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

export default ImageOverlay