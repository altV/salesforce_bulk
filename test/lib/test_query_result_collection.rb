require 'test_helper'

class TestQueryResultCollection < Test::Unit::TestCase
  
  def setup
    options = {
      :username => 'myusername', 
      :password => 'mypassword',
      :token => "somelongtoken"
    }
    
    @client = SalesforceBulk::Client.new(options)
    @job_id = "123"
    @batch_id = "234"
    @result_ids = ["12","23","34"]
    @total_size = @result_ids.length
    @result_id = @result_ids[1]
    @previous_result_id = @result_ids.first
    @next_result_id = @result_ids.last
    @collection = SalesforceBulk::QueryResultCollection.new(@client, @job_id, @batch_id, @total_size, @result_id, @previous_result_id, @next_result_id)
  end
  
  test "initilize using defaults" do
    collection = SalesforceBulk::QueryResultCollection.new(@client, @job_id, @batch_id)
    
    assert_equal collection.client, @client
    assert_equal collection.job_id, @job_id
    assert_equal collection.batch_id, @batch_id
    assert_equal collection.total_size, 0
    assert_nil collection.result_id
    assert_nil collection.previous_result_id
    assert_nil collection.next_result_id
  end
  
  test "initilize with all values" do
    assert_equal @collection.client, @client
    assert_equal @collection.job_id, @job_id
    assert_equal @collection.batch_id, @batch_id
    assert_equal @collection.total_size, @total_size
    assert_equal @collection.result_id, @result_id
    assert_equal @collection.previous_result_id, @previous_result_id
    assert_equal @collection.next_result_id, @next_result_id
  end
  
  test "next?" do
    assert @collection.next?
    
    @collection.instance_variable_set('@next_result_id', '')
    assert !@collection.next?
  end
  
  test "next" do
    assert_kind_of SalesforceBulk::QueryResultCollection, @collection.next
  end
  
  test "previous?" do
    assert @collection.previous?
    
    @collection.instance_variable_set('@previous_result_id', '')
    assert !@collection.previous?
  end
  
  test "previous" do
    assert_kind_of SalesforceBulk::QueryResultCollection, @collection.previous
  end
  
end