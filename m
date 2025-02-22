Return-Path: <linux-can+bounces-2938-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9409A4064B
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 09:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5144425D1A
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9B200BB4;
	Sat, 22 Feb 2025 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DaSk2wwh"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011025.outbound.protection.outlook.com [40.107.74.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D416BE17;
	Sat, 22 Feb 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740212409; cv=fail; b=uv0DoscPWqskytu4s8Lu4TpCsd0/CDunl843wSW8m/1HtZOio3cbejkhQK4yJe+On/06Xy2ZT/HWgvbTs0h+mPyyIi+uUaJxoVFQlno9VfDm444LnK/GX/znQXLpyp4WicheFsx0JthIXXmgu7pPnpeOq3P6zk9JGq+Odp3+FgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740212409; c=relaxed/simple;
	bh=/oacSY7ZgfzVDPDpxa8/FFBDlLU0fDBKt0vlQEPEXnk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jkge+sqWv72IrbmZJR3w7EHIPhp4KHkASg76lski+HPgsSrH5bD2lthmNykq2lQZQL0/TsmuYm49KH0pk2ZuTotnzq58BhazYlAyEXbHGsR4JPDSd3i3eAuQGDnBkxaNPG6/7p6kZCNLrLEQVNaGO9xikkYQGw6xTbuO9yoI66U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DaSk2wwh; arc=fail smtp.client-ip=40.107.74.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXehuv99nRfuf0AsvnArRur5NP6jARKpmYxJxOy3sLEkysoln3XofEp+wRuTBv8LFIO04vuqCg+nZjGMt2ehLWYtIsR+SJsj76bV20WrONCpRebvdNmEm45YG0JbN4vtJQXzGd2rj3eJIER3EsfywfDxfQKfclgU7AybORAoxSX2YUniUSpfTqpzVRPnZ2gNV+oYSPPs/MD1Hx6BLCtndU24xqBZzdzuVainmJODY1ncwbAtqsltpxZYPYmclKZjXVJGBR9BONkyJrsaUc8z5eAwA9Va/ZGNtrSGMqZEh/6EFFlRgdo0UOJHMlCNa7gGdmlHGBJBMFFinA1W+R+5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj0W+ypezxmRkAPG+yx9hFDV9fD+I8WrXgvBSyIe2sY=;
 b=Z7usIEqj1DFTOHn519/X4aDDoI1Q9YtqeoCuO9gbSmDwrWzXIrqRsd+1ufDzEXNRw3kZK9gYcIpHiSalamWfqrMlNuX/BgT4FjzIruTJXtJFifG5wo8yEFCg1phuVxZTvnLI/LenkJJmVxZd2PzRU4DM6UAzK90nguNy3keJY2+2qinejOwoZDH1yEZdrMqf2rhY8DvBC+89Gah1l49GEURpRr5Vjy7eLy+gGYgjHBQPAbnquRAjnH36xxSgO4YOGomcxf2eX2lqWBtyfKGGgz9Q0WmOuGHpTcnWIsTSnvMOxCSbrxwzEkZQnyWmGPjgtLWIcbD+8+CMKeek3wq3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj0W+ypezxmRkAPG+yx9hFDV9fD+I8WrXgvBSyIe2sY=;
 b=DaSk2wwhJWAq2KAJDB/hs40cC1BofQumKa78RBiyZwQr8IcQKv6HVkDvQxOka9bsU15hGySzi7cqKfW3VgfAY7hkVis9jHGFzSRj5gR40pdRX2htIoN3dYzErLBQKv8+4JqDP7bCBWLpeeuGyX3mMtK2RT+bkiqIdxXRGj5lYdw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB13296.jpnprd01.prod.outlook.com (2603:1096:604:34b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 08:20:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:20:01 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Simon Horman <horms@kernel.org>, Duy Nguyen
	<duy.nguyen.rh@renesas.com>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Thread-Topic: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Thread-Index: AQHbg5gEuVeABlhtqUKyBuyQ1fkjX7NSC+eAgABa3gCAAJUAQA==
Date: Sat, 22 Feb 2025 08:20:01 +0000
Message-ID:
 <TY3PR01MB11346C88924204C289FC24FB286C62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
 <20250220130427.217342-3-biju.das.jz@bp.renesas.com>
 <20250221-childlike-deepen-8daa4513d5b5@spud>
 <20250221231856.GA329615-robh@kernel.org>
In-Reply-To: <20250221231856.GA329615-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB13296:EE_
x-ms-office365-filtering-correlation-id: 8a552e63-50fe-44e0-46ae-08dd5319b3d0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Uc9ZYyW0iDlORIYqTsQEjEwK7utOUflasgq6m2qFXLFzjjrxtUbalRM9jQu5?=
 =?us-ascii?Q?raNaeGQqTxA1ogVxdZKcp40tCzt4vhbmw3nhoXHerDzjuaGp5wdV9U7SXtOc?=
 =?us-ascii?Q?mSh6Gbzf8sXpqdtum+/h+T3i2xj/MRsZ40IjD/CwMTMhqNVE5Dfp3lWeKcVH?=
 =?us-ascii?Q?iq1hkZzINVeZDQWICDlwwBs5BT+TppY9qm01HR9G2RjtNcRDwEL9+TiGkSWT?=
 =?us-ascii?Q?QK6ivXkNHtj/SxD8RWBKQDYeCz0/FEHi1yOD/r+oSKmFa9iNToKpsHXfstlF?=
 =?us-ascii?Q?UPWGLvqhB41Lb+4ksaP3mr4XkMRHOl3i7gyfvYm2kY2Sv75hW9u5QpCR/r3E?=
 =?us-ascii?Q?J7aNa2M1i/uH93M3+zEVFETp7B/TXG9Eg1VjN96FwCk3unhLzbhUwj9eJFsL?=
 =?us-ascii?Q?45PpaAkVB/ksgoTs81zuyoX9vZbE9QOj6UWsL0GN5Zu/dBzTeCvCeYH5kBOh?=
 =?us-ascii?Q?G4ziZ2TlxfTksfsOhk+M/KferyzmF/AECX8PsC+51In9vheNnrpjIZYqzj39?=
 =?us-ascii?Q?4zlV2p5GIth7vrM141N+tReIS4LqxMXcg6plDB8HUw4ASp02llBHEaNwoViS?=
 =?us-ascii?Q?nhzYjw5c+gZ+aYkh/hvIf+kDZAzu5j+ZR+95JF1Nrs+DbJkk6IotIq1e8fM2?=
 =?us-ascii?Q?SmcNLURUFVSGUJNoAND52tBbLgwFlQCjv6lGnI+kmzMhB64ARtvgKYfKG9H/?=
 =?us-ascii?Q?EjlNqm9qB836EylBjfLQydKVRFHcfKGYDm5jci0aUPgEDoDCl++ZBHJfjQR5?=
 =?us-ascii?Q?qHraefy0lHwviopojdjQXYZKnUHA9OZKi4VRh5K2RR8OmtRH3car3/kRxokj?=
 =?us-ascii?Q?lXe3AAEsrkKu1AUWS49Ka93aAGp5+qXGXnvn3rpbhjMGwDL90wE0FkssWoJb?=
 =?us-ascii?Q?4D8g70uKoupt0f17Ph3NAY9JrpDCO1ik/Vcxl04TMrMKWQlB7xwfA8qlyR6S?=
 =?us-ascii?Q?AsNhoRNn0rkue/0Keyywrq9ET6ooDt4bi2cEvhuQ+mIjhbX4rq0SbHzttamf?=
 =?us-ascii?Q?m7rPfO2cKb1RViQ8CbkNYfegKJeqXGjDw5paNggaJvw2BC2eEZf+7M4tLuKj?=
 =?us-ascii?Q?g082HNDQg2z/iYajB4AA6fP5Fh//BYVeiAjXko7hXl8NPfjUbEtYZxuilFMe?=
 =?us-ascii?Q?fuu17Sj95RF1cmrGL8ouptZgQWkCpcHJcH6e/7ZaA2Z1m2o77gMIpnSe5eKQ?=
 =?us-ascii?Q?9g0CVUtyAeskaA845H0TfmKH33O+ZbCny00eb5RHcc3A8xbZgtjzJTBAhMVY?=
 =?us-ascii?Q?bF9MzLKayctEe053jVd0HQaRnGOhxEI8mSHRUzmF6HV4LbGzcBf7bD1f4oqV?=
 =?us-ascii?Q?mf5z3bJZwMmbKujMCxJhkvYq6ZwqzLxBxK8yksu1ko4ECjMoB9qC4Udrz4X5?=
 =?us-ascii?Q?B6mSX/LVWHKHtnFeDHZTKwQ3u+sVCVux/6cmBHxzRTGj0KKL7f1gq1kEK9Lx?=
 =?us-ascii?Q?aqqlHKYPJtT0durCIimtFLBgKrg1yyh7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cn78Pl19+HgrfYc5f6IUhJhtoDxyMG4kic+ixx+u3BuiN7JbQfumCWaWfCcS?=
 =?us-ascii?Q?MWQwpIbAkcYRNOBB0LSTynN2IYBHNoLXShcMNhxXrP/TvL1Ko3Rn8p+ZVwy6?=
 =?us-ascii?Q?01iehtIIRgyYbjYrTjL15MybXFN1gMSaaTZpg2MqpQTzIY3FwSve/hSZkeuy?=
 =?us-ascii?Q?oT2H2sTpi+WdHlVZV+vb8nk+gcKj6BKdZsWrdpI6H06uhyukb+XcrQxIye8W?=
 =?us-ascii?Q?GZ4pHg1v5fVJzTJGb5CVA/iQCjiVJWDAuBas5bFFfcyl9FhxvWYvoB1i3gpI?=
 =?us-ascii?Q?R8ps+YVbqjgZ3x8TYvB/DTVZot7+OglHk4Y9dTIfR4TZCYMzZJgoJlJy6kd0?=
 =?us-ascii?Q?AMbKcT+YIIBFMSU5Lxss+uNULPUzFm0ir7RbDYvDRm+axqH4CypypALs9An6?=
 =?us-ascii?Q?l/2q15BzRZ6rPMiOYb1ZVlLLEXF38VY/kYfI92KZ6zyqy9ZUy4cbPDN0YbnG?=
 =?us-ascii?Q?+r5P6mLOf4OVxK4Xo90C7rQodBKYaa62GUVDzjxBl0cKeXUDGsW4P2Lq8Mmn?=
 =?us-ascii?Q?72rdY01L2on/gxPCZdmdai63/CTM5Bh0TIo8cpaWbIZ8NqbozwXRexP3aaq8?=
 =?us-ascii?Q?vYa/AugyzkAPgLdZ2A6FWoVdGdbxSMNb0vh4P5Zr7M0RvPm3AtHXjXpbUSbY?=
 =?us-ascii?Q?nGDdcEvzdnXxmg5IJOyxTfv+KcuYwC8CNgZY4idit/3JKaRk5KYN861U8qCt?=
 =?us-ascii?Q?4rNWDju4QMddhvi02U8HddNVjTbE+rI+mFKok3iMQwSnQs2ySK7pT9BNBC0l?=
 =?us-ascii?Q?yKH9FKyoIFOpkl0WQlkOocaU3EbCEJnHfGe9fs3E3YgeiSgNe6z5p3X3qTuT?=
 =?us-ascii?Q?5LvQnvLvEGRgQUrHaOoH1jaFWclY5QKy7m86JQzx3xt276Wv6fxTP0+EXCVm?=
 =?us-ascii?Q?GKYfxsvCPNnqh8rOzc+thiA3YJ/5kxSli88GyEKXb+mjSo71e0nuRqudU6IA?=
 =?us-ascii?Q?snjmcBFd2zlKJ115F2fiyGtv5US+wnswTOZBifg1NvR0xRqR66Y8k3wS3t+x?=
 =?us-ascii?Q?AkwoTJLRR7hbMB0Q6NWOAAAstnuaZQLnHmPv1EzXd3/eURtbO6q6yWfgsg7K?=
 =?us-ascii?Q?JrimWlrYLY9ZbNKu4iAsjzdWM9E0GGed7YmuHOQjg/YDtb9NVVurdG6goG4g?=
 =?us-ascii?Q?SHJ7ZPfjHR7/hCfoZJ9KoVY76z+GeMbrlkg+dXqggRY5/BFXcRKHr3hgE3Gi?=
 =?us-ascii?Q?nzDEAkUYWUiKe097609Vb3gJj83TtH92qmDyJRwOWdLZhSu2DYyhiBKtoWGi?=
 =?us-ascii?Q?/BDfyukLzxvEqAckhUoJJmj+fPod3nO0BPMr+r2BJSjkZec6JO7ZjpO6z6B9?=
 =?us-ascii?Q?/eiW9PSRUvQ/Jz8KrBmwCR5OHYwFeQToJVPs60EnxFlrWSglY9Sa6kBr7uRR?=
 =?us-ascii?Q?9NRfruJIkxcTInh6IV2s2VAL2XXHQjWyJ4misjKoTRNssiXL5P7XZmpXKgiG?=
 =?us-ascii?Q?MWDoVFgpBv3Llw6H4rFonZ5AO8iHKSBpa8fX8oGWBJZuiudlGvCk5qDZPVR2?=
 =?us-ascii?Q?GT3Wn+4xA8TxIkwRoxTka6gPE3p5EgimTPAgs2x6qXhy4e/v8uC06U48yxSi?=
 =?us-ascii?Q?S+196QAqahFuYt8GyWrAxePztaZwEvDtY0YytEH/uz1d/8QtxaZ0S7JGCveQ?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a552e63-50fe-44e0-46ae-08dd5319b3d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:20:01.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULkqy0qjXKor+WSqLqM3PpdA4zLxy+oyr7KbR9khz7e8lO00P+p7nM8EXmetFarYOAWurpyGnK16HOQxLJcTjwKk+0rgt2V9vHOwQ6CfduE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13296

Hi Rob,

Thanks for the feedback.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 21 February 2025 23:19
> Subject: Re: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Documen=
t RZ/G3E support
>=20
> On Fri, Feb 21, 2025 at 05:53:43PM +0000, Conor Dooley wrote:
> > On Thu, Feb 20, 2025 at 01:04:18PM +0000, Biju Das wrote:
> > > Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047)
> > > SoC, which supports up to six channels.
> > >
> > > The CAN-FD module on RZ/G3E is very similar to the one on both R-Car
> > > V4H and RZ/G2L, but differs in some hardware parameters:
> > >  * No external clock, but instead has ram clock.
> > >  * Support up to 6 channels.
> > >  * 20 interrupts.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v1->v2:
> > >  * No change.
> > > ---
> > >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 67
> > > +++++++++++++++++--
> > >  1 file changed, 62 insertions(+), 5 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > index f87f90f431e5..189d5303ad75 100644
> > > ---
> > > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.y
> > > +++ aml
> > > @@ -42,6 +42,8 @@ properties:
> > >                - renesas,r9a07g054-canfd    # RZ/V2L
> > >            - const: renesas,rzg2l-canfd     # RZ/G2L family
> > >
> > > +      - const: renesas,r9a09g047-canfd     # RZ/G3E
> > > +
> > >    reg:
> > >      maxItems: 1
> > >
> > > @@ -59,6 +61,19 @@ properties:
> > >            - description: CAN1 error interrupt
> > >            - description: CAN1 transmit interrupt
> > >            - description: CAN1 transmit/receive FIFO receive
> > > completion interrupt
> > > +          - description: CAN2 error interrupt
> > > +          - description: CAN2 transmit interrupt
> > > +          - description: CAN2 transmit/receive FIFO receive completi=
on interrupt
> > > +          - description: CAN3 error interrupt
> > > +          - description: CAN3 transmit interrupt
> > > +          - description: CAN3 transmit/receive FIFO receive completi=
on interrupt
> > > +          - description: CAN4 error interrupt
> > > +          - description: CAN4 transmit interrupt
> > > +          - description: CAN4 transmit/receive FIFO receive completi=
on interrupt
> > > +          - description: CAN5 error interrupt
> > > +          - description: CAN5 transmit interrupt
> > > +          - description: CAN5 transmit/receive FIFO receive completi=
on interrupt
> > > +        minItems: 8
> > >
> > >    interrupt-names:
> > >      oneOf:
> > > @@ -74,15 +89,33 @@ properties:
> > >            - const: ch1_err
> > >            - const: ch1_rec
> > >            - const: ch1_trx
> > > +          - const: ch2_err
> > > +          - const: ch2_rec
> > > +          - const: ch2_trx
> > > +          - const: ch3_err
> > > +          - const: ch3_rec
> > > +          - const: ch3_trx
> > > +          - const: ch4_err
> > > +          - const: ch4_rec
> > > +          - const: ch4_trx
> > > +          - const: ch5_err
> > > +          - const: ch5_rec
> > > +          - const: ch5_trx
> > > +        minItems: 8
> > >
> > >    clocks:
> > >      maxItems: 3
> > >
> > >    clock-names:
> > > -    items:
> > > -      - const: fck
> > > -      - const: canfd
> > > -      - const: can_clk
> > > +    oneOf:
> > > +      - items:
> > > +          - const: fck
> > > +          - const: canfd
> > > +          - const: can_clk
> > > +      - items:
> > > +          - const: fck
> > > +          - const: ram_clk
> > > +          - const: can_clk
> > >
> > >    power-domains:
> > >      maxItems: 1
> > > @@ -173,7 +206,9 @@ allOf:
> > >        properties:
> > >          compatible:
> > >            contains:
> > > -            const: renesas,rzg2l-canfd
> > > +            enum:
> > > +              - renesas,r9a09g047-canfd
> > > +              - renesas,rzg2l-canfd
> > >      then:
> > >        properties:
> > >          resets:
> > > @@ -187,6 +222,19 @@ allOf:
> > >        required:
> > >          - reset-names
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            const: renesas,r9a09g047-canfd
> > > +    then:
> > > +      properties:
> > > +        interrupts:
> > > +          maxItems: 20
> > > +
> > > +        interrupt-names:
> > > +          maxItems: 20
> >
> > Should these be minItems instead of maxItems? The list has 20 elements
> > at the moment (right?) so you're not adding any restriction here.
>=20
> And the existing platforms need to have 'maxItems: 8'.

OK got.

platform 1: Here one of has min/max 2 interrupts. Platform 1 has 2 interrup=
ts
        interrupts:
          minItems: 2
          maxItems: 2

Platform 2: Here one of Has min/max 8/20 interrupts and platform 2 has 8 in=
terrupts
        interrupts:
          maxItems: 8

Platform 3: Here one of Has min/max 8/20 interrupts and platform 3 has 20 i=
nterrupts
        interrupts:
          minItems: 20

Cheers,
Biju

