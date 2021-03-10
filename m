Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660CF333B3A
	for <lists+linux-can@lfdr.de>; Wed, 10 Mar 2021 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhCJLSa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Mar 2021 06:18:30 -0500
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:1668
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231880AbhCJLSS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 10 Mar 2021 06:18:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apEOWR/1Rz+rBgGUntXWQ8fW/h2Vi6nDVWHjYmTHdq0ohCvVUgnx08uxxMR6OIvC33GWG1yNHV9vHFdDasCLDYfGoDEltR95c8fkGSTU/5ofZgXrDuhkY0Q2JLaIYJcpD0fhNOO59nX467MMZ7HHRTRxSv15eJ5VybCBU4pS0gOMvYqCuBxSClglECloCocsqoKdwBU8Lg4HdMuw4UZKMvMKwa7/0dtE5NfV4JSsYw8lizTJM6IvwEFmqPXP5KE1OK/Kdpet7FsC9Wtf+ZpeyuRhUbvLm0fw667i+S4vJKydQ3/7CvylpnAIGdNS1k44Z4lmajr3b/M0Dtqa1giDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrIswzrH882kSwOV2iVzjj++0/vhi0naafI4dJe/TUE=;
 b=ne3lItvHcTlKsCZ63STdhAtT/aYrfi7A2m3pT4q9MRPvh34D8eoP1b439PuJ7Nvjo0cFhYVGLlLHAHgYjV6B6ZNlJx++JU4QxA7WjLV0qwl5YkRu2ZVK0UAHuZDNJAPIY477Us4P0Lkhed139jUDCyhq5/B2hThFr3Q0fL2FB3JaxEaUOUaonbT56QUjERYBfUAZW7GQUeRkfuBAA8B5NzNaQB0TYxQwYc36oQ1anC3cRgv8EmTnGBzRsya9AQ690UGM52K8ccmURdPTT7lrD0egNI/H5vbpSonXGiRjK1tB6lqfsgDkWv0BpEt1C/eG48C7BHPveMvacZQWD80ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrIswzrH882kSwOV2iVzjj++0/vhi0naafI4dJe/TUE=;
 b=TKM7IbpIFWS1biMzN3g3Xy3bF7tejZBgOSJ5BP5a81CY173DcpyyG7ZLUDE5ZE/vno8yzVJ+ZDbdtEUuncF8YsSkiVZv7nRrRlchdxYgS6KIpHnqCTsmMeddBaqIr6fDwF3BuyPn2debEG00yn1u8n2vKbHgVao1/oUakbV18b8=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PR3PR03MB6636.eurprd03.prod.outlook.com (2603:10a6:102:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 11:18:15 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 11:18:15 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Thread-Topic: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Thread-Index: AQHXFZ0Y/HPBGIUIOES83T3Tv9gfdg==
Date:   Wed, 10 Mar 2021 11:18:15 +0000
Message-ID: <PA4PR03MB6797F23B2236519A345A8C3DD6919@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01037a6b-d5f8-450f-536f-08d8e3b63329
x-ms-traffictypediagnostic: PR3PR03MB6636:
x-microsoft-antispam-prvs: <PR3PR03MB66365D875902705789ACE3A7D6919@PR3PR03MB6636.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2+r2T8hJ9UhYBTD4R0e6cHiRRM0vSY0eMu1BxoFoXOUleDkAxnJlsAYWPAtSvlJkTkAwiIdTR8qC9BWDeMpFKGaKZAwomGeHwnR3W+fiO283LsgXZCTDK+UI6i18JJWdeNf7gQkoWY9gMi6BKpi8cCgwykxHhbt7Yy1cc57vSIt15HR3wFeWTAzQfhZcFgOfUfWAQFnmHyItvKJw2UzuTpEhtMc23QBoeVFro4PhU/ThqY9rVItlnf9GcnGSKMu7eMHUiNoIOkOkGBUYbN7qHg1TuN/oLgI9MxunfPmx157Kug8AEKnET2wNqhjrOZjwi7EzHZgTMAEvPJP0hgicuscztstN9YOGj/s0+Oytty4fBYk37plhoWbv0zlpbBt7ZGiEkKj/DVobuPCYgW0FPJkV2Z7g1eMBbAvg9hQ6FUEIpz8z2GOt2PR3BAN0GeiK4jnjQSglwGD5xMXqXPMmdDyavwZBbZ+h88WGXlU/+bnTWlvpbt9XkF1QWGlq7hSDRYckitG1+vxq7mFnzgPEA1kSdFhdz2OWrXIt5aIcZWPiXGJ9WuhsSshe2zt8WxqGsegr1frleFzvENkwwQynnia29365LLard+80V3dQQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(366004)(376002)(136003)(396003)(7696005)(33656002)(71200400001)(53546011)(8676002)(64756008)(478600001)(316002)(52536014)(66556008)(186003)(4326008)(15974865002)(66476007)(76116006)(66446008)(5660300002)(9686003)(6506007)(966005)(26005)(110136005)(8936002)(86362001)(2906002)(55016002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?P9jazpQ9Nkybcma9VxN8fqUZrhR+7DOWifoq58+acDdyt+lj/qPFznsKLh?=
 =?iso-8859-1?Q?7r51QsKs86Ja81UjmsyTLrYklcKlP3BoaEII6fdje/aJ7bEnhE6jpAC56j?=
 =?iso-8859-1?Q?dxtNLbM0UOqvkJ24i55I7ycPXtB+Abyee2rbv3QriqtNlpc4FOPDUwZu+o?=
 =?iso-8859-1?Q?JpXq88AVAl+zbeeRSmBVFDbAtTSPcYhTn3BCUnKq6siJdz8z/8wkcqLyTf?=
 =?iso-8859-1?Q?2MBMdLEhZDfBBzs8WWeeGZ/3/WoQvTWAHSQFQC94ucCgZSxgIONDTXxNBR?=
 =?iso-8859-1?Q?nUu6Sa2SH5SPcWfvFDfG0gz/ul7PHKRZuk7StYt6JMzeC07ur3QvW1bkVH?=
 =?iso-8859-1?Q?3qJ+7P/NRAdOeoU+2q+YKQFr9YtQ315Mfny3uwNNBflWiM7vyTHM5fIY2e?=
 =?iso-8859-1?Q?YA3dT/e/wdNntfoo2wR1w9LeT16ee+krRvR6SHgEvLtti93x3c7vSz2CjW?=
 =?iso-8859-1?Q?x2LoUD3fXgs+RuMXZlatEpEyO8jwVmqRAlNQYBPWHTaipUpyPS1EFj00xT?=
 =?iso-8859-1?Q?jHlvRt08csjlkozzsQAfSUHD5P6yWYah5v99woLbAQgDKmSXGM1mYbKeHC?=
 =?iso-8859-1?Q?Bo1PaJ6KSOzOIQfRE6BVeLhuDXF2xQCyqdM81H+NQN6YX3Iey6YbcBNoeP?=
 =?iso-8859-1?Q?fa6WR3TpTZj8GTzxZTg7oXomw55Mxuqph4A+LOnRJn+Gk3qNGzGrZCpHe8?=
 =?iso-8859-1?Q?S7AAV15Df41PUnv2yet5onmvpSdvBQy1Q+juDtyjMT0anCVvb9/Ru5ye9d?=
 =?iso-8859-1?Q?U6M9i1YtSWzostdZmQ+wTvBbKIecTWjwsFfTtd2t4SLXc7B6fepIDJakMM?=
 =?iso-8859-1?Q?cgdazd0kl9PrOzWDoNp1eaKywvYMysjZEJM50i7Guok3ZH/QOgoRYnjcHy?=
 =?iso-8859-1?Q?kVEQwhb1+pfL3CvKb3aqL8qMJVaiQv9eQVfCLqBSqJ8NWE8KUEIuvXbXry?=
 =?iso-8859-1?Q?1DRtsACyDujuacmZoR1dflcIqNeEHNEOKpmAPBtRNIAXzNpfIh/cQnC6D4?=
 =?iso-8859-1?Q?wOBP5NpjzNGmYYJBdxkwakNe+NVbb3RyF8CXmtjZckjPCO3nFHAlYJODT5?=
 =?iso-8859-1?Q?KbQLTpyPQ05MpGztPWhZFw5Latz0kY6n32xQabQnSYSSUKcDTTjvJ8jugw?=
 =?iso-8859-1?Q?w320FM74P2tO9lOGAVUYvKiY7QxFGab0S4jTGcjMIAnP8sIpA68uYqqa2u?=
 =?iso-8859-1?Q?ALT+D/dByds/StskUQy6uHOAG2K/pZKnrfE05QgdxpisMVz5HGP5pFl3ze?=
 =?iso-8859-1?Q?RyB0WhrjgdfDsz2NfNIOlkzLYBip9hUMUa9rgc07mVuVKkA0PN8SpN93+Q?=
 =?iso-8859-1?Q?z4oOnbCEKPDiVju+aOm2jXuV8+QUPHKr6d59Gydn0htLChFyEsMN3PJ0Eo?=
 =?iso-8859-1?Q?Aw2A6tPWhA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01037a6b-d5f8-450f-536f-08d8e3b63329
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 11:18:15.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/EU9h01LH0YcfJmBHRcrtOhG7yO5NUo9JQSVe3OgW6Aj5ijosSEhN/r+xMb9hdCwnlXgCG/Alnn2yrb39bc8NaoazmcEMKwJKM8imVY3vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6636
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

To complete the open reflection on this subject: to be perfect, the echo sk=
b should in fact not be released by the USB write completion routine but, l=
ike the PCI/PCIe version, on reception in the Rx queue of an echo frame to =
the one written...

This means :
1 - the core of the peak_usb driver has to be deeply modified
2 - the rx path of the USB interface will be much more loaded, resulting in=
 a higher CPU load
2 - in the case of a one-shot frame, how to manage the fact that this echo =
frame is never received because the one-shot frame could not be written on =
the bus? Does this need a garbage collector on the echo skbs?

Is it worth it?

Regards,

--- St=E9phane


            From: Marc Kleine-Budde
Sent: Tuesday, March 9, 2021 15:58
To: St=E9phane Grosjean
Cc: Oliver Hartkopp; linux-can Mailing List
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode




On 09.03.2021 14:53:36, St=E9phane Grosjean wrote:

> In the usb drivers, the echo skb is always released by the USB write

> complete callback.



This means there will be an echo_skb_get() when the USB write completes,

which is usually before the CAN controller sends the CAN frame.



This means a TX complete or an TX abort due to one shot mode will not be

reported?



regards,

Marc



--

Pengutronix e.K.                 | Marc Kleine-Budde           |

Embedded Linux                   | https://www.pengutronix.de  |

Vertretung West/Dortmund         | Phone: +49-231-2826-924     |

Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
