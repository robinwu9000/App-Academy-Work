require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.json',
  # query_values: {
  #   'id' => 5,
  #   'nested[var1]' => 'val1',
  #   'nested[var2]' => 'val2',
  #   'text' => 'sample text'
  # }
).to_s

params = {
  'stuff' => 'more stuff',
  'test1' => 'test2'
}
# puts params

def create_user(name, email)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: { name: "#{name}", email: "#{email}" } }
  )
end

patch_url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/6.json'
).to_s

delete_url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/3'
).to_s
# create_user("gizmo", 'gizmo@gmail.com')
# create_user("abcde", "sample@email.com")

puts RestClient.patch(patch_url, {:user => {email: "better_email"}})
puts RestClient.get(url)
puts RestClient.delete(delete_url)
