Return-Path: <linux-can+bounces-2929-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E870A3FE2F
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8A119E017C
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF08F2528FB;
	Fri, 21 Feb 2025 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="c8cE6pno"
X-Original-To: linux-can@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011018.outbound.protection.outlook.com [52.101.125.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00F1CAA90;
	Fri, 21 Feb 2025 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161041; cv=fail; b=EbFNd/vFeGqE+V5p7oWGZ5XZdQX5ry1VjCCiJwzBcmE3R4NIaYCdeaPK3iqj4Q7h+DSepQScstdVrGspa+lZMmCOkQXlwK9qpukVGl6kpZ2savWHzmcte1yfH+XR3hwBBi2VmEAX8Oz0rG5GSBIyVttGF9SmYDNjTNxTs3IhPrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161041; c=relaxed/simple;
	bh=ew9iLoDccCzK+Sg/wZBRggaJCZR2QC/paFC9PlTWj7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ECPpWYL66tQhlpe9MJa0Vvu2kVhBzcKG5uExyKZdMSIeK2V81zC4Q5PpKcqewHusSjX7i3qUOLxv6mcBKIOxT1czFRbUH0D1PzCwkZzSvNNGE/fwgSfz8MxW2Wd902y34zROGXhIKXCGIwwMeI5ZKcKH1efpEHSEwjeAZYldnAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=c8cE6pno; arc=fail smtp.client-ip=52.101.125.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTkTlYJsXznpA9DdRrz9I9Sqp5Z3aaCTO+aV62mFsKyaDpU4xWwLLfCTqagKEmGjrSidtKu7qn9phrmfwAvOQM6aIcxbvpl1+TMZU0neqRsxp2acDOuoeCntdlZ2cf+gy54ye9ZUq8N45sWPHRgd4m7m0YavXelGz4nYZjk9Uy4Q2qzww3+mT4xKjCcMBxphG79do6z0ly/QZwvaXJ4/sXoEquWtC3uUv754xXbQ6FqTAWLKjDACx1AM17m9IrN4xV0dSTclRXbsJEEJ61YIANVrSFH3asGwptZsk/LVKRNbJH29Jek3fVi5LflZv99j5nmoDjMlEuBa5bNPchH+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMuk1G/4QTdVN/GNzvRfWyvYv8/2Y3hn/KX3rk5FpQ4=;
 b=Z8KLDTxNBl/Ze7rtUgR8EmBdZaxCk8vEE2cA7OBhedtrkEfk/R6KCRTo/sftgeDREjVcJlFF7o4l2bXMwlNIqI8XdIkwDwzdRErq19QN2qS4u426EErQYC2cvCwDOh9x+7lkEohseK5/66GZkoV/Ju9sFE3eF8O8Z+k7BX8wHsgKmD5wfK/+Y3viU23emjJ8sSwW8UXFCcCnb3YgN9jkBb2QnUVTu6cCFFRi//YIWslvLyeoFOGS8dZ68+5O5em4KMB5yqMR6S+XSmotL41p4mVyUnkln1UB+Kjw3BF+28ejQ9SmuP7thZIKARy5UN0CFFY2+4I616U5MPonjwLT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMuk1G/4QTdVN/GNzvRfWyvYv8/2Y3hn/KX3rk5FpQ4=;
 b=c8cE6pnofX7JG9jP5sTjF+g75bJ10D4XF+34o6x64QaWp+DKq5rPrerz+a0nlxXixMkjAB9xq3NFfUj+2GOep7GxZ2MObDywzKiCVnW0LvJDbX1omWIDiT4dn9uYLD5yIBY266hP6KrE3Sf9NpGloDQNnV/x7IhArHPrLrkk4DY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYTPR01MB10977.jpnprd01.prod.outlook.com (2603:1096:400:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 18:03:53 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 18:03:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Simon Horman
	<horms@kernel.org>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Thread-Topic: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Thread-Index: AQHbg5gEuVeABlhtqUKyBuyQ1fkjX7NSC+eAgAACiiA=
Date: Fri, 21 Feb 2025 18:03:53 +0000
Message-ID:
 <TY3PR01MB113466DC415F74C0FEF43C7F786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
 <20250220130427.217342-3-biju.das.jz@bp.renesas.com>
 <20250221-childlike-deepen-8daa4513d5b5@spud>
In-Reply-To: <20250221-childlike-deepen-8daa4513d5b5@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYTPR01MB10977:EE_
x-ms-office365-filtering-correlation-id: 83918fd9-3dfd-43af-46f9-08dd52a21a5f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/MFL5uEHQaaXubnTiWxoWolRcMGaJ2NRN1JaXqzoLxKK9thI2Ckw5TRbLzkt?=
 =?us-ascii?Q?gTqFn/JBnqoKKXb87XOjGWZj0gRyDVBm5fiFZ2/E8ug9rD/tY/cgLC9W3ud0?=
 =?us-ascii?Q?PCckLBlpn4fH1UMSH8ixFGfuoC8S0qqESzbUXipYrLBz8RAhkYkYmjmWxl5U?=
 =?us-ascii?Q?EOj/ou2Y6fdFzOdFR398CahxHwUFh4T+nZsK2FNGrHM8xBBPnZXqPhQ8we9C?=
 =?us-ascii?Q?PrY8NYqISiMoRXMI1eYXUDkV5wPkggfv83XBoKHidFQRTe2Zru4xama69lXG?=
 =?us-ascii?Q?DaW3MWI2O90vCwnkMDC/MMlLlyTdGvn9WCq8hwTVq42kw7GjAfJKE2jfIrmK?=
 =?us-ascii?Q?v094SM01Pmbx+nWXw6K/72vVLuCE3zNHO2Ynm/EFfiMnUs3nm3xo46thO0eI?=
 =?us-ascii?Q?tmcw2Bx1v2rvpQD8WNNSozdrGSejZgf5rObTp3ZQD8Ih0o4xI9b0+Hte7Nqm?=
 =?us-ascii?Q?IKg7dqKbgLABk2WII9+l5rDSR0mv0RtnbXZ+GqdFeH1RU4WifSyEZexGRwMH?=
 =?us-ascii?Q?lTGFKe0nuI3cMc9mhuB8ILKkVUz4y2eKqBNgC7UfjyGFjBKFTuRLueC7nHjs?=
 =?us-ascii?Q?SoXqsrwY8NfPbjWfdEDGvK/k4r9v6qdrmMX4WjK43cwO7U1OdpkH8pONTrG4?=
 =?us-ascii?Q?EtS5JAT8+Q+UJgJUZhZ/YK0MWJBypA4BcS8QKsyG7xj/h1fDnpwN5Szf/LKH?=
 =?us-ascii?Q?xKXpnME2I8n05m2FYkou+k3tb5rs6HgfCGct/+YD32ctmeUGCH04ODbDZFsA?=
 =?us-ascii?Q?5bE4CWgeiN59f830a/pfBbYlbaFjSmEmtNDIgFbM3U/bHBW8/LrAaB0xJgns?=
 =?us-ascii?Q?AF6qC89XXLe4H+7psNXRpQG+92eOSgQlrI1TDjbY0pjh18YyACK+a8yISMuX?=
 =?us-ascii?Q?i972ZQPS0BPbWzpHr3CiHbZingHnnfiRCz+qWsMsSCuwhRYwcXngtck6Qwg+?=
 =?us-ascii?Q?wA/3tfGgRKf2WV/45iJ5f/m6Q1YUy5KMmvAggip3lXrRk0E7/4tOdO5ekG5W?=
 =?us-ascii?Q?DK/SYNFoaYM4wUVxc1LiaXJOHQDnURUMZjWSrKi1LuSYgNhqJh/UZct9yqxd?=
 =?us-ascii?Q?Jum1viiaAK8UGEPVUUxbrLjbTCAWdEuPX3wmHxHiMTFo/NSsuYj10L52rOI3?=
 =?us-ascii?Q?UtftzZS5qBiS5sY5RkFqsOOTE15bLmXJs+bN2OZIuI6XK3C/FH0A5KhjfCPc?=
 =?us-ascii?Q?FgKrYJyiqX5ckf10KO4arkQhPDlDyYz/VJ7ZIqErsxsS+YCq84liGcPwhiGf?=
 =?us-ascii?Q?SiKAcr+/OVsozLCvSooDI1IH/0i4AcAWE1Rs6jnmK3QTEMTWT+HNL35TqdVS?=
 =?us-ascii?Q?htC672Z6t8RVceEQ12nUJOxwmJZoR+LYrnE018wQaLemgzdb2p0wZSO7uadb?=
 =?us-ascii?Q?aq5sw/JUTaM8/lG/+bOZphip9V8DpqWXGrKipMJOCQxDss2f8kzL362bASDC?=
 =?us-ascii?Q?RvtM9q3cG+bsM5GNL0cpHA4XKKkMKDer?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XBa8ZpyB+s9AqKyyMLCOtwXrYeBBUz/1YKcOu4gZk/73tM+Wkhf5iN4YB6HT?=
 =?us-ascii?Q?4jPuQZ9O2jVFDNDPmqURDrexKC75mLEZ+79h0nV2RWIzaMQkNEVvcut/jzPm?=
 =?us-ascii?Q?wEs8QjT7wDXtfKDlYc94WsX0MrxdPgLN8LcnJAxFL91pyHi/1wf1tX+KMNgg?=
 =?us-ascii?Q?wV26mw11u/+tOabyMjvzrnWJa1YUdBCDWrQ9D/aqxDUDZ6gyYacGSrqTjzam?=
 =?us-ascii?Q?RTXWYXVET54vyZsV1Osf6qGQhpOsBhNouyEGdwgRCllIsQcelaw33RJewXPC?=
 =?us-ascii?Q?x4DOfHitbulYaeq9VJHIgO4c6g5LvINFgKtNOL4VuEQzv0esnW02CjwqbSqj?=
 =?us-ascii?Q?lOy2vO4ot1W9ljq5Cq4uAJmCfy8g+l0XDtAV1Rt2CwxMDxuZ9NrKSQKlYoMg?=
 =?us-ascii?Q?exZfboh0Py66FfJF7K7XlOc2FKXE/PqsEmerEbdehliexlvzO4Rr5k5wpL25?=
 =?us-ascii?Q?xEoI5z5a6RbmX0vLfaoT8vppsa/OFPALsxvJh1PGfaDG/KuVmH49ecsgNzXD?=
 =?us-ascii?Q?P826UU29Rr0+H8mDhvKV2QGEg6znKpE9s/bpDE0hPBS4YCgmX0eSfv53hP4c?=
 =?us-ascii?Q?9GyZuXl++vzz6tVoTKNtFqfesdKC0HMTMmDX68m90qtxycAX0DZWd7N3EzZJ?=
 =?us-ascii?Q?ukFgiKIYWojdN4PvV1oz08DWNRDMHEmV3FTw7xbq9AjjcdyFLenB0kst5y2t?=
 =?us-ascii?Q?yyulY2iWoKrD9Z+FU4HdxAr4tb4cwRO5WHKEl3Gv1c5z1Zj1xnBtxzZ0AxEN?=
 =?us-ascii?Q?VmRoQGxC2F54smG1/P+BCLLFthZWls/xB60h9poGY8C10dvXZ8vz4bMtYEO1?=
 =?us-ascii?Q?k+8TC+oE9Ai3xvonq3FCoynMqa73AHzX0/JZnvK3T5k5+sIDouulOle4CZOo?=
 =?us-ascii?Q?JmQ6356vvxiUK00ID40xTfgMOv5S71qwCKi0eq1V7jWrL/eDdoi5HA5JIpKn?=
 =?us-ascii?Q?ddvxu+CSaFU8g2qpMK0hTPWuPD5XqJF9QsvKO44DVdmHLZ88+l7aR2MKGJzr?=
 =?us-ascii?Q?P/+bMZ/wZMN3vR0019NIQO7W97narBUPjC+eXq/aVsBKpiArsOzwZ6mFVri4?=
 =?us-ascii?Q?4vHJIuK8C6ok2oe8GBK5ksy1ZugplP29/hQ5acvFSGWuVT06XAxs71koe25s?=
 =?us-ascii?Q?iyw4/WyVKi9D3KZoTZS0jwDMxdEzWpiNuTSJNUnmSF2+iNkb9qzfXs63/n96?=
 =?us-ascii?Q?GveoNT0WpWy1VYeVBiOimsN8devaCy8khaA/ZLATp2EhOGkXEUk3j+K/NQSM?=
 =?us-ascii?Q?XZSsS3iHoscT8+A4KP9YpXENQGxiIVHCcMTJD/VmEFawyVKUvZ5qZu/A+KsU?=
 =?us-ascii?Q?48naePyRQhf88ox59XdidC9VAUITmNvW72bMRnmB2l2ONTkbsvY+cNN+v0Nf?=
 =?us-ascii?Q?XBiO65+E0YddGaI3VV46PIgTTTF9IQ1uv+XxQbMRUEp6Kf22fuqUTW3rlXKE?=
 =?us-ascii?Q?+cFq4cuELw0nDZwgkwF+ONOBNKBkrxg0P49mirthRGDpAOP7e3e+Q8NHG0q0?=
 =?us-ascii?Q?xhl0SLCeSGpt5LIx5pQfHCJA/jJDRBwRhPcqEFdMqAvK6SVJe90lzw0NAhHt?=
 =?us-ascii?Q?fwF7tPFfwwl4QCyBQIBJ1Mbe2a8Pl71+/FiKLGWazRClP65YveDdFqPhRl6n?=
 =?us-ascii?Q?mw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83918fd9-3dfd-43af-46f9-08dd52a21a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 18:03:53.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46lgXltHJG2hrksUHld+5hMqaLn3nmjts4UfOGjNKGt4nyAqYOU/mkUVt9N6Oj7r0ZbUfVW7vOSW1lhlV0Fa76Cg86VgF31gVE8QxFh7fa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10977

Hi Conor Dooley,

Thanks for the feedback.

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: 21 February 2025 17:54
> Subject: Re: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Documen=
t RZ/G3E support
>=20
> On Thu, Feb 20, 2025 at 01:04:18PM +0000, Biju Das wrote:
> > Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047)
> > SoC, which supports up to six channels.
> >
> > The CAN-FD module on RZ/G3E is very similar to the one on both R-Car
> > V4H and RZ/G2L, but differs in some hardware parameters:
> >  * No external clock, but instead has ram clock.
> >  * Support up to 6 channels.
> >  * 20 interrupts.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * No change.
> > ---
> >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 67
> > +++++++++++++++++--
> >  1 file changed, 62 insertions(+), 5 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > index f87f90f431e5..189d5303ad75 100644
> > ---
> > a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yam
> > +++ l
> > @@ -42,6 +42,8 @@ properties:
> >                - renesas,r9a07g054-canfd    # RZ/V2L
> >            - const: renesas,rzg2l-canfd     # RZ/G2L family
> >
> > +      - const: renesas,r9a09g047-canfd     # RZ/G3E
> > +
> >    reg:
> >      maxItems: 1
> >
> > @@ -59,6 +61,19 @@ properties:
> >            - description: CAN1 error interrupt
> >            - description: CAN1 transmit interrupt
> >            - description: CAN1 transmit/receive FIFO receive
> > completion interrupt
> > +          - description: CAN2 error interrupt
> > +          - description: CAN2 transmit interrupt
> > +          - description: CAN2 transmit/receive FIFO receive completion=
 interrupt
> > +          - description: CAN3 error interrupt
> > +          - description: CAN3 transmit interrupt
> > +          - description: CAN3 transmit/receive FIFO receive completion=
 interrupt
> > +          - description: CAN4 error interrupt
> > +          - description: CAN4 transmit interrupt
> > +          - description: CAN4 transmit/receive FIFO receive completion=
 interrupt
> > +          - description: CAN5 error interrupt
> > +          - description: CAN5 transmit interrupt
> > +          - description: CAN5 transmit/receive FIFO receive completion=
 interrupt
> > +        minItems: 8
> >
> >    interrupt-names:
> >      oneOf:
> > @@ -74,15 +89,33 @@ properties:
> >            - const: ch1_err
> >            - const: ch1_rec
> >            - const: ch1_trx
> > +          - const: ch2_err
> > +          - const: ch2_rec
> > +          - const: ch2_trx
> > +          - const: ch3_err
> > +          - const: ch3_rec
> > +          - const: ch3_trx
> > +          - const: ch4_err
> > +          - const: ch4_rec
> > +          - const: ch4_trx
> > +          - const: ch5_err
> > +          - const: ch5_rec
> > +          - const: ch5_trx
> > +        minItems: 8
> >
> >    clocks:
> >      maxItems: 3
> >
> >    clock-names:
> > -    items:
> > -      - const: fck
> > -      - const: canfd
> > -      - const: can_clk
> > +    oneOf:
> > +      - items:
> > +          - const: fck
> > +          - const: canfd
> > +          - const: can_clk
> > +      - items:
> > +          - const: fck
> > +          - const: ram_clk
> > +          - const: can_clk
> >
> >    power-domains:
> >      maxItems: 1
> > @@ -173,7 +206,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: renesas,rzg2l-canfd
> > +            enum:
> > +              - renesas,r9a09g047-canfd
> > +              - renesas,rzg2l-canfd
> >      then:
> >        properties:
> >          resets:
> > @@ -187,6 +222,19 @@ allOf:
> >        required:
> >          - reset-names
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a09g047-canfd
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 20
> > +
> > +        interrupt-names:
> > +          maxItems: 20
>=20
> Should these be minItems instead of maxItems? The list has 20 elements at=
 the moment (right?) so
> you're not adding any restriction here.

Yes, it should be minItems.

Cheers,
Biju

>=20
> > +
> >    - if:
> >        properties:
> >          compatible:
> > @@ -219,6 +267,15 @@ allOf:
> >        patternProperties:
> >          "^channel[4-7]$": false
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a09g047-canfd
> > +    then:
> > +      patternProperties:
> > +        "^channel[6-7]$": false
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
> > --
> > 2.43.0
> >

