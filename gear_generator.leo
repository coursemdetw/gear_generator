<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<?xml-stylesheet ekr_test ?>
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="amd.20151117214656.1"><vh>@settings</vh>
<v t="amd.20151117214656.2"><vh>@data qt-gui-plugin-style-sheet</vh></v>
<v t="amd.20151117214656.3"><vh>@string initial_split_orientation = horizontal</vh></v>
</v>
<v t="amd.20151117222229.1" a="E"><vh>專案開發</vh>
<v t="amd.20151117225618.1"><vh>參考資料</vh></v>
</v>
<v t="amd.20151117214643.2"><vh>@edit index.html</vh></v>
<v t="root.20151117220211.1"><vh>@edit README.md</vh></v>
<v t="root.20151117221230.1" a="E"><vh>@path js</vh>
<v t="root.20151117221236.1"><vh>@edit gear_generator.js</vh></v>
<v t="amd.20151117224124.1"><vh>@edit gear_generator.py</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="amd.20151117214656.1"></t>
<t tx="amd.20151117214656.2">QSplitter::handle {
    background-color: #CAE1FF; /* lightSteelBlue1 */
}

QStackedWidget {
    /* background-color:lightpink; */
    border-color: red;
    padding: 0px;
    /* border-width: 0px; */
    /* background-color: yellow; */
}

QSplitter {
    border-color: white;
    background-color: white;
    border-style: solid;
}

QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    /*font-family: DejaVu Sans Mono;*/
    font-family:YaHei Mono;
    /* 標題字型大小設定 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    /*font-family: DejaVu Sans Mono;*/    
    font-family:YaHei Mono;
    /* 沒有特別對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: red;
    selection-background-color: blue;
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* log font 大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: red;
    /*font-family: DejaVu Sans Mono;*/
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* 內文字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family:YaHei Mono;
    /* 下方的 Minibuffer 標題字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family:YaHei Mono;
    /* 沒有直接對應字型大小 */
    font-size: 20px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}</t>
<t tx="amd.20151117214656.3">horizontal: body pane to the left
vertical: body pane on the botton</t>
<t tx="amd.20151117222229.1">準備改寫為 Brython based</t>
<t tx="amd.20151117225618.1">&lt;!DOCTYPE html&gt;
&lt;html&gt;
	&lt;head&gt;
		&lt;meta http-equiv="content-type" content="text/html;charset=utf-8"&gt;
		&lt;title&gt;Spur Gear creator&lt;/title&gt;
		&lt;script src="http://code.jquery.com/jquery-latest.min.js"&gt;&lt;/script&gt;
		&lt;script&gt;
			function getN() { 
				var N = Number( $("#N").val() );
				if( N&lt;3 ) {
					N = 3;
					setN( N );
				}
				return N;
			}			
			function setN( v ) { $("#N").val( v ); }			
			function getD() { return Number( $("#D").val() ); }			
			function setD( v ) { $("#D").val( v ); }			
			function getP() { return Number( $("#P").val() ); }			
			function setP( v ) { $("#P").val( v ); }			
			function getscale() { return Number( $("#scale").val() ); }			
			function setscale( v ) { $("#scale").val( v ); }			
			
			// --------------------------------------------------------------------------------------------------
			var shift,
				guides = true;

			
			function Nadd( a ) {
				var N = getN()+a;
				setN( N );
				Nchange();
				generateSVG();
			}

			function Nchange() {
				if( shift ) {
					shift = false;
					var P = getN()/getD();
					setP( P );
				} else {
					var D = getN()/getP();
					setD( D );
				}
			}
			function Dchange() {
				if( shift ) {
					shift = false;
					var P = getN()/getD();
					setP( P );
				} else {
					var N = getD()*getP();
					N = Math.floor( N );
					setN( N );
					Nchange();
				}
			}
			function Pchange() {
				var N = getD()*getP();
				setN( N );
			}

			function calcP() {
				var P = getN()/getD();
				setP( P );
			}


			// --------------------------------------------------------------------------------------------------

			function generateSVG() {
				var w = 400,
					h = 400,
					sc = getscale(),
					N = getN(),
					D = getD(),
					P = getP(),
					A = 1/P,
					B = 1.157/P,
					OD = (N + 2)/P,
					RD = (N - 2)/P,
					BC = D*Math.cos(20*(Math.PI/180)),	//14.5
					CP = Math.PI/P,
					rmin = RD/2,
					rmax = OD/2,
					rbase = BC/2,
					pts = [],
					ac = 0,
					
					addpts = function( p ) {
						pts.push( p );	
					},
					pt = function( r, a ) {
						return { r: r, a: a };
					},
			
				out = '&lt;svg version="1.2" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="'+w+'px" height="'+h+'px" viewBox="'+(-w/2)+' '+(-h/2)+' '+w+' '+h+'" overflow="scroll" xml:space="preserve"&gt;';
				
				if( guides ) {
					out += '&lt;g opacity="0.2"&gt;';
					// pitch circle
					out += '&lt;circle fill="none" stroke="#f00" stroke-miterlimit="10" stroke-dasharray="4,4" cx="0" cy="0" r="'+(D/2)*sc+'"/&gt;';
					// Root circle
					out += '&lt;circle fill="none" stroke="#ccc" stroke-miterlimit="10" stroke-dasharray="4,4" cx="0" cy="0" r="'+(RD/2)*sc+'"/&gt;';
					// Outer circle
					out += '&lt;circle fill="none" stroke="#ccc" stroke-miterlimit="10" stroke-dasharray="4,4" cx="0" cy="0" r="'+(OD/2)*sc+'"/&gt;';
					// Base circle
					out += '&lt;circle fill="none" stroke="#00f" stroke-miterlimit="10" stroke-dasharray="4,4" cx="0" cy="0" r="'+(BC/2)*sc+'"/&gt;';
					
					out += '&lt;/g&gt;';
				}

				// calc
				addpts( pt( rmin, 0 ) );					//first point
				for( var i=1, pn=0; i&lt;200; i+=2 ) {
					// get a point...
					var bpl = polarToLinear( pt( rbase, -i ) ),			//base point linear
						len = ((rbase*Math.PI*2)/360)*i,				//length
						opl = polarToLinear( pt( len, -i+90 ) ),		//add line
						np = linearToPolar( { x: bpl.x+opl.x, y: bpl.y+opl.y } );
						
					if( np.r&gt;= rmin ) {
						pn++;
						if( np.r&lt;D/2 ) ac = np.a;
						if( np.r&gt; rmax ) {
							np.r = rmax;
							addpts( np );
							break;	
						}
						addpts( np );
					}
				} 
				// tukrozes
				var fa = 360/N,	// final a
					ma = fa/2 + 2*ac;	// mirror a		
									
				for( var i=pn; i&gt;=0; i-- ) {
					var bp = pts[i],
						na = ma-bp.a;					
					addpts( pt( bp.r, na ) );
				}

				// repeat
				for( var i=1, m=pts.length; i&lt;N; i++ ) {
					for( var p=0; p&lt;m; p++ ) {
						var bp = pts[p],
							na = bp.a+fa*i;
						addpts( pt( bp.r, na ) );
					}
				}
				
				// print points
				out += '&lt;polygon fill="#fff" stroke="#444" stroke-width="0.5" stroke-miterlimit="10" points="';
				for( var i=0; i&lt;pts.length; i++ ) {
					var point = polarToLinear( pts[i] );
					out += (point.x*sc)+','+(point.y*sc)+' ';
				}
				out += '"/&gt;';
				
				out += '&lt;/svg&gt;';
				
				$("#svg").html( out );
				$("#out").html( out );
			}
			
			function linearToPolar( c ) {
				var x = c.x, y = c.y, r, a;
				var AM = 180/Math.PI;
				r = Math.sqrt( x*x + y*y );
				a = Math.asin( y/r )*AM;
				if( x&lt;0 ) a = 180-a;
				a = (a+360)%360;
				return { r: r, a: a }
			}
			function polarToLinear( p ) {
				var r = p.r, a = p.a, x, y;
				var AM = 180/Math.PI;
				a = ((a+360)%360)/AM;
				
				x = Math.cos( a )*r;
				y = -Math.sin( a )*r;
				
				return { x: x, y: y }
			}

			// --------------------------------------------------------------------------------------------------

			function reset() {
				$("#N").bind("enterKey",Nchange);
				$("#D").bind("enterKey",Dchange);
				$("#P").bind("enterKey",Pchange);
				$("input").keyup("keyup",function(e){
					//console.log("key: "+e.keyCode+" shift: "+e.shiftKey );
					shift = e.shiftKey;
					if(e.keyCode == 13) {
						$(this).trigger("enterKey");
						generateSVG();
					}
				});
				generateSVG();
			}
		&lt;/script&gt;
		&lt;style&gt;
			label {
				display: inline-block;
				width: 200px;
			}
			.ratio {
				width: 30px;
			}
			#svg {
				position: absolute;
				top: 18px;
				left: 432px;
				/*background: #f8f8f8;*/
			}
			textarea {
				margin-top: 16px;
				width: 322px;
				height: 104px;
			}
		&lt;/style&gt;
	&lt;/head&gt;
	&lt;body&gt;
		&lt;p&gt;
			&lt;label for="N"&gt;Number of gear teeth:&lt;/label&gt;
			&lt;input type="text" id="N" value="18"&gt;* &lt;button onclick="Nadd(1)"&gt;+&lt;/button&gt;&lt;button onclick="Nadd(-1)"&gt;-&lt;/button&gt;&lt;br&gt;

			&lt;label for="D"&gt;Pitch diameter:&lt;/label&gt;
			&lt;input type="text" id="D" value="3"&gt;*&lt;br&gt;
			
			&lt;label for="P"&gt;Diametral pitch:&lt;/label&gt;
			&lt;input type="text" id="P"&gt;&lt;br&gt;
			
			&lt;label for="scale"&gt;Pixel per Unit:&lt;/label&gt;
			&lt;input type="text" id="scale" value="100"&gt;&lt;br&gt;

			&lt;textarea id="out"&gt;&lt;/textarea&gt;
		&lt;/p&gt;
		&lt;p&gt;
			* Shift + Enter: modifies the Diametral pitch 
		&lt;/p&gt;
		&lt;div id="svg"&gt;
		&lt;/div&gt;
	&lt;/body&gt;
	&lt;script&gt;
		calcP();
		reset();
		
		
		//console.log("-----");
		//console.log(linearToPolar( {x:100, y:-100 } ) );
		//console.log(polarToLinear( linearToPolar( {x:100, y:-100 } ) ) );
	&lt;/script&gt;
&lt;/html&gt;</t>
<t tx="root.20151117221230.1"></t>
</tnodes>
</leo_file>
