import React, { useState, useEffect } from 'react'
import Overlay from './overlay'

export const ImageDoubleOverlay = ({ showImageOverlay, handleSubmit, handleClose, url = '' }) => {
  const [showOverlay, setShowOverlay] = useState(showImageOverlay)
  const [image, setImage] = useState(url)
  const [image2, setImage2] = useState(url)
  const onChangeImage = event => setImage(event.target.value)
  const onChangeImage2 = event => setImage2(event.target.value)
  const submit = (event) => {
    event.preventDefault()
    setShowOverlay(false)
    handleSubmit(image, image2)
    handleClose()
    setImage('')
    setImage2('')
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
    <Overlay showOverlay={showOverlay}>
      <form onSubmit={submit}>
        <div className="title">
          Add an image
        </div>
        <div>
          <label>Image one URL</label>
          <input type="text" value={image} onChange={onChangeImage} />
        </div>
        <div>
            <label>Image two URL</label>
            <input type="text" value={image2} onChange={onChangeImage2} />
          </div>
        <div>
          <button type="submit" className="btn --submit">Submit</button>
          <button className="btn" onClick={closeOverlay}>Close</button>
        </div>
      </form>
    </Overlay>
  )
}

export default ImageDoubleOverlay