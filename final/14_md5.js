
var data = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZกขฃคฅฆงจฉชซฌญฎฏฐฑฒณดตถทธนบปผฝพฟภมยรลวศษสหฬอฮ'

var total = 2 * 1024 * 1024 * 1024
var buffer = new Buffer(data, 'utf8')

var quotient = Math.floor(total / buffer.length)
var remainder = Math.floor(total % buffer.length)
var md5 = require('crypto').createHash('md5')
var out = 0
var StringDecoder = require('string_decoder').StringDecoder
var decoder = new StringDecoder('utf8')


for (var i = 0; i < quotient; i ++) {
  md5.update(buffer)
  out += buffer.length
}
var remain = buffer.slice(0, remainder)
var remainData = decoder.write(remain)
remain = new Buffer(remainData, 'utf8')
md5.update(remain)
out += remain.length

console.log(out)
console.log(total)
console.log(md5.digest('hex'))

// while (buffer.length < ) {
//   buffer = Buffer.concat([ buffer, buffer ])
// }
// console.log(buffer.length)
