# encoding: UTF-8

require 'apollon/cli/cli'

describe 'apollon provider show' do
  it 'Shows providers' do
    out = run_cli(['provider', 'show'])
    expect(out).to be_a_kind_of(String)
  end
end