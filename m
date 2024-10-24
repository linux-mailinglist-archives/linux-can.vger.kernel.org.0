Return-Path: <linux-can+bounces-1742-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71129AE1D6
	for <lists+linux-can@lfdr.de>; Thu, 24 Oct 2024 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90354280BDF
	for <lists+linux-can@lfdr.de>; Thu, 24 Oct 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3A33C5;
	Thu, 24 Oct 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="l+Yk9fEQ"
X-Original-To: linux-can@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020087.outbound.protection.outlook.com [52.101.171.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692114B088
	for <linux-can@vger.kernel.org>; Thu, 24 Oct 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764041; cv=fail; b=kJOn4axzA1irJKGvc1SpuUB4p+FSxrQk9a6JE2MFSacmx0bvoHCoDPz3jB1Y+ZRWgM99qD15QBFh44ZSKgoPZ5BQhRL3WpxqCcHFFh2+eOFRrWfiAAmsyRW29gVh4NgGk13SBA1+YUwm0x6b2NsVDILOxp0W23tUdGmOgpSVrqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764041; c=relaxed/simple;
	bh=7Vx0EFl4LcQWnU+ZfY816t2ZVe4IbRuppPr6BRlEKHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BqjdzmXPCVoNJ+pDiIt0U+zqi1qm2OZi7/JDyep6WtQYKTNmViwxEuLGFnKWnHgbPQgBBuvzKKVs6olIxGm/oKLYtYFkbpE2CbhNaDEtgiiYIbec9H4ddH/aoTbGEQqDvilfoJhl6G502VNwFV0YBawovptiTXRVvWH0UCvuq5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=l+Yk9fEQ; arc=fail smtp.client-ip=52.101.171.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU0oEFuH2xUWUx4gGewpkxTVFKdyDdwuydKp0hYy+/kZTzhRSewZ9qSNOnMw2M+5Lk4Yn3z8rkLwY7/TN5oO9T1oNx/yVZyFrIQguRNQo0RomO8wB5qWiS5OiRrD3JV4jFulBBxQVz1kqDUrcbIiPL/jQxBofOdRD3zEIooXdsANz6bJWnD7nM7uenJC1WgWRsDPTPfAkGxaJQief12O7nkdwG72Tb7/p2ZJaHTmiLUCGyGs9St5WQXWeXtgW0ryamEEROGUWQaKTpzrGjdecRdvTiA4ZEmVlW4kRQmmKSK1tBue/5yc0MftfRTaDEXIfdIWmRmMiMg2IiQti+xHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LezbIEtrs6Ful3gj7omO141GSolitp+pAaSbQVgCISA=;
 b=k+zm1BZ/vnc2qRCDh0H16ni2aZMb7wio1pzcafQ5SuMpo5x3RdW8JUtJkDv6wn0ra0vObJFizCnXM4ZT0+uEkpeycew1nWpaiEKQ8rAaHwKC4WpenRFCBIvmse9Z0s6/8EdqZAyWHWgiJCC12s/xkkjSK9OH2hZvYPk6Q++NZ8Uiphtoi5meLDUD47Awid30ZrPGiVtqHA2vzzJWDSxoLXKL9XMdxGQKxqFmyETPdqyN9AP8vHnIPd4ML1hEZ0kmGImd4b+aGUT4tvXsgP808MexBQWb0wiRxDrdzQE4LRUqVZcKKwtEr23MiGIABmzVVfNQeMLv54fU8x8fVDuDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LezbIEtrs6Ful3gj7omO141GSolitp+pAaSbQVgCISA=;
 b=l+Yk9fEQjAwE/w7XOvq/gvzPtQj7ry44njo/lMvYiLcC5I52s5uJKa5odkLCjnCCSxsnqL9qSLOvqPvDrRF+F6P3hXUAZCydgxo1xGjGPhY8dYuHFJcofOhQ988sSoyjQzOUjKHgkl4X94Jv3Tg2lswL4bfGYsj4OE9Nv1wmWVk=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FRYP281MB3052.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 10:00:33 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::30c2:e749:7c7f:a6b5%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 10:00:33 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: AW: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Thread-Topic: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Thread-Index: AQHbFBOVeTJqdUhAD0yBXLlCGVgngbJ5a6XigBxjDLQ=
Date: Thu, 24 Oct 2024 10:00:33 +0000
Message-ID:
 <BEZP281MB2245544BA81549572750B368D94E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <20241001-mcp251xfd-fix-length-calculation-v1-1-598b46508d61@pengutronix.de>
 <BEZP281MB224549045AA4601B1951CD3BD97C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To:
 <BEZP281MB224549045AA4601B1951CD3BD97C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FRYP281MB3052:EE_
x-ms-office365-filtering-correlation-id: 46df1700-7f56-44f4-7530-08dcf412b326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uRTgVkMQ3V6sWt02WTMT2vJ5EvuMCBNzos1V9YvHxj1+bf/CQEWDX3BTp8?=
 =?iso-8859-1?Q?dEXZxN4kCoz68haE0ulMFLFFVzndZ1GW1BTYGe31KKuXtOrDs5U//IqgvO?=
 =?iso-8859-1?Q?owgxdI2pxv5muqgdXMbsOG9Jfbfmdg8rl4G0ov8bnmi0USBU8N7NlutNCd?=
 =?iso-8859-1?Q?WD+bKlqoxE048YrlSsVL1m0ybqoKlVbg0Y7VVCyyCbx/ggGjWcRfugpGr4?=
 =?iso-8859-1?Q?kahyUxuXYVKXKVZxhjOeBLjrc0jRAY02JBRW9CHShlacnPB+hRZR2Lw0sd?=
 =?iso-8859-1?Q?pgmLAO1soiMe2+ujKkY1msK/U2+wOtH8rZO2u+99itzIyTvBUnAfGXPz2R?=
 =?iso-8859-1?Q?KsGBYczzZG3TbH7XwFNClbJtn7FJn/mu71bl1oGhBAo1jez8tiOMujCA2m?=
 =?iso-8859-1?Q?7GJXOgNlK/Kv0Sa5wSfpnHOb0PmCGV+yayevLJ8NaGT60b5hCvYz5OhE6+?=
 =?iso-8859-1?Q?qp/jaahlNOvqVu39kndlFb/kHz4r0a6+1wvSNF80Z0nxAsENaE/Vb2tVEG?=
 =?iso-8859-1?Q?GPJGEjbH24QDHXr9wav6riI27O+5G/vGK9l7TPGhg8sRoFIkA9diTvl2Rb?=
 =?iso-8859-1?Q?BMnCDyUw+xqTTPwyKcTJbB1pGYU08DypEZYDHc9uffxZ8SpH96DoCHwiNe?=
 =?iso-8859-1?Q?Pw4efoPGeCU4NNkLJ7osL8P7erk6tOyTF6+Nqm2v+5PLLY92IG4q0R8j8W?=
 =?iso-8859-1?Q?S+HprDdEBYbS6fh9nJ7BQ3CulAF/WpeZhUtfhwT3ebfc9isuiWYGCzlXZW?=
 =?iso-8859-1?Q?+D/x6/s6ivk4bbp01Yl8UeUiKGshoWlVhGlXl3EvziblCrnPEJuXoQcMPL?=
 =?iso-8859-1?Q?hSzwm0y8ecB95XsieVP5wzPEroy7IGWYSkI/P8IwIZWnfm3I22ZgrYBF3y?=
 =?iso-8859-1?Q?r2KyFSRZTy+Cb7EHEzpb8o+0Bj54PUOyyqSxTVBQv25k8uDYkM0k/q6Wl/?=
 =?iso-8859-1?Q?r0JJ61omgdqJE9Zzw9iMfAYOYAZ2QyFvH5Z3WdMm9rSnfYeNgVP584J3LT?=
 =?iso-8859-1?Q?To9wXpfATyeQ+ctaJ8ZmrzOJwYn+osQtTjHZm2WBwIS/FwBl4GhXmj1qk0?=
 =?iso-8859-1?Q?lAN1zi2X+33bQ5nRK9JG6UjcqtkFtEI/0N0nraJd8SOoQQ/7hWMnOMlmIM?=
 =?iso-8859-1?Q?AQ1c47bJfiW77WScbcEKO8IuJIOKr38WheNs3G7phvl4MRg6jKGfoTrefP?=
 =?iso-8859-1?Q?Xq72g72x2/RW51eOAzB1TW3Vl/6E97K4iSYD3iRhUDEfaCW0CzL0rUFbJZ?=
 =?iso-8859-1?Q?O5B5XhoZQjni7bbOj8diuNAbTOv6tbyucvCvIriVzfu8PBec5nrmmXGr1+?=
 =?iso-8859-1?Q?R0TanSwvxJmkxgtLRYV/qYscYY+7c8hZBC42nhDEEh6QbTCpgVvQLvkKaH?=
 =?iso-8859-1?Q?2HcpLYOrKh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?E+fpg/MyQuFnZdxZGLynkYuACjMX2J0j40NVdCe7FkEXwtIgnXLu2Tynrr?=
 =?iso-8859-1?Q?Q0us/dFobN5kObPFB5xJzNhNaTkMNXkhu9ih34Qq3iGiIXKHTZT/qOeH6E?=
 =?iso-8859-1?Q?iOC8FPXlpB9dtaFvL1ZZjhpfcvw46PmIcwRnjHyUpYxxeZY1JcCtpImVeI?=
 =?iso-8859-1?Q?swQAKD4a83XkqbW973kC6GAVd4e87Xq9UpYbKob4gQWl1YfhXnZvfYM2ut?=
 =?iso-8859-1?Q?Eyoedwd6EC5NlHgtxZ18B7WpRHg29F1SllbWMdF0V+9Eer+L9IvYIhgiam?=
 =?iso-8859-1?Q?Ian15OKNFebhqygvHizWTOG7FGKAEcSbR2fOQlVIlMt1LnXzFGJjmn7U0I?=
 =?iso-8859-1?Q?+AcgGaRJpsuxQKR28OFZugO2QwavmYJa7j/8Vmwcw8qeuAAegiyGPmrIE7?=
 =?iso-8859-1?Q?B3qM5chK4MPrAVxuP8+kTICIZSZb65rSmYj8TSR2PW+ZKk3TQC/Wcgn024?=
 =?iso-8859-1?Q?ppoTKNKPaeat4tyfbcDTLK4N+EkJA931ZheJn+0wdSNrHcUAE77H7Hrk4y?=
 =?iso-8859-1?Q?Zv6DbMocE5gN/SYBUxkov/7Pt1Iim9/Y+MR4E9npdc5Txhg9mxb6TnCJIa?=
 =?iso-8859-1?Q?0wXtea/OA8Rr6v9Suq385tEDxYmmnany8t8wuEryQ1gNG5cVzlLW4iLtVr?=
 =?iso-8859-1?Q?CiW7Cbemrt5UJYbLwy90i95Sjns7vdbPxWBAiN2MrgwF1i5A4fy5EehvVE?=
 =?iso-8859-1?Q?/rKBpsGVLL4qU7I1rUIh51/ot2vy4z54CqQ7SxKwOKdfZweGt/C3U6EzdR?=
 =?iso-8859-1?Q?vZxY5Mu22JOZ3nz475IyMHNMMCryrQtTrBMHPNHpK4nZPYjClmb0dn79VO?=
 =?iso-8859-1?Q?3FMIfLtXiOfNZYagZaFpCiXQ4J/S/yKmiqEFjUDVMaVoZvJWo/7DUaCyJv?=
 =?iso-8859-1?Q?svPtb+E+lOBH96Ky6YkQlNASCIn992y918vu0tiVi6nSZDJFouI5naosxk?=
 =?iso-8859-1?Q?JF4+ZquD4OQ72vChU76e6/DdPYAbWppCQAi9qDbrPzqG4tQaLg4vgIFSX9?=
 =?iso-8859-1?Q?QiT4G4HJ6+k+Acg5UoBHxOA4hoqUeimYJYDBpEsP2eMCQTI/Vt3w+TZqEo?=
 =?iso-8859-1?Q?+jci8bsJ58pGxr8ATwt1uWI1mypf1G2y2gyr5sEVaeEmxzi+2yT4LQsXwl?=
 =?iso-8859-1?Q?nCPldz+bPr83ZGJyYPJ+eAp40eJbRLxSBE4EmfDbkKwTvl6M9nddFRXSmH?=
 =?iso-8859-1?Q?6U+kJUgOp0/e+WWMfCRRmFFVCSqhItfKswMc5KGa1LPkEYwVOME5FwGVdo?=
 =?iso-8859-1?Q?90XabRElEHzjOyweIV7m4mO6k2B1ioHSIkEBGEC5s0HJ5fzK0lZgW5TEzc?=
 =?iso-8859-1?Q?8EfhRCovViDgNp0tFRkZO3pUyRLihFymTizXagheBrRdvNyXCt4Fg1DNOd?=
 =?iso-8859-1?Q?a9HjYqzP1a+zyfs8zsJogxrHd1u2pfFYnXtiMXrXLQM2YV9xw/GOs7TrZn?=
 =?iso-8859-1?Q?027Z9UGNYqTEVGcuUlVgKtFlzGpq8kQfGdwkBz50chuA80M4uLwXHwRPks?=
 =?iso-8859-1?Q?7Z1X6RfsSYUY/EDq49dEZRFZS/siYtp9StPdzGxLEL+oO3JrxYWHgjR6ro?=
 =?iso-8859-1?Q?GhekD8m09R39frk1Si+klb6gMz7U2fRkn/FWFY/2sMXxeA8485n2UA2e98?=
 =?iso-8859-1?Q?o25cy8krlRcmaUHCXmN0kJIyh1CV9M+/cFcpleru0w2qPs1k7JaXOhug?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df1700-7f56-44f4-7530-08dcf412b326
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 10:00:33.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvnsN6VmNdCT9p+/XZOfZWR5A9FKe/MF+g12j9jXPLILpanBd+CqcW4+Eld4x8hS151xecnL2Ow+AyIRAbCAVeMlQMWTzhIKfe6mAImxD6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3052

Hello Marc,=0A=
did you have a chance to look at it?=0A=
Regards,=0A=
   Sven=0A=
=0A=
________________________________________=0A=
Von:=A0Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Gesendet:=A0Sonntag, 6. Oktober 2024 10:31=0A=
An:=A0Marc Kleine-Budde <mkl@pengutronix.de>; Manivannan Sadhasivam <maniva=
nnan.sadhasivam@linaro.org>; Thomas Kopp <thomas.kopp@microchip.com>; Vince=
nt Mailhol <mailhol.vincent@wanadoo.fr>=0A=
Cc:=A0linux-can@vger.kernel.org <linux-can@vger.kernel.org>; kernel@pengutr=
onix.de <kernel@pengutronix.de>=0A=
Betreff:=A0AW: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix=
 length calculation=0A=
=A0=0A=
Hello Marc,=0A=
=0A=
sorry, it still crashes:=0A=
[=A0=A0 25.173548] mcp251xfd spi1.0 canfd1: IRQ handler mcp251xfd_handle_te=
fif() returned -22.=0A=
[=A0=A0 25.173576] mcp251xfd spi1.0 canfd1: IRQ handler returned -22 (intf=
=3D0xbf1a0010).=0A=
=0A=
I attached the dump.=0A=
=0A=
Regards,=0A=
=0A=
=A0=A0 Sven=0A=
=0A=
________________________________________=0A=
Von:=A0Marc Kleine-Budde <mkl@pengutronix.de>=0A=
Gesendet:=A0Dienstag, 1. Oktober 2024 17:06=0A=
An:=A0Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>; Thomas Kopp=
 <thomas.kopp@microchip.com>; Vincent Mailhol <mailhol.vincent@wanadoo.fr>=
=0A=
Cc:=A0linux-can@vger.kernel.org <linux-can@vger.kernel.org>; kernel@pengutr=
onix.de <kernel@pengutronix.de>; Sven Schuchmann <schuchmann@schleissheimer=
.de>; Marc Kleine-Budde <mkl@pengutronix.de>=0A=
Betreff:=A0[PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix len=
gth calculation=0A=
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
I think the length calculation is wrong. Can you try this compile=0A=
tested only patch. I'll add a proper patch description later.=0A=
=0A=
Marc=0A=
---=0A=
=A0drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---=0A=
=A01 file changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/ca=
n/spi/mcp251xfd/mcp251xfd-tef.c=0A=
index f732556d233a7be3b43f6f08e0b8f25732190104..e40a6d4134c29b32baeda7ad3db=
af4de27b54ba3 100644=0A=
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
+=A0=A0=A0=A0=A0=A0 return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF);=0A=
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
base-commit: d505d3593b52b6c43507f119572409087416ba28=0A=
change-id: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0=0A=
=0A=
Best regards,=0A=
--=0A=
Marc Kleine-Budde <mkl@pengutronix.de>=0A=

