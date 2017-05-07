require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cipher (text, offset)
	alphabet_lc = ('a'..'z').to_a
	alphabet_uc = ('A'..'Z').to_a
	encrypt_lc = Hash[alphabet_lc.zip(alphabet_lc.rotate(offset))]
	encrypt_uc = Hash[alphabet_uc.zip(alphabet_uc.rotate(offset))]
	text_lc = text.split('').map { |x| encrypt_lc.fetch(x,"#{x}")}
	text_all = text_lc.map { |y| encrypt_uc.fetch(y,"#{y}")}
	text_all.join
end

get '/' do
	
	text = params["encrypt"].to_s
	offset = params["offset"].to_i
	response = caesar_cipher(text, offset)

	erb :index, :locals => {:response => response}
end