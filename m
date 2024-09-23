Return-Path: <linux-can+bounces-1529-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F697E73F
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC6A1C20FE9
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197226E619;
	Mon, 23 Sep 2024 08:08:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F256E2BE;
	Mon, 23 Sep 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078930; cv=fail; b=Kn/53/DyovsnUX/WKVk9fI4Xf/Tm+vneiCVp/ColeKxcItfynTf8oeUsKAJ30zQCORuSKF7iVYpgI2uLMPyRmrnSpi0Ydfs+dizErYCLD9F9mN0exyJ8+pqwsjvj3HqxoBk57wq8woNMWM3YSz5Tg9Ow1ln9iylCjSnfgklWrEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078930; c=relaxed/simple;
	bh=5jWd/RvE/bOAX9n6MSTbV4uhmKpjpmRnK7/d2w5sPlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H0uP7/f3N7FcTXLe8lZm6Zv7a/rn6okuskqCRgZgJSj9daNkxS1ZSPCLdHqQl1dvhWb84KRBQAeTfVuDrkZd7DjF5kIGWQ+oFVXEgwVHbCcAMYL6OLR6CVBqdUwCIPHXip04L2VB5m0R6Cv6K7YGpirN9OOQQMRfvJFIScdjxP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThhmqKkK+LHDjGkzT+PVK27kUzvWhfa+H9PGvh9s3HqXHUpzXF5WgFiXj8NYccbX7e8S5i+OLSwxpbKi1Of/wt4vLA/kHR8IlATHKEl2C0ZLl7UNuqjG5bdRHYTg2MZ8LDPstb9tfoBN8i5UjS4a/XViWB97uVA5ypOR/qIhnALVyxaep/5iZI++iLzFox7OM9cIr9wIp7Y61kUqXy65tTSElrrDjBBa/YaxkkSdOxt3OcLoWxM1Ypbhvyrwc2NNZuKfdQCQkWLtdwF8ye7gWvV4mjUiXpufIgws8yD+ORDt0f4tbDZ9cWRfDuT2SoLOwQZKQjMA7oIz0RUO3uT5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyQdn+W1djXv/5fY7L44dPNxVOJfDdFiZsdyAqqB0r0=;
 b=cwEFL2Rfgc6Eh7kGxwPGWgZqUCAuK0Zh4eHNBa1KDE2dugaWI2XV+e+9bAAXB7YRK8YLXBMi6tK0FKVZZzMkn3XPc7wWj5aMxVMuXa2muWswuIML9s+Fdibq8ijf6/LOXPURInyD+7Kb27J3UGSliF55x0ourdaAkcdEDTrmBEOossJZ5IsZCdz5xLdPCipMDmj91wIBBh2MnYxghAdDzdy9U4aJtLrCkix/LbYhn30QQCy2m/HgNaQSlwkddwokKPXeDkREwuSkbTbI3DEm3zINsCFWqxeXkFKT1VL6g8AWSY5dQNsB8o6MZUlEKrgGkW5VkvaDkaJovQcg6XF8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30; Mon, 23 Sep
 2024 07:53:25 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.7962.029; Mon, 23 Sep 2024
 07:53:25 +0000
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
Thread-Topic: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
Thread-Index: AQHbDP78QyTswaw7pki8MOjaOJeAtrJkAHKAgAC5iGA=
Date: Mon, 23 Sep 2024 07:53:24 +0000
Message-ID:
 <ZQ2PR01MB13071A093EB33F48340F753EE66F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com>
 <cf17f15b-cbd7-4692-b3b2-065e549cb21e@lunn.ch>
In-Reply-To: <cf17f15b-cbd7-4692-b3b2-065e549cb21e@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
x-ms-office365-filtering-correlation-id: baf9751f-ab54-4877-1c25-08dcdba4cd8e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 Ei2TJpZ6EkPWgpFNiA1MIjp3LEVKtRRY2ZHfcqcRYXR0N3xWLZ5O90iKc4gMDGzzjaVxZWcgHJB8XFhQ36Bmd+7IylO2sM3rRBkEHRYeEv5GnRSS9qIW0I5PAp5LE7PHU1wmc1g7nkd2XM5nZn6k/0i8+WsEge4g86E4DH06iHofbcDYhNOzb5NXRXE+GyA17mvBK7e0/NBC9t3q54K04Fr+dPukcLnMvG9s2QIu3QIvm1Ep6FdXLEVSdKwqMx0WN6yM4jp6RGGNGKB0mLlLZHl53QxQg0aziwcwnjPJh5TsU0FOJfob9CclYCgiELZlR0WQAsSYl4vovR2HIFLoOAG2xmvN+Oa7M9SnfIhf1PEC0GBbfl1htR683RWfKQa9S1RuW8Vym4jRHLuNd90cT/banill4LZnQpKXa20/tQo30zwiEFO9QMKldyeb+Dg6dRdQbPTdv3nKM0n3lxdvLIOCsZSX2L1/LO3z11eMqpkXv8EeYvcEDcIS9DMjsk3lM7bRhP2N1cDMh4qHVbzQCky8nf1Mjg0YoKX8JZm4ZHtZwt7oqKt0cPOuSiBiIAAl0taHXeTmogRgFiWyP7kPHtLkOR9+FNhzpQznbAaEOJ1wIIbWxrNKjBuN/RVMSfY2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vn5F7qKhSC2w0bchBD22ba4+L+rzlPxMwxPRLeZRaMVg4THK146JI7BbC3cd?=
 =?us-ascii?Q?6rXQo39B5bAE2j6aqwP8I/TgBDFAi/VKp/ioiO6mt5yCzR1yRszfqAQ6Ucd0?=
 =?us-ascii?Q?jf7Ke6fYJW0nXjgTYgJtzhpC3RVFBC3ZQfaZTxTvqHHadVdzdUmpbvTAauly?=
 =?us-ascii?Q?Op6Z48h9SUwkAdRlujdmwlvxm0GYDp8B8IzgR39s/wAD1YdUhxT0wH8Al+wc?=
 =?us-ascii?Q?wYz34QScKcYdxgAU5FJ9Lnb+nVEDMnleDnZxQb2/y8fIHTOj43yrnojvsc9n?=
 =?us-ascii?Q?mRv37zq62bIloUx8MLsc/pSv5OA1RuPauA0kIKhDaLM75RpLXRPCwcWf0W2o?=
 =?us-ascii?Q?GVGZoiS7vMAqn8BcujZMgIxKK6zkVOgCy6sRoNLnkG2Hev8k5dNAh8FO0oDL?=
 =?us-ascii?Q?G0+IK7HPM/YninWDJnwcv886EFUjQOdhoOCXG1ONXhO+3RbDcezH9nWoA1oA?=
 =?us-ascii?Q?JUNY5XGGIjk0NAasFsAyNGGBopXl4DcZ0fG7BQNoWDqvJKbQlP+/JAFr8TYQ?=
 =?us-ascii?Q?fmxvVD1lck9wmgvMSH+o/mX9daDcSgNyg0D1VouF6VUjYnxYdCrGY4UNdwHK?=
 =?us-ascii?Q?pD1YL+gHaHfIjjrqvmh2TQzNl9RAufo7CpUgv3hK5jgHFBxPJn9DtXy0MeaO?=
 =?us-ascii?Q?MZ8WX/Lli+qFUbGPPORUkQ6LXyOKsxcVjP9ciTRCVpEOSjvAaDXNZ7denkUX?=
 =?us-ascii?Q?Px1u2QP8R1/nPN5sMJ0yAeRQGeMtpVRJphAYJYe41DZi5fbULvqm6GsRgDG+?=
 =?us-ascii?Q?RIhxZXtw+C4XAHfundZ6N6xf5QUi8/2dRgW3tpjaH34fy+DCXpqydPmO3Fnw?=
 =?us-ascii?Q?59NjjOOPMgNjYKUFurBwXXMq/lY3/pN77SxYqh0i46uN4w34TNc4R32fLShG?=
 =?us-ascii?Q?yK1xdr4axGH4CVDMAjcT1C1qMFbr1Uo1z8JsIDI+dRg1kWaEq2a0YPjkxioF?=
 =?us-ascii?Q?WX9uOXslHy/ccg7ZVQThXCPz51cbdIqpbis8l/YQb2EvCiN6JA8U/1bjZhx1?=
 =?us-ascii?Q?SscxMxIzf5LO6MekzBdx/AUm/gzyKsK3NYrGhbTNgdcB5z0XWxG9yZQzCAfD?=
 =?us-ascii?Q?Y2bzFamlOh9JyhPJRG15c8e1VPhe3bou1arnhrj6viUY1y+/uEEB1XD3w34A?=
 =?us-ascii?Q?a0+2gBV7VJNR3Bt0n7s/NY7pdmstv3MOLlIjuUZ8Z6zTpnf829LS3ZZsW8+b?=
 =?us-ascii?Q?XTra8pVNvWBZ+dhp8P2toiDmmxEo3D3UJeNX3p+2AJUhpR3dTwkfpRFgRgKp?=
 =?us-ascii?Q?A5EYaijYAqV5/mrMkrH8wHd9ogvZDhVnWZasZvz584POQ8PCJ4TxXY7JVBwn?=
 =?us-ascii?Q?LHZiP1xhi/Iu1cxfB+HkZkQ/FU0gbD5u2WtEk2CHTKADRM1bUyPln9OMJkrX?=
 =?us-ascii?Q?qhGrvnhVAOIvg23m3o5BEgZ4OHQbOsjjodk+Yp6Gv0Fw73zGGUSZvi/WE7FR?=
 =?us-ascii?Q?rOpl5+boxn+FXT0aZnuP4sale6Fj+ANQhv23/Dueu3yxCFp4ciiZs4HpsB7f?=
 =?us-ascii?Q?UaSCipDxE5DpzlBnq1mKHk4hMbtmJYS5ydY9PUbTLHyrJwQisLyEW+GQuoWT?=
 =?us-ascii?Q?S/lflaTp9+aE/smQKta9KciDmVHi1OSZnTfPbqrc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: baf9751f-ab54-4877-1c25-08dcdba4cd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 07:53:24.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feyUlhW66cFM++aUWev1MMmE09ulyhCQBfNoGwvGkcYYAzXGx2bHsA8Vm6lM5J/nzb+wqi5tiWJl2auSaBwOV//gM3MjVH+tab3EMlz6Tqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211

> On 23.09.24 00:34, Andrew Lunn wrote:=20
> > +static inline u32 ccan_read_reg(const struct ccan_priv *priv, u8 reg)
> > +{
> > +	return ioread32(priv->reg_base + reg); }
> > +
> > +static inline void ccan_write_reg(const struct ccan_priv *priv, u8
> > +reg, u32 value) {
> > +	iowrite32(value, priv->reg_base + reg); }
>=20
> No inline functions in .c files please. Let the compiler decide.

OK. Drop them.

>=20
> > +static inline u8 ccan_read_reg_8bit(const struct ccan_priv *priv,
> > +				    enum ccan_reg reg)
> > +{
> > +	u8 reg_down;
> > +	union val {
> > +		u8 val_8[4];
> > +		u32 val_32;
> > +	} val;
> > +
> > +	reg_down =3D ALIGN_DOWN(reg, 4);
> > +	val.val_32 =3D ccan_read_reg(priv, reg_down);
> > +	return val.val_8[reg - reg_down];
>=20
> There is an ioread8(). Is it invalid to do a byte read for this hardware?=
 If so, it is
> probably worth a comment.

The hardware has been initially developed as peripheral component for 8 bit=
 systems
and therefore control and status registers defined as 8 bit groups. Neverth=
eless
the hardware is designed as a 32 bit component finally. It prefers 32-bit r=
ead/write
interfaces. I will add a comment later.

>=20
> > +static int ccan_bittime_configuration(struct net_device *ndev) {
> > +	struct ccan_priv *priv =3D netdev_priv(ndev);
> > +	struct can_bittiming *bt =3D &priv->can.bittiming;
> > +	struct can_bittiming *dbt =3D &priv->can.data_bittiming;
> > +	u32 bittiming, data_bittiming;
> > +	u8 reset_test;
> > +
> > +	reset_test =3D ccan_read_reg_8bit(priv, CCAN_CFG_STAT);
> > +
> > +	if (!(reset_test & CCAN_RST_MASK)) {
> > +		netdev_alert(ndev, "Not in reset mode, cannot set bit
> timing\n");
> > +		return -EPERM;
> > +	}
>=20
>=20
> You don't see nedev_alert() used very often. If this is fatal then netdev=
_err().
>=20
> Also, EPERM? man 3 errno say:
>=20
>        EPERM           Operation not permitted (POSIX.1-2001).
>=20
> Why is this a permission issue?

Will use netdev_err() and return -EWOULDBLOCK instead.

>=20
> > +static void ccan_tx_interrupt(struct net_device *ndev, u8 isr) {
> > +	struct ccan_priv *priv =3D netdev_priv(ndev);
> > +
> > +	/* wait till transmission of the PTB or STB finished */
> > +	while (isr & (CCAN_TPIF_MASK | CCAN_TSIF_MASK)) {
> > +		if (isr & CCAN_TPIF_MASK)
> > +			ccan_reg_set_bits(priv, CCAN_RTIF,
> CCAN_TPIF_MASK);
> > +
> > +		if (isr & CCAN_TSIF_MASK)
> > +			ccan_reg_set_bits(priv, CCAN_RTIF,
> CCAN_TSIF_MASK);
> > +
> > +		isr =3D ccan_read_reg_8bit(priv, CCAN_RTIF);
> > +	}
>=20
> Potentially endless loops like this are a bad idea. If the firmware crash=
es, you
> are never getting out of here. Please use one of the macros from iopoll.h

Agree with you. Will modify accordingly.

>=20
> > +static irqreturn_t ccan_interrupt(int irq, void *dev_id) {
> > +	struct net_device *ndev =3D (struct net_device *)dev_id;
>=20
> dev_id is a void *, so you don't need the cast.

OK, drop it.

Thanks for you review.

Best regards,
Hal

