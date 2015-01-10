//import processing pdf library
import processing.pdf.*;

HDrawablePool pool;
HColorPool colors;

void setup() {
	size(1000, 1000);
	H.init(this).background(#202020);
	smooth();

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	pool = new HDrawablePool(12);
	pool.autoAddToStage()
		//PART 1 of autostage: specify what we're painting with
		.add(new HShape("svg1.svg"))
		.add(new HShape("shield.svg"))
		//.add(new HShape("svg3.svg"))
		//.add(new HShape("svg4.svg"))
		//.add(new HShape("svg5.svg"))
		//.add(new HShape("svg6.svg"))
		
		//GRID LAYOUT. Comment out for randomly placed objects
		.layout(
			new HGridLayout()
			.startX(50)
			.startY(50)
			.spacing(60, 50)
			.cols(2)

		 	)

		//PART 2 of autoAdd: augmentation of EACH individual thing that we're running
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
				HShape d = (HShape) obj;

				d
					.enableStyle(false)
					.strokeJoin(ROUND)
					.strokeCap(ROUND)
					.strokeWeight(1)
					.stroke(#FF3300)
					//DONT USE .loc when using a layout
					//.loc( (int)random(width), (int)random(height) )
					.anchorAt(H.CENTER)
					//change to adjust orientation
					.rotate( (int)random(12) * 30)
					.size( (int)random(50, 100) ) 
					
				;
				d.randomColors(colors.fillOnly());
			}
		}
		)
		//PART 3 of autoAdd: paint everything all at once
		.requestAll()
;


//call saveHiRes to draw graphic to file, 
saveVector();
//kill loop function of void draw
noLoop();

//saveFrame("renders/render.png");

}

//draws graphic to the screen
void draw() {
	H.drawStage();

}

//draws graphic to file
void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "../../renders/render.pdf");


	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); //PGraphics, uses3D, alpha
	}
	endRecord();
}