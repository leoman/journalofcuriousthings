import React, { useState, useEffect } from 'react'

export const Overlay = ({ showOverlay, children }) => {
  const [visible, setVisible] = useState(false)

  useEffect(() => {
    setVisible(showOverlay)
  }, [showOverlay])

  return (
    <div className="slate-editor-overlay" style={{display: visible ? 'block' : 'none'}}>
      <div className="wrapper">
        <div className="inner">
          <div>
            {children}
          </div>
        </div>
      </div>
    </div>
  )
}

export default Overlay;