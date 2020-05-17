const SELECT_BOX = 'select-box'

class ProductListFilters {
  constructor() {
    this.selectBoxes = document.getElementsByClassName(SELECT_BOX)
    this.addEventListener();
  }

  addEventListener = () => {
    Array.from(this.selectBoxes, select => {
      const queryParam = select.dataset.param
      select.addEventListener('input', (evt) => this.handleInputChange(evt.target.value, queryParam))
    })
  }

  handleInputChange = (value, queryParam) => {
    const urlParams = this.getUrlParams()
    value ? urlParams.set(queryParam, value) : urlParams.delete(queryParam)
    const newUrlParams = urlParams.toString() ? `?${urlParams.toString()}` : ''
    window.location.replace(this.getNewUrl(newUrlParams))
  }

  getUrlParams = () => new URLSearchParams(window.location.search);

  getNewUrl = urlParams => `${window.location.origin}${window.location.pathname}${urlParams}`

}

document.addEventListener("turbolinks:load", () => new ProductListFilters())