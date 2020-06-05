import { serializeValueToHtml } from './htmlSerializer'

export const exportToFormField = values => {
  const serialized = serializeValueToHtml(values);
  const [formField] = document.querySelectorAll('form #post_content')
  const stringifiedValues = serialized.reduce((agg, next) => `${agg}${next}`)
  formField.value = stringifiedValues
}