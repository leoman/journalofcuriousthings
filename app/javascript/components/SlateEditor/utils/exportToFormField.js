import { serializeValueToHtml } from './htmlSerializer'

export const exportToFormField = (values, raw, field) => {
  const serialized = serializeValueToHtml(values);
  const [rawFormField] = document.querySelectorAll(`form #${raw}`)
  const [formField] = document.querySelectorAll(`form #${field}`)
  const stringifiedValues = serialized.reduce((agg, next) => `${agg}${next}`)
  rawFormField.value = JSON.stringify(values)
  formField.value = stringifiedValues
}