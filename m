Return-Path: <linux-can+bounces-4332-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7EB31C58
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504CAB66518
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3D6307ADD;
	Fri, 22 Aug 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EBzt4u+B"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2883128C4;
	Fri, 22 Aug 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873757; cv=fail; b=RiW3JOgUW6KN+rSRM5y5206cqxpUCvY/+AJ1JeoPnla9Hnp7g6MYD3of7yH7UIXLYCoF50Pfvdhutv4qgrMd/RQoMqKQZrgxB0VJ0C574kariZtDZWf/ZblgPMdIlSPNtr+HkanMGYVUkf6QyMPi3hCqtrgGEXx9XV59HWE61b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873757; c=relaxed/simple;
	bh=SSHe0TVxNeJPJ7bIYoDMIDq/l2nMhNsEITDz+de/Zic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFg16o6jvEm3krMdV61CJCH/eYlJan9HT0S1nUTS32hl5u8MO9IleZxC0KJEOnEy68QWr3p1IYYfl0M3/jzVUIq8F/pAVxy+U+CkIO41LJOo+WdCTKBRLjEZFAbOUXft/8BPEcIMyObmUU4VIPnb3gF3zzkkyRwxUQJ0hY82Kek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EBzt4u+B; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xc77noYluHSBYSLxvEz4uSXaiudHSnBNAWm/OzXH3KpmEkOvy36Y0cYEzI1uzMj6HCpf00fr6CV0sTKpbVgRDyX6risDdvEKcVRx5BogP9scydAKLWmsYYFNdVl6RmBHYIlpSnQSSGWWXnEUox0tPeWQqkj3w1CWmS51G4W5G/pFSwVnnuaB1fXsZRWMjIRFS0TvELNx3ekK6rsFy1Lu62lKERSH6+YIVm+cpD7HFYNlqf9VgFF3kEGcXVWSfZwVEfQEjzY0ojnaLUhvI9R0aG0AMoe2joKmdj7kABcjdH5A5C///Duya26iw47lbBKRSFsUmnii3bipcta6Lr7HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNHfgiQinpFvtRD4mtztShBPlRz/KH+q/+fKBIHq0zE=;
 b=Tzq7KJTryLfDDy3wb5HlBMDgrS5D6ZCwn1Ja7+uqC/aWYqWmxmSvOAtQUawCLu/OryCu0sspfiw6icPbXYE+xjiKMaXNm8/DfYaSv8uBzJDgl43otbEeCol275IRvm3HM3AWJTQryzv2q0bOXksrpq+DDzM1LySoq7kCxt4WZ49OAgHyMkhuyVgKZ3me1WWtxXgMMMxdelBY+dpokOBSj6OxYRo/oP3v0LC1NFttCi92GW2zCW65IMSPE0VFAwWLA8kMGHKtgPjY9v79b93X9RsSSPqsusoD5Hk7A4MTRZEi1IXO3WJv23VWvLcKsbud0KJqmE5VVhMaN1i6abcc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNHfgiQinpFvtRD4mtztShBPlRz/KH+q/+fKBIHq0zE=;
 b=EBzt4u+BxF81QCI98WF+g1Otsk4CaAfrHcn3FwyU+Y4S/oeDOaL7/HknmCzFs5D3SS4TkaPpYso4R0S6cU73MBV1xsyci/ZcLRrqjIMZsZGH/MaK6p4sY3e6GH4+xbq1qS75lNu/ySyd7YUKjTezla5sz5smv/aGJqG6ZjakJb0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14442.jpnprd01.prod.outlook.com (2603:1096:405:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 14:42:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:42:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 10/11] can: rcar_can: Do not print alloc_candev()
 failures
Thread-Topic: [PATCH v2 10/11] can: rcar_can: Do not print alloc_candev()
 failures
Thread-Index: AQHcE04bCuZXxUc0xUC0OWPtFfxP1rRuvzbQ
Date: Fri, 22 Aug 2025 14:42:25 +0000
Message-ID:
 <TY3PR01MB11346DAB2B159C12FB705A468863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755857536.git.geert+renesas@glider.be>
 <2d6ad4be211a35492570fd7219ca7a89b384bfad.1755857536.git.geert+renesas@glider.be>
In-Reply-To:
 <2d6ad4be211a35492570fd7219ca7a89b384bfad.1755857536.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14442:EE_
x-ms-office365-filtering-correlation-id: 662660b2-c87a-406d-9f71-08dde18a1c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+NSxZpg+oLMOxAWQqAMyFo8E55du0PMwPjDf3hqTN9zpPli0kEUyhuthy59q?=
 =?us-ascii?Q?HS/0QO2SJ0IFF6ZWNkSOOW+bezMwNW/Z0NjSCdhM+7rO7EQ9o58lqmK51Ilq?=
 =?us-ascii?Q?0v7FJv5GhbbILml7KgDpZ67HuFRy1jl42lUT3fLpxMXqiHVSxLt8/XdVdlXh?=
 =?us-ascii?Q?r3pW+hHosCTF/HyT8p1+YzNLDoB0UsoJY4TaG/ykL5PsLZIYC2eSCMRCYRwG?=
 =?us-ascii?Q?gzOB7KcLxPFCdwcBhWV7r89PAHRv08yniOGdjSLLUR7ldae6JxqvMY4AQOTW?=
 =?us-ascii?Q?tl1+SLbLkKbfTi/dhYYIS5T19+zJjqX+yLbMNlpRDSn2OCBryxvQua3HLMBs?=
 =?us-ascii?Q?c+yK4Z2nzTkDBp23j+eOmR2bqNr+JTMTJ5be4C7vlXHR34445Vo3NnVTMokP?=
 =?us-ascii?Q?Xi6N15mLd6bJvPsC/nJNVSZv5B9ygEUgMBJ0kvX7UkAIPKK8INXnTW7vvWEO?=
 =?us-ascii?Q?ZggPVKcfe1UYtKxbHzWEp8gQTiI2JJpm9GWGqTybtYOrYI5gIOdKUmWW8HpA?=
 =?us-ascii?Q?XHtkExNVpekqvaNl+aP/zlHLOj3gaRRC8bgHgvSrmtk7xw69qAV9itSvbqKl?=
 =?us-ascii?Q?AcZi9vReTANFnP9bb8RLtVOUh64WEJj/MaqWrlUY0P7EQP/HePbAJHthTDL0?=
 =?us-ascii?Q?QW1naj9vAeWeJyo2g964APk0Iwf3XSLIWlhqGYb2RgfZigq4xw1TNWrV5pHY?=
 =?us-ascii?Q?lVDmQUKTfvxUo8q/LqVZBYwQsPFl9QALbEfO+kv8WiL7HYQo7gYbbYNVg3cF?=
 =?us-ascii?Q?oR6j0X+Iv1cnEUpX3oI6N3usaNhSV0pAKyOTDQa7mJfqPqnrmSZxnb136ba2?=
 =?us-ascii?Q?h646GsQFv7KdHhaASU2yYbO9TKFALK4KtWdxOuh+wYDJPg/AxDn4h/GZFea+?=
 =?us-ascii?Q?/3TtOeTPmZxk226kf2CyC6FtRrrvi7vuc5byw9CReWeiARy/OcxMq4DRw+X2?=
 =?us-ascii?Q?SEjKr/xb/llh7iEF+z5LIr9TuEhkgnYhjNeDo90DRxM9qcgqRqz/e/NzH5yL?=
 =?us-ascii?Q?prqbq2rW3QdpBxzS7eRZ2Pu9Xg8zYVehGsW/k+K7IIsAqWr2avu+1p3/Rn/+?=
 =?us-ascii?Q?myr64sjHBNqAJZSghR7qktB8tDz2B9og4zK2OsO0Kz985FqSY5A015oMwW++?=
 =?us-ascii?Q?yHXlXqR3xKJSh9LtL/fGwbCWILDAhdmIFcmgjBy8H2Ak7tQFsIsic97PDAw9?=
 =?us-ascii?Q?zZvkCD/aEdyDfWkt55xWWmrAQj9qGADArfTcecD+3t5//coubiTlfmwZxrQp?=
 =?us-ascii?Q?YpqoANMoHEZaJ2X+HOWu+KIyxyb/N1VlSXj4i1kBNmnCLFLemtrFIcNZAt/C?=
 =?us-ascii?Q?+k2qWkVDjutGbWzGwWVBQp+4z3GSBVBFZPAtKe80F6k0k6glPOh+JdD77fkI?=
 =?us-ascii?Q?w5GUfcZf3UDSgz2lGGSWDJhBc8bUyhDVZxBSGv3acp8AQwDMzIZNLxBNk5AM?=
 =?us-ascii?Q?YiH6XGO+2b2Z1+0GlsulWGBFLoXGoOlD8t0qb/athla+k2jyuD2aXmp+BHev?=
 =?us-ascii?Q?HO1GA7tcYcsaDo4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b4LFp97hI+tir2gR32sWq7I70bs7rKkYfm1zvO0fGdr+yASA9VQc+rzP93t4?=
 =?us-ascii?Q?SEgZ7q6GTdQLep+rU0eEXG1PFJiP42KiA8NEm/M7HsyVg7S5INB7iGI722Mj?=
 =?us-ascii?Q?35c09KudT5BbmCEzQPkblErZe+BHbRj18/qBxIXkGy7QkXNZ6zBLNn5yOOUf?=
 =?us-ascii?Q?O6mmbCM8zoR2y0MSaRprFaj1PtmIXbWWvjs+a6aebRw0wgsBWFFacR2IbcK0?=
 =?us-ascii?Q?Gz+mHyuPurQs+JZCS52mNFDHN/o1dpBT02ebndQFSNwvDQGrLVayInkpgT3B?=
 =?us-ascii?Q?C/udJdrehLScZ7i2l0y7UlM90KjkAPJj8dfB3qWz0Hc95QG4TfEKV5Vdq39m?=
 =?us-ascii?Q?5IicyW4aOe1APMhCKWlqt+WgPGrmvMrqigDJsB3YxN1IPvikqrwrtlOOuN3G?=
 =?us-ascii?Q?Y9RquvVrHUuYqNq3+a8ukETH2Hv9aNXho64vzemy/NgJJ6wPEF5t8iXgoJ8+?=
 =?us-ascii?Q?3X1be+nnxPKLM8Mx3QltYWu9XyoDwA+7SInt9jVtp0UnM+3myYO6ozI4TFsM?=
 =?us-ascii?Q?QUdP/PfuAiom2TweIHtwpOp1n5NTZ1mn23FmNvjsYO3+xvhrLzR9xpMFnIDj?=
 =?us-ascii?Q?KiZKm9rtRfQO9FF9Jo7PnIhbQG8p8qnb49KHYACyrbnQL8tbzNq+KKI+uuxD?=
 =?us-ascii?Q?PwAGGb7mdoWezE3rdaKbGIUpU9L77y4fugm3OQ+4q+iu0onb9+tvZ+XT9zbE?=
 =?us-ascii?Q?hkE7WQ4en2bb8boumh2AjAt6y/+SFwwafld4N5xPgm3FJ3u4HHQ086ZuOWRQ?=
 =?us-ascii?Q?jQAF1Iwg1LCWdIbwbI+Jabj60wy9NYkhnjRqEcj+BHTbVjvidUh2vGfoiV+l?=
 =?us-ascii?Q?6KggcVpiN46A/T4uAHU/CZa9tLdJ2w1iRpieQoHWkb5dUsIMYfIqHbRR9MYL?=
 =?us-ascii?Q?VU2xAiOnHvGJN3TGPyhmqj/Qf1rtci284ujYBu+mquNPDIgr7wt/B3p7i+IK?=
 =?us-ascii?Q?xlZian4hh9rAVLWTLt5XXXQ6e/kVWZi8dqwbX1cetIZim1E0phTVvgcist2m?=
 =?us-ascii?Q?K4BA/nd1wd985H+K4SG3kiHThsTI0BEQmyeRfYic3Bu+47hKMD4PWIOLA1Ri?=
 =?us-ascii?Q?GGaeur5ZHetMzyyGFvQ9Iqy/mAkFWHPUIi//w5aTPPett4vYC4EbaIzVpcRF?=
 =?us-ascii?Q?Cek2dpN3MLdAF14IRlcb74B3I46disBa5pcq3SPgCTs6g0h/iK1H2sdTBYTI?=
 =?us-ascii?Q?3N0U5BWn+Q6/c+9AbpX7T+flcjLDQc7dXkCgEKJmBnyFdy61u5JAeFMl5RGn?=
 =?us-ascii?Q?2d1Ku4sY91TWnAHI64WIHQTT0F/pDeKe6zO0WI8DG+VgalicZ5DRFrIcgVDf?=
 =?us-ascii?Q?gClnuKkbFZc9Hyc+wFwFyZYnBxWD7JAKWRn0JmbSnIc0U5wIS93vkZv1u+OC?=
 =?us-ascii?Q?RMXvlzD3qL/wdNp0VkPnABBI27GT4l5gbd/5xD2dBttV+7OxHyj82A3jAVUi?=
 =?us-ascii?Q?nxHZU63NWFcL63Er7MXJgXPtwd1FTNbTmLCnxRgdJlSrqIHDDWaSqlyM4N6U?=
 =?us-ascii?Q?k6GEZBNKibOfjOTTIbfXUsr5ANCLEtym3pVH5P/XqEaADrE6MqR3+kfcPiMB?=
 =?us-ascii?Q?7Cq2Pq9ZWhSZOfuYbteKlZtZ2cfd0JjCZOisEdEY65yjrylHwXR9SFINj6BD?=
 =?us-ascii?Q?/Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 662660b2-c87a-406d-9f71-08dde18a1c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:42:25.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqiJBPbi5tgyDrN7lE32V9Df8wq62bC5osilOAsn54+Jglmht1MHBzycL5J7GXBi9ucjmYN7+a33i04r6qCiJ/HRr3OCrqh693QdePojy94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14442

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 11:17
> Subject: [PATCH v2 10/11] can: rcar_can: Do not print alloc_candev() fail=
ures
>=20
> If alloc_candev() failed due to out-of-memory, the core memory allocation=
 code has already printed an
> error message.
> If alloc_candev() failed for a different reason, alloc_netdev_mqs() has a=
lready printed an error
> message.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v2:
>   - New.
> ---
>  drivers/net/can/rcar/rcar_can.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_=
can.c index
> de1829477659757c..51bf8f7e71824ac8 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -773,7 +773,6 @@ static int rcar_can_probe(struct platform_device *pde=
v)
>=20
>  	ndev =3D alloc_candev(sizeof(struct rcar_can_priv), RCAR_CAN_FIFO_DEPTH=
);
>  	if (!ndev) {
> -		dev_err(dev, "alloc_candev() failed\n");
>  		err =3D -ENOMEM;
>  		goto fail;
>  	}
> --
> 2.43.0
>=20


