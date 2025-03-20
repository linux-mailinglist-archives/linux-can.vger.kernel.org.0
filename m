Return-Path: <linux-can+bounces-3189-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC5A6A9E8
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB567484A16
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6B2144C9;
	Thu, 20 Mar 2025 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="LOAx2SN4"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010045.outbound.protection.outlook.com [52.101.228.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A91E9B0F;
	Thu, 20 Mar 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484413; cv=fail; b=lQu2Ohhd3GttZ8VFX1yQC2r0FHimTPdy3aDrZMG01YuL8GNLWGApNVD/+Ip3w3jV8pLqzcmapxuArHngoUg+X1gDDr402IrPypOesGp9KImADl2OM+ckhyPtEz7CpoMXXOWGXeWlFEg5oydKQFCO2tqvtahytRykbst3zD2yUYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484413; c=relaxed/simple;
	bh=dAo1vchfj3uimicvTdAvUuLNgN0tjX3roxiI33nZCTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MABvQwcs47D2PPLjUuYuEAeMnxaMmlECr3hr2I870Hwo0ReZPGr1zeMd7zG8bvFVEm1wR1zDdahi7mxTTgsqxRJy2XUVxbc3MYS63IMm9B5ViZN/N9jc47Oa4gWJ0x4v44erChGPEvoTvYKRD/Yhc1d1Fng/W/hr7fCDndAN6rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=LOAx2SN4; arc=fail smtp.client-ip=52.101.228.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuW7/UKPFpcyLKiNVehJWw1kccOHrACs1fbAAlzlLvGB2ytGdmF9628c1VFqEMoBVUnAWatUTBjHBuJ9mykNAAgdinvD1r146m6Hd29suKgdz5MOpWMgPRstfVmnDXYYd1V7bdD8T8qr2y1UpsOyUnE7Sh/GrxxnsHWHP0pvwmIfm8kODQB4mfwDojql0G0tISFKWGqUiS7ek0PKSpC33seyX0Ui30nZy8Qf8qp2dXNOqiJPH9rr0a1GBsIuHHEtk0d5YyaqRlwn2mCk3+wpKmxx92hWja+LqZYoFQSU1Q8R1iE5l4cyvG2kHzKSvIGtZfEPMVR2h+mffkgEV71z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gTOl6+T1AqnEePNcR3+4b6WHkzP3VhovS2qs4OmKNE=;
 b=aii1OfFGhrURsoikYM2g1ruhgHJHC8fWqVW0EfblwZ3dTEbTy/g3NCXOQBX9A9fJ2BKOut9wEcx1z7PM99yYeyje2FE82FNbOHruv/+cr1qtgNeXPom/4hhdYssDWJZBKn7NPphQ6GI2j3P1xAtwwo1nFGYnf+auHXo2y7hS8newPc8zKT/UsdL+7lvsNJlHXdJIug7W5WSrQGwHX5LScarmUK2aQjkJ2AXZHu8GmoKZ7NFUcNShbNeWr8Zh75Edo16fvihV2qLdfhQhYjKWK3r3TTaeMze+0ElR/ShNkNR6iKFbHDv1kISA7qg2uRLQb77GN87Cl2hDGTH+91St2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gTOl6+T1AqnEePNcR3+4b6WHkzP3VhovS2qs4OmKNE=;
 b=LOAx2SN4drGS5Z1W1PqAhvC70mqR+rlphFn7wTiupE/EL8j9J8GzWKFo8MSJv6kSnACZHQWt9qHu+pNdwbSfaeT5plN11tb+QmI2fGaK8fSKZjXYTkxPV1vEhO+RilUi6QhsUG9i6YbtetVzY7dwU/fAfNNbK/t67GK2ZFgKFy4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13145.jpnprd01.prod.outlook.com (2603:1096:405:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 15:26:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:26:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring
	<robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, Aswath
 Govindraju <a-govindraju@ti.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] phy: can-transceiver: Re-instate "mux-states" property
 presence check
Thread-Topic: [PATCH v2] phy: can-transceiver: Re-instate "mux-states"
 property presence check
Thread-Index: AQHbmar9Ro92BJTb6UCbOZTNtqgJvLN8JXVA
Date: Thu, 20 Mar 2025 15:26:47 +0000
Message-ID:
 <TY3PR01MB11346021C2523D745BFE6005486D82@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
In-Reply-To:
 <3d7e0d723908284e8cf06ad1f7950c03173178f3.1742483710.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13145:EE_
x-ms-office365-filtering-correlation-id: e1678eb4-3de8-4570-771f-08dd67c3a0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cTO7J1kmzwPYT8ekvQgoq9TnyKMni92kHhobvN8PIs5V06Kwzkt6FSjISOV3?=
 =?us-ascii?Q?+diHITF23w3zpw+M+oqWLgUQW1JeHMu9ToWvOdn5QnxrUMuW6W247jbDP7sB?=
 =?us-ascii?Q?fwM3tyITKofY+/IXq55T3kgTnoUMSSxlso5yMNZT/TxZslYUlI3+kmEP3/Ff?=
 =?us-ascii?Q?wxSAhQKvceACfcPZtBdBDyOAhwza7T9nXO6kLE4bP/O2zKoaNROCTciSFJsl?=
 =?us-ascii?Q?6OUpjvC+nnL4ig5NOG5DnU3ByljH8dlrHh+QKxm6FNEu8QI3a/pr7SGlRc5u?=
 =?us-ascii?Q?h+g38PUpI8YQP7hHYw1bYaoG6wat38rl/5G7teAQ6jzHYQrpWVfT+As0xCiV?=
 =?us-ascii?Q?JpXcUEs3uBCPYBCi3asZvatPZp9hbXMYv1FbToExOso2ClinathggvlhHEJU?=
 =?us-ascii?Q?EUCjflFv1Sl0x0LobhA+IDKeZM7xwd0Q4iCL5ysQQAqHLwQ6yfwHPlEvt3Lz?=
 =?us-ascii?Q?ta+O3pxvYLBimVBLeJs8grpa1noclwDZXGu7efJlHFZeSRwHEqnRJOObimvW?=
 =?us-ascii?Q?fbuY+UKn2T3mI+hHBYtWUBiDBaILA/dXtDOToucws3PhjKuSu2YwXp+/EOAp?=
 =?us-ascii?Q?37B4fEOH4/tVEoCcPRFB38UENL8GKTNiza59GbTDWTh2r4XR/4Z7uth/QlUb?=
 =?us-ascii?Q?MYjygr3D/18K9H7i3EQZR7lH8jXU6nvfaoKK42z2R+g2Vl+lNm9ieUsScbSx?=
 =?us-ascii?Q?tCIjJ9iBpB0ncEHNsvm3mXCiLU/ayU06BBW9oynq20bHzQUHJQ3M1/J63XMP?=
 =?us-ascii?Q?vAZi+Sen1Ke2vY+8Fcbn+f6cDl/k6UQovLkGbpkScDDXv1AkOw+a71R1ZJIt?=
 =?us-ascii?Q?d/ctguP3Q6oiKZJerPbIKnIltNfuQbWQ90XlssdZVzqLBbSnYBq4NgJoWSIM?=
 =?us-ascii?Q?lKK81rpxV8A7ul3VOo0jWnsSeWaDm2SSG6d/UGAhkAcYpkUs9R9qrHxSYuTb?=
 =?us-ascii?Q?QurpuTOLt3MgmSv4bH0nfxaNWs3RxaxVIbvsknBUWs2IVp7oYEagMcwMwx3f?=
 =?us-ascii?Q?HkcuJ0D9pA/vVeInizAZforqVg9QvdQqfNXaIb3hc4eT1FPDd1S144hBN6jD?=
 =?us-ascii?Q?xi3tjf/N76Edflb/oixMzzUotTZz0Urt/toB68JMk1Wvr9NodXKEsfmsfsK6?=
 =?us-ascii?Q?rG95V+nzAK1/xC1nO53BLRj8vkIpWbmk8UuhpeWoqBSUESHJ9cvDHbMmlqGR?=
 =?us-ascii?Q?l734GTCRsP3MZgmx+OCAjsVgr1NoG64JmhAlLLq/G4Ie+DoVkYxP+XlsIY5+?=
 =?us-ascii?Q?N1z1IhuatEVim3lYEWteeTjf4Y5dpfYesab0E9V6IHtQbiVvUrI3SJKnx2J7?=
 =?us-ascii?Q?fNZVcLMd72Ipu61f83cn2sB74PvgJvNKewQtX5ZF5IMIEZcjgVvL7lHMtLjW?=
 =?us-ascii?Q?7dRNqp1uiXmVfbH68NyQw72fnVaV8HRpg9yUG2sR2Q+y3+MgxNbxnS5deROl?=
 =?us-ascii?Q?UextvgKcvdoAPHb2BGABFIZuX0EsjfXh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jqIdWQdXlvSAFOOVlx/cDWNsSOkwTLY67UykoSlNX9VUBvF8rOnBr1S1i1N5?=
 =?us-ascii?Q?4OkFkGV7Z26KzbkTidruMy7Mz2uvHjHenESKDT1C/Az1Hh5qxmWaFO00N6LK?=
 =?us-ascii?Q?F681AbI5V9xNUZKkyzvLThxyJ3+W10O00nkZEpZS4KtyZV+XrgYBol2l8dqx?=
 =?us-ascii?Q?6iUeqjjDfvbooZKo4GpepTv/CnwCF9XWnBrSV/5NBIn5TnT4UNvmVARHsAWc?=
 =?us-ascii?Q?1sHa64E91haoExsRdo5WXMg3mxjBw8af6GOB0TfreiDYN9x3UEiabd2357s0?=
 =?us-ascii?Q?tS/p7+nanjVVjalbEbjAbFfefATd63/Q8Mg/ctqng61WuCwMUOAHeLAI2VWp?=
 =?us-ascii?Q?UB/ggp9Rmq00wt/wzaHXL6aN+cocSqOL8v9jIPkkDgsWxNXEWC41IAzxRpJg?=
 =?us-ascii?Q?hx197UcLpyw0rkWPH75g/7l1zaatAbjaTQzo4rqjiArvmiCRXi1/BixRbYKB?=
 =?us-ascii?Q?ThswlAYeF3SWJd6ZpofPSRbSTdEDevSo+NV3wzGWABuGgxlP3MYfS8FCFOE8?=
 =?us-ascii?Q?CIay1KhTw/XZa7ZKKKRZgLCrEAY1SYQn6hvVGo2QMS/4Tl4n0sLDOuAjOly3?=
 =?us-ascii?Q?OjrSlYLAZvslkXx4EcQ+FJkRFmSUadnvNjZEEYeJpWcRr/PHoDP1LHuvLOqk?=
 =?us-ascii?Q?jtrYItXQply22HaAHsRdNH2VEi7VdZ9JYfixI3NSueRmVbll/kqREt6BSSZu?=
 =?us-ascii?Q?yJpzP1nXqy5cE9CBBmpJepsdNMBScIHilCy0u6nopskW7ho9UMqca6e45bs7?=
 =?us-ascii?Q?puLs+2UP/mXeskJ9vFAcBnic29I/mHo7DDW2rHnSr8sBYvn1iVYkNgkNgRdv?=
 =?us-ascii?Q?np3O1kJd2IEbm6nJyrVUA8eK7liID2vMkwxyJ8eSt6tOak4+5y9trkGj5LMH?=
 =?us-ascii?Q?JpmqJwyuingQf6WIwhOmBBfWndk2kVBhNknbNukgB+ocgBqLLDseMPsQHCQj?=
 =?us-ascii?Q?iosUt8usHYp6cUqsfARVoKfD6u4/sgtvpGqZuDM435zeFDvB1qIVpyE5+9rs?=
 =?us-ascii?Q?W3WiootcnQHI4DkL3Au9bJuugJz9HlVU0KyRGNg6WFN6r5qhaH33LVntHV7W?=
 =?us-ascii?Q?e6Wtdv4NAISrASfYyvoBUrtxOfdXNIXkS9fwkPZGmcQNGt1CMmCG3uYOGumm?=
 =?us-ascii?Q?oThMu4tUGEfg5tvJpIUM11YEImz6sZR5kQxXIYEiJpH552T1ITb4C8wf86Yv?=
 =?us-ascii?Q?XMa5hNNGWdzsucPp4eFDmnJo27ClTHirmbfVKjvTMp8dK3aGtn5gyXsC7JQ+?=
 =?us-ascii?Q?k13dLDh1p2mRmRObBp8qmPopcZDJ0eXbkkHCXFnxUNTmDuLFhWYzepqbq+tq?=
 =?us-ascii?Q?i7HvB7adX44p+5vGEwmeap/XCBMyQg11bx/fYPCyJo007SBQiQq2TJ/o2Y2b?=
 =?us-ascii?Q?76f/pS9O8uB70I80NReZipWVmhffOxEmv2GB1L3qsM9ioPUQRNjkyZ8xvtdB?=
 =?us-ascii?Q?/uOgJO6Rdm/iRdGvumLAW45X/hVgTs9uRgux3N1MG7h5Y4TDRfcbRyct3ZKh?=
 =?us-ascii?Q?UZZTuR03y6fBk30Up/4vjzS8FLH7iQYogF9R2xEDgtcRlsGUu3voZFsV/jGf?=
 =?us-ascii?Q?i+vbldunUUUOqdcB8HVEwM9mXb7ZzoYdl8ILMeoDxNRWZZHqx/43y7jj01PX?=
 =?us-ascii?Q?kg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1678eb4-3de8-4570-771f-08dd67c3a0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 15:26:47.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rB2ypmBpTWSA9DVakIIpsc5nU1Nlv/dlTWjhAXtz2bklEqkGGZfbk8WBbIBcKrh1gkdsNVC8VvseXPCphiFJmPkcsbNzrhS8AcTfoi3v9UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13145

Hi Geert,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 20 March 2025 15:16
> Subject: [PATCH v2] phy: can-transceiver: Re-instate "mux-states" propert=
y presence check
>=20
> On the Renesas Gray Hawk Single development board:
>=20
>     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
>=20
> "mux-states" is an optional property for CAN transceivers.  However,
> mux_get() always prints an error message in case of an error, including w=
hen the property is not
> present, confusing the user.
>=20
> Fix this by re-instating the property presence check (this time using the=
 proper API) in a wrapper
> around devm_mux_state_get().  When the multiplexer subsystem gains suppor=
t for optional muxes, the
> wrapper can just be removed.
>=20
> In addition, propagate all real errors upstream, instead of ignoring them=
.
>=20
> Fixes: d02dfd4ceb2e9f34 ("phy: can-transceiver: Drop unnecessary "mux-sta=
tes" property presence
> check")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Tested on RZ/G3E SMARC EVK that has tcan1046v-q1 that is modelled as two in=
stances of tcan1042.

Cheers,
Biju

> ---
> Alternatively, the multiplexer subsystem needs to gain support for gettin=
g an optional mux...
>=20
> v2:
>   - Add and use devm_mux_state_get_optional(),
>   - No given tags added, as the new solution is different.
> ---
>  drivers/phy/phy-can-transceiver.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index 2bec70615449f94d..f59caff4b3d4c267 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -93,6 +93,16 @@ static const struct of_device_id can_transceiver_phy_i=
ds[] =3D {  };
> MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
>=20
> +/* Temporary wrapper until the multiplexer subsystem supports optional
> +muxes */ static inline struct mux_state *
> +devm_mux_state_get_optional(struct device *dev, const char *mux_name) {
> +	if (!of_property_present(dev->of_node, "mux-states"))
> +		return NULL;
> +
> +	return devm_mux_state_get(dev, mux_name); }
> +
>  static int can_transceiver_phy_probe(struct platform_device *pdev)  {
>  	struct phy_provider *phy_provider;
> @@ -114,13 +124,11 @@ static int can_transceiver_phy_probe(struct platfor=
m_device *pdev)
>  	match =3D of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata =3D match->data;
>=20
> -	mux_state =3D devm_mux_state_get(dev, NULL);
> -	if (IS_ERR(mux_state)) {
> -		if (PTR_ERR(mux_state) =3D=3D -EPROBE_DEFER)
> -			return PTR_ERR(mux_state);
> -	} else {
> -		can_transceiver_phy->mux_state =3D mux_state;
> -	}
> +	mux_state =3D devm_mux_state_get_optional(dev, NULL);
> +	if (IS_ERR(mux_state))
> +		return PTR_ERR(mux_state);
> +
> +	can_transceiver_phy->mux_state =3D mux_state;
>=20
>  	phy =3D devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
> --
> 2.43.0


