# COVIDector
An iOS/iPadOS app which detects whether a person is COVID-19 Positive/Negative, based on the image of the lungs X-ray.<br> It uses CoreML format for the NN model. <br>The dataset consists of around 15,000 X-ray images.

Originally, I was goint to convert a Tensorflow model into the CoreML format using <a href="https://coremltools.readme.io/docs">CoreML Tools</a>, but due to some version compatibility discrepancies, I created a separate Tensorflow Lite model (Which can be found <a href="https://arxiv.org/pdf/2003.09871.pdf">here</a>) to be deployed into other platforms and used the CreateML application to directly create the CoreML model.

<h3>Note: This is far from production ready.</h3>
<h3>This was part of my Final Year Project for my undergraduate course.</h3>

<br> Inspired by <a href="https://arxiv.org/pdf/2003.09871.pdf">this paper</a>.
