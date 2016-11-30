Work[] work=new Work[4];
boolean SJF=false;
boolean work0=false;
boolean work1=false;
boolean work2=false;
boolean work3=false;
boolean sort=false;

class Work
{
  PVector location;
  int r;
  char a;
  int rr;
  int atime;
  int endtime;
  Work(char name, int x, int y, int arrivetime, int runtime, int w)
  {
    location=new PVector(x, y);
    r=runtime;
    a=name;
    rr=w;
    atime=arrivetime;
  }

  void display1()
  {
    fill(rr, 140, 110);
    rect(location.x, location.y, 65, 65);
    textSize(20); 
    fill(0);
    text(a, location.x, location.y+20);
    textSize(30);
    text(r, location.x+24, location.y+50);
    textSize(20);
    text(atime, location.x+27, location.y+20);
  }  

  void display2()
  {
    fill(rr, 140, 110);
    rect(location.x, location.y+100, 65, 65);
    textSize(20); 
    fill(0);
    text(a, location.x, location.y+100+20);
    textSize(30);
    text(r, location.x+24, location.y+50+100);
    textSize(20);
    text(atime, location.x+27, location.y+100+20);
  }
}

//only run one time
void setup() {
  size(830, 600);
  background(255, 204, 0);


  pushStyle();
  rect(700, 520, 65, 65);
  textSize(20);    
  fill(0);
  text("sort", 715, 557); 
  popStyle();

  pushStyle();
  rect(700, 430, 65, 65);
  textSize(20);    
  fill(0);
  text("SJF", 715, 467); 
  popStyle();

  pushStyle();
  fill(50, 190, 0);
  rect(30, 250, 72, 72);
  textSize(20);    
  fill(0);
  text("CPU", 45, 287); 
  popStyle();

  work[0]=new Work('A', 100, 50, 1, 8, 0);  
  work[1]=new Work('B', 200, 50, 2, 5, 145);   
  work[2]=new Work('C', 300, 50, 3, 2, 210); 
  work[3]=new Work('D', 400, 50, 4, 10, 255);
  for (int i=0; i<4; i++) {
    work[i].display1();
  }
  sort();
  work0=true;
  sort=false;
  textSize(13);
  text("BeginTime", 500, 55); 
  text("EndTime", 580, 55); 
  text("TurnaroundTime", 650, 55); 
  text("WTime", 780, 55);
}

//run repeatedly
void draw() {
  textSize(13);
  if (sort) {
    for (int i=0; i<4; i++) {
      if (i==0) {
        work[i].endtime=work[i].atime+work[i].r;
        text(work[0].a, 480, 80);
        text(work[0].atime, 520, 80);
        text(work[0].atime+work[0].r, 600, 80);
        text(work[0].atime+work[0].r-work[0].atime, 700, 80);
        text((float)(work[0].atime+work[0].r-work[0].atime)/work[0].r, 780, 80);
      } else {
        work[i].endtime=work[i-1].endtime+work[i].r;
        text(work[i].a, 480, 80+20*i);
        text(work[i-1].endtime, 520, 80+20*i);
        text(work[i-1].endtime+work[i].r, 600, 80+20*i);
        text(work[i-1].endtime+work[i].r-work[i].atime, 700, 80+20*i);
        text((float)(work[i-1].endtime+work[i].r-work[i].atime)/work[i].r, 780, 80+20*i);
      }
    }
  }
}

void sort() {
  sort=true;
  for (int i=3; i>0; --i) {
    for (int j=0; j<i; ++j) {
      if (work[j+1].r<work[j].r) {
        int tmp1=work[j].r;
        work[j].r=work[j+1].r;
        work[j+1].r=tmp1;

        char tmp2=work[j].a;
        work[j].a=work[j+1].a;
        work[j+1].a=tmp2;

        int tmp3=work[j].rr;
        work[j].rr=work[j+1].rr;
        work[j+1].rr=tmp3;

        int tmp4=work[j].atime;
        work[j].atime=work[j+1].atime;
        work[j+1].atime=tmp4;
      }
    }
  }
}

void mouseClicked() {
  if (mouseX>700 && mouseX<765 && mouseY>520 && mouseY<585) {//sort
    sort();
    for (int i=0; i<4; i++) {
      work[i].display2();
    }
  }

  //SJF
  if (mouseX>700 && mouseX<765 && mouseY>430 && mouseY<495) {
    SJF=true;
  }
}

void keyPressed() {
  if (SJF) {
    sort=false;
    if ((key == 'A')||(key == 'a')) {

      if (work[0].r>0 && work0 && !work1 && !work2 && !work3) {
        work[0].location.x+=(30-work[0].location.x);
        work[0].location.y+=(250-work[0].location.y-100);
        work[0].display2();
        work[0].r-=1;
        work0=true;
        work1=false;
        work2=false;
        work3=false;
      } else if (work[0].r<=0 ) {
        work[0].location.x+=(400-work[0].location.x);
        work[0].location.y+=(260-work[0].location.y);
        work[0].display2();
        work0=false;
        work1=true;
        work2=false;
        work3=false;
      }

      if (work[1].r>0 && work1 && !work0 && !work2 && !work3) {
        work[1].location.x+=(30-work[1].location.x);
        work[1].location.y+=(250-work[1].location.y-100);
        work[1].display2();
        work[1].r-=1;
        work0=false;
        work1=true;
        work2=false;
        work3=false;
      } else if (work[1].r<=0) {
        work[1].location.x+=(300-work[1].location.x);
        work[1].location.y+=(260-work[1].location.y);
        work[1].display2();
        work0=false;
        work1=false;
        work2=true;
        work3=false;
      }

      if (work[2].r>0 && work2 && !work0 && !work1 && !work3) {
        work[2].location.x+=(30-work[2].location.x);
        work[2].location.y+=(250-work[2].location.y-100);
        work[2].display2();
        work[2].r-=1;
        work0=false;
        work1=false;
        work2=true;
        work3=false;
      } else if (work[2].r<=0) {
        work[2].location.x+=(200-work[2].location.x);
        work[2].location.y+=(260-work[2].location.y);
        work[2].display2();
        work0=false;
        work1=false;
        work2=false;
        work3=true;
      }

      if (work[3].r>0 && work3 && !work0 && !work1 && !work2) {
        work[3].location.x+=(30-work[3].location.x);
        work[3].location.y+=(250-work[3].location.y-100);
        work[3].display2();
        work[3].r-=1;
        work0=false;
        work1=false;
        work2=false;
        work3=true;
      } else if (work[3].r<=0) {
        work[3].location.x+=(100-work[3].location.x);
        work[3].location.y+=(260-work[3].location.y);
        work[3].display2();
        work0=false;
        work1=false;
        work2=false;
        work3=false;
        pushStyle();
        fill(50, 190, 0);
        rect(30, 250, 72, 72);
        textSize(20);    
        fill(0);
        text("CPU", 45, 287); 
        popStyle();
      }

      if (!work0 && !work1 && !work2 && !work3) {
      }
    }
  }
}