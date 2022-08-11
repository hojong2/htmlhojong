/*��ʿ� ����� ��ǰ�� ��ü�� ����(��Ǫ��)*/
class Product{

	constructor(container, src, width, height, x, y){
		this.img=document.createElement("img");  //������ ���� �̹���
		this.src=src;  //�̹��� ���
		this.width=width;  //�ʺ�
		this.height=height;  //shvdl
		this.x=x;  //���� left��
		this.y=y;
		this.container=container;

		this.img.src=this.src; //img DOM�� �������
		this.img.style.width=this.width+"px";
		this.img.style.height=this.height+"px";
		this.img.style.position="absolute";
		this.img.style.left=this.x+"px";
		this.img.style.top=this.y+"px";

		//������ DOM ��ü�� ���ϴ� �θ� ��ҿ� ����
		this.container.appendChild(this.img);

		//�̹����� ������� ���콺 �̺�Ʈ ����
		this.img.addEventListener("mouseover", function(){
			//���� ���ư��� ������ ��� ����
			flag=false;
		});

		this.img.addEventListener("mouseout", function(){
			//���� ���ư��� ������ ��� ����
			flag=true;
		});

		//Ŭ���ϸ�, �ش� �̹����� ���ο� ������ �����ֱ�
		this.img.addEventListener("click", function(){
			window.open("https://www.naver.com", "_blank");
		});
	}

	//�̹��� �̵� �޼���(������ ���Ŀ��� �̹��� left���� �����ϹǷ�)
	move(){
		this.img.style.left=this.x+"px";
		if(this.x==-(this.width+5)){
			this.x=(this.width+5)*6;  //6*95
		}
	}
}