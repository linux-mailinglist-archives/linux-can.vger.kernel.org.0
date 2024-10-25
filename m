Return-Path: <linux-can+bounces-1786-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA59B08E5
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E1D1F21E3C
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DBB15E5CA;
	Fri, 25 Oct 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="bmFOqt8v"
X-Original-To: linux-can@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020110.outbound.protection.outlook.com [52.101.171.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506321A4D1
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871445; cv=fail; b=O/CdGR1+wtkgP8SzM+Xaqz8EPdSzscZAWp3v/auYuAg3lEcLWYAmpUcMqMml9YcjfeG2XqvrSy1G+iu5H84UrZkSYmUvCbmGTroDX28HQqJ2nMk+OKaKRx04wmQVxZihAqEDWlyEnV7hDE4zI/0APTaZ9XyA0FIPrWgqsbiVEM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871445; c=relaxed/simple;
	bh=Hhcwh9tC4Fs2+rwPncYELHptLm108kinsrjskHk+GvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvZGy1V3R4CrqZ62n1uBgVKMvmHES41T54PQb/SpS6BpqCxeODROjFzcTaZA8ANMlSoqv1iDAQimDyKKmvgatBV7tGwtyyaLDbE445E5dNhB8EU48etv/+Lx+4ho/EVTxPT8snYZdghZfboPD9/2JVvmqBbECN52sWMKH9sthQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=bmFOqt8v; arc=fail smtp.client-ip=52.101.171.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODy5lPhAeJiIcLnkkRKiSqJk2wEIfZI2UCH3ZiuUtutTGBBKLrRI1En86BgBdzZBkRSDw03Q67tzFrESKk+hZTaRXRHo46sgf5PxykoCHp9/zFsomRBb/pU6xyUSA2AE55VrEXulY14ndyox6EEWkaRO+2FUnhAhXSKqv/QZOLsvyC6pKYfkpAy/JYYPqGAhEkoGPPKtd52SnKQum/xk1ZSJzvl9qhBV8qeHSXIErNnVO5mKnpyldcxsz69rzwgHqWDLTqzukc1ix8NNp8wREveCTsNWvP7qcslZH6+hXeOjGVf3a3AmJ6wzCaIzOcN4tFSeFvS8/R1ZJr7G9z0pSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwgCGSYrXGDEJrfhml6SfJnqLI376Wqv6DnAulmclhw=;
 b=ZkwcmmwIQwUnlHO3yNYy309jVVQIncv+IKkluLrmYPakoAAS+5ExLoOgb/blds7ia/kjpEKreF0+qtcnLmKGIihiNS568SHUXFX8QnEmosFCZyRvRqqDGYJXwTT7oaq4qDwKwxm8TgoN+bUIfANcrpcWanFVfa4ZT81l+SWc6VBVOTRF2m9Q6K2QEo6S3WZeYIAcc+BjCiQG4Lv1lmGV4bCub7CDCAzWrWlimedXHAQPjj7WQUDbCCErYtKdYAPOuKFL+86snJwH4Oul1Ppft/xeYUSnN2JjDOBT/nBV+fgwArq/66C2ZidrBGJ+rCLFGAaONYehddYlQy7cUlPAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwgCGSYrXGDEJrfhml6SfJnqLI376Wqv6DnAulmclhw=;
 b=bmFOqt8voKqaVpS6+nE+bIvQOGSMQzJJ4hn8fTuaeH1N2RWAxlL0PIYMY3b2tDlC4uDPZL9vB5/OOzbq5Z+iK5ejyvOIkvGUauMP15rXK6ZwUsdLaHEowX56DakzmGkkCxATWLerWF4MBcydwBufT2xZTN952higjMHug7sLn6E=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by BE1P281MB1716.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 15:50:37 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:50:37 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Thread-Topic: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Thread-Index: AQHbJsReg/Ty+zMwvECtW4DULiPQ0rKXnUtW
Date: Fri, 25 Oct 2024 15:50:37 +0000
Message-ID:
 <BEZP281MB2245A3077CC6306F78C623AAD94F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <20241025-mcp251xfd-fix-length-calculation-v2-1-ea5db778b950@pengutronix.de>
In-Reply-To:
 <20241025-mcp251xfd-fix-length-calculation-v2-1-ea5db778b950@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|BE1P281MB1716:EE_
x-ms-office365-filtering-correlation-id: 2424b127-9115-4639-372d-08dcf50cc51a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1Ng6DDpg4dg8kJV8kpHE14uw6nMPC0pMdR/6NNY4v7kFqHbuETG6YGpW29?=
 =?iso-8859-1?Q?UaBKgXaFYIL2DzsRXFCAQuWuvIVAblVHRZc3IsCKtm0UnPCiPF9i4Q6jfW?=
 =?iso-8859-1?Q?bopTz2nbCqeJimE4lPJafmEpugFk6UFhd7VJqKuQxQgciNcC9XjxgC3wxF?=
 =?iso-8859-1?Q?0WLnXNeZuOKL4y7nKr3YgfLIBFr3ffBdgRu0IXzlkSetRAH+HKLEjYaL5U?=
 =?iso-8859-1?Q?Qp8kTzZb7yWb+/QeZjfgTg/cGLsW6qUM/B2bsoe+Qw5yJfTViBTgCQXVVM?=
 =?iso-8859-1?Q?/dEETmkBOk9r2Ew2F+lXcQ9chZ7KQWd73DS2qingwBtyXf5AaR/lQb3hxH?=
 =?iso-8859-1?Q?i9uUVDE1+p335e5kVZiLU4iLNlcZCZ2My+JQcsVkW2BEZ85AD5YIU586hQ?=
 =?iso-8859-1?Q?uF8o833BzKDNAGEthg+ojL33Fd7A8jbFFbmQr0RZVNMfHr/zosvog/Skdh?=
 =?iso-8859-1?Q?YqhhnPYhJ4AJyy7JiwKLJMX8f20c3o/q/DZSuFCqI3Xg34wVnCZB41ym/G?=
 =?iso-8859-1?Q?Bsm2yC2o6Sb9IKqaZb1cYVesIV7Qkub3JQq3lwEqY+/D5BxhGSvkrnJYYg?=
 =?iso-8859-1?Q?2Da5MnHioK72eJqFDuFEK99YZEQSRc1V+uu+/bgfutSJ5Apqvj6gDcW+Md?=
 =?iso-8859-1?Q?3BsHSHiawizhjemvXwYUK69YD99/HJs+lbLWOKDxbOl0RU0xa0eTdSLfL2?=
 =?iso-8859-1?Q?OYbKduJiUhjjPSgBYaKI+Gpmm2QPJ4WuxyHW3h9yGUbhO4tKEeoV5YiRN7?=
 =?iso-8859-1?Q?kP/Q6Zzrk39uiKxsfOHHPwZOfwebxJdtqs4rJ+jDdF2mCYbiKZPnvNuoSg?=
 =?iso-8859-1?Q?DGqNryYSA01K9J80t3XtMSKg9KsZPtYB759k5LjRsePgLBB54xjWd1nH3M?=
 =?iso-8859-1?Q?8ak0akyhQfmMWn363n1BnbP6rOemWcjnk9sxPd95Fp+gAtJI/S42gf8RrR?=
 =?iso-8859-1?Q?qkqaTcGxKHNjVokLdtv1h2Te56SCG1mmaQJajhOpLkhcTFIU4XzWLkMG5t?=
 =?iso-8859-1?Q?Y7l8QBJAIZIpdrcs+rSz69iGiDbVdh6M3nWYINwnsIwAklHFEbP6VilnMl?=
 =?iso-8859-1?Q?E1WHyq+/T5xRlAFatI6GaTLwRa9vh9XGt2UdPF2spXUG9OEtsIpz7k78Zw?=
 =?iso-8859-1?Q?iUs/0bo0mypiCunL7UXI/oGrdwiwO/a5xzExwFfGSRf/H+leE7QazBEBPA?=
 =?iso-8859-1?Q?qOyvVhfrIGw7/6yeO/yVchotCztNZW/JB6Eh/vY+3RMhR25keIFUJ0+/ZZ?=
 =?iso-8859-1?Q?pfDHN2Iksy9gB7eUZ4i5Y9yMxEULca8SkpQQGoUb8ddRCujK9GftucXTZa?=
 =?iso-8859-1?Q?pHX6IlRYL0jE1kEANkPdVpVNTVjKEmx4Z1/FHI3QYhai21ldX7B43P3C+6?=
 =?iso-8859-1?Q?B+yBXHzihL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?StdwCqPnzea1kkXRSnxvCglK0XARK/d2k5rhoD20cCwAbRhJxuOSG4MMB1?=
 =?iso-8859-1?Q?VjA/voLkvXrwTkkmio0mh3AzVSEKu4NL3qaQM80TnX1ede+OUtiz7kXsaV?=
 =?iso-8859-1?Q?UFphy7/7kDr0bwgi7JylTyOTkLXwYp05XmcO33W/SA/Y8tIHEN057dJJjf?=
 =?iso-8859-1?Q?RGyD0ebUyt/PKnuARXp7xvkCy7FnGaK9ltvSyssmX3zaaggtIenFRDvr93?=
 =?iso-8859-1?Q?NFvWl2TBB7+Gk8+SEyxY7iO539D+za4hXA+Zxp+h4NxGlMPkUjXKAi/sK+?=
 =?iso-8859-1?Q?ZA/qV4CjAyR9cnwJNIb9KUbTO6MLxUME2ycObE1fF7C3OqJcK+AljFtQWV?=
 =?iso-8859-1?Q?oBljl8uHcYL1DwLjyDwN4IqASRDwv4Pket+/VNupfyVWgVGs+cQ7gO87LA?=
 =?iso-8859-1?Q?1tMvvUfXZhIRXlYV47Tzx3WUxP3zOUg4wEUt32IqtoChNsXP9sUyknVKtf?=
 =?iso-8859-1?Q?DUXsx1vwG5Paikg03tWKA3CJcMj8/cG+lt79PqNpNQ5XsZDfzTvPcTqJcw?=
 =?iso-8859-1?Q?9Khq8XJyLM7JBpT5mM3LT1V9oQb5X56EaJIAsS+ZrTXim5vY83q2PfP8nU?=
 =?iso-8859-1?Q?NbFNVoa6LhjAT9NG6qVUlX1WkNhpDXGKBosewyK7tPJ8KoI0jvlhAGi1vB?=
 =?iso-8859-1?Q?hZEwls+bGweWtnU6LYt2Jo1qC7NM0wJqeHUTLPov6zOfg7A/My5wC5ipti?=
 =?iso-8859-1?Q?mrb6dpkQcWKo/qkPAbl4WTKJZ1wwZHTKuEv94a0ZtYo3p3uMNFuldKIzFk?=
 =?iso-8859-1?Q?xERC9xbsM0GbFf/bHj2Lqbb4B9nq6XEgPSAscaRFBAFleG/nS8iXbogyl9?=
 =?iso-8859-1?Q?V2fE3yqMdv22KgPzVjXV6McDo6LIp6KVFjUFZZIogfcqcvezdzBHBLrXSy?=
 =?iso-8859-1?Q?ljQNgKMx57BqpTUgGEuTJEtCLPY9mKs0d+7TnTHKEL+ZBL0R9FRbYO4Km8?=
 =?iso-8859-1?Q?BWxOINKIyOH5nMS0apLfoqKYay+sRWJ8VwdFznOowseTMjDEGWRbm+1wEl?=
 =?iso-8859-1?Q?IXcPXIZ5kmCNQzy9IQ8xgtOmkATg5o4VrpBIOQjCCkQnlqEYlD6WsrBV+k?=
 =?iso-8859-1?Q?qJ7d27Kwwp0D6bR12MHNnuPuYwQCrOwGZ8JPwKBgHzi0LXBb9wzA5rIfPT?=
 =?iso-8859-1?Q?2tLOKfQczKPLRsTNbS8bBMw6wYk3pn0p5pExP+IyMnCD/XDBrvBeqjc8NK?=
 =?iso-8859-1?Q?NBX+ex3hhpegJ7EBgEeGKiTfte9ZHUwPJwlkhAi0NIRWhoPirBepaTmiUx?=
 =?iso-8859-1?Q?cSFwwrLi2u8zugLOH2U2RBR9mB8GynrlOpV0sRhetAF3HV3aQ5/0lB6Z/H?=
 =?iso-8859-1?Q?6pPfWD/U+EaaEc3VQSdHFd9u7P/t4pmkQ1NUmviHptogn0RLyvrOlRPJx7?=
 =?iso-8859-1?Q?mJ7mL7KuPXA004J8pSafY3I2MSXzuDr+sHLORghDg8e/jHkzcT5Nr7lQBc?=
 =?iso-8859-1?Q?yXtGtPZUOKi+Ja5XP5PJAqKh6JYuqFruHxgQSiEFQerwfwn7tHW+30/GqO?=
 =?iso-8859-1?Q?xY+NlAcNZSh0gR+qmaSkZq7niRtZXWsEz1MT1CjLYbSprZy7sHOTCUbFrC?=
 =?iso-8859-1?Q?FaEqt8QXPz3wSB8KQTXKbOXv3EQj2iT8ecZ8WUAtplHbV9Crrsa9/0cwnU?=
 =?iso-8859-1?Q?SgH5vlW/a24gt9rTnYpdKBm2WftdGMSO7Ur9QCMlMezafTMuyvA2V2Qg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2424b127-9115-4639-372d-08dcf50cc51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 15:50:37.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dz4RQT/Knu8g3kWtUzBJ5eCg7YPNEDbJk1dxf/QG+8t5e6Gtib+Pyp5r6Mko2GTfNFebdce8aLRR5BN6xxQb/64zz3RsHyTQ66MloYkWkEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1716

Hello Marc,=0A=
=0A=
this looks good to me!=0A=
I have no crashes here anymore.=0A=
=0A=
Regards,=0A=
   Sven=0A=
=0A=
________________________________________=0A=
Von:=A0Marc Kleine-Budde <mkl@pengutronix.de>=0A=
Gesendet:=A0Freitag, 25. Oktober 2024 11:57=0A=
An:=A0Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Thomas Kopp=
 <thomas.kopp@microchip.com>; Vincent Mailhol <mailhol.vincent@wanadoo.fr>;=
 Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Cc:=A0linux-can@vger.kernel.org <linux-can@vger.kernel.org>; kernel@pengutr=
onix.de <kernel@pengutronix.de>; Marc Kleine-Budde <mkl@pengutronix.de>=0A=
Betreff:=A0[PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix =
length calculation=0A=
=A0=0A=
Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Closes: https://patch.msgid.link/FR3P281MB155216711EFF900AD9791B7ED9692@FR3=
P281MB1552.DEUP281.PROD.OUTLOOK.COM=0A=
Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF=
 FIFO tail index erratum")=0A=
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>=0A=
---=0A=
Hello,=0A=
=0A=
I got the empty check wrong and fixed it. Please test.=0A=
=0A=
Marc=0A=
---=0A=
Changes in v2:=0A=
- mcp251xfd_tx_fifo_sta_empty(): fix check if TX-FIFO is empty=0A=
- Link to RFC: https://patch.msgid.link/20241001-mcp251xfd-fix-length-calcu=
lation-v1-1-598b46508d61@pengutronix.de=0A=
---=0A=
=A0drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---=0A=
=A01 file changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/ca=
n/spi/mcp251xfd/mcp251xfd-tef.c=0A=
index f732556d233a7be3b43f6f08e0b8f25732190104..d3ac865933fdf6c4ecdd80ad4d7=
accbff51eb0f8 100644=0A=
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c=0A=
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c=0A=
@@ -16,9 +16,9 @@=0A=
=A0=0A=
=A0#include "mcp251xfd.h"=0A=
=A0=0A=
-static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)=0A=
+static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)=0A=
=A0{=0A=
-=A0=A0=A0=A0=A0=A0 return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);=0A=
+=A0=A0=A0=A0=A0=A0 return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;=0A=
=A0}=0A=
=A0=0A=
=A0static inline int=0A=
@@ -122,7 +122,11 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 =
*len_p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (err)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {=0A=
+=A0=A0=A0=A0=A0=A0 /* If the chip says the TX-FIFO is empty, but there are=
 no TX=0A=
+=A0=A0=A0=A0=A0=A0=A0 * buffers free in the ring, we assume all have been =
sent.=0A=
+=A0=A0=A0=A0=A0=A0=A0 */=0A=
+=A0=A0=A0=A0=A0=A0 if (mcp251xfd_tx_fifo_sta_empty(fifo_sta) &&=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mcp251xfd_get_tx_free(tx_ring) =3D=3D 0) {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *len_p =3D tx_ring->obj_nu=
m;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
---=0A=
base-commit: 9efc44fb2dba6138b0575826319200049078679a=0A=
change-id: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0=0A=
=0A=
Best regards,=0A=
--=0A=
Marc Kleine-Budde <mkl@pengutronix.de>=0A=
=0A=

