import java.io.FileNotFoundException
import java.io.InputStreamReader
import java.nio.charset.Charset

object Util {

    fun readResource(resourceName: String): List<String> {
        val stream = Thread.currentThread().contextClassLoader.getResourceAsStream(resourceName) ?: throw FileNotFoundException(resourceName)

        return InputStreamReader(stream, Charset.defaultCharset()).use { reader ->
            reader.readLines()
        }
    }
}