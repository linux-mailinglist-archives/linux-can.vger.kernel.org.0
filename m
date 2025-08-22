Return-Path: <linux-can+bounces-4326-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE4B31C25
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9767B58570F
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2498D340D9C;
	Fri, 22 Aug 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZEGqU2rF"
X-Original-To: linux-can@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010065.outbound.protection.outlook.com [52.101.229.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A8322C70;
	Fri, 22 Aug 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872806; cv=fail; b=aV2P3+wiJxm9VNums6aQN4qEjfB/6pJRIwa6ZQRf2GcNFcF42yHSUOCAJ0BwFutc8HhvuWZwIFcbLuFlCDmrT3L0V4WzLQLxOvhUKPWrA2PeDF1W+vRguuhS+Nj2RRpXdgU+u3CsYRjoDj9swOR5NSYDNvZpYwWMSIf1/yy9DiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872806; c=relaxed/simple;
	bh=cnzTcrBGp6/nWTeLLTiVgD6W71FoKjVtfCZrSKDM93Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKTKQfOJoaKN8MiqYVYeVx/3tMAx7muC3bQKLLL9jKXai65pEGCwY94IOXLrSpZWAIURRIgPXitPpvEQ0GbdSmVrMpRmBxg8I3u9bJrhtjIfsgbws21Cv4axJMS/Jz94vY0xUTNWLofSSUDwkqS4d7UR5yeQjohkk9X/sUD3bJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZEGqU2rF; arc=fail smtp.client-ip=52.101.229.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFaDHecF3AB59pZzZjizozq/z2duyNrzGy5i9eJtSkHW4EelCusRYxzFDHNZW8nLBRCNNs3gMjUs8VxvAeZaRIt8gD99dH9dLbr1OKmM7OSFC2+zIW6VISIvQ1iGmlF5mXroVWbVZsU62FeVr5GHTqaWgqh4T401lAiZa1XkMtPIRNLKFGHoEM6ATpiMRtBzMBT+ePHXRc3Y8YWw9PPWS8DofIgL+Mr2x0NLMRNxcTLA6AaCP0OEDoVxgtvd2BI69gmdQYm6NHVHRn4bkR6n8arjRCFrcYwpG4RjY2NDzeloEPTOtXvwKKu8frFVagUHh5zocv5Y7NpWgVTzwTlUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnzTcrBGp6/nWTeLLTiVgD6W71FoKjVtfCZrSKDM93Y=;
 b=s+2KTF/6p4kzfWrUXa5hI2ZIeCwEf4sDq412KyLdSqhY00VUFY3qf8p63G6Uh6bHeq08C4NWYpT0S6Z9xpGHJZ+EjebrTI0i27UsYwSe8E3yi45gIX/4EzvHDdXDtg5OQvztUF2l0C8wSmfupA4R0iIsDqrI1h8oy5+F4ryTZe/JxPysd3W6EQs+83bPRXFto+Kq2aclYSb/oc2dtZGM99OkZg1aajtmFDq/SMVpUwo8NsNTVPxzxC18Oi8E5tQsS6+mXQpL+JxQqECVGp8B2/KBuRc3UXNMfrK0BwpiyloERDokfMBYmvT0VUi5tkVcbJLoBwyuftL1KGkoGC9FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnzTcrBGp6/nWTeLLTiVgD6W71FoKjVtfCZrSKDM93Y=;
 b=ZEGqU2rF5lqlmRrU0gIIGWbBJlzh/uZbeRIqOUHhpsy9aUKlHgYttaIJs/wlcvN69TFWI3DeXH7eGCrwnP6aIBzQsZXOkcCZiDRTdfHydvQXMigEXCClCAvueHtzuokzvfNmvPomCoXedsJFOVEXOi9Aqccz2oDakM9sFSSAlJY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11975.jpnprd01.prod.outlook.com (2603:1096:400:387::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 14:26:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:26:41 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 4/6] can: rcar_canfd: Invert CAN clock and close_candev()
 order
Thread-Topic: [PATCH 4/6] can: rcar_canfd: Invert CAN clock and close_candev()
 order
Thread-Index: AQHcE0pHrfRgdEzUo0m0cSeKNdTN07RuutQg
Date: Fri, 22 Aug 2025 14:26:41 +0000
Message-ID:
 <TY3PR01MB11346DCB9DB8384DDECD2BBEF863DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1755855779.git.geert+renesas@glider.be>
 <e5e09af5bc8ac530b7be6a958beea1941166b0b2.1755855779.git.geert+renesas@glider.be>
In-Reply-To:
 <e5e09af5bc8ac530b7be6a958beea1941166b0b2.1755855779.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11975:EE_
x-ms-office365-filtering-correlation-id: 16787eaf-9641-4357-7afc-08dde187e9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PKNz2uTnJ40Eq4KODo1WTpnUCFdY9TQns2h2KrlaK65yeho7fuq12bhWwS2I?=
 =?us-ascii?Q?G+LphkZQtrpsXPfdkrjjVBQbZ5KGvdANd6SlHffyEb/BCYwax9+SbNbmgtaS?=
 =?us-ascii?Q?Ezq7uYRs1SyffbCexP2+QOn3Ib6JakPI45gwtVtUurCf2S9kBOx3/XvIuWcv?=
 =?us-ascii?Q?5FjvWcqx3C0xpqC7x8GHcIrgIczm0SP7oemsQp+8iba6+UcdTKacDnmYOUfi?=
 =?us-ascii?Q?XQcVeDiT3X13tEyFyFfk14wQ2EC2xFTs0hG7jNeNiHxgmuy0CVOXEynsEzlB?=
 =?us-ascii?Q?zVT/ZwBy+6arBw+iAhDofs7/b8voKK7Xc2dC9x28MBuCBvi0s7gf0E74b+MM?=
 =?us-ascii?Q?3SSQzaa5Ndm4WJ/+qaH0i1eodbr1XvDpgo4vwMsqm9vjQm2UrC91fUQZg0Vq?=
 =?us-ascii?Q?iVJr+lDNUEcOEjmlWu6hPtSRdLxpHM3aGVQEtYv/vH2fV0w3xr5jptHDetRK?=
 =?us-ascii?Q?CSv6+wnaImw/9a52PVVlV9W940n6iJfWzjjpUwij0fMKV7Su2y+eoyx1Uj0U?=
 =?us-ascii?Q?oVMVoE1G2K8i6fbj9YRTXNI65F5ARZ80xqicyP+na7ZaXx28T+V1vXYdfGOO?=
 =?us-ascii?Q?+UWnVwlTqF2FwHzgGdhlopZo9SItwXQbofgybTGS/sHW/5Nco1RBRCtCkzns?=
 =?us-ascii?Q?RK4Ne9dHe1YC/X8B9OT5TCZ0L1wBTJ6mpg9GlpvxyTs7+jbUxpc6MYgrGhfa?=
 =?us-ascii?Q?qmu8ePQm/fwbwZJFOo4f0UbU+argOahKZSEzKgG2DmOgYkXrJNavwLuJ5ksy?=
 =?us-ascii?Q?ycLethH9/Cd0Oc7t5TWBmJ6vBkdqfgjfSoEKK3VB62ghLP4tlgvymrYTuVJi?=
 =?us-ascii?Q?X6U1FNbRg30XRQIjF3d4A8oyGpJgwO96419RvPoQXmh4zcUHTtA3TEzDkR5j?=
 =?us-ascii?Q?VjaTLyO95yEsgqbqu/X5yJvpKkbgTjo5WYundMjjlpOL1WJMiRfe7keZjQAg?=
 =?us-ascii?Q?ugdHT9ZgYj2ryYn+j3nnXat5UYUOiRjlauCEqsqfHi5GUJG4NAtTQIping7k?=
 =?us-ascii?Q?7N14Z6YBinTwCMFqrO7ZRXcbbpvibNMdsblKPX6o5ujz6MlkMyQHMAPD0LSy?=
 =?us-ascii?Q?qQ8IHrN5l+aHAv6BriqcChqnONGsJXC3tezFEAjC49R7c9tC4KERVpRNRuuC?=
 =?us-ascii?Q?my/mVfrAZyn8B8UxqLuY1+WD3MbgHJ4Td8ZJeGqPCFyzEUiqqeTOLNJj7UHB?=
 =?us-ascii?Q?DzjpTfI3yn2+lqFcRI61jt0sVkIvZuTrrGXS83ibWWUStQFqtG+jQvuZRIvD?=
 =?us-ascii?Q?PFBgACXgTck5TSf8wDazTmr4MywsvUQU0LyI6W0i/NIc/BlDwOKPipMKpG+7?=
 =?us-ascii?Q?AO7NbtHDKtqHFZZ0VbU186DMJ9iQsjE68RRt98cUWswPKqYXsW+6p2FF5oE5?=
 =?us-ascii?Q?RNsURwWfgWswOL7jvxYWeCCYbdlFGbvcplncE6XNANuF8PExzGkjDk17gG6Z?=
 =?us-ascii?Q?x/uYRYwtU8Ng7QlqARQK9wUz65LgWrMcrsyW3JBWaXO/TKxyzlithA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rWhkeoXodhyZD7mOWiBzBRgC+AAQvlJgS0py9jnYE/u6YNU2xOwHD3Okv9O5?=
 =?us-ascii?Q?K4LUjTNf46BguAdLLyE3ZUQo+pbZ7WETcEodetpyVyMe4EFXt78AyqL2uwt9?=
 =?us-ascii?Q?i430Yivjk0+ukBI/Hahvp12HMciAp1MH9H8Xc8gSLpB29WabTzXSAsu8YY3R?=
 =?us-ascii?Q?d6b/qMHaYC4+lkD8Tpfm+YiohCGXU+ZwpcwJC+8hJhL3w2GrGUYB5gpTl0NP?=
 =?us-ascii?Q?/HUcfg3713vXG/jpaNdvn3zkinDCrfjMV1wDtKvEuyFNDhVlM1QimwwsH/G7?=
 =?us-ascii?Q?I0YS2OEb0JUf/NUcGx7KJktYuGOczJ68EAE6xcB6PBwMNEcDCS5Gw2LxV/h+?=
 =?us-ascii?Q?EB/9J56jKUC5MbtXtwkE3XpLTBm0Qauf1OVG58ERAoObAIRmpDfQdhhCEdSV?=
 =?us-ascii?Q?OEww/F1Q/YNdZ3Icz2wERxN9aeaCyRrFZu4lIkMwaEtjnyDqQkTKOF3xOnBr?=
 =?us-ascii?Q?oCKD3XbHszTc1ndkNqwHVQJ9k8sKN8pO+V+0W/llm9FQoWfrV6EOzsaM9NyB?=
 =?us-ascii?Q?4uJesqcL+VeNDKIo8EqYW9pgtWSAr0aFszvVcPSA5PkTOhHxe8bLijL4Edbf?=
 =?us-ascii?Q?5uOoSEvl10ZQUy+djWO4YznXaGkvyLGubKB3cFRwNrYGKfunyTZKtbv5AEKi?=
 =?us-ascii?Q?mXIl9xlk05mKnLWUzAnxPeJO+FuV5o9/KSOYXtAE4nFySzD+xfK82glvNW9+?=
 =?us-ascii?Q?CuWjSAqEwQerP3tGyz+YwaR57o4M6rbLp+NwuQpUU1TEXoagXW4eGMaAUg7f?=
 =?us-ascii?Q?i/vUKb2SoSZrTIfYCpZ5uXZOr7WHnbh3FQqiM2dZagcOaxaOlzbuiRgDPfwA?=
 =?us-ascii?Q?co5TDLODUTkHiMLk4Z0a8HsutzdjAhlgh4Tyv1hLHx1xXwXz2sSIct1CgnDN?=
 =?us-ascii?Q?WVwEoX5sT5hyb5+TiJzGggnn1yej9vjUuksJAS1cEA9QPBZg34939pyvJ2QM?=
 =?us-ascii?Q?19mNj+0dkbSkMgbA9FNaGqd7Sm9LPxoNwroNyjWHMys00Wl5mWMiVwvpkD8/?=
 =?us-ascii?Q?sWPsajRafttTxjfYqCNHTVr8P1U0dbK6RATzppt5SYHUooAC8g0oVFhrIeUm?=
 =?us-ascii?Q?LTRQ3ORPKLJcWFBdmHNzAufTDMjXMLjL0/em9alNXx4zVjjJ2uW0pAGxnLkk?=
 =?us-ascii?Q?R+PDb4upVTovM+7ADeqRZVrFoWbkrLyxxFOU6rF3npmpPLKQrJDifPERF9bm?=
 =?us-ascii?Q?3Vb+Q0XK0CtHOhWGHX4QZSzKckgz24FnoH2N/fKA5oYDcAHvVZcYbC4L6ze3?=
 =?us-ascii?Q?F+EO9hX4rxUbs1klHQZPDjRNhp6pCgOvPiV8y1plwp/DDNiyztiu5xIvCqdw?=
 =?us-ascii?Q?IgP8ivQnevWun3bJGgBdr3m763gyj/TgjvQNX5rfrw315WH+PdX6E+8BreH3?=
 =?us-ascii?Q?l5PbITgC+I2TfJ3CIqy5Payo5VczxBPmu9lJGsgEX1wB7f0LgWww054HvKVR?=
 =?us-ascii?Q?jI1cgjFaPjR66Dt8dh7gXwYt6SORRnn/NzRWMcXkX35ov5miH2DpeBHAxbry?=
 =?us-ascii?Q?JFfkcrnUV4vb2dWm2Vb4uWEm2j1l91E8s0amyj9hJn4LM4O0hxhAfIxDZx0V?=
 =?us-ascii?Q?Jk2k9nyx1q+nLsLpQ5X2GNPkPAhQulWaQ3H5MdWY+z0pVXpuOlaRp++Vqfxm?=
 =?us-ascii?Q?Cw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16787eaf-9641-4357-7afc-08dde187e9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:26:41.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVhFRv1cS4V80GU8PrM9tnYXTu7PvEnFkMzATEEsHAPfiMW9CGfCeEbUM2FImdrDnb0agBmwEx+hNCPmcqgF8Pf3O6asVRAYRRQ9dAVo/1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11975

Hi Geert,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 10:51
> Subject: [PATCH 4/6] can: rcar_canfd: Invert CAN clock and close_candev()=
 order
>=20
> The CAN clock is enabled before calling open_candev(), and disabled befor=
e calling close_candev().
> Invert the order of the latter, to restore symmetry.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju


