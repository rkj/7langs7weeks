import scala.io._
import scala.actors._
import Actor._
import java.nio.charset.MalformedInputException

object PageLoader {
 def getPage(url : String) : String = {
   try {
     Source.fromURL(url).mkString
   } catch {
     case e:MalformedInputException => null
   }
 }
}

val urls = List(
  "http://www.amazon.com/",
  "http://www.onet.pl/",
  "http://www.twitter.com/",
  "http://www.google.com/",
  "http://www.cnn.com/"
)

def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}

def getPageSizeConcurrently() = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, PageLoader.getPage(url)) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, page:String) =>
       println("Size for " + url + ": " + page.length)
     case (url, _) => println("Bogus data for: " + url)
   }
 }
}

//println("Sequential run:")
//timeMethod { getPageSizeSequentially }

println("Concurrent run")
timeMethod { getPageSizeConcurrently }
