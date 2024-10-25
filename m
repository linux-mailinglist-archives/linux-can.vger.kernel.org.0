Return-Path: <linux-can+bounces-1758-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C19AF746
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 04:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795EA282ADE
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04654727;
	Fri, 25 Oct 2024 02:11:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2130.outbound.protection.partner.outlook.cn [139.219.17.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04994409;
	Fri, 25 Oct 2024 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822271; cv=fail; b=HcocXcmQROzzcoZCkOVvyZOsMqSnySeKYwn1rZa3yxQZBujTOhoBvXn7Ck50qXkMTB9rgEGS0EzYMpLQwSpRo0V9Kz9mmAswF9nUbf23mCBVHesUvGj5+eGx3SznPiS6QjOSIutyKm+Ko2TUwmdQDggq7Z7PeeYrZ9KcErapRVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822271; c=relaxed/simple;
	bh=YCvP0Z0ALzV0ZngMrJkay999acFXsyWLsPyqmhb7koI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HgDt09t33V+gMzLcyEN8SQ1eGbLssm3IFMYOFMfNkYzqBrq3WYPQUq6tYzC8gn086b76v5E7NB6YJ6PCL+vcF/NA2b68MJ/vKVRuxKRqdfiAVnbv1RJaCnw7WfvFSM0xZlhvPYxcDOIaNI3sxDT3VKk8B7VES64LSdm2LYfJ564=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmD5TBrz1d8psYMushEzawmw+xXSuFnw6svW4Q7safsPz/5gouAsy5ka0uJzExJGDqgFKBnflkQaKWO35gDiIP5qrjsXoBU83WR0vGwLbNvJW3Nm91/w0/wLusNxpNAqQEXvavIhVoHbv5n23EJwc3a6Qp+jAFieTgp6aEFQtEHFVB2LSO+YjvuK3iRwlocwxjsuLO+ndKOxw8j6od3uXgBmFdQWUv7emiTpPNCZc0DbZEitrHomilJ+TadWnD+WpRQf+EIbtWSmr4++/qMILjvDsuMJW3MUGuichZmJmszNHtMfym4lz7/xMG/n6XpxPzhToCFU6fBB4fyP78Pqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXve3JTMO9j7JYE3j0kQd0CKnXLUfrlY354SqZNl/a8=;
 b=fGeDxSHxzsYtfp42aHEzPf62VmdGe/dHih+okU5/9D8gUarASwL0oiWkvE1tfJG1qwWJ5GaH72q0UWIhiePKfqhUR4139R78BRAftU6Z9CH2/F3rEK5ZZ9Q8ZaUmQZRcEA5WfaSLBNdbCHHoYWpm5HFEtM/ZmmAL+qgTQrJqmN9f2nFeAX+9Mx9nVOnMibHTaqBQkkGohVQmMGwZQQG6FMgAX3CafKoWPvCBCOtm46oGoKXr+pQHqkzWkt5i7Kl6t+PvhOhvzkXKzklFS7Utpa3nbJ838KhcQPCamMkfkl1oKLR8WB2ipvGlYPCKH1hPBfBh73ZBPlJ60hnVbT/QSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1291.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.33; Fri, 25 Oct
 2024 02:11:10 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Fri, 25 Oct 2024
 02:11:10 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, William Qiu
	<william.qiu@starfivetech.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Thread-Index: AQHbDP78QyTswaw7pki8MOjaOJeAtrJkAHKAgAC5iGCAAI/MgIAxnAvw
Date: Fri, 25 Oct 2024 02:11:09 +0000
Message-ID:
 <ZQ2PR01MB13076C761C45F2D5834DA718E64F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1291:EE_
x-ms-office365-filtering-correlation-id: 5ee6e6b3-d73d-4fde-4029-08dcf49a4b03
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 ZV7vdnYnKu/IPmzURWv2K3L3quePUfB+kHLeZV9wlov53zmzg0rpROfDgImasLpl4FZe61QKP5MPW57z2TAce7m3qpUXxQ9pku2WRBbHhHy2MryvNBVnUGg6PfXwXIWef6EsQkORruxiXH7s+ol5IMR+34SL/4wMQ9smUea6DY7St9RS8hpV/uJaiD3I4GmhpTj86tA0rKShQBYcnE6GZWqWc24K7ACeca7ZWgZHPHbmlaXLZ4o7BVEo4IT7BtnNEfRGVHSAoLEYBQ+J5+YUR7Yi5aWstE9zxOC+oIfp7musYz6kqEzY7Vx22yQ7nv3LvjftBUortTqZDsyaUrou9Bz4+ItxgOi2aVbPOsp2syXMbd2jhridiDElP6nPV3UMhExix8+UQgN7/kE+GN4RRUVmIYzFRSIPEVloldXixtPYJc/X/81yT3HrKbX+gsvcqqRI5Ly7XSjk85qXJP3yGWHXsbY6sFJtzPEyIf4cYI2R/qkYcKxObCWfgsq+Jvl81SJlR7cbxM9Ti0/vvet641SJVSiGNY/rvNFffPq7UIohy5lTuOXHNB4dyGBuir33O0AyyiTEghOU3lXgs4HBLwWWNlEDrLE4ChmHXita1rJyq6rFSfzTt1hddR3NuJo+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vrQo/2+v4clwuscgBDbo9+0vaiG5jpWrGFs0NLcRy2zj/eDa9tmjDIckP+ys?=
 =?us-ascii?Q?HHW7dNmkFJCjCiFHmhroxGbdcirLXizbmS642E3PTYfa6n+Yzjt+/Q2LNoRH?=
 =?us-ascii?Q?UYqWVJRJdckkpQoLL0FoMk0OnUMmrkFabhqc35Z/rTUTBBAWSVaHmmXNPrOH?=
 =?us-ascii?Q?LVLou4NSr1KJuqV2yUfpXEzQizua48OsYCM0Ay19zI/EJ7zRAzkJMRjzdCMb?=
 =?us-ascii?Q?zPA4TqutHq6cW/Or6+8O3oEgDwqv4qqg2AbGDhExjwJXr5hYkq0UsTGfD6uX?=
 =?us-ascii?Q?tB3F0oNnjcDLrDTF5A+jnczfj6N4Ht24bG9DlMi/HCb1sAOFdvlGmF0uf9yT?=
 =?us-ascii?Q?RBcWxCBNi+ivy56S1abBqHoWmlPqdXoI2dkqBWDxitar+8yeSgqPJNlfw1JO?=
 =?us-ascii?Q?O3i+wDoJ3mu7wgPQseJ/pcCLyN8N/9113rId4nFXAbpTXELaRjlw0cqDp47e?=
 =?us-ascii?Q?3uwUrb9GEWLUm7tZ9p14gEMPuGS+c+YF0Fw8l0RGgclue0GKpiujBO38QAHm?=
 =?us-ascii?Q?6Pr3bci9gjbpqKCF8+s08anCE1Ki9E9ha99CWVUHYv1jIXzJDWJuBiT8er6D?=
 =?us-ascii?Q?gvTvaFM0reD1pRfPzsQVMItfRLg/AfUAB4yHwXE0J8B5X7YqKTw70qgcmZHf?=
 =?us-ascii?Q?xBhgKXYrSI4uHtAQ3FMmAcylnghGbIY0xif5TU6mUaz+tKEqrnC0S984uovs?=
 =?us-ascii?Q?YaLb+X/sqvaA+A1FZ1y3q0mq+PqWiveEAKQkudGaiyEGBKoocpdVj9XjEsYM?=
 =?us-ascii?Q?79cillnRAY+/U90ZSqmoQmKed0loiv0p5qv08ZIZtH/ValKta1i+FyAci6x/?=
 =?us-ascii?Q?3EgBYvspJv2XCusBt2+3gDmv1GlSD4k+vnjTc5Bp1mtVdIdCPAQKz5MqQfV1?=
 =?us-ascii?Q?yN9g01NykRjA2FPjMUnaUbN7kIElWY4dJSg9/KqbSXA1DWtb0b2hGncyAAhE?=
 =?us-ascii?Q?dWttapqdDeUdqZjj2Y9GEgQZAIrsuH9bQR5+tdasV0EaLsRpozZCQO9Y1gzB?=
 =?us-ascii?Q?goM6m4WM27FnDtVyKAtLr0PEXkxBs/h17WFZ4DLM0yEKWnC79urQHRIUwTy9?=
 =?us-ascii?Q?vecPPtdBvsRnxFXZgRoYr1RQQi6LQOXOfM9vapi13BPMKNHGVE0MIvZLi0DE?=
 =?us-ascii?Q?Sspn0+kU/q+gJcgzqKoPcl7UkTiBAV7F8/VxtFx2bt/4i8lKZ92bVMHwM9s+?=
 =?us-ascii?Q?ClDnI9b1JNAu1MxlzK8046xrzxq+iN0lbSuj/2WFNE21S1oonWhsahUT+ga1?=
 =?us-ascii?Q?8/jXwJp3QIFDl/f0sUFbeb1NWJuU/N/O8nBE7jwJiJsdBbg1rs3XZZY94Hsa?=
 =?us-ascii?Q?TOeACyztqZ6qRpeQCz8oLnmMUdJtGveZHemNnCaZmYotpffG0HNcHO5Vv6pK?=
 =?us-ascii?Q?BXH2+N6hjvT8gAXCbde+SYT9+K/jmxeGGpET4YhkCGObSM7Fv/Mj9T0F236r?=
 =?us-ascii?Q?1EgfbCXc4FNV8H65hBIQkAbprszmsSD0d8ucoQrgQJzpPGW7Kplu0yhUZMmu?=
 =?us-ascii?Q?9OoljftsU+HnTYrh2L/4VPKg0XTYAff0/BlCJ/AVWyKN2Bcw6Y3DJy2G6lEZ?=
 =?us-ascii?Q?FvaTReRzpXKBehn6gLrlucVj+i84yKQVkfPgGj1X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee6e6b3-d73d-4fde-4029-08dcf49a4b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 02:11:09.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWUOU/V0TMVBtWqtZYRUHVoPBH7Stv2DWeBoLKMXp40YWR4CSWehTrLIfYwqIPwHZwlPX0ZRymA/9FkfTfOoj3alE0YNKj+Ec36Ae+u2xUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1291

> On 23.9.24 20:13, Andrew Lunn wrote:
> > > > +	reset_test =3D ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
> > > > +
> > > > +	if (!(reset_test & CCAN_RST_MASK)) {
> > > > +		netdev_alert(ndev, "Not in reset mode, cannot set bit
> > > timing\n");
> > > > +		return -EPERM;
> > > > +	}
> > >
> > >
> > > You don't see nedev_alert() used very often. If this is fatal then
> netdev_err().
> > >
> > > Also, EPERM? man 3 errno say:
> > >
> > >        EPERM           Operation not permitted (POSIX.1-2001).
> > >
> > > Why is this a permission issue?
> >
> > Will use netdev_err() and return -EWOULDBLOCK instead.
>=20
> I'm not sure that is any better.
>=20
>        EAGAIN          Resource  temporarily unavailable (may be the same=
 value
>                        as EWOULDBLOCK) (POSIX.1-2001).
>=20
> This is generally used when the kernel expects user space to try a system=
 call
> again, and it might then work. Is that what you expect here?

The bit timing should only be set when the module is in reset mode.
So we return an error here if the module is not in the correct mode.
Could you give me some suggestions about the return value here?

>=20
> > > > +static irqreturn_t ccan_interrupt(int irq, void *dev_id) {
> > > > +	struct net_device *ndev =3D (struct net_device *)dev_id;
> > >
> > > dev_id is a void *, so you don't need the cast.
> >
> > OK, drop it.
>=20
> Please look at the whole patch. There might be other instances where a vo=
id *
> is used with a cast, which can be removed. This was just the first i spot=
ted.

OK. Will modify for the whole patch.

Best regards,
Hal

