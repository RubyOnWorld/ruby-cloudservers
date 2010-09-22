require File.dirname(__FILE__) + '/test_helper'

class CloudServersServersTest < Test::Unit::TestCase

  include TestConnection
  
  def test_list_servers

json_response = %{{
  "servers" : [
      {
     "id" : 1234,
      "name" : "sample-server",
      "imageId" : 2,
      "flavorId" : 1,
      "hostId" : "e4d909c290d0fb1ca068ffaddf22cbd0",
      "status" : "BUILD",
      "progress" : 60,
      "addresses" : {
          "public" : [
              "67.23.10.132",
              "67.23.10.131"
          ],
          "private" : [
              "10.176.42.16"
          ]
      },
      "metadata" : {
          "Server Label" : "Web Head 1",
          "Image Version" : "2.1"
      }
      },
      {
    "id" : 5678,
      "name" : "sample-server2",
      "imageId" : 2,
      "flavorId" : 1,
      "hostId" : "9e107d9d372bb6826bd81d3542a419d6",
      "status" : "ACTIVE",
      "addresses" : {
          "public" : [
              "67.23.10.133"
          ],
          "private" : [
              "10.176.42.17"
          ]
      },
      "metadata" : {
          "Server Label" : "DB 1"
      }
      }
  ]
}}
    response = mock()
    response.stubs(:code => "200", :body => json_response)

	conn=get_test_connection

    conn.stubs(:csreq).returns(response)
	servers=conn.list_servers

	assert_equal 2, servers.size
	assert_equal 1234, servers[0][:id]
	assert_equal "sample-server", servers[0][:name]

  end

end
