# COVIDector
An iOS/iPadOS app which detects whether a person is COVID-19 Positive/Negative, based on the image of the lungs X-ray.<br> It uses CoreML format for the NN model. <br>The dataset consists of around 15,000 X-ray images.

Originally, I was goint to convert a Tensorflow model into the CoreML format using <a href="https://coremltools.readme.io/docs">CoreML Tools</a>, but due to some version compatibility discrepancies, I created a separate Tensorflow Lite model (Which can be found <a href="https://github.com/kapilb7/Create_COVIDector_Model">here</a>) to be deployed into other platforms and used the CreateML application to directly create the CoreML model.

Check out <a href="https://github.com/kapilb7/Create_COVIDector_Model">this repo</a>, if you just want the pretrained CoreML/TensorFlow models or want to create the models from scratch.

<h3>Note: This is far from production ready.</h3>
<h3>This was part of my Final Year Project for my undergraduate course.</h3>
<h3>The Research paper for my Final Year Project can be found <a href="https://drive.google.com/file/d/1fYgd4OUgnGzP6vrADuQwnIgpCU3D0-of/view?usp=sharing">here.</a>



<br> Inspired by <a href="https://arxiv.org/pdf/2003.09871.pdf">this paper</a>.

![IMG_2963](https://user-images.githubusercontent.com/21005627/118356352-866bda80-b592-11eb-951e-08588f025bb9.PNG) ![IMG_2959](https://user-images.githubusercontent.com/21005627/118356358-8bc92500-b592-11eb-9329-1ad7af73111f.PNG) ![IMG_2960](https://user-images.githubusercontent.com/21005627/118356363-92f03300-b592-11eb-97b0-ea33d031dc61.PNG)![IMG_5768B4E12D81-1](https://user-images.githubusercontent.com/21005627/118356399-b6b37900-b592-11eb-81bb-a752eca7cc0e.jpeg) ![IMG_2961](https://user-images.githubusercontent.com/21005627/118356407-c0d57780-b592-11eb-9ce1-9ca6df3eff8c.PNG) ![IMG_2962](https://user-images.githubusercontent.com/21005627/118356414-c6cb5880-b592-11eb-951a-d1ed2e963849.PNG)





