extends WATTest



func test_array_init():
	# From Array Object
	var array_obj = [1,2,3]
	var pba1 = PoolByteArray(array_obj)
	asserts.is_equal(3, pba1.size())
	asserts.is_equal(3, pba1[2])
	
	# From another PoolByteArray
	var pba2 = PoolByteArray(pba1)
	asserts.is_equal(3, pba2.size())
	asserts.is_equal(3, pba2[2])

func test_created_from_array_of_byte_values():
	var pba = PoolByteArray([65, 66, 67])
	var out_ascii = pba.get_string_from_ascii()
	asserts.is_equal("ABC", out_ascii, "Array of byte values are okay, and can be retrieve via ascii")

	pba = PoolByteArray([65, 0, 66, 67])
	asserts.is_equal(4, pba.size(), "Input array size == output array size")
	out_ascii = pba.get_string_from_ascii()
	asserts.is_equal("A", out_ascii, "Input array does not return 0 in ascii")
	asserts.is_equal(0, pba[1], "Zero value is still in the array")

	pba = PoolByteArray([0, 127, 128, 255])
	asserts.is_equal(4, pba.size(), "Input array size == output array size")

func test_created_from_bad_array():
	var pba = PoolByteArray([65, "string", 66, 67])
	asserts.is_equal(4, pba.size(), "Input array size == output array size")
	asserts.is_equal(65, pba[0], "in 65, out 65")
	asserts.is_equal(0, pba[1], "Input array treats string as zero")
	asserts.is_equal(66, pba[2], "in 66, out 66")
	asserts.is_equal(67, pba[3], "in 67, out 67")

	pba = PoolByteArray([65, -1, -2, 66])
	asserts.is_equal(4, pba.size(), "Input array size == output array size")
	asserts.is_equal(65, pba[0], "in 65, out 65")
	asserts.is_equal(-1 & 255, pba[1], "Array initialized with lower bits of negatives")
	asserts.is_equal(-2 & 255, pba[2], "Array initialized with lower bits of negatives")
	asserts.is_equal(66, pba[3], "in 67, out 67")

	pba = PoolByteArray([65, 256, 257, 357, 66])
	asserts.is_equal(5, pba.size(), "Input array size == output array size")
	asserts.is_equal(65, pba[0], "in 65, out 65")
	asserts.is_equal(256 & 255, pba[1], "Array initialized with lower bits of >255 values")
	asserts.is_equal(257 & 255, pba[2], "Array initialized with lower bits of >255 values")
	asserts.is_equal(357 & 255, pba[3], "Array initialized with lower bits of >255 values")
	asserts.is_equal(66, pba[4], "in 66, out 66")
