Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564211908D5
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2020 10:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCXJQO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Mar 2020 05:16:14 -0400
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:6723
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbgCXJQN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfUX6RxnR+ob4V0I4n1qnLMhwthyxNjejLyKkDoCtLV+bYb4uQKwYYr9roz0l9wMqGfSl6ia/cSANPmYH2kkEFFPR7dqNWBeeXC9a9X7FmwlnlJu08z9cDyLL6vJLumGCZHqneMMAeHtY5ilhv6VaeFSLkuNqQM4BpJa6FA8MD8Zl6XtTrDhQxjsZUBdfsEQ1BW9VOVsOajGWWyeeRV9egx7eAyf2bhd0+StkLKTIoOWY18MRPa1+aQtifCTGHMfcR1tEneFpJxHDwEBfELcldGXN2vWunUHcc/OX9uNx9/oBw6150t0eI+hrvZEESfR/H5QpMligLAJU6fCclFqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI6TVy7J025PzR5zPtVZ/Ua4VZ1oSb12uvyf4Gh+8xo=;
 b=JG8LzNc9YU6f8srLH5ha0IbECEctZ+lCIlVkzlBYFk+MCDF3oAIUa0HJ4SO8ZQHetVe+UPulDpAX2sW45+DwMwZnURRTA01/UDpFW9OgRg96AqI4VEC3LhN0bVvcEnXVDSbbNPA+UtNEUraU5Uk/wjCRM9c9Bbn4WIXDOJSVyEB0BtkgIol1IdGjL13i+mIp3dZ8miaEpGNYmGqrs4hE3UvWYFLEWrrlkdRBdc/w4pND1Df4ry+SL634z2sjt4ep4xjF1rOjTPB4D39bMAzfe4Dpb0tmJjl58mv15VoZ6oAw7qicgyOaTjWu6H2xVxlkLTaVvKQeAjVKVPP1rOpRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI6TVy7J025PzR5zPtVZ/Ua4VZ1oSb12uvyf4Gh+8xo=;
 b=7Rq9qy48+PgpJGdvukq1urwsZ9OVQ7DyMLMA/qTLFO0XQ/PY5FSioH6yKGJR3eBXUpVGDVgkJC9Ih5zRiON2uZwY1lf/crEdt2rTdMteTifXAilcw1WM26OBup70sguNrKzw8ykqbOipYowqNmjwPbxBpXrWPzP6WL3pLlflaHs=
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com (10.165.163.10) by
 DB6PR03MB2872.eurprd03.prod.outlook.com (10.165.162.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Tue, 24 Mar 2020 09:15:29 +0000
Received: from DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1]) by DB6PR03MB3093.eurprd03.prod.outlook.com
 ([fe80::9c30:9ea5:1f62:3eb1%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 09:15:29 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: PCI/PCIe cards and MSI support
Thread-Topic: PCI/PCIe cards and MSI support
Thread-Index: AQHV/do29lzRw5ZU0EO1t7ZGglOftKhP8g+AgAXsB9aAAAMFAIAADCUwgAAD9oCAAX9LIw==
Date:   Tue, 24 Mar 2020 09:15:29 +0000
Message-ID: <DB6PR03MB30934B5DE1A1B43E7E684937D6F10@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <20200319140127.GD2538@x1.vandijck-laurijssen.be>
 <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
 <DB6PR03MB3093D18BB366D78BA9D384D1D6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>,<45fe5f0a-9b74-a673-40e9-c3e361c625d5@pengutronix.de>
In-Reply-To: <45fe5f0a-9b74-a673-40e9-c3e361c625d5@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=s.grosjean@peak-system.com; 
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0df6d1dc-35d7-46bc-0ba3-08d7cfd3e5bc
x-ms-traffictypediagnostic: DB6PR03MB2872:
x-microsoft-antispam-prvs: <DB6PR03MB287263EE28B607F546A61783D6F10@DB6PR03MB2872.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(136003)(376002)(346002)(366004)(55016002)(5660300002)(76116006)(86362001)(66946007)(508600001)(52536014)(2906002)(33656002)(64756008)(66446008)(66476007)(66556008)(9686003)(81156014)(8936002)(966005)(15974865002)(8676002)(81166006)(316002)(26005)(4326008)(186003)(7696005)(66574012)(110136005)(71200400001)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR03MB2872;H:DB6PR03MB3093.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: peak-system.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBrflOSsk1mnBPKZOhpF/XqRi93noAiGdOVswn4zUAnStN75Ffke34/hw5rimfl6igNmC6tuPuwDFVnzDJJ9Paq4Xhv/KLyQ//IFKk9Phgd9M4i/JOKo8yaRGGlSc333H8gfSoxN5DRNqOTxoucKvqcZFxmmzDqoxlAEC+ofW3PlwfHdddUchj6Gj/E1NC7IZd64RO6rHqrnQcafuVZ8CX0ZB1nxWnUeL5tIcOJotTZTpB+fSjwT0keq8VsfJEfCm01oFEk3Qq4VrZFpxVNxY50PdFYvUQXPCl7wvhOS2v5bAkNClJQ2eO5W4++okegwjFzpiNj1MwPfDVJSkbB2Z5kK1Y+EQc77zvoEH62lVNQx2pWB2LN9Nc6SXygn05HrrsYs9+y40eoUlGUvsbia7bGPfyhnFNwh/x4/Zk//IoWtzXbOr8ke/At86opEnzx+3rr0Dwf8ru9ZcSCbPPbRmeWvSFN3T9aJOkNd0D//4eBjRD2pxpwpalhNvAmjNohkoMyI8bvxMWAB7Wt5maxAlw==
x-ms-exchange-antispam-messagedata: hMUf7FNT3vAkvIlOFbILlixQfc80j0LgEDOY4LQByN4UkTaHw6K0PlCH+IZ6FoAsBne5qfWxy3MYvdNnKyZfFRVcfaSKShwTKuSBn4DqdNgnM36pwFh+dLwXmAJU2qOcbHgT7ntPpJjTZoQ2NPkitQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df6d1dc-35d7-46bc-0ba3-08d7cfd3e5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 09:15:29.4400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okti6wj/72NWFKdtAKSrR/3gS1bn3c71jlBxQDGJonfQf7mhCjUkhHkMt5adB9PUF3MtErTAmo4rv6gLGAsox72xXonOj905tXAGjJdiLzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2872
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

>> When switching in MSI mode, we've noticed that once CAN0 is closed (i.e.=
, once its own interrupt is freed), all other CANs on the same card no long=
er receive interrupts (i.e., the handler is never called
again).

> Is it the free_irq() or the other code called on ifdown? Comment out the =
free_irq() and check what happens.

This issue does exist for peak_pci (SJA1000 PC/PCIe driver) as well as for =
peak_pciefd (CAN FD PC interfaces driver) when MSI mode is requested.

At the moment, free_irq() is called on ifdown in both drivers. That's the c=
ore of the issue. When commented out, the interrupt handler is always calle=
d for the other CANs. But, obvioulsy, ifup(CAN0) now says "RTNETLINK answer=
s: Device or resource busy".

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97











De : Marc Kleine-Budde <mkl@pengutronix.de>

Envoy=E9 : lundi 23 mars 2020 10:35

=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>; Kurt Van Dijck <dev=
.kurt@vandijck-laurijssen.be>

Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : Re: PCI/PCIe cards and MSI support




On 3/23/20 10:25 AM, St=E9phane Grosjean wrote:

> When switching in MSI mode, we've noticed that once CAN0 is closed

> (i.e., once its own interrupt is freed), all other CANs on the same card =
no longer receive interrupts (i.e., the handler is never called again).



Is it the free_irq() or the other code called on ifdown? Comment out the

free_irq() and check what happens.



> This issue doesn't exist when any other CANx then CAN0 is closed.

>

> The reason of this is not clear. What we know is that this issue doesn't

>  exist under Windows for any of our (CAN 2.0 as well as CAN FD) cards. On=
 the contrary, the issue is the same for all of our CAN 2.0 / CAN FD cards =
under Linux.

>

> Up to now, the only workaround we have to run in MSI mode is to

> request_irq() when probing the devices (starting from CAN0) *AND*

> free_irq() in the opposite order (ending with CAN0)  when removing the mo=
dule.

>

> Obvioulsy, enabling/disabling hw interrupts is always done when the can i=
nterface is put to up/down.

>

> The "only" side effect is that all MSI interupt levels allocated by the

> driver are requested, even if their corresponding interfaces are not UP.



Which drivers have this problem?



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
