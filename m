Return-Path: <linux-can+bounces-4334-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDCCB32062
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12E9173E6A
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F192441A0;
	Fri, 22 Aug 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XRuhFTPB"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCA265623;
	Fri, 22 Aug 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879569; cv=fail; b=IXheR+6HgxzYchzyJA2DCOGiFfBF6PwTPp9/ntbPPFDbUp2EfaTQJzgQbKvKHpvgEpzwjtfJdaE1eZ+AclP9NOe85k16ArN84NVUWeUYyd0mKSLJhJ0X2b2qzT0J6qzQC5YWpaoEVBY4OjQ84LSqGiKTWciPA7cbSEnuk7QyAb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879569; c=relaxed/simple;
	bh=i0hz326cZkVO9/e273GAjnrdy7YOz+yDnjRVtEdZfuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHpsJy/HKCOhmNU13ne1NlRaM4rpuc+3+zmL3dvBpr9j7vUTGLCBWqceT012weRk+qEt+INhGwD0dCkQFlQ+lWlRJFLtTGtTBy4aCUAYBJ0LKjQWgftnJ0hxdEZc0akGA34pwKVSvXFu9iF+NtTmHv3vnJ8kOKNBAnPPl8KefrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XRuhFTPB; arc=fail smtp.client-ip=52.101.229.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpQ7dr9Z80Z7GgN1/Eud+fax2Aik68kxdGWStQ3nunge58wsJvkreQiTRzHS0RrLjAeIvuVPI1B+hR9XEDoQSEWrBantrFQctYYRqZsoe6eyqT7U/ETTDhACk4SqkZ04ZQF1eC1NJeD8kxOA7zT7a5OBMsqoORjyOnlUykjIQAUe7Ej3Hk16JQX1rb6/MU12cjVmVZCWqMb4qqU876UYjKpMeNAkdWUJHsCzV1pn4xcT8tm0C2onUATTseu2N8X5IwTvSGi5NYfGjABWCr8VTDvx/Vie+rG1U9VypxY8c1udwlMuNN5LfIPqJdSWuRuesEqf7MkxHOHr4aSQom3rzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gl1aeg9xgPvCrm2p3aXNUPmCmspjaIlMLSwSY1u2QI=;
 b=ge0u3T9nfy1C1ioz4l/hSSMQ10kGCpKPGjoWDHWViFcCVJBhJLNpiojz6a2XeP8yzBtyd7EWSE58TtN9cXSs5B4/pqyKeuWb3CR++Yf+vt+b3UABXOb5quDyiqS8VrdKyznRUQ9n+ZI+3NQ+rDcMyhqg+jP01BLJddDR7BUgGsOhuYUewBH6Zi0hVw2g36pVsbw/5Ot+l1hTaKuzA/jx1almbAW9OrNKr3SJ2WccaSphpBNmV8UgnNt/A/eyFYYIP2pKGmxTcdi7tMW1zsIC5xKDkbl+Edgxuv76Lyh4naYz7g0no2yb5NYnPJf70w14Mp7X+rGejcImlNJ5LZAX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gl1aeg9xgPvCrm2p3aXNUPmCmspjaIlMLSwSY1u2QI=;
 b=XRuhFTPBwiUtrZW1dX4VfeG/2EDdbXlQPTOAonFwNxomoifr5n5ewZIjm81KKQiL3Cf3pk+zYBwdylLC9eM7DY2uhWwNKNyn8fanl58kbnhAvQem2gM2i5Isl/bbdP2vYo19h8qjc+w+UxxV7tqMo10EAcPiwlmBH6z5gpo/9LI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB16048.jpnprd01.prod.outlook.com (2603:1096:604:3db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 16:19:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 16:19:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Topic: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Index: AQHcE0pKZp7DWIl5uU6P5IZbLCRQZ7Ruq/zQgAAth8A=
Date: Fri, 22 Aug 2025 16:19:21 +0000
Message-ID:
 <TY3PR01MB113463800F4EBB1762FE96DBF863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
 <TY3PR01MB113463B58C2110A8BC108072A863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113463B58C2110A8BC108072A863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB16048:EE_
x-ms-office365-filtering-correlation-id: 4c585336-f3e8-4add-1e8f-08dde197a748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ca+wEg0XoL/rlIaKhnIisvxaJSJ5dKDVZj1pWCAhLMG0V/rwyXPofPXjnvVI?=
 =?us-ascii?Q?zRrfJn6EcIWWBoWkfYlezmXfR7in2FkY/bDwcMmXcycQ3B1P4w4Hp25GG7dy?=
 =?us-ascii?Q?WeN21KoQyAC+in5R1i96RhwNmLrgev+D5DIzfkSgxXgr05Ies9xO2YYafsbv?=
 =?us-ascii?Q?nb8ipiSkqJbwZqVbOuhZbIZ9M1HB2YhPqVvyN5N3+d0tCIViUxIJRVAhoywU?=
 =?us-ascii?Q?kjFI8sZomH45goi3HK6cMlQuPbRNsLz92qGi/lM0vh0CaCr06OxXPQ7K0Dn5?=
 =?us-ascii?Q?qK44KX1FpI9/6/6GKEdUYQOn8zVE+Jd4zVliHY+fzwtB5PWQccs2SfPEv7lS?=
 =?us-ascii?Q?ud07dEQH7eDWLK7+3h5wfIfcxVeMB+H8ebZuHC+bxy+tLP3CZxurVKMUTOOm?=
 =?us-ascii?Q?w5zrW5+RIrjWxBxGD6aGIlBgWAuP6pgFnEFu/8pZs4Vax0VmA0ezxg6+iZL6?=
 =?us-ascii?Q?iN7bjDwb6c8Oi5tSmPL+wxiB2hOEI43ILHKH/w8r1etpafCqMEmfDUmxnevE?=
 =?us-ascii?Q?A53rO6ymuKr5AL7xImZbOOuiE4vKZ3OncIcbuBpxx6ma4lhgaTSvYRSOEVlt?=
 =?us-ascii?Q?hIqQBBd6Li9uB8dnFu6lf3xI6BQRB8qdQVlgHqqbDreSDv8MdrY8za3JqVPN?=
 =?us-ascii?Q?AMcLjjTu79YuzDMvz7mBwMtxL3FjTNEIlggQs9SMveezQvS/9AKvmoBnoQQ2?=
 =?us-ascii?Q?FZaZC84n+rZjgkv9ax85e0IYxsBO5pffO3Oe5RWnHFJ9+NFpWEQh6OdY9S9p?=
 =?us-ascii?Q?+jFQwnyc+rZiStklH1I0yAM3AX/gwQrciQp1M+fYy4gtzutMdB67w5iKvPJ0?=
 =?us-ascii?Q?IbCn+iiOTWKBipM2EGDiiGmAc+pBsZwRRj7+6fcudXp+Me2jTnv7SXFB6o/m?=
 =?us-ascii?Q?ECKVPljjPYoLNmRDtvizFxAS+aOcSCShh130scMlUocmJxfWkJFyeUzIH5KR?=
 =?us-ascii?Q?948cpH+eMog/wS7pMTwU2JXK7Xn5yfp9aLru53wMazKgXM4xg94V0rDXtfO0?=
 =?us-ascii?Q?NJm5oYqie4ikI8whAiP1GhFLn61aX6IZdWWnEkBeffEbNbMlbHD6JNahsvRK?=
 =?us-ascii?Q?vL/BFDL8EN8mKLhswqdwKop127YeGdS6tP6+QG25+/U/qfz0bPt0n4iF380R?=
 =?us-ascii?Q?K6jvihWWBS2gZulrt3OYRAe+xrrCd2mBf6DiDdzKv6sZB7WEZQt54GBi+My1?=
 =?us-ascii?Q?p2PNhR2qvOvgCV4nBtQz4jkDF0Eg00atfMHwcH88R+wkTlwGHtOfUDLZbOLR?=
 =?us-ascii?Q?m+dLGs5bZCtKb9v9TglBdLN1lZg4UlXjk3FTTifwQMPM4cfE8pTKCkxCcnsZ?=
 =?us-ascii?Q?vInp1ZtmsqE4cASDU9dA7v2bDT/zxDmesK4gab0KylkQCyEAYIGoOGMv5KiD?=
 =?us-ascii?Q?WnUqgUKIX7WCUdihVj7C/N1b4ZzHXk9xWQ3Dqj21EsH+VqS0Cs5tEFh/Hef+?=
 =?us-ascii?Q?myevKpR2vySEt8FJ8Ee2Frk1bEsDHEpGNSy3qumFcWFCKV1Kco0Y5KxLcBWB?=
 =?us-ascii?Q?WdIh99vEJOx2wDc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RDUhmtooPzjX2TuRXXy1XnSccQDfche8opO6jlHUNlihE0QCsnr7Fw4ZXflP?=
 =?us-ascii?Q?4jIivTQdcGAj3gp7zsgkZcQzlCRYKYKgMrxMI0o/iosb7nuSOnknKIWF1F37?=
 =?us-ascii?Q?9eahZN2A6mqmBO1gOZXLYf7U6WoipsU4Kv25cOGzy/J9VwVOztZWtjorSmFm?=
 =?us-ascii?Q?ViTecsRRWHK8VLGDN5RChZsr5O0xV2QrFrf8DSqsB++KuXXtJVAQypX0zM/o?=
 =?us-ascii?Q?SwHnkz3rdHWJs3r3CISL/cEu4FZqtQsJX9igJv0r1cfZ8PXRKfdUxhbymSmF?=
 =?us-ascii?Q?p771xbWWCbdpKNRovbr4O+JgUAgErsXQWTgUiQyXGFTkwekUcDEqTHZQnfJ9?=
 =?us-ascii?Q?m3ANUgO2/YUDx7DsDRDz7EC6RAPnvkrvuZobmKRfUnRURoDYSWf3JeFAsGWC?=
 =?us-ascii?Q?Xg8m7fhViWGCBOv20Qkr4MZJA8HVhCWJWasVFZBvVp6pGsLW2nfNdknvxC9a?=
 =?us-ascii?Q?yLlmow6EK/dQAYvBnTQDtu0suCAF2LlArPNiN5uaTIieByqQK3Tqe6tDPriz?=
 =?us-ascii?Q?TYp2azRotpBd+wKSIKYlPmJX/3qj9OVMm6SjSLjQBKK2eyd+ZRgMX2x/kcia?=
 =?us-ascii?Q?BQbobcOkzaQNX2V6NtvMZblDwaEeyLl0yngjY1WLkeHQQPrNBXdy1MJ/XAB8?=
 =?us-ascii?Q?pjs4lK6u6NBJSxfDiamHm9KpVfe3CRvvmyYDb1gfhA8P92IglQBlLdbY2Flf?=
 =?us-ascii?Q?BqYiCccMx3QBd0CY9DDzZfglms45Px6pPqa41gcblM3h6QXTqnEUA2m/+fck?=
 =?us-ascii?Q?FmmUbbVXXMff8zjZnRGLk7j/B4cnWyGR2W5lQKisPVdxXnrnLMJ2zYmEN/uG?=
 =?us-ascii?Q?wHLCI2D0KzcemlQfY+IF8bbFydsX/XlGhz6l+b3DRkOblvwmdev350X+NBeN?=
 =?us-ascii?Q?MObCG28Q/iNDOiIGP1/ZS4PbvXKegpDLv/1uZpYNYx9p+5BoXe0lKNWhvo/a?=
 =?us-ascii?Q?ppo1fp486DeP/5w8fe9ZUQ/ONc1js69yVjWoA5BD6KD7FVmhMAsv61J2Rvis?=
 =?us-ascii?Q?0B7cxFJDxQYl1yYEToN6nqZjv7kwwN0RMe0jSxPH9sUCE41Lw9bBQJLEV97x?=
 =?us-ascii?Q?U9Bf82haW1SJigVTixgERRbe7x7G7veV0MibxtA6pmVia2Xh59GuRC1p3nIX?=
 =?us-ascii?Q?+NmnXXmeb2EgwpPh6ZDTaeehbmeFVTdGksZKUGdCfdVpi+xgBgeTsUW1VAoh?=
 =?us-ascii?Q?AcVpnEzJLKWA9AOJgDzY3JFmYtbzET0v47iJsbh805R+kOA/m7HaUgA93FSz?=
 =?us-ascii?Q?SpDe13U331DzntAhy+JGRhDCDYpEfGpY++Z80SO60CLgjM6e7H/qUG4/cWlW?=
 =?us-ascii?Q?/pIK3/9GN60r8HGpkUWMTW6m7xuOeKs876QxPZUFEjINblxv5xSBU2ct4Gxh?=
 =?us-ascii?Q?rm9vzmf4CBioz36UC66VkWR6oJnz7gCcdXlY9heUsAlU2DMwGYv0okhd62K+?=
 =?us-ascii?Q?z/APNCF0cFfY+arJKjasqFUsb5RGvagmMY1ISyiEVwygfj23UZLb/WG4AXs6?=
 =?us-ascii?Q?WK1wdUhdkLlF0RVILtq4jBXgAQGK3a0n8psDj7uOQIovdRuh+JYMPsPQHYSA?=
 =?us-ascii?Q?0pA+lKti2FR3VS81VY1T+Pe46ejj1Ccvbhq6xoQOYh9UO6qxjChSibGFZir+?=
 =?us-ascii?Q?tQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c585336-f3e8-4add-1e8f-08dde197a748
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 16:19:21.9225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/j4voSUBf403CWsobb8EDT3XwYKWjo6/oFb+go5G+MGyaf32dK/nFu25Kaxj/69Fhw4xbkrBvzL2TDTQgXvOcoiqOSRBGEqhm33NpWQob4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16048

Hi Geert,

> -----Original Message-----
> From: Biju Das
> Sent: 22 August 2025 14:40
> Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
>=20
> Hi Geert,
>=20
>=20
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Sent: 22 August 2025 10:51
> > To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr>; Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: linux-can@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > Geert Uytterhoeven <geert+renesas@glider.be>
> > Subject: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
> >
> > On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume,
> > the CAN-FD interface no longer works.  Trying to bring it up again fail=
s:
> >
> >     # ip link set can0 up
> >     RTNETLINK answers: Connection timed out
> >
> >     # dmesg
> >     ...
> >     channel 0 communication state failed
> >
> > Fix this by populating the (currently empty) suspend and resume
> > callbacks, to stop/start the individual CAN-FD channels, and (de)initia=
lize the CAN-FD controller.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > While this fixes CAN-FD after resume from s2ram on R-Car E3
> > (Ebisu-4D), it does introduce a regression on R-Car V4H (White Hawk):
> > after resume from s2idle (White Hawk does not support s2ram), CAN frame=
s sent by other devices are no
> longer received, and the other side sometimes reports a "bus-off".
> >
> > However, the underlying issue is pre-existing, and can be reproduced
> > without this patch: the CAN-FD controller fails in the same way after
> > driver unbind/rebind.  So something must be missing in the (de)initiali=
zation sequence for the R-Car
> Gen4 CAN-FD register layout.
> > Note that it keeps on working after ifdown/ifup, which does not reiniti=
alize the full controller.
> > ---
> >  drivers/net/can/rcar/rcar_canfd.c | 53
> > +++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c
> > b/drivers/net/can/rcar/rcar_canfd.c
> > index eedce83b91414c57..6b0c563e894f74b3 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -2236,11 +2236,64 @@ static void rcar_canfd_remove(struct
> > platform_device *pdev)
> >
> >  static int rcar_canfd_suspend(struct device *dev)  {
> > +	struct rcar_canfd_global *gpriv =3D dev_get_drvdata(dev);
> > +	int err;
> > +	u32 ch;
> > +
> > +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels=
) {
> > +		struct rcar_canfd_channel *priv =3D gpriv->ch[ch];
> > +		struct net_device *ndev =3D priv->ndev;
> > +
> > +		if (!netif_running(ndev))
> > +			continue;
> > +
> > +		netif_device_detach(ndev);
> > +
> > +		err =3D rcar_canfd_close(ndev);
> > +		if (err) {
> > +			netdev_err(ndev, "rcar_canfd_close() failed %pe\n",
> > +				   ERR_PTR(err));
> > +			return err;
> > +		}
> > +
> > +		priv->can.state =3D CAN_STATE_SLEEPING;
> > +	}
> > +
> > +	/* TODO Skip if wake-up (which is not yet supported) is enabled */
> > +	rcar_canfd_global_deinit(gpriv, false);
> > +
> >  	return 0;
> >  }
> >
> >  static int rcar_canfd_resume(struct device *dev)  {
> > +	struct rcar_canfd_global *gpriv =3D dev_get_drvdata(dev);
> > +	int err;
> > +	u32 ch;
> > +
> > +	err =3D rcar_canfd_global_init(gpriv);
> > +	if (err) {
> > +		dev_err(dev, "rcar_canfd_open() failed %pe\n", ERR_PTR(err));
> > +		return err;
> > +	}
> > +
> > +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels=
) {
> > +		struct rcar_canfd_channel *priv =3D gpriv->ch[ch];
> > +		struct net_device *ndev =3D priv->ndev;
> > +
> > +		if (!netif_running(ndev))
> > +			continue;
> > +
> > +		err =3D rcar_canfd_open(ndev);
> > +		if (err) {
> > +			netdev_err(ndev, "rcar_canfd_open() failed %pe\n",
> > +				   ERR_PTR(err));
> > +			return err;
> > +		}
> > +
> > +		netif_device_attach(ndev);
> > +	}
> > +
> >  	return 0;
> >  }
> >

STR is now working on G3E based on BSP code with the following modification=
s[1]


[1]
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_=
canfd.c
index adf73d6238a1..89a1bc73c1af 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -469,6 +469,7 @@ struct rcar_canfd_global {
        struct platform_device *pdev;   /* Respective platform device */
        struct clk *clkp;               /* Peripheral clock */
        struct clk *can_clk;            /* fCAN clock */
+       struct clk *clk_ram;            /* Clock RAM */
        unsigned long channels_mask;    /* Enabled channels mask */
        bool extclk;                    /* CANFD or Ext clock */
        bool fdmode;                    /* CAN FD or Classical CAN only mod=
e */
@@ -2158,7 +2159,7 @@ static int rcar_canfd_probe(struct platform_device *p=
dev)
                gpriv->extclk =3D gpriv->info->external_clk;
        }
=20
-       clk_ram =3D devm_clk_get_optional_enabled(dev, "ram_clk");
+       gpriv->clk_ram =3D devm_clk_get_optional_enabled(dev, "ram_clk");
        if (IS_ERR(clk_ram))
                return dev_err_probe(dev, PTR_ERR(clk_ram),
                                     "cannot get enabled ram clock\n");
@@ -2262,20 +2263,15 @@ static int rcar_canfd_suspend(struct device *dev)
                if (!netif_running(ndev))
                        continue;
=20
+               netif_stop_queue(ndev);
+               rcar_canfd_stop(ndev);
                netif_device_detach(ndev);
-
-               err =3D rcar_canfd_close(ndev);
-               if (err) {
-                       netdev_err(ndev, "rcar_canfd_close() failed %pe\n",
-                                  ERR_PTR(err));
-                       return err;
-               }
-
-               priv->can.state =3D CAN_STATE_SLEEPING;
        }
=20
-       /* TODO Skip if wake-up (which is not yet supported) is enabled */
-       rcar_canfd_global_deinit(gpriv, false);
+       reset_control_assert(gpriv->rstc1);
+       reset_control_assert(gpriv->rstc2);
+       clk_disable_unprepare(gpriv->clkp);
+       clk_disable_unprepare(gpriv->clk_ram);
=20
        return 0;
 }
@@ -2286,30 +2282,71 @@ static int rcar_canfd_resume(struct device *dev)
        int err;
        u32 ch;
=20
+       err =3D reset_control_deassert(gpriv->rstc1);
+       if (err)
+               goto fail_dev;
+
+       err =3D reset_control_deassert(gpriv->rstc2);
+       if (err) {
+               reset_control_assert(gpriv->rstc1);
+               goto fail_dev;
+       }
+
+       /* Enable peripheral clock for register access */
+       err =3D clk_prepare_enable(gpriv->clkp);
+       if (err) {
+               dev_err(dev,
+                       "failed to enable peripheral clock, error %d\n", er=
r);
+               goto fail_reset;
+       }
+
+       /* Enable RAM clock */
+       err =3D clk_prepare_enable(gpriv->clk_ram);
+       if (err) {
+               dev_err(dev,
+                       "failed to enable ram clock, error %d\n", err);
+               goto fail_reset;
+       }
+
+       err =3D rcar_canfd_reset_controller(gpriv);
+       if (err) {
+               dev_err(dev, "reset controller failed\n");
+               goto fail_clk;
+       }
+
        err =3D rcar_canfd_global_init(gpriv);
        if (err) {
-               dev_err(dev, "rcar_canfd_open() failed %pe\n", ERR_PTR(err)=
);
-               return err;
+               dev_err(dev, "controller init failed\n");
+               goto fail_mode;
        }
=20
-       for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channe=
ls) {
+       for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS) {
                struct rcar_canfd_channel *priv =3D gpriv->ch[ch];
                struct net_device *ndev =3D priv->ndev;
=20
                if (!netif_running(ndev))
                        continue;
=20
-               err =3D rcar_canfd_open(ndev);
+               netif_device_attach(ndev);
+               err =3D rcar_canfd_start(ndev);
                if (err) {
-                       netdev_err(ndev, "rcar_canfd_open() failed %pe\n",
-                                  ERR_PTR(err));
+                       netif_device_detach(ndev);
                        return err;
                }
-
-               netif_device_attach(ndev);
+               netif_start_queue(ndev);
        }
=20
        return 0;
+
+fail_mode:
+       rcar_canfd_disable_global_interrupts(gpriv);
+fail_clk:
+       clk_disable_unprepare(gpriv->clkp);
+fail_reset:
+       reset_control_assert(gpriv->rstc1);
+       reset_control_assert(gpriv->rstc2);
+fail_dev:
+       return err;
 }


[2] logs

root@smarc-rzg3e:/cip-test-scripts# [   36.691587] PM: suspend entry (deep)
[   36.695460] Filesystems sync: 0.000 seconds
[   36.704009] Freezing user space processes
[   36.709820] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[   36.716809] OOM killer disabled.
[   36.720049] Freezing remaining freezable tasks
[   36.725879] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   36.733327] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-169-g1410189b0
NOTICE:  BL2: Built : 12:53:12, Jul 15 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[   36.759719] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   36.818341] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   36.832139] Disabling non-boot CPUs ...
[   36.836762] psci: CPU3 killed (polled 0 ms)
[   36.843491] psci: CPU2 killed (polled 4 ms)
[   36.852615] psci: CPU1 killed (polled 0 ms)
[   36.855973] Enabling non-boot CPUs ...
[   36.856187] Detected VIPT I-cache on CPU1
[   36.856231] GICv3: CPU1: found redistributor 100 region 0:0x000000001496=
0000
[   36.856268] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   36.857067] CPU1 is up
[   36.857163] Detected VIPT I-cache on CPU2
[   36.857185] GICv3: CPU2: found redistributor 200 region 0:0x000000001498=
0000
[   36.857205] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   36.857783] CPU2 is up
[   36.857878] Detected VIPT I-cache on CPU3
[   36.857901] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a=
0000
[   36.857923] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   36.858631] CPU3 is up
[   36.875320] dwmac4: Master AXI performs fixed burst length
[   36.876219] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[   36.876241] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[   36.879753] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[   36.897118] dwmac4: Master AXI performs fixed burst length
[   36.898009] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[   36.898026] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[   36.901567] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[   36.948005] usb usb1: root hub lost power or was reset
[   36.948012] usb usb2: root hub lost power or was reset
[   39.107397] usb 2-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 u=
sing xhci-renesas-hcd
[   39.294764] OOM killer enabled.
[   39.297903] Restarting tasks: Starting
[   39.303378] Restarting tasks: Done
[   39.306841] random: crng reseeded on system resumption
[   39.312209] PM: suspend exit
[   39.502581] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Ful=
l - flow control rx/tx

root@smarc-rzg3e:/cip-test-scripts# ./canfd_t_003.sh
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
[   48.400817] can: controller area network core
[   48.405291] NET: Registered PF_CAN protocol family
[   48.445879] can: raw protocol
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 500000 and dbitrate 2000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
 [INFO] Testing can0<->can1 with bitrate 250000 and dbitrate 1000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
 [INFO] Testing can0 as producer and can1 as consumer
[   69.411870] kauditd_printk_skb: 5 callbacks suppressed
[   69.411883] audit: type=3D1334 audit(1755879165.759:22): prog-id=3D18 op=
=3DUNLOAD
[   69.423995] audit: type=3D1334 audit(1755879165.759:23): prog-id=3D17 op=
=3DUNLOAD
[   69.430946] audit: type=3D1334 audit(1755879165.759:24): prog-id=3D16 op=
=3DUNLOAD

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

root@smarc-rzg3e:/cip-test-scripts#

