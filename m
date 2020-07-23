Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150DE22B6DF
	for <lists+linux-can@lfdr.de>; Thu, 23 Jul 2020 21:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgGWTj6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jul 2020 15:39:58 -0400
Received: from mail-db8eur05on2043.outbound.protection.outlook.com ([40.107.20.43]:44588
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgGWTj6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Jul 2020 15:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK9eB18gOu3AgQI3WsHA+0nBDmP1WEc/35oqPnT6QvWTDFRxPfVUIFM7n+2a3SkcyIoIKDO2ctFZOtdln5tZ6/ntuwvfy00yEgQW3DmB+qgydrpOMUhMH+TwG9LqdGJF/hTueCU8MvYGjDPpuBkHx+NtCjathXP4rl1P+XrrdPTfT2wE0EqRGeq8zUL7palc5lz40ugJPwSC4Kjyb7VdscT+iSRr2PJIbQTNLAaWCY/GDvf3cf/k54qscQ8+6WGsJgJNRXZ9zNypRZz1/MNXJRkjw5reb+jfRxKUiwUgbnDX/yI3YqgqSMXHxNKSHB3Bw60jEUh72/QtNXdJIaRKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA/sk3UqbpQkSUWT6tDTbYdZXJSxX4iRJ4mJ7bDFvBM=;
 b=J/u3i4HE+wQ42uao2o+y4hEZirLrr4oQVl/0mnKgzb7O+3Hivf0QHlvNHIzZQtgp5h7p0QTkrpelGkZPmT4frvarYxh1ZkLR2QJeVUTxDjk1N3nlc+jfYPWPM8NixI0eqKiTNrdLWa0UhPaB9BixfwrYmPcZerA+JzNE3YtVFvX5okDyOi9Gf/MoRHvTIMl2IDeoJj9ghbch/P/Ri1D6bS31uK9tL/gAscFQh5H2ppABLMvv7F/WjWoyqZVPDYe34A0j85iZ0HqYV2lwO7BCI/30ZnrA904RiedZUM/SwdgvV0NGw1OYlgH7svGUgHyVWmMDQLhkSKjoowhojOm5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA/sk3UqbpQkSUWT6tDTbYdZXJSxX4iRJ4mJ7bDFvBM=;
 b=rbxC1bLu6S+82OQykqvgitR07xiLcYL+hCDSsS3f0UhILQh2CjQYqaQUBBxaXIhMZfSCXFho6ml2Oi/Or9oiLtWEUNPuE/DXc27jNX7YL29wwAiYS7T5wcmddSMZeVExwss6IfmK6KAZxryoTnnGVGm2Fvsu79kDTajKzJUFMhU=
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com (2603:10a6:803:bb::18)
 by VI1PR03MB5055.eurprd03.prod.outlook.com (2603:10a6:803:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 23 Jul
 2020 19:39:53 +0000
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9]) by VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9%5]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 19:39:53 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: About sysfs usage by socket-can drivers
Thread-Topic: About sysfs usage by socket-can drivers
Thread-Index: AQHWYSjQRUYGLa3AHkGWSYoBE7dosA==
Date:   Thu, 23 Jul 2020 19:39:52 +0000
Message-ID: <VI1PR03MB50531E485F82E3FD4D64C459D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 500e270b-2312-4868-5b74-08d82f402bb1
x-ms-traffictypediagnostic: VI1PR03MB5055:
x-microsoft-antispam-prvs: <VI1PR03MB505509F58B7FB24ACE48995ED6760@VI1PR03MB5055.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k265cKW08G2mZt4M2ZAqXc82sJafkApyeyzI8GGHUPzD6j4H+ufVuFQSvpIc9lJfQ8b2snAx660wWuvYNqnUn5yMrRr1/0S40jz+8Y33Z1kZxqzkWNmOgbC7tS9U7NU7FabJQriAMC+3SlbTyxnYhtvSDFEX2uY9c0SdFRDboXzcXZ1Sp+r1nnjzUGzk1SKIq4KQoIQkgrgMZxjQBb5fjcIaY4i3EyyHKbOy62uAzgkb82VsqTdZzx2B+y8To+oNIlvfdq3HSndGekYBzWz21OKfccOg7bGX7nOLPdbjCNMbEI60svVCHvdmiRkSmidqyUbJ4iYqw8SXorPaDSrcPPIVkS2HxkEq4Wi3aCKh9A1q90rNGPIEstSsG+cjtv7lrzctDGWiq5Ky7ddi05uNWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB5053.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39840400004)(346002)(396003)(136003)(6916009)(26005)(8936002)(66556008)(76116006)(53546011)(4326008)(6506007)(5660300002)(66476007)(66574015)(83380400001)(66946007)(64756008)(66446008)(8676002)(2906002)(33656002)(55016002)(9686003)(186003)(52536014)(86362001)(7696005)(508600001)(316002)(71200400001)(15974865002)(966005)(83080400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: btyB3SyYD0kzEV02W4llBfnI34aCKsnlipemx58Ox1b6RQW0D7fnhOuo4ZUKGrO5hL/2I2leCX4PZHVSLr+bgx5XTFV3bn7HNqGAQMPpkba/9AfkO6dfOwHi/VtxEsCWa9LZEGZaVkSJCgcpKB8k4xXwkM3MBwKcrHzqDmkblHN4nGa2oH2HIeSQl7WdXeOdDPNSs+BPfoEpNAl++JKUj8XPf9k/6h46c2GrGjx5gdFHNOhnfr/hQSAJs19WJOBNWVAavOUb6HG2PTxKPhBzSirVWNpaMMfJybqh78XVBHPvS531G6JqF6bYf4clX/mJs7FMtJ2FQ3rRV1ALxYrgtzDkjdgTfUFOUQcmKVJ5egG2OxyZ84T+lEu+6zv0j9x65qFC+gK34ZHldLGNgLTYrCfAs0+YWaqkBD8Lgx5Ul1B2gXZAgvRpr4VJI8AFpK72tGUq7CZiIgYZF3VYEI4pofDl5wHObjJApx7GK7oXKfb1F46pR0eq12GxM/7hk6LG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB5053.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500e270b-2312-4868-5b74-08d82f402bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 19:39:52.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33lYbTnZlQjncs/4lHaummu7b3OU+V4qq5+ZkL/kkGH2qvYU74vWXN5p3d355lrP9/PJIgG93Q20vEvAlhLrWllmxrZStWmRUqlURiDAQOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB5055
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

>> We've several pending requests regarding:

>> - changing the default clock value,


> The input clock rate for the CAN IP Core?

Yes

>> - reading the bus load value,


>..as calculated by the USB device?

or by the IP core, yes.


>> - using a flashed device id. to better control the can interface number,


>Can you make use of dev_id/dev_port
>https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L=
1687

Ok. I'll check that, thanks.


>> - identifying the (USB) channel


>Does udev offer all needed information? E.g.:

Sorry, nope: identify the USB adapter <=3D> flash the LED (which USB device=
 corresponds to which canX)


>> Adding attributes under /sys/class/net/canX (or into a specific/private =
group) could be a solution.


>Marc

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97







            De: Marc Kleine-Budde
Envoy=E9: Jeudi 23 juillet 2020 17:23
=C0: St=E9phane Grosjean
Cc: linux-can@vger.kernel.org
Objet: Re: About sysfs usage by socket-can drivers




On 7/23/20 4:50 PM, St=E9phane Grosjean wrote:

> We've several pending requests regarding:

> - changing the default clock value,



The input clock rate for the CAN IP Core?



> - reading the bus load value,



..as calculated by the USB device?



> - using a flashed device id. to better control the can interface number,



Can you make use of dev_id/dev_port

https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L1=
687



> - identifying the (USB) channel



Does udev offer all needed information? E.g.:



    udevadm test /sys/class/net/can0



> Adding attributes under /sys/class/net/canX (or into a specific/private g=
roup) could be a solution.



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
