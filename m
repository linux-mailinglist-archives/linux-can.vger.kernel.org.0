Return-Path: <linux-can+bounces-4329-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06867B31C12
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BF31D64A44
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532C3093DB;
	Fri, 22 Aug 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZhihPk7z"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010035.outbound.protection.outlook.com [52.101.229.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166A3074AF;
	Fri, 22 Aug 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872981; cv=fail; b=p6euSH5SbS2tCxZY6nsBvRj0gZJNF9wwRlOyW+BR81gjNZ4KEs9aTOzgY6ntpvl6JI8ZisaAHBSTBjt71v/sp3e/Lva9lv0im2ronlfDiORwBxiJZoMzk2nFr/MN0XsTnC2ZfR2Mmy6kSZgkKqtd5/VAY8Ob25MONgWYejwGqz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872981; c=relaxed/simple;
	bh=l2ozzBNt3ZW8LL2xDwMHhZbqL7wm2m3/DfMqsjE44Ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r6BL5kNlFK338ZPS4529UbWLff6hnDQJCzBIa4m8Lh8H6QGEgVU5/fup/LJPGAQTyCa+lk/oaqtpAKJXMB77dAi4PmV6gjCdGbJoC8l4XakEbLyDCd1uiufHZ9DuuYsuHvBKdSfcEuUQwF/KH66/4e33f39kmdEtZQMTUKfliXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZhihPk7z; arc=fail smtp.client-ip=52.101.229.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9jqZRM2qu9NiN5IUAUyqmmUkt2m2xzwaKQ3WHh07KNIdQ92euu7owc5j6DGDDq2EPO5PlFSHnxIQKUBC9al+3jMrqt8z8AQPweK7ELj5S2AEklYm8Mm0G+8owh8uSJRGr2z2zac/JbTpVDxpwuIE3Ex+YBGmncmo6KbgtbZQjxpHAMTyZizHLTed9+yk9L0rSBGEwph8j1Ec+B7L28qompH50BXHx5/crGmpMdmSypTQYKrobERgvJE7Lz+gAy9u4Ul++E06RzCPgoHfx+H8lqIk1nMWSGMIHVZP5TZ62U45xJ4BAxQhmbMYJLNqHPf+OWhMX8JADLxaB26rD7erA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX7B424MtQmdaIArr0nqgsntbTolv9kLs1KO7aC/w94=;
 b=WIxkJIwdyvzzpCf/aEGcHwdrl2NM0897SO7bRDAsDR8PMva9yeXzWv2oDOY5xIniNRC+fcvXnvXJZMvE4mHYabMBTg6BYGb3VorAALpaMBc0/QytBdc8qpHmOsznOJRhGEO/XJu6qxIMfnDQw/9Dzxt/FNFKYQhwPk30/8lp9ZyWMf7zPizJ6WG3AWq45nEPtkeXS1f/I/n67t+cUnmwwaVaPJGTBN9O3YPHp6BEF6D+3YXF45MU+9STRhrrBHXVXQoI2R406DI/bYO9wXRO269v4QzHn9HDkiNTcKk5XPKIkLcceLJBAf/G14+ULldsRJqBk89h36VLrfywjsEx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX7B424MtQmdaIArr0nqgsntbTolv9kLs1KO7aC/w94=;
 b=ZhihPk7zgV+eydABLQuUne3TkG/QyfqqUSpJOU3tMRn+o1W/L+N13QPwUhdBK/wCG/2DtmSBDLg9MmpSGM/2KbrUWuzj4JvBXgFqz1Vr+Yg4mh/enZ/D12gP3AvwQUSwueheygWGBszTwelQZ0m96+gKpzX0R+aN3k7OiwVARAA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11975.jpnprd01.prod.outlook.com (2603:1096:400:387::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:29:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:29:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 02/11] can: rcar_can: Add helper variable dev to
 rcar_can_probe()
Thread-Topic: [PATCH v2 02/11] can: rcar_can: Add helper variable dev to
 rcar_can_probe()
Thread-Index: AQHcE039EOTCSd6CHUa70p2UlUz+krRuu4hg
Date: Fri, 22 Aug 2025 14:29:35 +0000
Message-ID:
 <TY3PR01MB11346C146A52B4C52B3979E05863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755857536.git.geert+renesas@glider.be>
 <baf34c8bef5625ae73c830dbb3c617eb8f7adddd.1755857536.git.geert+renesas@glider.be>
In-Reply-To:
 <baf34c8bef5625ae73c830dbb3c617eb8f7adddd.1755857536.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11975:EE_
x-ms-office365-filtering-correlation-id: fc297bb5-6a12-4801-7d9c-08dde188514d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0eufzKez3ztKDAZt5JwLou1OqkZ0NAWYj0a2AEqHMtuZhXfozShkp/JlK5cP?=
 =?us-ascii?Q?4W8sXxekf1IW3j0VD7Is4MNXa3dy5CjaBGptSozGRJ7Y+nP3sSVrgwkq9TY1?=
 =?us-ascii?Q?jDo6tqpUidzDunsMzA9npN6PXAhGDuVgAqOMse1RVvHUUOmsDgpVMBucaIGV?=
 =?us-ascii?Q?BCeAUQ8p/1Gz1Y8c/KZZYHqgFNqno/QBxnrtqugRFUbwDaFU+gXjnFfeBx0E?=
 =?us-ascii?Q?lJi6Px7LmlCrW1VISMhuM3J9XwqGYaXZMBH8QNKOMQN78MaTDwv9MrLf+m1g?=
 =?us-ascii?Q?HHd9XJHoYENFfTD00NRSDnMPvnfXAkvLVHROPXxFvWbaZ3bMn8JoLGgvcirr?=
 =?us-ascii?Q?fclVGhvjIksZT1BANFuGPVd8z2BjW8bW8IDHw0ToPjNWpveGPmITr7694ud6?=
 =?us-ascii?Q?AzF8tT5koFer+fBWtI/V3Ns0XAb0ybyPVXhjdlfrpe5GRHFPjJuj37fZIHYJ?=
 =?us-ascii?Q?tDEpNU1LQZWyWOup+8TE9oGykIaA0SHwOgXAbib9OQO75agCiapuRVWeam2a?=
 =?us-ascii?Q?fZmhV5pyBIU6UGPclKCeqGIxAbZKUql8H9jFpJ27X/QzL6no9kJ0BjS7Bx8Q?=
 =?us-ascii?Q?1cWQwRslopzRvepKN4vtxG90LjbLngNx8u7xqG2v/sZNznW65UJTxDhrXJD2?=
 =?us-ascii?Q?XV28P0+mcdqJUEiGfZ6kOK1SpOllb2XKEtqsAJUmxqwdfYWE21Sx2lc78xZ/?=
 =?us-ascii?Q?2ApbFUtpQrm/3iFDjRY8KPti812hHFPPH8P+RQjNqZjyYEdea0r3R8LC+4uM?=
 =?us-ascii?Q?nRwO+3sXyReOqiarx0wcYhno0KyoQpS/PYJ5vErXJhuKd+7ytJ1PYb1s+UiC?=
 =?us-ascii?Q?rgmY1azPWoivmoaNnoxpy1Qo0hxefds31pPxCqLT9/NDaxVdw1Z9/eGfs7oo?=
 =?us-ascii?Q?Ka0heESxVGPONC0ydgcyc6DsE3/VxDDwsJeLxiuKTG/VkXmvH4aplBrmq3d3?=
 =?us-ascii?Q?u/1EA89/Y3OzoGqsAObBCKIFaYSko9HxAWM0+wx28n+H6ANB+YaMqo302RGT?=
 =?us-ascii?Q?A3J+Xm8CO2G4QT2seTn91bcjHPt92SD43DZNP/fROQgHzTnF1u8X3o+o6l3C?=
 =?us-ascii?Q?tXvzxrRnfHdE5P2891SNaOmIlXqvwzc+g2EVvATB4hE5xVH+vX+3Gh/tvUxJ?=
 =?us-ascii?Q?QhiDeoOb4Woyn4dN04cUQLwLfYt5R0wX9iytT3Gx9TWBn38OjX+oRtERlpPb?=
 =?us-ascii?Q?6q7+IYZ/G9OS9hoA4s1lgJbfu5QVpJLhOgZbZXhC9y1vA/H7WeqGsOE5tC8F?=
 =?us-ascii?Q?OWZEgXoMD+AgG/5tGN22Dj4TZylBH1rTtQVEW6uDYWze+pdzd9hepdsd0T1G?=
 =?us-ascii?Q?krMbMzo1yIbddVdTt4/nTSOU5mBIlk3UuKoTx9NAB2TKK2yJ/vC10qrqoR/u?=
 =?us-ascii?Q?VYguvRueRS3cqvL2hr0GVexRpKvqe8heF5SyDuN5S02Ul/Wm8YDp+M1ZDwVk?=
 =?us-ascii?Q?lGSM21xGButKRkY1BxsmbEAE3hakiDrTcfP2a52EQ8YAEWoigvDLmA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sKmnn2o7zBi8thHXl+0raU7WJcBrTbebFsxgz3wDI1JXwc/v7e98TyAtdU/X?=
 =?us-ascii?Q?yzyEVbKUdV56y1xemE4GqonFTAzIsYQiY/9o/QIt/PsydydgKpotlXf3CUb1?=
 =?us-ascii?Q?OW5/pshX5BZ+NoyW2ZiyBVxR06Zm7eIoA1yEvUFWpOauF+bMGmIkdxxZ3aex?=
 =?us-ascii?Q?qzfq+1liblNcRwEzOQc9vKs1Ush2uiptiqQPTt4B6fGAedFWAiJ0NYTIMr6j?=
 =?us-ascii?Q?4EA3j9os9wiY6N9xKvx2m903iT5cjotn0JBdUIuIxOL40e6qheggz3Nw2O/j?=
 =?us-ascii?Q?TB2febmVZbv/g6eRBVURf0T+cVC1HZZ4a+5Ih5LIO2P8ly4nfZPkWFBMRMWw?=
 =?us-ascii?Q?jBHPevAaw1WMa/STVgNf80PZfUms8D7HZ0zCqA/N+44ChXLV90Tf2djM/4z0?=
 =?us-ascii?Q?bApwPw/DkLP7P+97u5gzQtndkzrby+EGmPzq4bmM0/el1o64r8xzQijFz5cA?=
 =?us-ascii?Q?nC1OzIzHyHiauatxGmL3w00jLEnLhwjj2R1ZtuoqV9dy6P3sOxJp2OIDNCSK?=
 =?us-ascii?Q?0YIyeXZEe45jLt/gZO5FcbnDHPB0Y2lKZQ4Hb4Zajmdiw1R1Dgw3lMNUEd7y?=
 =?us-ascii?Q?cFaTw2c1UbrGn7UIj5KU/vXamvwBU3+QzFNRfZlfrTRBHksbMXERr+Gul7ki?=
 =?us-ascii?Q?iqbyVJ/LDo8/WW/9iAURupgDtucF6j5FbBzuskplPuyoIY2vUTSkcoe0IEr4?=
 =?us-ascii?Q?C1MaHGIfOARRxWgVijEBKiK+T50RZBsm263H35pe5FsCeMemQyzqLax2HeDH?=
 =?us-ascii?Q?s9h0ZKfcwKRQGaMlYNTRhSsC4F/kIpUGcRd+gmy/Jg3mDaO2QQ8Gw1LPT9If?=
 =?us-ascii?Q?gZ2W59zohbo4vNMC8GC5Yt6w5XvO1OFGkXZuYgAsrLXyCkTjh8ZXK1KZ5T4s?=
 =?us-ascii?Q?wKq43znjjNVWYrYS9d9XJTopxL+p3Bf1vxFMlpgd0GcKKeg+5+g3OxEfczxD?=
 =?us-ascii?Q?oMV7MJgRiejAt3sVwLYipz5Cv4WLR4FgQrP+ZtL+NXtcivXuJ3ud+biNyJW7?=
 =?us-ascii?Q?GBP1n2jPJkq8DjNJqTtle67PjFe5k5LA8qfZlg9LYAQy6ueNzqiHPekQIXx9?=
 =?us-ascii?Q?rKLznDvQbj/YCI4V2ez82/M50qyRiPbh7aqV2mXk8mI0dvWtXPexeiZTtJqg?=
 =?us-ascii?Q?odRCBTCcVe6TiRlg93CWhDl20PGvej0LHuhH3QyGFeqEBCR02ALiCEQM5HTh?=
 =?us-ascii?Q?EAYOne7LYujVZ8/TEtSuBFy9RQ6SRCXCYf/qElAsVnDmpGltv74fqFaTXoDm?=
 =?us-ascii?Q?FfdZeQzg1Vr4oKpnZYPz90nummUeIqlHjlQphlKFrhkh6JbtPt8FwPKyjoRK?=
 =?us-ascii?Q?eWLZymJ6E1ZEG8vOmb0vEEBvXP5WKgBEN0ru7rO/dC06g1YYy4SGwc8RfRew?=
 =?us-ascii?Q?dkRR0V5OeyG+ElfO9NjcXVFePQGt207B5AdUINEmFsT+icfKc6esesOtIwXi?=
 =?us-ascii?Q?xoUx0VlVE4Smqd0Nu23zmqQRdv3ysaUq6URNg/AEVqhQdqSK05Ee6WBae8uP?=
 =?us-ascii?Q?lOmOhCY6+b64xPENGYZMRK5MY73ABhINHpSYop1E9kKmAS/cdTA7WVVK61IW?=
 =?us-ascii?Q?khtS/sapocQeGcuTrw3I0eLlrSYsge18ouMT/iEP7yoZmEf0XuGZBmJB9DhQ?=
 =?us-ascii?Q?gA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc297bb5-6a12-4801-7d9c-08dde188514d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:29:35.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIfbqbJLpZY8lKhjZIgYelbbMoDgCHpxGbRJashQsC+BSMtKW2fESv5tEEIRFDezsWvj4c0RShEgoGlrl6wZVUqVhB5EzQ4zmcgky69655w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11975

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
> Subject: [PATCH v2 02/11] can: rcar_can: Add helper variable dev to rcar_=
can_probe()
>=20
> rcar_can_probe() has many users of "pdev->dev".  Introduce a shorthand to=
 simplify the code.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v2:
>   - No changes.
> ---
>  drivers/net/can/rcar/rcar_can.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_=
can.c index
> 5b0b495d127cdcb3..57030992141cc523 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -738,6 +738,7 @@ static const char * const clock_names[] =3D {
>=20
>  static int rcar_can_probe(struct platform_device *pdev)  {
> +	struct device *dev =3D &pdev->dev;
>  	struct rcar_can_priv *priv;
>  	struct net_device *ndev;
>  	void __iomem *addr;
> @@ -745,7 +746,7 @@ static int rcar_can_probe(struct platform_device *pde=
v)
>  	int err =3D -ENODEV;
>  	int irq;
>=20
> -	of_property_read_u32(pdev->dev.of_node, "renesas,can-clock-select",
> +	of_property_read_u32(dev->of_node, "renesas,can-clock-select",
>  			     &clock_select);
>=20
>  	irq =3D platform_get_irq(pdev, 0);
> @@ -762,30 +763,29 @@ static int rcar_can_probe(struct platform_device *p=
dev)
>=20
>  	ndev =3D alloc_candev(sizeof(struct rcar_can_priv), RCAR_CAN_FIFO_DEPTH=
);
>  	if (!ndev) {
> -		dev_err(&pdev->dev, "alloc_candev() failed\n");
> +		dev_err(dev, "alloc_candev() failed\n");
>  		err =3D -ENOMEM;
>  		goto fail;
>  	}
>=20
>  	priv =3D netdev_priv(ndev);
>=20
> -	priv->clk =3D devm_clk_get(&pdev->dev, "clkp1");
> +	priv->clk =3D devm_clk_get(dev, "clkp1");
>  	if (IS_ERR(priv->clk)) {
>  		err =3D PTR_ERR(priv->clk);
> -		dev_err(&pdev->dev, "cannot get peripheral clock, error %d\n",
> -			err);
> +		dev_err(dev, "cannot get peripheral clock, error %d\n", err);
>  		goto fail_clk;
>  	}
>=20
>  	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
>  		err =3D -EINVAL;
> -		dev_err(&pdev->dev, "invalid CAN clock selected\n");
> +		dev_err(dev, "invalid CAN clock selected\n");
>  		goto fail_clk;
>  	}
> -	priv->can_clk =3D devm_clk_get(&pdev->dev, clock_names[clock_select]);
> +	priv->can_clk =3D devm_clk_get(dev, clock_names[clock_select]);
>  	if (IS_ERR(priv->can_clk)) {
>  		err =3D PTR_ERR(priv->can_clk);
> -		dev_err(&pdev->dev, "cannot get CAN clock, error %d\n", err);
> +		dev_err(dev, "cannot get CAN clock, error %d\n", err);
>  		goto fail_clk;
>  	}
>=20
> @@ -802,18 +802,17 @@ static int rcar_can_probe(struct platform_device *p=
dev)
>  	priv->can.do_get_berr_counter =3D rcar_can_get_berr_counter;
>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_BERR_REPORTING;
>  	platform_set_drvdata(pdev, ndev);
> -	SET_NETDEV_DEV(ndev, &pdev->dev);
> +	SET_NETDEV_DEV(ndev, dev);
>=20
>  	netif_napi_add_weight(ndev, &priv->napi, rcar_can_rx_poll,
>  			      RCAR_CAN_NAPI_WEIGHT);
>  	err =3D register_candev(ndev);
>  	if (err) {
> -		dev_err(&pdev->dev, "register_candev() failed, error %d\n",
> -			err);
> +		dev_err(dev, "register_candev() failed, error %d\n", err);
>  		goto fail_candev;
>  	}
>=20
> -	dev_info(&pdev->dev, "device registered (IRQ%d)\n", ndev->irq);
> +	dev_info(dev, "device registered (IRQ%d)\n", ndev->irq);
>=20
>  	return 0;
>  fail_candev:
> --
> 2.43.0
>=20


