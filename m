Return-Path: <linux-can+bounces-4328-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22669B31C29
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A436604A3
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813DB308F0A;
	Fri, 22 Aug 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Zc5Xq66F"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011038.outbound.protection.outlook.com [40.107.74.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA293054DE;
	Fri, 22 Aug 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872917; cv=fail; b=dEI6CXi9NSnyZJtdyUPwpl/WvLNOQxGePPPE07UDygRI7dRv6G3bYHeZjJxjTC+MKsMJhEhyOdPoqXXjnEumJTAigDs8JNzyObDKSUOVwXB440tlCKLpMBk4DWw/Q8Fw1iBR4e90jlOsDyZwKMRWSai2+RQMDTUSgQicAh/4/zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872917; c=relaxed/simple;
	bh=5rxSQYHp+k2j5QmEEO95GtGIv+ZXPGEwTTV+4pgAnI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OgajGmgk+Jq4ysc5x22n4DBW+vAMvv+EJItgxbv8wxzALHSeVq09yULa6hHaBt+YWdZvruTmybpMWiamWcL7zFvxsogj9OOimCxN9ok376PU0UmyaEb5T2OGlvZfLh0AETlIfoMXHJqj3+fZYPKKh1qcYjLqJ3PTklb0yboa5/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Zc5Xq66F; arc=fail smtp.client-ip=40.107.74.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkgTMUOVyLcmQhR6QuPsGgsLwTIwMzJsycmoemhNe68E1Roa/LWGlyWePpNBUYs9bTV8B/lw+m5aOBxtUJVrZWtnaoxY/Sqd2jmyyh01zlCofJv87nUbUriYR7peYwyBHT/55o6SMrQxB2jllAyjNVYocWl1Mc1nTU+nWE8m/lLaEWEVIfAFlBfGg2GK8/7HkWOWnzZRMYGZCcuNRP9Qrz+XpsESwhqDmKy8wdu89Wi7/nJ/6rm3WTCkukCo85KIDyXiWIV9+uEwzmf+IWpwSBCDcogJZ2rDDNNUgyj5gaQDI63Nr8jQIP7q+UHeJKWCHV2D/EPsc5+COMXTaqx/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rxSQYHp+k2j5QmEEO95GtGIv+ZXPGEwTTV+4pgAnI0=;
 b=x+KeOT1YxhbcgKiDO3Zxqk/OMVPVCKOMureFY4lLkhFzsxc6HQr3egobRuXIXdxpZpLOfJfB/3h2MPkg9lV+CLULYvb/Krcxq/CKkHHAVOLpmvcFpyMyTkV1T8SYTMqVP9x+PzqxUOIaB9+bzcmtQvpyqVLurqiz/bAptXvL/wyNCk72EZJQbFQgeAzx18eVXXh+02mf4KbivXCofITIkBj5JbJVC4F2/pHwfmCsY2iUSmiqYjWWadrmC1mGOtQLamz3kHeKZn67QOnxjYGAwI6FuIaONBJQ1pw3p9mucaUVoCadC9GuiNZiZR8ax5Ask5UomEy3pR5E4wI1oCM88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rxSQYHp+k2j5QmEEO95GtGIv+ZXPGEwTTV+4pgAnI0=;
 b=Zc5Xq66FEHIyX1X0M/edM3XmjTp2nwN+LV/PyBIv6PusD4YfzXZ10/iFFe64Tj6gmcRJzyAIG0m1tDTcHWjtUwDCJtjmkulWYcFTWiWJVPLk8aFEyO27UtDjQY/2OXyh7Vd6jf4oNe1+mVo1XtoXe0ZFnoOtQ6CG1K8tMpGEWEU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11975.jpnprd01.prod.outlook.com (2603:1096:400:387::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:28:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:28:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 01/11] can: rcar_can: Consistently use ndev for
 net_device pointers
Thread-Topic: [PATCH v2 01/11] can: rcar_can: Consistently use ndev for
 net_device pointers
Thread-Index: AQHcE04IhbJZON6V+EWfHtZ2PWVeOrRuu0mg
Date: Fri, 22 Aug 2025 14:28:33 +0000
Message-ID:
 <TY3PR01MB11346DA6FB48F15C0AD9FAD14863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755857536.git.geert+renesas@glider.be>
 <aac66fb5b5e1d6787121cf2ec36b551b41d4b32e.1755857536.git.geert+renesas@glider.be>
In-Reply-To:
 <aac66fb5b5e1d6787121cf2ec36b551b41d4b32e.1755857536.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11975:EE_
x-ms-office365-filtering-correlation-id: f97b4a66-4ebf-4189-bb6b-08dde1882c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9RV4jHbJtkwDushQGjxzsqukPmqI9d5hXpwtQ+WRoWnkP6QHGoKpcCVAtKSl?=
 =?us-ascii?Q?Vn0DsVHoYkDIeuDsiFnIqojaq7G+PM7SE+au7FIlfXyLC7VQJ2EOfAyDjDhY?=
 =?us-ascii?Q?m88D49pn+4fpwCbNXAcQFZBXGpRl3azXphKH8UGyOYjNfkWELsAqkb6Vs5jl?=
 =?us-ascii?Q?vN2gRVMH4ORp/nQyYf4P2MHxfNQa4NDrSyH9/sNwUcgL9pjctcAYCbPaXrv0?=
 =?us-ascii?Q?MYotCCknRMisH6WUwy9KN8241aySsJsrUzdcUnP2J96oZK0+j8B+Xlh7QHoS?=
 =?us-ascii?Q?cgEPBMh+/00smi1JH+pH7s8Wn/FAF5vFr8dqYWwfIOQBOPmOkGyDuY4jsxq1?=
 =?us-ascii?Q?EatJznOka2a4Sk6FRlNdOip+96wC/Jiit8BOn6k61NfVqadxkAVJRiNDbAmZ?=
 =?us-ascii?Q?eFJHqfrNy/r20kFug1sXeSzgzArmdTBzul6N/gdhvNaQh8IGPjbSRJT/XQji?=
 =?us-ascii?Q?s43ybiUgfsGhtpfcG6LxU+8D8zt/Fi2awjPC9N7bPLgKtPTCazY0wS7bLk9x?=
 =?us-ascii?Q?aMUuRjxwTZWyDrV9bCzHGIzmgnlX2v9Gm4TO82hq1vl9lH3Uo1jCqbKNrbUR?=
 =?us-ascii?Q?JkhL/rFzQgU1BNS0/QqVx01Czf1L3UhpPx5APXxzc3UkhiMPbUGR+Owv8FVf?=
 =?us-ascii?Q?WBhDsCj3mka+zDIeUrSGQYV8HE+DOfD+h0+YRdV6/9HowwjeOiKMNGwVZIOv?=
 =?us-ascii?Q?GtdSYiRGiAWVWSKaxBhSJX+ZbB0xkhO6zSqBA+GCWJOxNuYvFRMF4RhX5Imz?=
 =?us-ascii?Q?1zxJthCsIuVgrU8qU5ziuuLwbnbfiGdqRLYZyC33fqtT57rDqnPEkf8+LvL/?=
 =?us-ascii?Q?CqiZeYVjcIoB2h+Xc6eH+0IU4kr0ITru7miRF+hNU9zKYxr8Hz2pwFL7IvOf?=
 =?us-ascii?Q?dUlaUNGF/lHSouWfdT4z1N3bSpK3q8+rHxptg9TLQ5LJe1wF/W42S/RRSACN?=
 =?us-ascii?Q?pgEagy+hw6pxrPFJi3NpxY6fAeV6+V4Vr7BfID81cxVu9DIsKh9QZcWx0iHk?=
 =?us-ascii?Q?blTbzkhZeG/aH6Uf+kWqLQFcrU9XPX7WokspJC3g7aitvH+VVb2yl+aeI/bA?=
 =?us-ascii?Q?rbhUgGpnjXQXlXra0aBDRN5uecGHLub9XRVfx7adiK2gq62IHtTR9IYRpkw8?=
 =?us-ascii?Q?k/pm8pe7Pf8VhMtYFfhF0S5ckJ5pVFWG/Jpm0yovuV3PbjFisqmO3BA+Cn3c?=
 =?us-ascii?Q?QxzCEJYBWCdc3D2zvt7NF+Wb3MvaT3JJT1WK/4Gvm16l0fbZ+h1/o5Nk2H44?=
 =?us-ascii?Q?Z4IlCrOthnFZD8MedVjQOpCvuL5hUttAwJDJ9RxfgA9HMzzWDiBVj3Fe/1Hn?=
 =?us-ascii?Q?IuRZtm4W/Eafr53o8e4AuOwjkF+xw1fK8TQHNk4EomDpK4TL9dMnEoSh0Tgh?=
 =?us-ascii?Q?M0n28a0lj8PUdwBeWk6sRGLsjGYOs+/aFpiy0jhkoPrLijtFp4d3r1w/vhlb?=
 =?us-ascii?Q?g2Zha/Y0BmhKuvg5lVd9kFi9aQuH6rhk/MdMWzx0Ff4sri0r2QOuyySDYUWu?=
 =?us-ascii?Q?eUsfIpzKSjBYr7U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lcUj+PYbkiGJrutU9DeOuNwh4BX06zFWtAYnleHsvZK2Qf2wVHAwHNIDxi6y?=
 =?us-ascii?Q?RGmVkB+msm15fNcIR9nv8Fpl6wcuisHbGISgwPJTknzz+moUlekUwrsdhQ4D?=
 =?us-ascii?Q?NXGaZEf58xrmPEs1KRtlU4A9yySDZmNsUtUH9N4u+Dd3y4SggNhyPvjswrtg?=
 =?us-ascii?Q?3YDAJdeAGD1nCuGLu36iDY4Dwhe9D993N9ByBz9RXsAEfkzTXBEH6cjADvy7?=
 =?us-ascii?Q?IuUujQKw8g/8EWTxEU+g7ihYCqrQsoy02RRFxZwEki/LAmw5W8wjcHr4TWz2?=
 =?us-ascii?Q?bTroMVOei5StjA33im+LthDrLeTf1Yow3ZpwVQts7e0nBL9Usbl/jTUN7lsK?=
 =?us-ascii?Q?tNFjwKQ4ssBaAixbZevGscK66ZN3IGAQbykMArlJT/nX/qN0EM72Z/J2tBkM?=
 =?us-ascii?Q?gOMSuyphjD/q32+j0cVLqqLxAfIha0od/HWbXqRrft/pMs8B4wQjfMVrhytu?=
 =?us-ascii?Q?xXRzSR/We7khBX1RUjY0+OZbLwBIo30HCnEHTeqz42vaksFh/g+y6YNLbzWV?=
 =?us-ascii?Q?jo5hoXXJKdF4C642IAk2/zvcdt3Hv9/9gGYICwyX0sN+95FY8EP3W9aXF61M?=
 =?us-ascii?Q?8HI36c5i8OegPRI82wBAT7vu4XwRLzDikqSJsziKn7K3m08sC4UoSRUpiVTg?=
 =?us-ascii?Q?YBHNLmDQ8dvYBAN8qk9oerJyefmDgINPE9H8IjlTXN8r0UtOGJRXtnJxDh9b?=
 =?us-ascii?Q?Oj9ibkdo0CKvk3zGFk3n022FOoCdSv/Ds+FpaMGIQXmuX7TAIjwcxX+TSI2M?=
 =?us-ascii?Q?OuCiIVm42z67BtzLMQ6AkF9dZmeEbFfLP/y2zQF+Htn9ob+wwkQDhRSw2nwo?=
 =?us-ascii?Q?Ex09kl5y/2DfVb7Ol0ujEyTx3yZrtGqziAi5MZqEFYEKdoNTG00/pCacbEms?=
 =?us-ascii?Q?mK2a1OjNj7zELvRj00u+DkCAGp/2zA3a0BTonWudxvL5cfB7S4fI5fpTi5Id?=
 =?us-ascii?Q?+3cAYS2FpVBmG6++51CscQaZ0sRVbKFAwtKp+iuWBbnCP3MM27BoRMlWNZbO?=
 =?us-ascii?Q?6oaEA+RF7KEnASalYwjMhmbYHoLfXc4bkTznPoyguZMq4AvAv8evCzJKR079?=
 =?us-ascii?Q?J5VJQUIPl+N9bX7hnTypY99Lizh3+CrJc2DHKYnm2xpPf8oKByt+uacPgWwc?=
 =?us-ascii?Q?LlyJR+yHKs3BB2ba9VdOCbyouUXsVIcIodS7PgTBCxpspfzl8maYG57kABfj?=
 =?us-ascii?Q?fBZn1JocQWUwkmEIt4EJ4PP/i0CREF30vnJt+tp7sfzSD3jk4QXdlxBAR6uS?=
 =?us-ascii?Q?FH+eT/VuBDBRm7zyhm/EGmCaLX2QMB4xgQInuArsw4U417lPf0Zhdo3ErLyf?=
 =?us-ascii?Q?6TAjkRa42l4FnYSsDCmFS42hBC8u8qCDi1DC002woVN12fgM/DypCDLGEm07?=
 =?us-ascii?Q?YzQH5Btwycv3RZ1Rz9z7qQkr5HBE7qYXQSQsm1VzLHT9M5CbVjv6wHdlC3Gh?=
 =?us-ascii?Q?PHAsDjBq5bcIHnco7Eba/QjJ8GUJCk3cBlDWh109XvL6j4WETYAEXohxRPFn?=
 =?us-ascii?Q?J5+PPQxjHNN6R5QC8jRePgAYdkzsiodd31sodJtUAcfy41vT96jwK7QcTYQr?=
 =?us-ascii?Q?GavxP7S05grTpeLmizlhaXyY5Y6GwCYLtVBgTdjg1sHZvmKbZPF6nOMPSbkc?=
 =?us-ascii?Q?vg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f97b4a66-4ebf-4189-bb6b-08dde1882c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:28:33.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3J8lFdNw7RGYHHL1jh0lgigon3bwJ274+01GPtSETpZpruA3L2h2URmZGMz779bt8gz/sMAw3D9duUpXXLl3ONl9VHHR27IhZsTyOuScp0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11975

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 11:17
> Subject: [PATCH v2 01/11] can: rcar_can: Consistently use ndev for net_de=
vice pointers
>=20
> Most net_device pointers are named "ndev", but some are called "dev".
> Increase uniformity by always using "ndev".
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju


