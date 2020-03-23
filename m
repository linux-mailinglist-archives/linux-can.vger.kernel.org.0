Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5418F1B9
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2020 10:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCWJZ2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Mar 2020 05:25:28 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:21646
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727669AbgCWJZ2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 05:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irVzQ4c38H/qYYujNbAbQyIyTvkXH4P9lfHEWCBZPIh0HHl2mBroOfzpQxFjJQy171C2xEQKC+Lr59Pa+LGRSsK5XMhlCenFp4oDIVvDZHCs3QRbmq/jfAiHVGbxIjw4GqCNcCPLYXyYcG4BW7QH+v0rLvK+G2z2MecMCERbgXbYpyrWxK9giyATC5JvMER1CpDl/Fa1WXDHUxKi4KyEFAe2vZaxTOOrmmMbUSFSVY90ruLM8kRAl+h9HPlXW4PzcL4f2N69BeBKTMqZNerzoNp4ytJUiOoPU09cFJvd57ImiFg0svPGs2Ipi+HfeY8Muz3a6ASiWzlKyiMcgwOj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0UfY1z8xsMBYvHapME2V7MjNjku64sMgYVsDnqu1a4=;
 b=k2ZXn04T9OD/gu4nx+gaHSmS2YOXIEA9CAFd3NkPOgfoOQneooC7dnYSV43kaIbC7vlJ7T8bjwEFPW1KI348CxP6TK8z9+u3BNnDXy63XI7RAfBFxGz+2Edd20ySxsIT5hg/y4/gdkzZ5MWeKg2tH+geDf0nPxSipal+vebhGk1FAOdisE85AJHAyiIidze+GBb8q8N0V6xgI54akY3FGSaplNgmnisrV2dIn5oL0XBTsM/7jFqW8pLxKfkpH1M1VYFBnX2LSu0365J9T+4Fzy8RypIMJPqyBxyodpTa1jD7AQSjqxz4KbngU/HXXCCnd8VmwAH4EkADh3+JcHH5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0UfY1z8xsMBYvHapME2V7MjNjku64sMgYVsDnqu1a4=;
 b=DuC6S13ZAyzjX4KPAoQ+JKMrHdoiZUDBmsXbMrMti774osYoPLSFUGxGqW8kgtj7VHdygL2ZA0Hi5E4NnhKLfla5w7DmRIOIOK1ARPs+UuwFLwwgEZDttPI2gYMkFP5K3PtLjYAy43JSvNMj4DnlG+CAWpeT6kXPgunyarGuIuk=
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com (10.165.163.10) by
 DB6PR03MB2888.eurprd03.prod.outlook.com (10.165.162.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 09:25:23 +0000
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1]) by DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1%6]) with mapi id 15.20.2835.017; Mon, 23 Mar 2020
 09:25:23 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: PCI/PCIe cards and MSI support
Thread-Topic: PCI/PCIe cards and MSI support
Thread-Index: AQHV/do29lzRw5ZU0EO1t7ZGglOftKhP8g+AgAXsB9aAAAMFAIAADCUw
Date:   Mon, 23 Mar 2020 09:25:23 +0000
Message-ID: <DB6PR03MB3093D18BB366D78BA9D384D1D6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <20200319140127.GD2538@x1.vandijck-laurijssen.be>
 <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>,<375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
In-Reply-To: <375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 660243e8-f847-4503-ebf9-08d7cf0c1d82
x-ms-traffictypediagnostic: DB6PR03MB2888:
x-microsoft-antispam-prvs: <DB6PR03MB2888EA4260D92369B39CEDDDD6F00@DB6PR03MB2888.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39830400003)(366004)(346002)(376002)(199004)(8676002)(26005)(316002)(81156014)(81166006)(508600001)(8936002)(966005)(55016002)(86362001)(5660300002)(9686003)(66446008)(66556008)(64756008)(4326008)(52536014)(15974865002)(186003)(66476007)(76116006)(66946007)(6506007)(53546011)(66574012)(7696005)(2906002)(33656002)(71200400001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR03MB2888;H:DB6PR03MB3093.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buteaMG3opbcVRiQsvDXfU6j4aPeU9r/DTHrSEeanV1hv5MVYuxSbGRWE7WCAhmwGNO1ciQFHwPGS8BfWNTpEYqWoi3I5rQeL37fR6fEE4VNtDcHclG8LGHJdcqY0Mzm7Vb0IuLAAb/PPL9qx+dN9fye+ph6+XQ86h9GoKaESifOoig+mJir+kFaPkHHPurzizXebwNTVg8zCCTxB2S01iESSPN9oDc/Y+jDTZL0BbGs7JZltZzIJstnMCGSxljbb9yNk87DkKeElYnrr3iLu2vacCRF1F0Pr8dYBQBw6hDKDDrsvTrLdQiV+PWZN/GZFzQma0Ls2O5Vp4KFCGOmVOcGUdveCvYshpTyY72uE5E1+Uy372hC4AnOlNbbJ97k2VZ6/sx22ysqPqeufjCzVxcY9tXb5MEKP0Lyu2/yhARzQ9hb9syFoCLis9g/uCcC/eq+PMmN/viLOxERzS3tYVRo59Nv9POE/+y0DR9/pM0YqBfkr0t/KaTt0zhttsjlkSES/gDjxxo16U99trw48Q==
x-ms-exchange-antispam-messagedata: 9wa1YTxdW6Hi/80t3guib+OMShw5zBtH2FoZst0nqRONVnV/Gl2X5N0WeVvC8R4GMDoNzQMBnmCpXgXd2nk94nJ9OhU8E6FkkBinyno/uGZLl0bG7olth30BTHUD94qHRK8xTBh6mm03/jDHmB6BvQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660243e8-f847-4503-ebf9-08d7cf0c1d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 09:25:23.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qB8fAg99X20whe/wrIGjmPpy27elp5dsfuWo02dp0nSbU3br9k2LQuqXq9paqx1XU7kvDrJfYITDAlIrbrk7hB0ZjWDddahGcZKX8jv4IM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2888
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

When switching in MSI mode, we've noticed that once CAN0 is closed
(i.e., once its own interrupt is freed), all other CANs on the same card no=
 longer receive interrupts (i.e., the handler is never called again).

This issue doesn't exist when any other CANx then CAN0 is closed.

The reason of this is not clear. What we know is that this issue doesn't
 exist under Windows for any of our (CAN 2.0 as well as CAN FD) cards. On t=
he contrary, the issue is the same for all of our CAN 2.0 / CAN FD cards un=
der Linux.

Up to now, the only workaround we have to run in MSI mode is to
request_irq() when probing the devices (starting from CAN0) *AND*
free_irq() in the opposite order (ending with CAN0)  when removing the modu=
le.

Obvioulsy, enabling/disabling hw interrupts is always done when the can int=
erface is put to up/down.

The "only" side effect is that all MSI interupt levels allocated by the
driver are requested, even if their corresponding interfaces are not UP.

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97



De : Marc Kleine-Budde <mkl@pengutronix.de>

Envoy=E9 : lundi 23 mars 2020 09:38

=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>; Kurt Van Dijck <dev=
.kurt@vandijck-laurijssen.be>

Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : Re: PCI/PCIe cards and MSI support




On 3/23/20 9:33 AM, St=E9phane Grosjean wrote:

>> This seems a bad idea. Loading the module should not allocate resources.

>> A reasonable point IMHO is the probe of a device.

>

> That's what I was thinking, sorry for the approximation and

> misunderstanding. So, you confirm that I can modify the driver to

> request_irq() when probing the CAN channels one after the other

> rather than when these are opened?



Why exactly do you need to do this?



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
