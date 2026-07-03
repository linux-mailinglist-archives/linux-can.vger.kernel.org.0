Return-Path: <linux-can+bounces-7991-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X1G7M9PGR2qAfAAAu9opvQ
	(envelope-from <linux-can+bounces-7991-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 16:27:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777070365E
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 16:27:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=TPLyRFDV;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7991-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7991-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D94EB301A178
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1A3E0C51;
	Fri,  3 Jul 2026 14:23:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D23CB8F0;
	Fri,  3 Jul 2026 14:23:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088625; cv=none; b=d+BYRaSuzNyoKL1swdbyOy25z0dhEs/JzZXYdXn+pgMtEMmqjhwhaRe+VWHGrvUYacE1iZ7Py3OtF0mNRPkeqYV68buuRoWgfJ9wMwkwzwSLdEWJI2miIhOZuAZNEEMgRSnJYXwiyf//HjRl6+RvqY2qUyhX96jYNh7jJoF5mGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088625; c=relaxed/simple;
	bh=6wIbRy2Zdm8ebG9nOt2I/vQJTjjJO0MMn6scd/YZzwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXaUNjFA7l1JJnUoqGydno8cxy4+6DhdXse6NE5y64ToUMju5C5yFS0l1sd9eQh5sjgEiWzuxBVHGUvj6r7kkLHxWjMJYcF32d5bnml+yHvYVNl/9at+8h0WQ46t3I7r45wuXGFamvXGJNexp6N7IOsnhijgNNgGGn5yzg87KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TPLyRFDV; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=1lCH77eIOkpyT6UD6CNZ7GGsrspDZ0kqeiwmNw7g46I=; b=TPLyRFDV5oqX2oLuzs2c7r4tay
	CsE76Bq2bIY/IcZOm78Rj0OUPdsOmW/E9AL0oHE2vGBwCCUqRJcsCspd6RWCkl1FjrzE2yP8VjD5c
	o69aPl5YR/YB2/DP5acrfQX5WgAfQRCgG5hUs+PQ0JPOIFbH20tsG4BMCh3Wtdwe/bDwna5fkYl6X
	614NQpT8M06EOrbiSrzhf0Q/XhQycxO4Z8DIPHrXqSu/UCI9OjhdcEJqEf+TEfU95qDXwehdI/KDi
	WE1Of/5DDRF1pKFiqava9nEWMeJm1Mf4HrwFgoHnT1E/Qxs3G/ag/VLsvkz1bQyWEloSNWnjEjX1H
	oVkrIpwA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Cunhao Lu <1579567540@qq.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH v4 4/4] arm64: dts: rockchip: Enable CAN controller on
 RK3588-Tiger-Haikou
Date: Fri, 03 Jul 2026 16:23:22 +0200
Message-ID: <3078012.2VHbPRQshP@diego>
In-Reply-To: <e03fcd5c-de56-4f39-90c2-3ba0636a1cca@cherry.de>
References:
 <20260703-master-v4-0-47d40bbf5fda@qq.com>
 <tencent_F79E849B11AF805A4401BF9F263B1A469907@qq.com>
 <e03fcd5c-de56-4f39-90c2-3ba0636a1cca@cherry.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:1579567540@qq.com,m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:quentin.schulz@cherry.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[qq.com,pengutronix.de,kernel.org,cherry.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7991-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qq.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cherry.de:email,sntech.de:from_mime,sntech.de:dkim,diego:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3777070365E

Am Freitag, 3. Juli 2026, 16:05:18 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Quentin Schulz:
> Hi Heiko, Cunhao,
>=20
> On 7/3/26 10:01 AM, Cunhao Lu wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > CAN0 is piped through the Q7-connector to the CAN-Header on the Haikou
> > base-board, so enable support for it there.
> >=20
> > At least on RK3588-Tiger, the CAN clocks default to 99MHz, limiting
> > usable CAN bitrates without skew. Errata documentation mentions
> > 300MHz as the default frequency on RK3568, so replicate this here
> > to allow more bitrates.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > Signed-off-by: Cunhao Lu <1579567540@qq.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts b/arc=
h/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> > index 873fbeb8daa1..6273e695b039 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts
> > @@ -155,6 +155,12 @@ vddd_audio_1v6: regulator-vddd-audio-1v6 {
> >   	};
> >   };
> >  =20
> > +&can0 {
> > +	assigned-clocks =3D <&cru CLK_CAN0>;
> > +	assigned-clock-rates =3D <300000000>;
>=20
> Why is this not SoC-specific? We are only routing the signal from the=20
> SoC after all.

My main reason was that I have no clue what a reasonable controller
frequency is. The default on Tiger on boot  is 99MHz, which causes
problems with accurate rates.

Similarly the controller has issues with low clock rates (erratum 5 if
I'm not mistaken) and ther Mark wrote that at 300MHz the issue is less
visible. So I took that frequency, but have no clue what the "right"
frequency is.

Similarly, only Renesas socs seem to set their can frequency in the DT
and that to 40MHz.

In the Rockchip vendor-kernel I've seen rates to set to 150MHz, 200MHz
(or left alone) on a board-level

rk3568-ok3568c.dts even sets both 150MHZ AND 200MHz depending
on the CAN controller (200 for can0+1, 150 for can2) .

This does suggest the usable frequency being specific to the board-design.


> If it cannot be put into rk3588-base.dtsi for some reason and is=20
> product-specific... Why is this in the baseboard DTS and not in the SoM=20
> DTSI? I would like to avoid our customers to have to copy things over if=
=20
> they should just work on their baseboard too if they don't do crazy=20
> things there.

We can of course move the clk-rate to the tiger.dtsi.
(This should not affect the rest of the series, as I'll be applying the
dts patches anyway)


Heiko


> I'll try to find time to test the three CAN controllers on RK3588 Jaguar=
=20
> with the CAN1-CAN2-UART4 Mezzanine adapter board and will contribute an=20
> overlay for that if it goes well. I don't have a CAN-FD adapter though=20
> but I hope they reused the exact same IP for the three controllers in=20
> the SoC :)





