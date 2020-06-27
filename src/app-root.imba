import {listings} from './data.imba'
import {Logo} from './tags/Logo'

var filterArray = ["HTML","CSS","JavaScript","Python", "React", "Sass","Ruby", "RoR", "Vue", "Django"]


css @root
	box-sizing: content-box
	$font: 'Spartan', sans-serif
	$shadow: 0px 5px 10px hsl(180, 29%, 80%)

css body, html
	p:0 m:0
tag app-root
	# APP-ROOT STYLES
	css &
		d:flex
		fld: column
	css main
			bg: teal4/10
			pb:100px
	css .container
			max-width: 1200px
			mx: auto
			margin-top: -30px
			px:6

	css .signature
			ff: $font
			text-align: center
			py:6
			color: teal5
			fw: bold
			a 
				color: teal8 @hover: pink5
				text-decoration: none
	css %logo
		display: inline-block
		width: 80px
		transform: translateY(10px)	
	# APP-ROOT TEMPLATE & LOGIC
	def render
		<self>
			<Header>
			<main>
				<.container>
					<FilterBar>
					<Listings>
				<div.signature> 
					"Joyfully Coded with"
					<a href="https://v2.imba.io" target="_blank"> 
						<Logo%logo>
					" by "
					<a href="https://github.com/ericvida" target="_blank"> "Eric Vida"

tag Header
	# HEADER STYLES
	css &
		display: block
		h: 150px
		w: 100%
		bg: url("./images/bg-header-desktop.svg") repeat #5ba4a4
		bgs: cover

		
	# HEADER TEMPLATE
	def render
		<self>

tag FilterBar
	# FILTER BAR STYLES
	css &
		bg: white
		display: flex
		align-items: center
		ff: $font
		c: teal8 p:2 radius: 2
		min-height: 41px
		shadow: $shadow
		border-radius: 5px
		.left
			flex-grow: 1
			display: flex
			flex-wrap: wrap
			mb:-2
		.right
			flex-grow: 0
			px:2
	css .filterPill
		$height: 22px
		p:0
		mr: 4 @last: 0
		mb: 2
		user-select: none
		radius:2 overflow: hidden
		cursor: pointer
		display: flex
		bg:teal5/12 @hover: teal5/20
		height: $height
		@hover
			.remove
				bg:teal9/100
		.name
			px:2
			fs:12px
			fw: bold
			c:teal5
			line-height:$height
		.remove
			bg: teal6/80
			color: teal1
			fs: 16px
			fw: bold
			p:0 1.5 0 1.3
	css .clear
		cursor: pointer
		color: gray6 @hover: teal6
		fs:12px
		border-bottom@hover: 2px solid teal6
		user-select: none
	# FILTER BAR METHODS
	def removeTag str
		filterArray.splice(filterArray.indexOf(str), 1)
	# FILTER BAR TEMPLATE & LOGIC

	def render
		<self>
			<.left>
				for item in filterArray
					<button.filterPill @click.removeTag(item)>
						<span.name> "{item}"
						<span.remove> "×"
			<.right>
				<span.clear @click=(do filterArray = [])> "Clear"

tag Listings
	# LISTINGS TEMPLATE
	def render
		<self>
			for listing in listings
				<Listing data=listing>
			
tag Listing
	# LISTING STYLES
	css &
		display: block 
		bg: white p:4 my:7 radius:1 shadow: $shadow
		border-left.featured: 5px solid teal7
		ff: $font
		@lt-sm
			pt:10 my:10
		@lt-sm
			position: relative
		.info
			display: flex fld: row 
			@lt-sm fld: column
		.thumbnail
			1thumbsize: 80px @lt-sm: 50px
			img
				width: 1thumbsize
			flex:0
			align-self: center
			mr:4
			@lt-sm
				position: absolute
				top: -.5thumbsize
				left: 3
		.left
			flex: 1
			header
				display: flex
			.company
				color: teal6 @hover: teal5
				font-weight:700;
				margin-right:20px;
				cursor: pointer
			.pill
				color: teal1
				bg: teal6 .featured: teal9
				mr: 3 @last: 0
				p: 8px 8px 5px
				radius: 50px
				font-size: 12px
				text-transform: uppercase
				font-weight:700
				user-select: none
			.position
				c: teal9 @hover: teal8
				cursor: pointer
				
			.details
				color: gray5
				span
					mr:2 @last: 0
			.dot
				color: gray3
		.right
			flex: 1
			display: flex
			flex-wrap: wrap
			ai: center
			justify-content: right @lt-sm: left
			&@lt-sm: 
				justify-content: left
			.tag
				p: 8px 8px 5px
				bg: teal5/12 @hover:teal6
				c:teal6 @hover: teal1
				fs: 12px
				fw: bold
				radius:1
				mr:2 @last: 0
				user-select: none
	# LISTING METHODS
	def addToFilterArray language
		if filterArray.indexOf(language) is -1 then filterArray.push(language)
	# LISTING TEMPLATE & LOGIC
	def render
		<self .featured=data.featured> 
			<.info>
				<.thumbnail>
					<img src="{data.logo}">
				<.left>
					<header> 
						<span.company> data.company
						<div.pills>
							if data["new"]
								<span.pill>	"NEW!"
							if data.featured
								<span.pill.featured> "FEATURED"
					<h3.position> data.position
					<div.details>
						if data.postedAt
							<span> data.postedAt
						if data.contract
							<span.dot> "•"
							<span> data.contract
						if data.location
							<span.dot> "•"
							<span> data.location
				<hr[border: 1px solid gray2 w:100% my:4 display@sm: none]>
				<.right>
					for lang in data.languages
						<span.tag @click.addToFilterArray(lang)> lang
					for tool in data.tools
						<span.tag @click.addToFilterArray(tool)> tool
