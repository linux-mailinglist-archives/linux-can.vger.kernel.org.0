Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F435C44C
	for <lists+linux-can@lfdr.de>; Mon, 12 Apr 2021 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbhDLKp3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Apr 2021 06:45:29 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:18646
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239082AbhDLKp1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 12 Apr 2021 06:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7ybXNmCVlzjE6yGbWvysrkwZ2S1NopiL6/PoOtFMcOTVnEG1lCnLkyCiftiEEuV60jOzZg+z8iSCALiEHfBnV+YzJ7CD/jrl245X15x0M8Ic9uore/6iZHfgpMnWe/jSoEIxIHFT3dCBqAvFAucARkN2g5mI6RokQ0AupLu+cYFWsyG4bpwwp+LPUnzjTOkSGODhZRU7+nK+97AEXiA2T43pOof7syPIgbshzGDORAKQVxGgIgq1lmpoVxzxy2nbd1wgSM2Aj784JC7bzlyxUqFDlHK7WfH8h+nypEGDLPTK7fNKag39NtfYdY88NNfsDKsLwWxf2QeMVcO4Aws9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buwJdYw5CzyCLadqUI3plZI7zlnYgcvAy+dW8VUFpoo=;
 b=TwbIA2p89lU/BDqyvGSWMgS0M0oxxLP9IsiU3BGGBVmPKSOX99WM7+WmBRUzsG6tbnO+nlZECNNm4nnKo5IAkQ70FtBLYtxodRLqF4Ej9ukepI2nrySk3yYtM+l8W90K1IJ90ot1zpePtGjgyqKQQcvpYarCTpEyOU4ke3dv3Y0edqofhnLNfyV6cQm3iJ9O3RIUP6Dp1NWfM4FLbfj/S6zTNgCsGoBLTEBj6VGD+kusI2+JgLK9yp2v1KW5JFGHX0ttRPXWCT6M8pJX94GUnsYjiSIkJ8A/A8tLQjRt9FTnfa4ZK+6p5mgH4/s/AYsSQDHm3e156W9uT5qrR9FKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buwJdYw5CzyCLadqUI3plZI7zlnYgcvAy+dW8VUFpoo=;
 b=0lSuVJyQ4tjXTTgHrUfV7U1/dV7gkSBbr5J7NjA/VLlQAriy0XoodcWDBA9f7cBDWV41uJ4HWGPIVTjnzWK/apztxNC+v12nGo8DSAKFa5wE0G59h6fb3zJWPc/5DIH6GVUcw6JCUHxbWWFJtB7RHy3z5WtSLdrmgOin6aVZ7zk=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PA4PR03MB7328.eurprd03.prod.outlook.com (2603:10a6:102:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 10:45:08 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::816e:66e6:d784:304]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::816e:66e6:d784:304%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 10:45:08 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [RFC]: can-next 2021-04-06: peak_usb cleanups
Thread-Topic: [RFC]: can-next 2021-04-06: peak_usb cleanups
Thread-Index: AQHXKtZJaiQVc5OWm0+h8omhfBPoD6qwkA6G
Date:   Mon, 12 Apr 2021 10:45:07 +0000
Message-ID: <PA4PR03MB6797F3132E6EF387A0C809B5D6709@PA4PR03MB6797.eurprd03.prod.outlook.com>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
In-Reply-To: <20210406111622.1874957-1-mkl@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.142.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e13ca7d5-632b-4bcc-4e45-08d8fda00a39
x-ms-traffictypediagnostic: PA4PR03MB7328:
x-microsoft-antispam-prvs: <PA4PR03MB7328376372642823422B34BCD6709@PA4PR03MB7328.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 26Dt8O3rRC2/8vkoiiUuvl94faTwmQrE5ya4Qy5YwQG6bLyRUhHLxyYImA4uX8rFCuSRT8EOy3UWQWFWpp5/xH3uH6MhuGcKpJspkN3FJo1wA3IiA+Tjq82miMuRZrT33Ab44ygHfdegfZSsPoa4tpIZ8gJa0OVeXLR34g6rCJVLIfnQjJ1ZUoGGPFMye0IiXuxeaEtj88xTpoqJmUhwnXUSp8/8uAAJUaajG3tjAtoG0r6qxoYifzie6vTb2qWwfLceIcflmRrRLihQ6aMZ3Jn4D2/yi+AjGmb6GJ3B0oc45zOPQiFBt9onHYurEbTR7m1toQzLdAEm3qSJlGzv9ahzIi1KYk3SrSpyggYoAIBr7XuSkn6Yoq++eBW6LCIx9x9YkPatJpM62oq3N9UieystwfdoPNDVYgq9Om8RMbLDs4Hq5st86tCpXnxM04sWR82elKDfIxki45cF2foGSOsXVGBiDMgI46uVbfFJsacBx4ySNkz3A76xyKPYZ+TfJGHz3GCm1ecmD7nQvt5Neh5aM+KPzOjaFPRN/ox+xCsmjGNXprZ1AtlDYaI3B/Z6AGGlxef1+E76arGeZ3B+PlVwegH6K7ntc9oR7k/cSW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39840400004)(366004)(52536014)(38100700002)(55016002)(64756008)(66556008)(76116006)(6506007)(5660300002)(66946007)(26005)(7696005)(66574015)(66446008)(54906003)(8936002)(478600001)(8676002)(9686003)(2906002)(33656002)(316002)(15974865002)(186003)(4326008)(86362001)(83380400001)(71200400001)(6916009)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?LW2fFLScgAyRNTj8zwswYuWYjc4XdmsEy8wMK8BbmHgZCmKqPDKbT2oa7B?=
 =?iso-8859-1?Q?A2w3yCtv9y+vyCvQcvokukbg0GVmdiQ5vdF0AlbjOQKhU6Niqtzp4eLFxy?=
 =?iso-8859-1?Q?RFg+FjbIAwOh01RZDF7pXea4K5lC+J7GBBkfzg5asBm2qCfdDKTZQ8X4JN?=
 =?iso-8859-1?Q?bRPzlcuWFuaxfg2tJf0l5Em3RGHdhXcr+gWGHr/rF0s6gCuLfH2JEJlgGE?=
 =?iso-8859-1?Q?orauhnYUZ0VWWI7grBV1WiJXRcVLs9ocKnmpHfMlBtcuXk0NJjqmyQ2yaL?=
 =?iso-8859-1?Q?cYHdXvUt5oS+zWrtVIfVo4w4qSkgznvgqbzaOq8BrO/Rc0i5Gi5cZcPZGP?=
 =?iso-8859-1?Q?fd4hEZK/ak6buU5OT/RZpx4NHREc2L67VXNbO3ZM8peeRK5hoAcoN013WP?=
 =?iso-8859-1?Q?O7VQxSoZUyAxShz/x8CUqoJXvULGrcMl5p+ze0VqnptKG9Syc0paJbL8tA?=
 =?iso-8859-1?Q?p/o9LMgxe6GfxKQ/6JCb0C2+yfbO9spVh5vxk64qoQlDUkFv4foBCIZGRY?=
 =?iso-8859-1?Q?hI7qtTy1K3OxNju892qelg8KFECs3pTARONRcGdfY/D5tFgAhmjBEx6UvB?=
 =?iso-8859-1?Q?j+F8uMbJ1Ms/LyQgT4FYiXMzaoQXDz19qC9+1dT262GAyKK27ehpcQEvNt?=
 =?iso-8859-1?Q?lMOWhqz3DTDnWrxagdMa7awHkLsuCa/bI+6lui+dPUWI6rSDxrlMidC78v?=
 =?iso-8859-1?Q?obLDKq5W1+n5y7ckO5MfAuUAQdM1MiSH4OtAB5w1cvY/QEG9EHwuMROJJE?=
 =?iso-8859-1?Q?0bmX6kcdue68yaY5AWiYwTsrmPBiFKjBeQH2yE6Fu88iMMWCRJZ0QncT/K?=
 =?iso-8859-1?Q?1HbR5PRZgUMPaLPPueAKK6AlYHv6lUKWLmMVGjqsuPR0g9Cb2shZ+F0qyF?=
 =?iso-8859-1?Q?Z5UgjpP2UXjQAl9VfHpZnde2ENRlnLDqLm4AQIz9DUYct5NytEgB0u8KkG?=
 =?iso-8859-1?Q?GvtWl/GKTaWFMQ1xYPk4AzM54znaYamzO/TlOnDZbksP50VGc842KcEAAt?=
 =?iso-8859-1?Q?VPQ/Qo6SU0ZTtbh9jrvvmhmx8m8/QjUX302TauyCBrD2BIx3cLExXFkllt?=
 =?iso-8859-1?Q?3oHf24NgAtdkVGXyuxQ1Vopj0WP/9VsecIX/bbGtf3kmwIO5DPJFe0VBOc?=
 =?iso-8859-1?Q?WUf7AhbUw3554BJkRhK+NW/ajJP8Pj5IDW6Y3MK7ASMHwNIeVjLCJbuQL9?=
 =?iso-8859-1?Q?fVFFxY5YyEk6His0wnSmxxlCqH8C4Wh73iSfVBgnKNujXeyF6gL+R8cVrr?=
 =?iso-8859-1?Q?/Rzva0q8VGD0STg8FzJCRn52NKTpMHv330SqHPuTn41hxHVQgRg8Wcy+0X?=
 =?iso-8859-1?Q?Eg4W8b9MPqYzC5jOShoCkPxbVoO+odzRTH4p74JB+dgwXv+CLBvzNQECFO?=
 =?iso-8859-1?Q?9bdBM5O8kz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13ca7d5-632b-4bcc-4e45-08d8fda00a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 10:45:07.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52d3CXae7hqTau4wMCkZNmnwkbID1Pwsp9ZB3SRgyj7+qkexYyb9LWwGHnNRIHgHN5x9rx/f2wJsLRp5n7g95N1kYqxHFySwnKiO7xKX+sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7328
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Thank you for your time and your work.

I've tested that serie of patches with all the CAN-FD USB interfaces from P=
EAK-System GmbH (that is, PCAN-USB FD, PCAN-USB Pro FD, PCAN-USB X6 and PCA=
N-Chip USB) as well as with the CAN 2.0 only USB interfaces PCAN-USB and PC=
AN-USB Pro, and I confirm all of them.

Do you need my Acked-by and/or Tested-by for each patch?

Regards,

--- St=E9phane


De : Marc Kleine-Budde <mkl@pengutronix.de>
Envoy=E9 : mardi 6 avril 2021 13:16
=C0 : linux-can@vger.kernel.org <linux-can@vger.kernel.org>
Cc : kernel@pengutronix.de <kernel@pengutronix.de>; St=E9phane Grosjean <s.=
grosjean@peak-system.com>
Objet : [RFC]: can-next 2021-04-06: peak_usb cleanups

Hello,

this series consist of several cleanups for the peak_usb driver. It
was tested on the peak_usb_fd, but it also does some changes on the
peak_usb, which I don't have access to.

Please test.

regards,
Marc



--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
