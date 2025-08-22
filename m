Return-Path: <linux-can+bounces-4323-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD8B31A12
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C819A642B78
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05942284669;
	Fri, 22 Aug 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="OEfXfAu8"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011053.outbound.protection.outlook.com [52.101.125.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61127462;
	Fri, 22 Aug 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869983; cv=fail; b=rwBu0OyZUMzKDksCmURlWxYVbyvdXnYgi+aLozRg8Z8kjmMsyaUDCQXPLOCZmGnhmMlS2dJe/HT7fX03pn8R22DKcXcThabfktYcQ7pxJWcjDBNGSJJTNSfVPi3EEuPBAAa0/1Q6fug+krkuSjMZn6EQ66KStZSE1yn4/WVkwII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869983; c=relaxed/simple;
	bh=rQdgr4Zh22dUYNTAf/0Q/m4t3WE2lH8fc9PmbUxLcAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZzMNi9fzym7Xocp2YyyaWH7FPr9XrTdtClN0lBmgSS514/FDOsxiIT1pjheWhkQ5N2pLT87lDJMpjpBjD8mPDjJR50fCtowHaVc57zZECGjjRD8tdcKMgMhLQ7PGW46TRLBYI9N26uc66GyRDRzxSxGCBNKSd2DxAOeH0f9Fy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=OEfXfAu8; arc=fail smtp.client-ip=52.101.125.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIU8L7GuI5ElHywSI3UMTEKIEbKDwAI4nS/CBemU2gyPqxj/hJYYG1rnF8PZN+jlsPE/XE098k3TlklZIf05hWtqzoQ5iNqt8+cqU3gmp4lq1dy4jik3WUL0pc0xKe6L4d7oHMfveWX4qko8706P3a2kabvLLlFl8kEImVg6HZqUTiEjI0djIxc04DKb9zo7rWXw1rvxTygXVWJCa4PwGSqe0UwA31KNwj4WduNd4Ouia5gOdZ2Sh3nhhAw2rMbqcb9uirMfWbVQfhKa+J24ORfrHGnGYy8EXKnI+JLnETfTIfYCJa3c7QS78Z1/Bq7xEfiFzjZCE8z5jrCvqmYp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZxN6BWnlfZd6g0z6QPFFUKEIe6Lzxqmje08q9B1yEA=;
 b=bh2YWGeNT703S1e0KGs88mnDJ39fbYrNPg4VHxV4SsEPqBeiIigteyipg8x+8/A0OU04Q1T6z3DwYDK4xrNEKixhpVUHW7F2K00uj8tvC6bIJiPgsOuuxum+arSZ53V358O9XaqDdi9RzoRU/Qoy1Lyd+JSEJaJipvbahVzAKZBEDaoXA46vmPfDdMtI53BddvxjLnvqclSw5vbDVBRhDD5vY/pk8gsvl+eqdfPKdl1tiFa3Uf5or5nLsEbD3dJUy8EUyjU2TjkSJfvj8xR5BY8mmQtAKLCsem2D/Ot3S01CgbOvu0IKxYKSRtLou/vN7DjWfTdKMfq1oIvE8xV2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZxN6BWnlfZd6g0z6QPFFUKEIe6Lzxqmje08q9B1yEA=;
 b=OEfXfAu83Bvx+E8U8g8IKqzChRqotYbv0DCsbzvUnMeVWsmYlQ4raUFrWpX73H1Q0R+ogGQXulyc/LSN81kt6u5omhrnS4p1VZ8qR/wOviWxOsIHW0G9HOdeUrnxhi/44UxR1iyOLz/x1oCjwC2vkFSahlRBDzLdCPWMBlqqLw0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8844.jpnprd01.prod.outlook.com (2603:1096:604:17e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 13:39:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 13:39:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Topic: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Index: AQHcE0pKZp7DWIl5uU6P5IZbLCRQZ7Ruq/zQ
Date: Fri, 22 Aug 2025 13:39:36 +0000
Message-ID:
 <TY3PR01MB113463B58C2110A8BC108072A863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
In-Reply-To:
 <f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8844:EE_
x-ms-office365-filtering-correlation-id: b50888f8-5988-4f0c-bdc2-08dde1815624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+Km+arszT9Jr1bonbC683HW7hNqahKUkTpk51o5YlF8eqBit6T0Rf112a53S?=
 =?us-ascii?Q?R4kdSaE8wmFgmR6PTbdoeNiJyuJ3PxtkjMPCGj06FXg8ITGfpsAec3BKno34?=
 =?us-ascii?Q?FMo6EyB2fdN+dFkqfhAaHzo2CguwbjXhg7RpkmF+arUXqCFGZX0UXw7PiCbd?=
 =?us-ascii?Q?42irYQoPxngc1WmkaTRKHXINvORDc/hE1teAO1tlrHBbiK0n2QtI++r0MOAj?=
 =?us-ascii?Q?QovJrlHK3KlyplHkdxVVTvYDQ7MWSiv2Gj132NiPs4q0EzB49ZgLg3eERUJT?=
 =?us-ascii?Q?/iv/+J0TDEzxITOH7QhETvxe8THK/E2DcwxMFy+XwK502Z+1Sqhoz2ORjJnJ?=
 =?us-ascii?Q?YxWKviUzGwfVmJi3LyEm2Jw7iKLBDkFNT9m4UJWRjIytqJgPQwmN2F6GeJSr?=
 =?us-ascii?Q?rR1l4n64J55k6wBu9wzRxft9eZOM+8J+uuonOjgOaP2suknF1I/QM3lqrhmv?=
 =?us-ascii?Q?htumEG9wQdw08smGJL3R6+qWMqBYf9PeyA+M31ZO+GQbefl6xUkEKTX0ZPGM?=
 =?us-ascii?Q?iv/YnbHFMiHjVNLaMRxlVscUHFxTPTe1Uhl5DNdXSO2j/3kgbbkTMI3lr+Z2?=
 =?us-ascii?Q?mDsnvI2pm53mwR+Uk1xCFQI/JTjp2S763xm5iqr5B0PYPa2feogG628nQdpE?=
 =?us-ascii?Q?oP3YGJhm4DetG/GQ+oFJt8rmrODQPeaQ1CrRJ/W6U0Ip4jGBBN0EQqgaXddf?=
 =?us-ascii?Q?dVGuR4YYfJqIRVBdZbs/jwBmbmhF7wrJLUL2HpPIG0DHOL9QWYshoSQdLwPl?=
 =?us-ascii?Q?MLl87MrQM5aev6+Om/YCMYoWUU1L1KNsg2iu2BvnCeYT+rE4ut3w+RmrhE0q?=
 =?us-ascii?Q?dK1AAfEtooGmPa8XewGJ7DRQVJxowGj6tSuJNxuzF7OTpawTdLr9G0CP+h1F?=
 =?us-ascii?Q?/FYejyqORqZa/cWrFW2ikPZnr6w7j5vRgmKPM4G9mp95yaNLOzKMsyhSBSgU?=
 =?us-ascii?Q?WRG++pIRMj6Ip3pVbtRD8p2cRxkep4OH5gKZ4yPBPLYFnknBxGsBQohGEbvR?=
 =?us-ascii?Q?nI1reglG+fhTYOOgxgIww8+u9uBLPT3UPYtMso98kdXDWT6EgwStk7ryF/F8?=
 =?us-ascii?Q?QaGODq2f6hEwiG+HbCwMumeT5oFE5yKBlIkkoPVaNXaM16EnxbQofM3f9Zp3?=
 =?us-ascii?Q?cKvLaiQWtszonMZBGGlUuv6ATG28iB6bcrksYNqfneVBIgm2VUXHl9cIYvWw?=
 =?us-ascii?Q?nx6sFOlLTVbWHFz6aOTD/j8eI6BWuzTLpHfewD2J/IHPtpAMHbwyCMKq7+sJ?=
 =?us-ascii?Q?ExOANewrDhEKjB4EPywp8nePVtAGaYRwY+VcRDrnuwrr1pKOQZ+12/c+adMD?=
 =?us-ascii?Q?uKXKkDWE2bfZsgD87kWPXYD614VuPgWet1CG9gvrRxKDv/DfLpVOhD3Yrjt9?=
 =?us-ascii?Q?iorxcNW6FIcpNM/+hwdOy7nVoJSBnyrDGNYb8BG0aRdAglZgeLDOUPNUrtIq?=
 =?us-ascii?Q?s7D1tk5UWKKNpjCtqKLjyq9QvKm8jxv0EOj9Qas7ZaTm2BJoG2opaxj2RVpp?=
 =?us-ascii?Q?LIbJFJh4yzySgII=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EzWMkPje6Wvt5zkNIQjCZPdtByw3D5PZi3nI+SaK8Rm0u1Jxr2Te0NJW4JoW?=
 =?us-ascii?Q?6+sYrsSLpjqd/UhopR+igAE0xsJSLb7OIf1ZntXXr+SX66vINfcqWLeWUCGk?=
 =?us-ascii?Q?U8yM7rj9Jqe4C9TgPZoi6DWA90IBMeVnifzkStHBn8rZ8RWrxNFQgnZh5no0?=
 =?us-ascii?Q?di/Mi5IibOR/frDaUpJgTiPQ/5tWYeXp1NFz/AGdkMtkmChwqKvn8zynep0n?=
 =?us-ascii?Q?T6WCwzq633mGxdiMrjhtWCWBqP2dTzIeGq9G/QL2EBYG9bRrwU+aDWrTdXfX?=
 =?us-ascii?Q?fXZ69npUMwf4S3sa5aWfsig5n3uISOrcAWZSN7N1Vd+tt6EQx0U+YRZtF1tw?=
 =?us-ascii?Q?0ZgcexfXKzpl3/NZfX6iCDE+/VlZKShKrEGaZPZ8LFS4Z0Fx7qsUSFlzyXjH?=
 =?us-ascii?Q?pUvTSWHRAyQlWtJaGOqotPqUOEdJQRZDdByal1mlIAQNocoNLr1e+ClmEl5F?=
 =?us-ascii?Q?PgaLTAwIetDAIszQaWjNHaG7sq41rlGWsTL2xOAeShzlsv0yTDpQGQNLfDws?=
 =?us-ascii?Q?IeAJH39sBHS2CVOxT4R8iIpRMHyzlXnqtt8gayujKmFS6TBgFpoYT/AAkPIe?=
 =?us-ascii?Q?1wMRb+LH8Aiv9NttlXqrDTtHRxGrFQ0LMohoZkN8pfTQYbIg0tTGWQgNoYAx?=
 =?us-ascii?Q?a0rs6rZAAAO/qyd3pTUojWHeQ8nLe7aJLor1znlEB0CgpH8CUkZjPJvuQ1AQ?=
 =?us-ascii?Q?j8kEBf9sLbWQR4nhnWNbLw/EPVvRiiqR53tQ4VUk05F7cYSQN43VF89Pxr8Z?=
 =?us-ascii?Q?TUbjt8Rhg7IyYgogJlMDBVa1FrykC/nPX5CDhWsBX35O3DYE0kt9GPIR6o52?=
 =?us-ascii?Q?V29Y9N4985RGm34bmyzSrQHWO6RrzvRY4T/g3ueMmqjZX0u8kh+04V7GUFXf?=
 =?us-ascii?Q?n+bPG5e1NeH6NMt0+VRofePTgiF0G7dVTwTYx9egCN25g79WWFk4Us40FzTH?=
 =?us-ascii?Q?uZ/diDIbNwfvNQeLmoSAEw7N8I8k2LJuUicsLLqVWAdBlF5NPjfnsyHrq4IO?=
 =?us-ascii?Q?jc794IjI1dnqSTWR5whJg6djMaWWZ5qx2Lv0qKvKM9SOOzhloPFu1kOy18rw?=
 =?us-ascii?Q?dnsKB4mGLj/74HkGVebCBZcTw7Rw02YaH1JaIeUVpeCPquykVLT+IlhvegOf?=
 =?us-ascii?Q?9KtudYIjcua2Ry+okM+7K53ZOtNFkpHvoNS56VuCRXVI2wZDAyqsKomMJfvw?=
 =?us-ascii?Q?k/0jblcJ1F8qqfEsqEq+RKz4LDhOMs1LtEIIvkW7jT6m6fBM+piWyDsQVF4t?=
 =?us-ascii?Q?Ad228MXu8aGfArhoaUv/ZVYcEpamF2P/8rHWmc6J0Z8btqzUlTIje4wKGwKS?=
 =?us-ascii?Q?KDOQQ8Azvm/NX19wgtetqL52zAOOF1DuzXzYFwxYf8x1nk/FXnpu/F/psFKv?=
 =?us-ascii?Q?A+Cym/mtVEa/JouSoRxM7gAhWUsFQcoC+t7yYpVQlA05p+PYnkotUsnITcx+?=
 =?us-ascii?Q?/aUilfeFQQiwF/zVamno4Kbp2GJiaOK+k8lusNQ5D2wnTVJIy3wS+shMyKaG?=
 =?us-ascii?Q?uB4QJmoTLxcRbwAAp5uMtunh5R8AT/8Abx80DazdvTBWAwUHBG9rlILe1QQr?=
 =?us-ascii?Q?EcaOSRQd5xE1IfZiRt5LVxLauKaE0gOHVE86rKg0BvkzLuPAa+DrUO7Rk3q9?=
 =?us-ascii?Q?eA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b50888f8-5988-4f0c-bdc2-08dde1815624
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 13:39:36.8135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Foe0KYRVb76uVewaPdxY/z9pzIsChZU4yQGDoMofXAbLS3n5/q6B+oYsuvEXRqFgISqIriXYzUecFvjX3uNiCa5kFG1LOlCLOoLV9DLHT7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8844

Hi Geert,


> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 10:51
> To: Marc Kleine-Budde <mkl@pengutronix.de>; Vincent Mailhol <mailhol.vinc=
ent@wanadoo.fr>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Cc: linux-can@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Geert U=
ytterhoeven
> <geert+renesas@glider.be>
> Subject: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
>=20
> On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the C=
AN-FD interface no longer
> works.  Trying to bring it up again fails:
>=20
>     # ip link set can0 up
>     RTNETLINK answers: Connection timed out
>=20
>     # dmesg
>     ...
>     channel 0 communication state failed
>=20
> Fix this by populating the (currently empty) suspend and resume callbacks=
, to stop/start the individual
> CAN-FD channels, and (de)initialize the CAN-FD controller.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> While this fixes CAN-FD after resume from s2ram on R-Car E3 (Ebisu-4D), i=
t does introduce a regression
> on R-Car V4H (White Hawk): after resume from s2idle (White Hawk does not =
support s2ram), CAN frames
> sent by other devices are no longer received, and the other side sometime=
s reports a "bus-off".
>=20
> However, the underlying issue is pre-existing, and can be reproduced with=
out this patch: the CAN-FD
> controller fails in the same way after driver unbind/rebind.  So somethin=
g must be missing in the
> (de)initialization sequence for the R-Car Gen4 CAN-FD register layout.
> Note that it keeps on working after ifdown/ifup, which does not reinitial=
ize the full controller.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 53 +++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index eedce83b91414c57..6b0c563e894f74b3 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2236,11 +2236,64 @@ static void rcar_canfd_remove(struct platform_dev=
ice *pdev)
>=20
>  static int rcar_canfd_suspend(struct device *dev)  {
> +	struct rcar_canfd_global *gpriv =3D dev_get_drvdata(dev);
> +	int err;
> +	u32 ch;
> +
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) =
{
> +		struct rcar_canfd_channel *priv =3D gpriv->ch[ch];
> +		struct net_device *ndev =3D priv->ndev;
> +
> +		if (!netif_running(ndev))
> +			continue;
> +
> +		netif_device_detach(ndev);
> +
> +		err =3D rcar_canfd_close(ndev);
> +		if (err) {
> +			netdev_err(ndev, "rcar_canfd_close() failed %pe\n",
> +				   ERR_PTR(err));
> +			return err;
> +		}
> +
> +		priv->can.state =3D CAN_STATE_SLEEPING;
> +	}
> +
> +	/* TODO Skip if wake-up (which is not yet supported) is enabled */
> +	rcar_canfd_global_deinit(gpriv, false);
> +
>  	return 0;
>  }
>=20
>  static int rcar_canfd_resume(struct device *dev)  {
> +	struct rcar_canfd_global *gpriv =3D dev_get_drvdata(dev);
> +	int err;
> +	u32 ch;
> +
> +	err =3D rcar_canfd_global_init(gpriv);
> +	if (err) {
> +		dev_err(dev, "rcar_canfd_open() failed %pe\n", ERR_PTR(err));
> +		return err;
> +	}
> +
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) =
{
> +		struct rcar_canfd_channel *priv =3D gpriv->ch[ch];
> +		struct net_device *ndev =3D priv->ndev;
> +
> +		if (!netif_running(ndev))
> +			continue;
> +
> +		err =3D rcar_canfd_open(ndev);
> +		if (err) {
> +			netdev_err(ndev, "rcar_canfd_open() failed %pe\n",
> +				   ERR_PTR(err));
> +			return err;
> +		}
> +
> +		netif_device_attach(ndev);
> +	}
> +
>  	return 0;
>  }
>=20

This patch does not work on RZ/G3E, please see the logs

Bind/Unbind:
-------------
root@smarc-rzg3e:/cip-test-scripts# cd /sys/bus/platform/drivers/rcar_canfd
n > unbindroot@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# echo 12440=
000.can > unbind
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# echo 12440000.can > =
bind
[   67.645615] rcar_canfd 12440000.can: can_clk rate is 80000000
[   67.655044] rcar_canfd 12440000.can: device registered (channel 1)
[   67.661788] rcar_canfd 12440000.can: can_clk rate is 80000000
[   67.671258] rcar_canfd 12440000.can: device registered (channel 4)
[   67.677603] rcar_canfd 12440000.can: global operational state (canfd clk=
, fd mode)

root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# /cip-test-scripts/ca=
nfd_t_003.sh
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
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

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

G3E S2Idle:
------------
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# echo s2idle > /sys/p=
ower/mem_sleep
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# echo mem > /sys/powe=
r/state
[  160.231921] PM: suspend entry (s2idle)
[  160.236099] Filesystems sync: 0.000 seconds
[  160.248409] Freezing user space processes
[  160.255200] Freezing user space processes completed (elapsed 0.002 secon=
ds)
[  160.262354] OOM killer disabled.
[  160.265681] Freezing remaining freezable tasks
[  160.271723] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[  160.279253] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[  160.311505] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  160.377382] renesas-gbeth 15c30000.ethernet end0: Link is Down
[  162.226309] dwmac4: Master AXI performs fixed burst length
[  162.227718] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[  162.227788] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[  162.232919] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[  162.252982] dwmac4: Master AXI performs fixed burst length
[  162.254258] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[  162.254321] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[  162.259706] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[  162.307564] usb usb1: root hub lost power or was reset
[  162.307607] usb usb2: root hub lost power or was reset
[  164.471610] usb 2-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 u=
sing xhci-renesas-hcd
[  164.584382] OOM killer enabled.
[  164.587540] Restarting tasks: Starting
[  164.593757] Restarting tasks: Done
[  164.597263] random: crng reseeded on system resumption
[  164.602497] PM: suspend exit
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# [  164.959424] renes=
as-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/=
tx

root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# /cip-test-scripts/ca=
nfd_t_003.sh
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer
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

EXIT|PASS|canfd_t_003.sh|[00:00:25] ||

G3E STR:
--------

root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# echo deep > /sys/pow=
er/mem_sleep
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# echo mem > /sys/powe=
r/state
[  237.863858] PM: suspend entry (deep)
[  237.867860] Filesystems sync: 0.000 seconds
[  237.878623] Freezing user space processes
[  237.885330] Freezing user space processes completed (elapsed 0.002 secon=
ds)
[  237.892455] OOM killer disabled.
[  237.895804] Freezing remaining freezable tasks
[  237.902064] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[  237.909648] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-169-g1410189b0
NOTICE:  BL2: Built : 12:53:12, Jul 15 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[  237.943571] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  237.992789] renesas-gbeth 15c30000.ethernet end0: Link is Down
[  238.006388] Disabling non-boot CPUs ...
[  238.011104] psci: CPU3 killed (polled 0 ms)
[  238.017799] psci: CPU2 killed (polled 0 ms)
[  238.023704] psci: CPU1 killed (polled 4 ms)
[  238.028259] Enabling non-boot CPUs ...
[  238.028474] Detected VIPT I-cache on CPU1
[  238.028521] GICv3: CPU1: found redistributor 100 region 0:0x000000001496=
0000
[  238.028558] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[  238.029374] CPU1 is up
[  238.029470] Detected VIPT I-cache on CPU2
[  238.029492] GICv3: CPU2: found redistributor 200 region 0:0x000000001498=
0000
[  238.029513] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[  238.030046] CPU2 is up
[  238.030145] Detected VIPT I-cache on CPU3
[  238.030167] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a=
0000
[  238.030189] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[  238.030873] CPU3 is up
[  238.047257] dwmac4: Master AXI performs fixed burst length
[  238.048165] renesas-gbeth 15c30000.ethernet end0: No Safety Features sup=
port found
[  238.048185] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advance=
d Timestamp supported
[  238.051680] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rg=
mii-id link mode
[  238.069106] dwmac4: Master AXI performs fixed burst length
[  238.070002] renesas-gbeth 15c40000.ethernet end1: No Safety Features sup=
port found
[  238.070018] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advance=
d Timestamp supported
[  238.073613] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rg=
mii-id link mode
[  238.119909] usb usb1: root hub lost power or was reset
[  238.119918] usb usb2: root hub lost power or was reset
[  240.279309] usb 2-1: reset SuperSpeed Plus Gen 2x1 USB device number 2 u=
sing xhci-renesas-hcd
[  240.468214] OOM killer enabled.
[  240.471358] Restarting tasks: Starting
[  240.475721] Restarting tasks: Done
[  240.479171] random: crng reseeded on system resumption
[  240.484426] PM: suspend exit
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# [  240.692426] renes=
as-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control rx/=
tx

root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd#
root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd# /cip-test-scripts/ca=
nfd_t_003.sh
 [INFO] Testing can0<->can1 with bitrate 1000000 and dbitrate 4000000
 [INFO] Bringing down can0 can1
 [INFO] Bringing up can0 can1
 [INFO] Testing can1 as producer and can0 as consumer

EXIT|FAIL|canfd_t_003.sh|[00:00:04] Problems while producing data from can1=
 and consuming from can0||

root@smarc-rzg3e:/sys/bus/platform/drivers/rcar_canfd#

