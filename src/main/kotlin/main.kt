import kotlinx.cinterop.*
import Parson.*

fun fibonacci(numbers: Long): Array<Long> {
  if (numbers == 0L) return arrayOf(0L)
  if (numbers == 1L) return arrayOf(1L)

  var previous = 1L
  var current = 1L
  var temp: Long

  return arrayOf(1L, 1L) + (1..(numbers - 2)).map {
    temp = current + previous
    previous = current
    current = temp
    current
  }.toList().toTypedArray()
}

fun Array<String>.paramOrElse(name: String, elseValue: Long): Long {
  var result = elseValue
  if (this.size > 0) {
    val json = this[0]
    memScoped {
      val schema = json_parse_string(json)
      if (schema != null) {
        val root = json_object(schema)
        if (root != null) {
          if (json_object_has_value(root, name) == 1) {
            result = json_object_get_number(root, name).toLong()
          }
        }
        json_value_free(schema)
      }
    }
  }
  return result
}

fun Long.throughFunction(operation: (Long) -> Array<Long>): String {
  var result = "{}"
  val elements = operation(this)
  memScoped {
    val schema = json_value_init_object()
    val root = json_value_get_object(schema)

    json_object_set_value(root, "result", json_value_init_array())
    val array = json_object_get_array(root, "result");

    elements.forEach {
      json_array_append_number(array, it.toDouble())
    }

    result = json_serialize_to_string(schema)?.toKString()!!
    json_value_free(schema)
  }
  return result
}

fun main(args: Array<String>) {

  val result = args.paramOrElse("numbers", 10L).throughFunction(::fibonacci)

  println(result)
}
