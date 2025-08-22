Return-Path: <linux-can+bounces-4331-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15770B31C5E
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A631CC1CBF
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CB3054DD;
	Fri, 22 Aug 2025 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JPkvLRkS"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010038.outbound.protection.outlook.com [52.101.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAB2BDC33;
	Fri, 22 Aug 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873492; cv=fail; b=sXa/gH+725s/sil/IoePauD/XfMVXTFZZDjjCkV00pfeailI+s/XiEUD8R3pV4qO4g3AhUIUWQt6hMLZ/2coUPwVj8MOEX5OIg4u5hh4I2xQ95Fead1lH475Jc6betmMq4i1PQ3S9Ckx3vE6psTyKODLQ9u74xtwzhnNYl3maSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873492; c=relaxed/simple;
	bh=De/9vsakmWc/DemnQpA7aDrmSJq0e7x3genJCHlmNT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSR/pcRghSv2jCdT07sd4j0jjC93etpNArgKzv6MDUPGGLbomJ5Nag22/DDoabB8p1uf6nfqPACnDH6Xn/G3AxHhpKQsjFT7Ptb9DgpuNyscpi3hXWzq0I70jG3NpciHTNEV47vYZDNNCM+W6e8VoGf1IXGpg+KrF+/DHurkQZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JPkvLRkS; arc=fail smtp.client-ip=52.101.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sofHJd63U9ihiskC3NbqAuim3vD+Nq7EneH+6do9df2D+w7mB7z2duIPnkZiCnerNiJifuefbfJTqamtx4TASdt57eZuxCnk0eA85oYpmKAoA3IFzwhx3ANxpfc3TTmNeOxBNvkMcAaC/dbz2uNaEQsVCVoFh8VHj8pYTHyM+zw3PrhX+GY5H+lL2UMPxbMfTXtKoFLR384I/3t1wfjpAfiUV0Qu5Q6auw9+XD5FwsfGXe7XmD8EvQooHuBYXjynNTk9y4/+EVjxINVv5hx1iz+XKhdugUHLgVjRV6ppuvWdc4TdpCnPcryYpaqbc49geGmkkkWTw8CckIfexF3WYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA8i9xVQ8HhO3VP3Qw+PIIn+w6s2VWI6HoFpA6BX4kw=;
 b=g0ZH8AGn0mmyGhiSJQZbbrh+9eDu0tgsaC4t/Y2UlR5cNX8rZIOEi0hE76NuA24y5RTlKNGK+eIqWuqgrMKGm5WNVkjgChoTOk8dTob0AWE9UUOyIdMuMJNnYQ0pw4whg0UzJJXZgFDWk2LQ9JClbEmq5YOlGZIz5zZQFcV7TK1HiEx+C7LaUTknmoGhAoaYA2ds5hifxHs+0FezlfgZ3pxkUH7FJI6Q3Bpa2EE+MmNHg5rSa94Bb0dXrjPHUOg4DzuDsOzmsizb6sy0Twi4p3GVs+ZhQzBNRoBU9380BNN+hKfNVT1+PY0e5ZGwfOWhpEUe2q8v5MTlsE8YoT0shQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA8i9xVQ8HhO3VP3Qw+PIIn+w6s2VWI6HoFpA6BX4kw=;
 b=JPkvLRkSRbB9s2xlRxVUJIfdfs45F81s4dOTTQ8cdT2L/qY725ghpjxo+KMKVFzc8koqqNfZlyAzSOfVxmu2YXz6Saa1DLwXjK03EULeG34fBuB1YuS3yzVSClEix7y+qL9uq3LV+Zj4Hc5q8K/oLmdR/e7HeA6L2GAQ6Yx/HMs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14442.jpnprd01.prod.outlook.com (2603:1096:405:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 14:38:06 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:38:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 08/11] can: rcar_can: BCR bitfield conversion
Thread-Topic: [PATCH v2 08/11] can: rcar_can: BCR bitfield conversion
Thread-Index: AQHcE05/XDrLUtk9zU6UoZw13tjYGLRuvfxg
Date: Fri, 22 Aug 2025 14:38:05 +0000
Message-ID:
 <TY3PR01MB1134642BAC9147B7A9D5D67CB863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755857536.git.geert+renesas@glider.be>
 <01cfaedba2be22515ba8700893ea7f113df959c0.1755857536.git.geert+renesas@glider.be>
In-Reply-To:
 <01cfaedba2be22515ba8700893ea7f113df959c0.1755857536.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14442:EE_
x-ms-office365-filtering-correlation-id: ea691598-f972-4a04-e0ff-08dde18981b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FkMlpnwFvZ9iN74pjS09uYwzuZaXgwsoEb6K2PwxWgQw9zkETzMk73hv9VAq?=
 =?us-ascii?Q?Ejr/d65XtmDeBAq+94bV0DsLMRrme1d09EUBAbLLTpMGxr4rnKBHv0MAe7Wx?=
 =?us-ascii?Q?/rx5Wts4Al3yUNtbxkEIRt8sQvFee5BDVgTgvAaTKRUE84kP8LZUd8TGyOpQ?=
 =?us-ascii?Q?zEMsOcEv7Y4gwLsAuklXp3X4LGSzaJAA8Cdhhwe/ZXIERwYC8IAZI8jnEI9I?=
 =?us-ascii?Q?Qpc5NCblgybjIqQTCZpEp65W47ZkkqozizFC294eG3/ejzwYlZtcCHyHKfTC?=
 =?us-ascii?Q?K6bJWSTrCzkjgd5USHr0/zvGZT3MujPUIG7dg7s7cLey3CuY++IvkZ7vVWAd?=
 =?us-ascii?Q?jwgvTO3RQjcBTpZtUaQGJMGSBW+KsrM8vfLDO0/AUh343qRxENI3ChMl1q2H?=
 =?us-ascii?Q?Slp68B01RJLWcPsUjBH8KVfeHcS0qfMmNzP3E8wNpWrZ7tazuTnWyIIUiH1/?=
 =?us-ascii?Q?3xekNUdQtGId4rA275NEhMWmCIoODmAYyW8ozKqDnVtA+wNZcxo6iZiUUGH2?=
 =?us-ascii?Q?2mEH/dIcrTcGL8R1iwcgUDmKaMGyMXc95fe80lGJTMvMoe8pi9zsJPZB51wg?=
 =?us-ascii?Q?dYrQhGz9Rn6addDDoWR8A1phWXAS1gAgueIdYIk3s+flB2L5rs0h5b1LYXjT?=
 =?us-ascii?Q?2GpZslB0HHXICRofdY71YgM04fFpTcmiznqh4PvvgHDbl+09T6U0eF75RHEY?=
 =?us-ascii?Q?zOkztKmqRrWMNz4kUEOZLxtbJ9Q/IFRkQ2t0qgKRJf87/x8G0S5aK7M86gAW?=
 =?us-ascii?Q?9zZRf3FZp2yGhfR+c14t2A0euoatEM5C0D4lWFb6YG4vI7czo/oIuzfbAN64?=
 =?us-ascii?Q?zCX3WmaWP9ZqFHVM3mKpc7Zk8nTtFUBtcJRrVkWolqMgxTu/Aq9GqN6orezC?=
 =?us-ascii?Q?omDNy/Ckig3x/6aUeF7p6QXTb1G2IXETGcnNDX3QS2g/T/Mv15BI+J0oWPQc?=
 =?us-ascii?Q?Z2QqitjaPME1y4uwo4B+mcrnUYuxd9whpUqvL5tXKRAOaeBJzHpLAP43FnPh?=
 =?us-ascii?Q?f53jb+yPrFbMSvXA3YuRt6ntSnI3Uy7yy5UFpQnJNaNVYGB5gqaGidZQmTf0?=
 =?us-ascii?Q?CQIYTRlwaekPIMcUDSYS+sDzbxQd7XXTpOPzLXRuPy7VexmIfB9oiSTdeX3s?=
 =?us-ascii?Q?lchqUUfwnV1y8aM1ulbk/fFaHz1wxb9TcMCkUJkTaywTtjMjAHViDspecL1r?=
 =?us-ascii?Q?gU5rz4dOc5wL/rP7QKKUW/7YnqwxqFNwWp1EQE1/cSFHDjFgZUV3kxzY7olC?=
 =?us-ascii?Q?qFkX9UQikp/Hyz9I0cGWuQIM6hHoE2f6CLTVTa+4iCBi5DwIQqdTwkCIqLav?=
 =?us-ascii?Q?omutrsC4xYy/DbvC2My0hRxhJto8BXpn1J/0Vw92DIVuzn3cMAsVQevvisde?=
 =?us-ascii?Q?87solh4MTXea9dMveRX5003KFFehGAqaGrg/ftQZhPuPMAG0ICFlCGJrUwhU?=
 =?us-ascii?Q?GAXGjc+rZxf/gnZIHGDgbkaI6upOCWftIjtopYQck9hZf5LF9YkZLA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N6ns2IhPxfcL81D8zy4dPeLaermjhA3mPGRZji9lI6QinmJusA+MQ+u/W9ge?=
 =?us-ascii?Q?DWF9urPj9Bu3EvoSFe7D9HRbViwRq3GhEdl8B++dxvRJzxndFMDExpxFvS67?=
 =?us-ascii?Q?fPpCNwk3OdQ6j3vAOka4OcPAwKr/bAID2qvamkZ9qn1RolqWc/iG5O7oaq9x?=
 =?us-ascii?Q?9TOw8rrwkSWzS8bD+lrdhj+36CNrWhJDkgIhOMHEeLMXL3i9B5kp5qma51Ba?=
 =?us-ascii?Q?vRwVk6amOj+oPPYbTO7j4AXKcIu9j/vOMCxZyMgNwNEYYQUDJ92c3sSfAcGY?=
 =?us-ascii?Q?EyFEahOMvXTVM2+6ud2BGiRpqe4WAgV6CCgE/cuRTVmd+Xj9U9QnEjrDG5Vi?=
 =?us-ascii?Q?VXXXsnUwJ2k+GUITXIIOx45CDp09TRJZlj4rW6xqnxqseBkrBcfP0y4J4bzq?=
 =?us-ascii?Q?fHUAqSnLwQauObXAHdg8nYnLMyYihgMcFOdxaqULCni0ufBZ/gTde19j/yx8?=
 =?us-ascii?Q?5dLz+IXm96qJpjnVB6NLc1brMR+hp6gOqZ+/XlXVAWs+ZTehu+TJcURUNOEf?=
 =?us-ascii?Q?uXYTHBYx3Nj1bmRjr5sUXfrE3n/H8USAnGkxdwVAYQGxJq9kyPAbhXJQQL8G?=
 =?us-ascii?Q?vf/qjJxAggovcFzsh1Mwou5mXzrZ1TGm5sjIDMtTUmlonvJJwfSc3BqiWAJJ?=
 =?us-ascii?Q?1MlhjFM5IeF79wU9FXGCTiF63cZjgH+xvKPyMV332JrWlkJu+E4jC9qO+wbD?=
 =?us-ascii?Q?fYq029B/xlbHffnCjWVzyuBvFKWKg2lE13Skw6+3xzLNPHmTrwBkNNv6wJpI?=
 =?us-ascii?Q?4kl/YPv8xKQ0L4L5cquR0CWMV4EDFD8lwJKgydRlLdkVx07pcyu7EiF/f3Lc?=
 =?us-ascii?Q?JYY0I8FDt6qSK4z03QT6JNjxAtR/J4jDFZnuNzHsYx22viTAyB3QiDJ5LpVT?=
 =?us-ascii?Q?hx2x2tLXwhn250sUA1ctwebhx9igOVlWYyJag3NUkq+MxPyN7aFYkmReSDu4?=
 =?us-ascii?Q?UDn4aQvCwXgja4Z4JztVDBIGsi50yzU9cynbtVg8nNGezGDmJM8ElnXEVeog?=
 =?us-ascii?Q?rkKqP2YfMYq48q57UwH5RP99NuZsbtmbdcb0oHhb4tGjV9IyG8kFvrzC0T7U?=
 =?us-ascii?Q?IYYMwL0UeDTzj3KmAC0JiDgJ3Gk+G9v7aFw5/7qmk+Y+0qXuLuMuTI8HA2TX?=
 =?us-ascii?Q?qCLUTkiqJCRR0xZqaJDgA2259lUhM15wigsVMVg/FGn50kg9ceqG2DHwtrHL?=
 =?us-ascii?Q?CtxshKGml9dzGNpWbW7kryJcCbbPrOfcf7upJ/S4IRJq4eB2YvZYC6x1Z/5F?=
 =?us-ascii?Q?SPcPvu4H19x8M7yFeUGZtB9L2UGSn4VU4yfurJ6B0B/I1y610SB/IR06teD3?=
 =?us-ascii?Q?hqPVrN6Ok9GjmbKSeFXGF3yTvHM6UKG9ZqlLVsTdjOmx8MinWJS4Du4sV8/1?=
 =?us-ascii?Q?36onArvghHUPuRgTtzPAqZxXq5Od3ZDZewwnc6zAYAyvQqvXMdc7TZCSYs1t?=
 =?us-ascii?Q?/htXbWySYYx/Tkwnrt7fuliyh51d/XKTiKxLLTFREuXukFVze0CFfd2bK0G0?=
 =?us-ascii?Q?zWVveKIqfDxXz6jdlb2rV2MnKavU+qWTNIjQnrhcGUZUc/UJ6Mq9MFYLm2Ks?=
 =?us-ascii?Q?ALK20kpRI0oeYBzGOk9gRnBbEifu46a/51IgHf91EQJGJ7On+ewObDR/jLLX?=
 =?us-ascii?Q?Kg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea691598-f972-4a04-e0ff-08dde18981b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:38:05.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjqRkRnWgZWp4Goa7d1il9yngPpERJ2BCY8N0pugf6J0jGjUdxODqc7xCpMFCX2VYrLUmcP/RuOzhxbuaVGIP99NnbsvBk3KJIMii4W9VPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14442

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 11:17
> To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol <mailhol.vinc=
ent@wanadoo.fr>
> Cc: linux-can@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Geert U=
ytterhoeven
> <geert+renesas@glider.be>
> Subject: [PATCH v2 08/11] can: rcar_can: BCR bitfield conversion
>=20
> Convert CAN Bit Configuration Register field accesses to use the
> FIELD_PREP() bitfield access macro.  While at it, fix the misspelling of =
BRP.
>=20
> This gets rid of custom function-like field preparation macros.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v2:
>   - No changes.
> ---
>  drivers/net/can/rcar/rcar_can.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_=
can.c index
> 6f28dc9354511120..4c5c1f0446913d37 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -152,10 +152,10 @@ static const struct can_bittiming_const rcar_can_bi=
ttiming_const =3D {
>  #define RCAR_CAN_N_RX_MKREGS2	8
>=20
>  /* Bit Configuration Register settings */
> -#define RCAR_CAN_BCR_TSEG1(x)	(((x) & 0x0f) << 20)
> -#define RCAR_CAN_BCR_BPR(x)	(((x) & 0x3ff) << 8)
> -#define RCAR_CAN_BCR_SJW(x)	(((x) & 0x3) << 4)
> -#define RCAR_CAN_BCR_TSEG2(x)	((x) & 0x07)
> +#define RCAR_CAN_BCR_TSEG1	GENMASK(23, 20)
> +#define RCAR_CAN_BCR_BRP	GENMASK(17, 8)
> +#define RCAR_CAN_BCR_SJW	GENMASK(5, 4)
> +#define RCAR_CAN_BCR_TSEG2	GENMASK(2, 0)
>=20
>  /* Mailbox and Mask Registers bits */
>  #define RCAR_CAN_IDE		BIT(31)		/* ID Extension */
> @@ -428,9 +428,10 @@ static void rcar_can_set_bittiming(struct net_device=
 *ndev)
>  	struct can_bittiming *bt =3D &priv->can.bittiming;
>  	u32 bcr;
>=20
> -	bcr =3D RCAR_CAN_BCR_TSEG1(bt->phase_seg1 + bt->prop_seg - 1) |
> -	      RCAR_CAN_BCR_BPR(bt->brp - 1) | RCAR_CAN_BCR_SJW(bt->sjw - 1) |
> -	      RCAR_CAN_BCR_TSEG2(bt->phase_seg2 - 1);
> +	bcr =3D FIELD_PREP(RCAR_CAN_BCR_TSEG1, bt->phase_seg1 + bt->prop_seg - =
1) |
> +	      FIELD_PREP(RCAR_CAN_BCR_BRP, bt->brp - 1) |
> +	      FIELD_PREP(RCAR_CAN_BCR_SJW, bt->sjw - 1) |
> +	      FIELD_PREP(RCAR_CAN_BCR_TSEG2, bt->phase_seg2 - 1);
>  	/* Don't overwrite CLKR with 32-bit BCR access; CLKR has 8-bit access.
>  	 * All the registers are big-endian but they get byte-swapped on 32-bit
>  	 * read/write (but not on 8-bit, contrary to the manuals)...
> --
> 2.43.0
>=20


