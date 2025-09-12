Return-Path: <linux-can+bounces-4669-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0ABB5443C
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A03B17D3E2
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF712D374B;
	Fri, 12 Sep 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vzijFp7W"
X-Original-To: linux-can@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2058.outbound.protection.outlook.com [40.107.113.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877022D3735;
	Fri, 12 Sep 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663673; cv=fail; b=aoruFu3QOb47mIXpAO6BF9CfbvrJ3/bGktQJIoKZO9l+GnoSum0mFEvzd9N426q7ECGthyx/+HmFLcSlJy5E9mXlUdC4AVJxyWV7rDPNVa7eQtZBOEGVQUtp0eSi3A5YFFuQ25q9fJ627YDoZVz1vPBqG3njeR3um1/6/keRlOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663673; c=relaxed/simple;
	bh=JAk18VntQXfC74fHgzLoduIizw3BQfq1qZVCpoHZDZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OkUrQCB4GwJ36ZvYiuWtqUJI+lVUN4R9IC5sjngii26M0smwxjPt2z0bD5KIjUBIxWSJ4I7K+M6NssRzOoIUQaafG2fHX5CUIowdCaP7/d6zOBl8ogWXAWNEy71o+XfajFTWime83uJowavGUeRvjdJy4/XdctZaft126L/YHVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=vzijFp7W; arc=fail smtp.client-ip=40.107.113.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjl9tWIjRs885ZZWU7uTfIGQW9EZP9T6+oQmw1lP7tMzcohuigLlze+7R/OhlSAWBMRvRjXzMfdF48YZTKRB6ttRH8laHELCdBDjN5orS2rMWnuzZo4X62sAqbbqYaFJB3aRTti07KLxxEopjuwBUcwrtYe/8LENgfyskee9j4XONJS3yJfCHjuJ3rbJTluDVkuLFshy62PVfBkawlE91ik89eQRuwgkGvbirKkd7F2t5R0hQB6C1WFS6fjvhtBu5umHMPIfxsNEdvYM8i0nvydjKczlXFt7yCGgQ97IfddRPRkgdJUy224SPLxAByzuyxjNomWq3B/Smg14BQuH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKe28Yxwgn0KRukUGC+wyssQ5ZRire7qC1A6d8yt2Cw=;
 b=q8qx5Fr2fq++hnEXdkc5wSzU9TFZDCqHbr5O26zhWtjKHTIzZmaIT7mYRfbVDWG/uHGARuEbpA6vhrAcYplGzcJdlUQdleb/pjMrfOBelg6Nd5022Aw+KlhtFm7R20JClSoNKmj333KU0B6nobHYiwQB86eusaqMjIqculbcDRqSPwILlNeZa1ViFldpoKiEojGT8S0AE+eaRYk0ZzrbN2voO71DnDv9UwdluEqxYLkNFXT9lKc1InJmZNvEbP87kOW/fYjVqldZP3y7UDSGjY0SaSlqxpzwEvvzn3MycwVplJyg/lRo+0wJ1PjcphC5be9NzToYQHO3EVhLzu3NeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKe28Yxwgn0KRukUGC+wyssQ5ZRire7qC1A6d8yt2Cw=;
 b=vzijFp7WODs+xuI1jYHuijZWK8jps10R778ztR6NB5is9JllqsuBSHx53raW8zBxd3HVs3gfw/JT45F4ZleYUvczILVZNXoHhNfCieEvhgfq5Wg2Lp+zDVjK1mt6u7RC0Q0EXw6V1fKKWlMJL9Z6Dc4Qd32MM35FDJjluwvJz1s=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB15856.jpnprd01.prod.outlook.com (2603:1096:604:3cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 07:54:25 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 07:54:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Topic: [PATCH/RFC 6/6] can: rcar_canfd: Add suspend/resume support
Thread-Index: AQHcE0pKZp7DWIl5uU6P5IZbLCRQZ7SPTPuw
Date: Fri, 12 Sep 2025 07:54:25 +0000
Message-ID:
 <TY3PR01MB1134652A3383410EB50783E3A8608A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB15856:EE_
x-ms-office365-filtering-correlation-id: 91a8c9e5-b7a3-4432-2a40-08ddf1d1979c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v7B9dN9xmLLjxMKmz8s6J67KjFiE6AUwqQPlHQSherMsfnZfn8sYOYdA1KIz?=
 =?us-ascii?Q?qUyP+9rrEJTRRH0sNzOU5dYv2IXWsaQmEXD8SSn+aPST2Cr2s7rqxAp7hXIs?=
 =?us-ascii?Q?zeKGZbuGt4A71pU3IubEab5gmwC0ieyLBnb7PO+PTeOQyo8A8GXIOkeq4bh2?=
 =?us-ascii?Q?8U+eGMnXzZqfBb/kDBGCloosbXvmW8pDZaM8fNgYlK73ggGvyEqmMaMokS3N?=
 =?us-ascii?Q?bOFfjONawadBXqIs2EvlFSdrdxH3XaYIGOmaY0ecqJKisbWhbNYsHFPgiHHs?=
 =?us-ascii?Q?5ZDAcg0ZYFJdnQ8cfb52wv79AnwGpHoRTgPyMmQlSFM8BmL4OgFe9ouuefuI?=
 =?us-ascii?Q?xKeeJqmLxU/de7NcqFPAn5X0WFUeNku5Nq6Agk9aXiA4uzetdmXd7fU9yVzc?=
 =?us-ascii?Q?BU3m7KJcaNsgSb0h+X9N+hmw6HPmNrujsEkjvMKwo9qIaQNZ+jUaXhn/8oRX?=
 =?us-ascii?Q?zEiTKx55KChzgpAanX6cdrTXDkdPTZIvPQitm9mias+jKGlSIl5oZ10Xxtyf?=
 =?us-ascii?Q?voTCv8jqwQlkpwg4TTVFbnfpcx1Ya/+sg5YBAAsCeI8V0XH+WYRqZ/33pyfb?=
 =?us-ascii?Q?2/LAc4DZuE6vMslkraGBG2+2FUlI7pGbbsffebsVmbK822DI2kRNULGhKDDR?=
 =?us-ascii?Q?puMxCWZ5XR70sxdGqMN5tz0ZVSRAPhKm0bk6tm95WGiwRDCfycawbbolfivr?=
 =?us-ascii?Q?yELVIKPvVt/F6F/Hl+qqy7WGgKPQGlH51/prJKXONEPTvu1MBSV6i0hNxbmF?=
 =?us-ascii?Q?O3VRy1VcVeElmpOnoFuae213hlcbc4YaaCHs8iTZUKS66q7XnYnAufynjmIF?=
 =?us-ascii?Q?haTq/PcKdUiTSlKMwEbFJSRzfCVPpyYaiWPtB+lxqPyNvOvoYHfGRchHEadb?=
 =?us-ascii?Q?6W7QyUNgRhQUlh6BnCXUsKGZaPO7DqnwYe0THnR7Af0RF3un6e5lMdZ5ivao?=
 =?us-ascii?Q?IgoHsf9W973UHmo9ruWUtOVHmDMRX6+BdEbVNEsk6cBxJLM/gIaCfW0ceo0a?=
 =?us-ascii?Q?gj62BLT97syVN3NCPBZAHS+StrN4dQkqu1Bw4qZPcxXgn/dG7D/f64zIFf1o?=
 =?us-ascii?Q?SFZQTsZZMWHnAduJkGTr+NMrTINIpUxAInZ3LKE+JRF2adkuiKUyxp+jQvRR?=
 =?us-ascii?Q?FACi3mcEdlg1kT4YpVm2qJZmbLzV2RQUUjOi5VckJB65iGzha1Nx7pGCrVg0?=
 =?us-ascii?Q?cTU9y3sVzYJk9OgnHZLfDCc8zIie8RJrYaOquisF3yTT8DNL1JNLoMECqkDu?=
 =?us-ascii?Q?Ld8lzArtKwaZyu+CW29dOtSHvRxuXP2UxFL4Jojqn9DdqigHtrcAhY+4InsX?=
 =?us-ascii?Q?RNR0+aA4tDczXjNscNXMocpnGOBaylE7oRgvPczlKc8RRaJZdcU2wRn45r4k?=
 =?us-ascii?Q?8XnN4M1qpfyPBP37+Ryl3qi+yR9AALehDb+RQqeSmB8gLqH0TBlMeFQrqDgG?=
 =?us-ascii?Q?vaRwjNZgNDgrHE4qe9b/PVIMMM5sPrR3dI+CW/0ZneehPdhf3wsW6lnSP58I?=
 =?us-ascii?Q?opBko6s+OXLFCD8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DeGFTHuF9DPQUzaG9MaiZIqKpj5Nn4t9YgWjE0SFZ4I3bB90RJ+77Tbkn3Vq?=
 =?us-ascii?Q?dWq63I6J9gWj9pQ+B6a7amvd2kB5kQSVIzXprh7n2ZatjVnO2CdIVvivE1yh?=
 =?us-ascii?Q?D0nawJdZss/oobwVYp3FeZCifA6RPU+fYOfw8dPCkSDtk3a7yRhyUQlJ5CDV?=
 =?us-ascii?Q?9wOXSs0Hsym3k+S4C2iBgT4EbCne+kAjwXqu97N5oxQRaF8rbAo53wjZJe8E?=
 =?us-ascii?Q?jw+ipN72TS5NulakzKyAyY3Zc9tH8cdJi3mvrwh1d3VusoDfylGuf8Uh2coQ?=
 =?us-ascii?Q?tlvskKISn/u8O+hbD/PdNxAprZgjX3CEapSckFYElGzAh4zvwGiGBuxvKXek?=
 =?us-ascii?Q?fg++BMQyg8tensx2nOY2VVF9u6sBE80J91HCsiQCdTz7Bw2eAruj2STRBKAd?=
 =?us-ascii?Q?WtbfyqJdDwzkLqqXrmHLpENpJ3ASUezFJT/j0OpTFgklQeZoZoeV0Q36U0+g?=
 =?us-ascii?Q?c77PumkvkhWn3q3m4hGihj24ib59EVeNFSJJHgQX2HMTic7vyWqhMIO8qkft?=
 =?us-ascii?Q?mhjtDvRaBVEp5IQOTz/3s6QJNr4k9985PErOeC9d35LSbR1Cy1Hhfjmo9hKf?=
 =?us-ascii?Q?dAN0pevo5hHzGZ7xRqGPeGwsqJiR9I/W5xR4YJ74KnNuEdh53ZHZqwj/uB87?=
 =?us-ascii?Q?EH4+TcSW3lEyIyI4FZaOHzi1+BjLZUQHx43M/T8sPq80BR6z7/LMfn4W2KDH?=
 =?us-ascii?Q?5ae9BY2OpaaVNLyhDj8XEPHOUX/kh2LfQp0cJ/s3CQQq9IqbZ3Gs0fXIaeo2?=
 =?us-ascii?Q?tIeCxrJv0wJyeIFhQeUTaS2zvTk8Krz2NoAzQ42vgsOT32E/JKbGz0gYHbqI?=
 =?us-ascii?Q?uBZTm3BCEZPwEtTl5EvuRvZFNwgsAzjrJLM2PeZQVmwgkDsMALoc9j3otKkr?=
 =?us-ascii?Q?0VcXnabqYxQ+oFWJ8h1dUQGw99/TZlrGGjdY67dF2zJLwF/oxBmQSS6fDHKU?=
 =?us-ascii?Q?xzBlZ6f8wFVOjHZwY7b6VOtHZqM35eODidnOnpMLUjj/8REK8t9WUBdjQ37Z?=
 =?us-ascii?Q?JGjtR7HdEG1/t0QtfA8om4/F6+jqgKZHxjEWiCJ6/QTVvnHWiWmVzHb1qQl2?=
 =?us-ascii?Q?YRlpUOy5Sy8CBmRvBfznVP/hQuEjwbAm8YFUgtrZE2+okodlHk9mbtz9jg6K?=
 =?us-ascii?Q?STXatgnvf+cba/gXJywn4nFcvhFjJLmIZ/SSg3zGWKR+3dQSFqKCPeXPMtz3?=
 =?us-ascii?Q?agYNAxu1McL0cRgrNff6UQiGewZNpl2U/qNQPBtXN9mqy8SpOl3GRyYfik+h?=
 =?us-ascii?Q?SVGmnSa6kGlBpRn4IXiK2zj8iGRt48fXoaHzJZ5VdxMpTwreAD8U1WMNlfum?=
 =?us-ascii?Q?cEcFiunBcThiG2li0j4FTIcaOMUmPY6yAsAz5tcJbYmeeqazegySPstLTDUi?=
 =?us-ascii?Q?/QM4qv+/H+26E+AdTMtGzU1KHWFXsv/+OB1N59I0AmFtZyp6Qe2ZIzXlKWcA?=
 =?us-ascii?Q?fF+EtYar7nUSkJnSCj/kq3j+yWeHfvawL0wUS9siZLyE9rQ/qPqmosoOnsPp?=
 =?us-ascii?Q?vgWcge+JAX7ZlN5+Hchuo6G4kbA1V2kt6ejRlVBX2bvtge/b0dpQgl0v4yd8?=
 =?us-ascii?Q?sY9WOvqBWF6DnGDVqN5i9AUfJvMMN/RHDkadNYtp320y6Ah8S+YNYLduRVt4?=
 =?us-ascii?Q?dg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a8c9e5-b7a3-4432-2a40-08ddf1d1979c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 07:54:25.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOiTW9u42w09M+fmS2PXVtp4CrhOLPxOZ31o+MZ/j3nAxtbGzT92QV6l3QJgG0+L3SCaL0TbHS35P/Ozl6Yl5MXJrCt+7Hkav6yresQj+y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15856

Hi Geert Uytterhoeven,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 22 August 2025 10:51
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

Tested-by: Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

With adaption to RZ/G3E for ram_clk [1]

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

Typo: rcar_canfd_global_init


> +		return err;
> +	}
> +


[1]=20

biju@biju:~/linux-work/linux$ git diff
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_=
canfd.c
index 57ac90e57f11..cb358a4e49d0 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -468,6 +468,7 @@ struct rcar_canfd_global {
        struct platform_device *pdev;   /* Respective platform device */
        struct clk *clkp;               /* Peripheral clock */
        struct clk *can_clk;            /* fCAN clock */
+       struct clk *clk_ram;            /* Clock RAM */
        unsigned long channels_mask;    /* Enabled channels mask */
        bool extclk;                    /* CANFD or Ext clock */
        bool fdmode;                    /* CAN FD or Classical CAN only mod=
e */
@@ -1983,10 +1984,18 @@ static int rcar_canfd_global_init(struct rcar_canfd=
_global *gpriv)
                goto fail_reset2;
        }
=20
+       /* Enable RAM clock */
+       err =3D clk_prepare_enable(gpriv->clk_ram);
+       if (err) {
+               dev_err(dev,
+                       "failed to enable ram clock, error %d\n", err);
+               goto fail_clk;
+       }
+
        err =3D rcar_canfd_reset_controller(gpriv);
        if (err) {
                dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err)=
);
-               goto fail_clk;
+               goto fail_ram_clk;
        }
=20
        /* Controller in Global reset & Channel reset mode */
@@ -2026,6 +2035,8 @@ static int rcar_canfd_global_init(struct rcar_canfd_g=
lobal *gpriv)
        rcar_canfd_disable_global_interrupts(gpriv);
 fail_clk:
        clk_disable_unprepare(gpriv->clkp);
+fail_ram_clk:
+       clk_disable_unprepare(gpriv->clk_ram);
 fail_reset2:
        reset_control_assert(gpriv->rstc2);
 fail_reset1:
@@ -2045,6 +2056,7 @@ static void rcar_canfd_global_deinit(struct rcar_canf=
d_global *gpriv, bool full)
        }
=20
        clk_disable_unprepare(gpriv->clkp);
+       clk_disable_unprepare(gpriv->clk_ram);
        reset_control_assert(gpriv->rstc2);
        reset_control_assert(gpriv->rstc1);
 }
@@ -2153,10 +2165,10 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
                gpriv->extclk =3D gpriv->info->external_clk;
        }
=20
-       clk_ram =3D devm_clk_get_optional_enabled(dev, "ram_clk");
+       gpriv->clk_ram =3D devm_clk_get_optional(dev, "ram_clk");
        if (IS_ERR(clk_ram))
                return dev_err_probe(dev, PTR_ERR(clk_ram),
-                                    "cannot get enabled ram clock\n");
+                                    "cannot get ram clock\n");


