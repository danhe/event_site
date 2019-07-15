import _filter from 'lodash/filter'

/**
* Check if the input with key has an error
* @param {String} key of input
*/
export function hasErrorInput(key, errors = []) {
  return errors.map(error => error.pointer).includes(key)
}

/**
* Error messages for input
* @param {String} key of input
*/
export function errorsOfInput(key, errors = []) {
 const errorsObject = _filter(errors, (error) => { 
   return error.pointer === key
 })

 return errorsObject.map(error => error.detail).join('<br/>')
}
