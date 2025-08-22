Return-Path: <linux-can+bounces-4324-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77D0B31BB4
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C0E1886CA8
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FE214232;
	Fri, 22 Aug 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JUYiLXzT"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011059.outbound.protection.outlook.com [40.107.74.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABB1CDA3F;
	Fri, 22 Aug 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872509; cv=fail; b=rc/0z24nXb7zXAi/mYXlcPFEWckCKioHZBxqRfNMz63KIbefSAfvxahivcQma+/3aChwLtYWcJZbyY6KiGnB9kh5d5SLKXcRT0siUaGo2vjnRxA4bFDKPoCDNnOsFPhZjPH6nusg3p9au9n7szBewbtol48EXRj6BMVEx1+2fZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872509; c=relaxed/simple;
	bh=WvlVHXRwe5W7AHIBakh9HkZByuFIftHEn+u3fW6Qlgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRuzTBb97u1lFlI2Zr30XudbOB3QrnSZqyy8Wyfu/z8iHB6qMANiaf23ZvbvRfNMpyQyY/Dy9JAjiSFHbWQC5T1rTo5DbIyVOdDI0jxDfuOpVw8pNfX8uZyDOeJQOn5ifsR7QH2FBMNNt3hlxd9ce8izO3B+FR+Vvxud5+1XnHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JUYiLXzT; arc=fail smtp.client-ip=40.107.74.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk5rhSyF3vr7e4Ek2x8B/QVwdwHC+fvsN5u+26v5j378i6lHfEgod8uUqYJkmsAY5xamipwkjcct9ba6+YJusjNHNM5V37bbMsJzOhL1ePydfZH9qv3aUZmhiE34Bl2WMxw7SfLKtrZwM8vYrddB2mkmTQcmvxYEYNObwLnKtghmrSWJPw39r1WCEGe1VLDz23Osdob9XeUKcMAjXje/ORWHNHhtJtZzdpFdOqZ1UTPfGDsjkpOz7bEOty4kRNj2qehKThZbcbAZgoLWxH4EOJxdYQ1dA2K0Dgjxlj7FYxze76HpI04Uvu4kH22l2ZLANQPBY3fcWdQTVUmxYKXNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvlVHXRwe5W7AHIBakh9HkZByuFIftHEn+u3fW6Qlgo=;
 b=RNbHYw3uAeVqHz0v02azRm9XGOxUfus650GD++AIIBvtgEBU0edFORqdnpvAFiJX+r58LmyjXukXanVMdEA72/nZeaGulzBF8NIB01g4ULJH8Z3ZF4Q30+1xTtevJFN9CKKin43knsWaYL7/xVo5jabJtsG/YYfmJzqewOMfe1gnsuFTNoSY4IEbeCWpK/Z7VH4qIf9wHyxsCmvJcNe4lvn0TxB5hhgBuEpULh5ppUmFJEeWOVYQrp5IuFyXOxKnenTEYJxnxzahbTXPLP+YmzqkHWQGWUlMZhx1Bm+0A36AcZDNeqV6S6U4UgvPXBe2jeiH3HzOBzTNxuxKk6tjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvlVHXRwe5W7AHIBakh9HkZByuFIftHEn+u3fW6Qlgo=;
 b=JUYiLXzTsZRZ2jYB777zJ4fHimdu3AZkyMpa1UtdGTJuA9e3mF0LyZsXmITsIzYWNBFJBisrwyRAHzWYuNL6XifYwcxU5bl+nACY2cKMcxbNOynIVY5pIs8nYGKo7FFEl1i5gNe7wj3xbCf6PiWp7b+m+XGUF4eedytQVadPwAU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11975.jpnprd01.prod.outlook.com (2603:1096:400:387::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:21:43 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:21:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/6] can: rcar_canfd: Invert global vs. channel teardown
Thread-Topic: [PATCH 2/6] can: rcar_canfd: Invert global vs. channel teardown
Thread-Index: AQHcE0pEI3iTHv3GGkqe5A0oMsVWZbRuuUqA
Date: Fri, 22 Aug 2025 14:21:41 +0000
Message-ID:
 <TY3PR01MB1134643466E69B0B7032CF461863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <00ff7a4ad18bb26a74c77134182b4efd380ecc84.1755855779.git.geert+renesas@glider.be>
In-Reply-To:
 <00ff7a4ad18bb26a74c77134182b4efd380ecc84.1755855779.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11975:EE_
x-ms-office365-filtering-correlation-id: b29a2d3c-2911-42f1-cfb7-08dde18736bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vCoWkhkTFxWeeQWUr0c2ZvzW0YhYIdVHr/7cmbm2vRRO6rO8XQFQkd+Odm4r?=
 =?us-ascii?Q?y0e1clF1YorYMadWeIqOt09VfdE8VcFn9UW+beH4F0JYuFQfYdbWrymS/4X0?=
 =?us-ascii?Q?eKWyuoqgNpKIZRkIWpMCNuQfzdtIrL9kWNcKiEd6wTUoTK/sz/Ju/ZvKbXIb?=
 =?us-ascii?Q?x774w7OHnt5HN6gP3YGDOC0epyBOxdkjN7uyKO6w1tfdbo+hrYQ/T8LIJRiO?=
 =?us-ascii?Q?PMD2O91SmTDVlp9bFay/01aiQhH3OvjmOfVcaX/APVWXDhsgX1+M0UwiwPwP?=
 =?us-ascii?Q?T/yu7eA4c7R/2MzQMBLVz7z6kiZePNsI2VENWEmp6MmfT3riTfA4pmv8k1Mg?=
 =?us-ascii?Q?OZ3reQogxcZPTYAe6YFucef25kWO3yck+zXK28ZcXfhgH7Az04pQpNoSdCGk?=
 =?us-ascii?Q?iPXkJN2kXRCRCAnVkErcqidGnChuQVck4jCidWwPzLJs4DkEFOyAjZ/cy+cJ?=
 =?us-ascii?Q?tvPKXDpM6hJ4S88H8e1RYYxJjeN6jQuYcLJKZ7RQStzYdCEFT9xW6h8znPRN?=
 =?us-ascii?Q?iNcZoZuooLUBf/EyvIgceU7McF2j73G2WhwTES1H7U9ScMlNTyodRPnO9xAL?=
 =?us-ascii?Q?td+Yekbg4fLv/sn7twajjuleS5NdQITjjbXHgdBO5/FLS5kwI803a1KzwP/6?=
 =?us-ascii?Q?J1LIqVIfeHTQo4dAhO76Bv50FEKJVkZQPwwJjqPEqt66ZlsKUzqQYAFqys7w?=
 =?us-ascii?Q?+Pvxl/m+tszXTVfATwTq0XKnTSyKA+8fa0/J8Ta1NSMPx2pPu0EF+fSjjkwa?=
 =?us-ascii?Q?qVgg7LxVbwwlwoe2mf7ZWF4g+tQ2/HzEO01Xv3P1aRCeomOl6a0tRXTNtlk1?=
 =?us-ascii?Q?OYaUG3hhBVCWA4RlKLv0xJNmBtTC6CqiPKHgtxpBpO625th2MRZIcIQ6MPd0?=
 =?us-ascii?Q?GSdCwnESwvexw5QIfsHQwd53SPlc6aHXtPO77uAuxsxA125fiGVGsTaVrty4?=
 =?us-ascii?Q?kEbT/IfX6syYwrgDqgAGm/s6RyANznT76FIM/4JQRxxbsjru2BITv99byom/?=
 =?us-ascii?Q?GOuXpZsFvvbxPeLSbt8vsJHwBmukU0+kRn5IaoC9jGGqjoClbwg19cQnAfN5?=
 =?us-ascii?Q?fMWxW0OIC5BZq5eEmiqFPjtzIbMAViDEOebk+kZ71Iupz9pKS5fgx2BvurSc?=
 =?us-ascii?Q?UogLK5068mvrwArMn+l+zRQG/CzMwmItVAP5MOrNYMVBQdU6BTW662f7vdsx?=
 =?us-ascii?Q?cXFlJ5SqMpr+aduY9ku5jpyo41e4sEfZerJbp5OZAwJQ/QZovGmybwLRwbOo?=
 =?us-ascii?Q?TnPpaBNDYO9buVCG7EFqY/+eRrtIEv/IE0fCEqVlWUtq0cpkn4sneMxBLvqX?=
 =?us-ascii?Q?coig/DXUJS9k4jNexIAbBYMAQbMx4Bgd3hGNQcUi8U/97sbuJ2cM0JxOjO3n?=
 =?us-ascii?Q?dPj+yhENUoObwD2wxIZoMRBOsP2euPf4B9NLEZkE2s2Ok3ZEX1W8Px2/lmbv?=
 =?us-ascii?Q?4kd2r6yQv/hfuwtj8XoGruOPunnDROUsbbMH0OeqeSmVU5C7M1sw/BbFoqxC?=
 =?us-ascii?Q?KEb7w8e6gkxa4aM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DdT05hZeBihhuogdMOSP9hOvrcQvKc56Ysx/BAM5vCz1BzPEhlcLIputJ90V?=
 =?us-ascii?Q?OEi+sMbC8tWCmsx/B+Qh9quffRjKOUzZGBY6Jj4EErKLjZZ5rjGgxldDDfAj?=
 =?us-ascii?Q?KKmYKLi3c8fizciJO2nLgIgbSC9O0iZiNUVLlZKBubcOeOzehax+h9ggS1jr?=
 =?us-ascii?Q?KNUxN+nA46CTk4zeRYQYrVT5YG9UxshrydlhmOm4vIGM16SqUMt5FptB3e73?=
 =?us-ascii?Q?QMQ+lWZ6HpfiIgPlX5207ei4udwmFxecwT4ZvUEF3FMUsPw7ODS/a5o53vLu?=
 =?us-ascii?Q?s9Efishvqp8ECAP0dQAISFYDEypSGlqHpMAUaQ72o7vlFwAcDt+V6vuLn7iT?=
 =?us-ascii?Q?3KDVOG7Wg8BwfKKYSnuEHXMrdI7isVWJtnIlKgGItYRJfYORh21EQGgp9sQC?=
 =?us-ascii?Q?xsTHnMszM+XCbYw7yf6ryxcWZ4LdhywHuy8AamRq272MwjYnMg7FMZmpVzXL?=
 =?us-ascii?Q?aPPNBsEW/65s+4frsFpSa1bn7U7ByGUGDoB1T/lomsOaO30B/+Q07ql1J+tV?=
 =?us-ascii?Q?sLR59ToRtPwVEnh634omdTwpGHtkGMqIXwMYi+OTa/Hu9yv7IsvuytSE/4AA?=
 =?us-ascii?Q?XpSIhdZbFgVYfU4YY6V8ZWu7LFD1+Eud5076sFvbDU4emh37aV5qKpoiEgVl?=
 =?us-ascii?Q?W3A/2jU2maV/RmJRGVX60duKHW4HjvitXWwKVTbW98PKl0n1u8yIBxQTPYoF?=
 =?us-ascii?Q?OBtqDfSQiw7JsnXUe/a+pXkTtf6fX8WICCp+VKJX2YJXPivn2QWHBI9ygNXg?=
 =?us-ascii?Q?+bCjvq0i+clU+GFXksyBEVwkJKy6G/P8JJZTSTi8kKGAKcDl6qGeIsXq4fFq?=
 =?us-ascii?Q?1GgNDuEFsKFnxyesNINCO17Ac4NkZH0ZE5GhyapNzA2TTtdzCvbKcXoNBD3h?=
 =?us-ascii?Q?NkfEoj3ln5x6MyeuzGdlQPfiMhHtvhkG0i7dL+igoELqs9aWWBGcQiMm3ze1?=
 =?us-ascii?Q?3ZjIK4wOu91Re9IvV1ly6MZnPqFq9XkxcwAaoNFYXLa0bJE9EjbGQBWA395P?=
 =?us-ascii?Q?9yJVSVg86hW9doVbCG14C7nNNR2+lxN4wd6baxyPhR/qg2Neh8gq7YS5HrCn?=
 =?us-ascii?Q?I6BWFaJH7AXNa/XYy8lxhZtNNmKvysWUOycTgoNK0beEIESz0zNF57X6i/7M?=
 =?us-ascii?Q?7VyaWyWUaAIzB5Sb2/L77jhbC7Ye1w9PkO7CDRWBdalJsnDggpLBNO9iG8Fi?=
 =?us-ascii?Q?n0ZZPBCoTBM3poGE4/1PsYYcmT6dUAuVzNe1QwS5LaJoSWaeEvs6IUsbwqVZ?=
 =?us-ascii?Q?Mu6L7TBT5FARbvpiA3bJ0T7dzHhBrcp4tM8GzQ/2a8I6jbZaAJFy+/a5IXx+?=
 =?us-ascii?Q?CYCFRh3TpvJnOF3WLgzq0u7dSW8POdu4O6/c7+LZE/icv90ZOrRq3Ltk4VFB?=
 =?us-ascii?Q?Rz38BNGmnkk225I4hhxcCh7dcTGZ/Sq7wWagalvtfuFp/c64NzADlDiWh0G4?=
 =?us-ascii?Q?vGUijU65yDCSAfJv7yozKqmMneplT2hp6orrGTe1aH87Jd5nrnsgTQb0fJfu?=
 =?us-ascii?Q?4w+2iaGV50SwI/TOLnh4wQ40Ias7mK+46Gpy6Cv8tIRE/XhNziQ2PyLIU3D5?=
 =?us-ascii?Q?Xo9ujZ7ndqjyrqGsOViA+6GB/Jr7uOtQ54sCFpfK+yDsTv554qDu9RerNctD?=
 =?us-ascii?Q?qQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b29a2d3c-2911-42f1-cfb7-08dde18736bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:21:41.1595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dhcx58HJIAi8MIInWv/UYmr6nAj2gXrxvvCURwIyTjUIYosLBrfHTw9vFEtcaaZ2SFLTo/wqNiTI4VQKuHRoH1hSzqLbqqvmXUvj9i/n0Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11975

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 10:51
> Subject: [PATCH 2/6] can: rcar_canfd: Invert global vs. channel teardown
>=20
> Global state is initialized and torn down before per-channel state.
> Invert the order to restore symmetry.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

