Leaf Notes:
===


---


	#if(score > 70) {
	    <p>Great score!</p>
	} else {
	    <p>Try again.</p>
	}


	#if(feedback) {
	    <p>Here's the feedback on your test: #(feedback).</p>
	} else {
	    <p>There was no feedback given.</p>
	}


--- 

let band = ["John", "Paul", "George", "Ringo"]
return try req.view().render("home", ["band": band])

<ul>
#for(member in band) {
    <li>#(member)</li>
}
</ul>


// You can read the size of an array by using the #count tag, like this:
<p>There are #count(band) members in the band.</p>


// There’s also a #contains tag, which lets you check whether an array contains a specific value. For example:

```
	#if(contains(band, "Taylor")) {
	    <p>Taylor is in the band!</p>
	} else {
	    <p>This band is Taylor-free.</p>
	}

```

--- 

let pythons = ["John", "Michael", "Eric", "Graham", "Terry", "Terry"]
return try req.view().render("home", ["pythons": pythons])

	#if(pythons) {
	    <ul>
	        #for(python in pythons) {
	            #if(isFirst) {
	                <li>The first member is #(python)</li>
	            } else if (isLast) {
	                <li>The last member is #(python)</li>
	            } else {
	                <li>Member number #(index + 1) is #(python)</li>
	            }
	        }
	    </ul>
	}


Notice that I use #(index + 1) to make a more natural display.

---


Text formatting


<p>#capitalize(name) will print Justin</p>
<p>#uppercase(name) will print JUSTIN</p>
<p>#lowercase(name) will print justin</p>

---

Formatting dates

return try req.view().render("home", ["now": Date()])

<p>#date(now, "y-MM-dd")</p>

---

printing HTML

return try req.view().render("home", ["html": "<h1>Hello</h1>"])

<p>#get(html)</p>

---

Comments

	#/*
	    This is a comment and will be ignored.
	*/


---

Embedding pages

	<html>
	<body>
	<h1>Header</h1>
	#get(body)
	<h2>Footer</h2>
	</body>
	</html>


The #get line means “get the value of the body block,” so we need to make a child template set that value somewhere before it embeds the parent. For example, we might write this:

	#set("body") {
		<p>This is the child template.</p>
	}
	
	#embed("master")


---




---










