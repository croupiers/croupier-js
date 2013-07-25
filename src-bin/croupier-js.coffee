#!/usr/bin/env node

program = require 'commander'
croupier = require '../lib/croupier'

program
  .version(croupier.version)


program.on '--help', ->
  console.log "Croupier will generate random numbers with the specified distribution."
  console.log "Currently you can use this distributions:"
  console.log "" # Add distributions
  console.log ""
  console.log "Usage:"
  console.log " croupier <distribution> <n> [options]"
  console.log "  where <n> is the size of the sample Croupier will generate."
  console.log ""
  console.log "Get options list for any distribution with:"
  console.log " croupier <distribution> --help"

program.parse process.argv
