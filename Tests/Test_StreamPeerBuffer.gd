extends WATTest


func test_end_of_buffer():
	var stream = StreamPeerBuffer.new()
	stream.data_array = PoolByteArray([1,2,3])
	
	asserts.is_equal(1, stream.get_u8(), "First u8 value")
	asserts.is_equal(2, stream.get_u8(), "Second u8 value")
	asserts.is_equal(3, stream.get_u8(), "Third u8 value")
	# End of buffer
	asserts.is_equal(0, stream.get_u8(), "EOF u8 value")
