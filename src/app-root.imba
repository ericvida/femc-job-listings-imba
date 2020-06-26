import {listings} from './data.imba'
css body p:0 m:0 
css @root
	box-sizing: content-box
	$font: 'Spartan', sans-serif
	$shadow: 0px 5px 10px hsl(180, 29%, 80%)
tag app-root
	css &
		section
			bg: red4/80
		.container
			max-width: 1200px
			mx: auto
			mt: -20px
			bg: gray3
		.signature
			ff: $font
			text-align: center
			color: teal6
	def render
		<self>
			<Header>
			<section>
				<.container>
					<FilterBar>
					<Listings>
				<div.signature> "Joyfully Coded with {<a href="https://v2.imba.io"> "Imba"}, by {<a href="https://github.com/ericvida"> "Eric Vida"}"

tag Header
	css &
		display: block
		h: 150px
		w:100%
		bg: url("./images/bg-header-desktop.svg") repeat #5ba4a4
		bgr: no-repeat
		bgs: 100%
	def render
		<self>

tag FilterBar
	css &
		bg: white
		display: flex
		align-items: center
		ff: $font
		c: teal8 p: 2 radius: 2
		shadow: $shadow
		border-radius: 5px
		min-height: 60px
		.left
			flex-grow: 1
		.right
			flex-grow: 0
		span
			py:1 px:8px
			display: inline-block
			&.tag
				mr: 1 @last: 0
				display: inline-block
				user-select: none
			&.name
				bg: teal1
				radius: 2
				brl:2
			&.remove
				background-color: teal9
				color: teal1
				brr: 2
				fs: 1em
				cursor: pointer
				fw: bold
			&.clear
				cursor: pointer
				color: gray6 @hover: teal6
				bg: none @hover: gray1
				p: 8px 8px 5px
				font-size: 16px
				user-select: none
	prop tagNumber = 5
	def removeTag
		tagNumber--
	def render
		<self>
			<.left>
				for item in [0...tagNumber]
					<span.tag>
						<span.name> "tag"
						<span.remove @click.removeTag> "╳"
			<.right>
				<span.clear> "Clear"
tag Listings
	def render
		<self> 
			for listing in listings
				<Listing data=listing>

tag Listing
	# Listing
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
				bg:teal1 @hover:teal2
				c:teal6 
				fs: 12px
				fw: bold
				radius:1
				mr:2 @last: 0
				user-select: none
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
						<span.tag> lang
					for tool in data.tools
						<span.tag> tool
