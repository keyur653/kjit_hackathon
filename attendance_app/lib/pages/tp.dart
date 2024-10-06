import 'package:flutter/material.dart';
// TODO: add flutter_svg package to pubspec.yaml
import 'package:flutter_svg/flutter_svg.dart';

class UploadFileScreen extends StatelessWidget {
  const UploadFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    uploadFileIllistration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "File Upload!",
                description:
                    "Select a file from your device to upload. Make sure it complies with the upload guidelines.",
                // button: you can pass your custom button,
                btnText: "Select File",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

const uploadFileIllistration =
    '''<svg width="882" height="871" viewBox="0 0 882 871" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M871.21 496C874.072 496 876.816 497.137 878.84 499.16C880.863 501.184 882 503.928 882 506.79V858.21C882 861.072 880.863 863.816 878.84 865.84C876.816 867.863 874.072 869 871.21 869H519.79C516.928 869 514.184 867.863 512.16 865.84C510.137 863.816 509 861.072 509 858.21C509 762.146 547.161 670.016 615.089 602.089C683.016 534.161 775.146 496 871.21 496Z" fill="#BCBCBC"/>
<path d="M251.59 611.73V385.08C251.595 383.209 252.341 381.417 253.664 380.094C254.986 378.771 256.779 378.025 258.65 378.02H306.27" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M512.89 690.62V730.27C512.885 732.141 512.139 733.934 510.816 735.256C509.493 736.579 507.701 737.325 505.83 737.33H413.57" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M514.57 335.26L581.01 401.69H514.57V335.26Z" fill="#BCBCBC"/>
<path d="M306.26 646V333.06C306.262 332.602 306.445 332.164 306.769 331.84C307.093 331.516 307.532 331.333 307.99 331.33H501.13" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M567.57 397.76V688.45C567.57 689.026 567.341 689.577 566.934 689.984C566.527 690.391 565.975 690.62 565.4 690.62H385.4" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M501.13 331.33L567.57 397.76H501.13V331.33Z" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M444.43 589.95C474.844 589.95 499.5 565.294 499.5 534.88C499.5 504.466 474.844 479.81 444.43 479.81C414.016 479.81 389.36 504.466 389.36 534.88C389.36 565.294 414.016 589.95 444.43 589.95Z" fill="#BCBCBC"/>
<path d="M437.34 576.64C467.754 576.64 492.41 551.984 492.41 521.57C492.41 491.156 467.754 466.5 437.34 466.5C406.926 466.5 382.27 491.156 382.27 521.57C382.27 551.984 406.926 576.64 437.34 576.64Z" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M437.35 549.1V506.95" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M330.09 354.17H379.72" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M330.45 373.38H434.8" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M330.45 393.67H418.13" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M330.45 417.58H478.28" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M547.85 669.77H456.54" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M547.85 648.75H430.45" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M547.85 627.74H489.15" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M121.19 713.41C121.185 690.09 128.956 667.434 143.273 649.026C157.59 630.618 177.635 617.508 200.239 611.772C222.842 606.035 246.713 607.998 268.076 617.35C289.438 626.702 307.073 642.91 318.19 663.41" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M116.24 869.4C93.0338 869.4 70.7778 860.181 54.3684 843.772C37.959 827.362 28.7402 805.106 28.7402 781.9C28.7402 758.693 37.959 736.437 54.3684 720.028C70.7778 703.619 93.0338 694.4 116.24 694.4C118.467 694.4 120.674 694.483 122.86 694.65" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M413.57 737.32C406.538 713.617 391.207 693.237 370.382 679.91C349.557 666.582 324.63 661.198 300.161 664.741C275.692 668.285 253.316 680.519 237.127 699.207C220.939 717.894 212.019 741.786 212 766.51" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M314.88 869.4C330.882 869.383 346.66 865.638 360.963 858.461C375.265 851.285 387.699 840.875 397.278 828.056C406.857 815.238 413.317 800.364 416.147 784.614C418.977 768.864 418.098 752.671 413.58 737.32" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M319.83 869.4H116.24" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M172.72 364.89C156.353 364.89 140.355 360.037 126.746 350.944C113.138 341.851 102.532 328.928 96.2687 313.807C90.0056 298.686 88.3669 282.048 91.5598 265.996C94.7527 249.944 102.634 235.2 114.207 223.627C125.779 212.054 140.524 204.173 156.576 200.98C172.628 197.787 189.266 199.426 204.387 205.689C219.507 211.952 232.431 222.558 241.524 236.167C250.617 249.775 255.47 265.774 255.47 282.14" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M445.36 189.89C437.587 162.551 420.701 138.691 397.504 122.268C374.306 105.844 346.192 97.8448 317.823 99.596C289.455 101.347 262.537 112.744 241.536 131.895C220.535 151.047 206.712 176.803 202.36 204.89" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M411 220.85C422.025 204.271 438.092 191.679 456.826 184.936C475.56 178.194 495.967 177.658 515.029 183.408C534.091 189.158 550.797 200.889 562.677 216.866C574.557 232.844 580.982 252.22 581 272.13C581 310.23 559.18 341.81 526.33 356.13" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M172.72 364.89H306.26" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M654.35 630.91C645.387 630.909 636.568 628.652 628.707 624.346C620.846 620.039 614.196 613.823 609.37 606.269C604.544 598.716 601.698 590.069 601.094 581.126C600.49 572.183 602.148 563.232 605.914 555.099C609.681 546.965 615.435 539.911 622.646 534.587C629.856 529.263 638.292 525.84 647.174 524.635C656.056 523.429 665.098 524.48 673.467 527.69C681.836 530.899 689.262 536.164 695.06 543" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M793.14 545.5C793.135 529.892 787.561 514.799 777.422 502.933C767.282 491.067 753.242 483.208 737.826 480.769C722.411 478.329 706.63 481.47 693.323 489.625C680.015 497.781 670.054 510.417 665.23 525.26" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M771.16 560.39C775.824 554.959 781.779 550.788 788.477 548.26C795.174 545.733 802.4 544.929 809.489 545.925C816.578 546.92 823.304 549.681 829.047 553.955C834.789 558.229 839.366 563.878 842.354 570.383C845.343 576.888 846.648 584.04 846.15 591.182C845.652 598.323 843.366 605.225 839.503 611.252C835.64 617.279 830.324 622.238 824.043 625.673C817.763 629.108 810.719 630.909 803.56 630.91" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M654.1 630.91H809.03" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M583.5 145C603.106 145 619 129.106 619 109.5C619 89.8939 603.106 74 583.5 74C563.894 74 548 89.8939 548 109.5C548 129.106 563.894 145 583.5 145Z" fill="#BCBCBC"/>
<path d="M666 163C674.284 163 681 156.284 681 148C681 139.716 674.284 133 666 133C657.716 133 651 139.716 651 148C651 156.284 657.716 163 666 163Z" fill="#BCBCBC"/>
<path d="M611 195C615.418 195 619 191.418 619 187C619 182.582 615.418 179 611 179C606.582 179 603 182.582 603 187C603 191.418 606.582 195 611 195Z" fill="#BCBCBC"/>
<path d="M29.5 525C45.7924 525 59 511.792 59 495.5C59 479.208 45.7924 466 29.5 466C13.2076 466 0 479.208 0 495.5C0 511.792 13.2076 525 29.5 525Z" fill="#BCBCBC"/>
<path d="M99.5 541C104.747 541 109 536.747 109 531.5C109 526.253 104.747 522 99.5 522C94.2533 522 90 526.253 90 531.5C90 536.747 94.2533 541 99.5 541Z" fill="#BCBCBC"/>
<path d="M58 572C64.0751 572 69 567.075 69 561C69 554.925 64.0751 550 58 550C51.9249 550 47 554.925 47 561C47 567.075 51.9249 572 58 572Z" fill="#BCBCBC"/>
<path d="M568 35V2" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M553.5 38.5L535.5 22.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M583.5 39.5L597.5 25.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M46.5 589.5L37.5 608.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M69.5 589.5L75.5 608.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M36.5 576.5H17.5" stroke="#0E0E0E" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M424 517L437 499L450.5 517" stroke="#0E0E0E" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';
