package wa2en

import kotlinx.cinterop.*
import libb2.DIGEST_SIZE
import libb2.blake2sum

object BLAKE2 {
    private val hashes = mapOf(
            "ev000.pak" to "BE4FC285F26F9AFC8547C7E735499D84",
            "ev150.pak" to "2288ED08576F6606BFFD07A835381437",
            "IC/mv010.pak" to "D8F09A45AE18030B447FA8B58E7DA45A",
            "IC/mv020.pak" to "D90AA13A244571603B20B0DC9D4D9077",
            "IC/mv070.pak" to "18145C62DBAD3F91B0B8E9993571E308",
            "IC/mv080.pak" to "37E9F331C4DEB1EB1101CD76D791BF4C",
            "IC/mv090.pak" to "494765CDA61E9BF0A08105184136927E",
            "mv200.pak" to "31AF9B29437C926021FA8B1685EED0EB"
    )

    @Throws(Error::class)
    operator fun invoke(file: File): String = memScoped {
        val result = allocArray<ByteVar>(2 * DIGEST_SIZE + 1)
        blake2sum(result, file.open("rb"))
        file.close()
        result.toKString()
    }

    @Throws(Error::class)
    fun verify(file: File, name: String): String {
        val hash = invoke(file)
        val expected = hashes[name] ?: return hash
        if (hash != expected)
            throw Error.Hash("Invalid hash for $file (expected: $expected, got: $hash)")
        return hash
    }
}
