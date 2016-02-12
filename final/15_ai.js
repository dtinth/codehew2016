'use strict'

const Promise = require('bluebird')
const rp = require('request-promise')
const server = process.env.TTT_S || 'http://128.199.205.4:8080'
const TicTacToe = require('tictactoe-agent')

function rpc (t, body) {
  return rp.post(server + '/ai/' + t, {
    body: body,
    json: true
  })
}

const TEAM = 'チャンキーベーコン'

Promise.coroutine(function* () {
  let resp = yield rpc('play', { team: TEAM })
  while (true) {
    console.log(resp)
    if (resp.status === 1) return
    if (resp.status === 2) return
    if (resp.status === 3) return
    if (resp.status === -1) return
    const model = new TicTacToe.Model(resp.table.replace(/ /g, '-'), 'X')
    const recommendation = model.getRecommendation()
    console.log(recommendation.index)
    const newTable = resp.table.substr(0, recommendation.index) + 'X' + resp.table.substr(recommendation.index + 1)

    console.log('newTable', [ newTable ])
    resp = yield rpc('move', { team: TEAM, table: newTable })
  }
})
()
.done()
