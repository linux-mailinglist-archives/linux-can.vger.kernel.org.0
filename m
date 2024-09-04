Return-Path: <linux-can+bounces-1408-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E695996C4AA
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E587B217BD
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D2811F1;
	Wed,  4 Sep 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GurltbUt"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635C208B0;
	Wed,  4 Sep 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469355; cv=none; b=b78oXZcZM5JbMduA6uMMws7BXobVoQkJcb+rCU8T2KGRTKo8L7lf/N1taNoHDQGT2B13/a71tQAjuErcFulcLNzKXgb18HzJpwfdG+izn6oI7WThwZ+3cGgfx2+foDBwUKxwTjltS5m9j11GWLuH3pZD5v6LYjedecaSh4sg7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469355; c=relaxed/simple;
	bh=sORX5VEgoe509ZQr0SKamAFfSHB60pe6cyvvjB5IGZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR8Eb9v9YC2M0Bu+ZpPnd5LFqaS8OIWwszpKAeCXvRCW51TrFiqSG40ti/GsIsHvGA70hXr0k0UtxYzCqq8s4n8kvv8qzGXyK9+6UUm+9cb71mnT3peq9TsD43ASXroxGrJNF+SQzR52oJuTO6BbY9dBIO1wtAhHcL/AcWsuaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GurltbUt; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sORX5VEgoe509ZQr0SKamAFfSHB60pe6cyvvjB5IGZs=; b=GurltbUt/g0trnYK49OGBqD1RI
	STz36H4cL4V5IouRnNPrCGcVHJHwewfTFwcX+EVl/4fOFJ5SlxOR8/sX5eC5bYaauRQGRHglFo9Op
	4ShSM5z4ku0O7FzwpYrBqXN9st0mk5yGJf3sT5YvJVpYoIvI04UUETbPnNnkR5DV9imQNtVoJ3m3h
	xUx6V9hWgtzaR0O1wirONGoxagQa3RdXhAZm43FQu1reRp3ZtJNLH8GxnGtv9RhF01gnDDMY2ndZa
	iQpm79kW5XUoJdi8adciOrPWrn8PMtXuERXqPOY0Rpwfjs1gwc8drkm/HWqEA3CFlB0MvCAQ8Vjm8
	mUjTGtZg==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slt52-0001UH-Nt; Wed, 04 Sep 2024 18:42:04 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 David Jander <david.jander@protonic.nl>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Jander <david@protonic.nl>
Subject:
 Re: [PATCH can-next v5 00/20] can: rockchip_canfd: add support for CAN-FD IP
 core found on Rockchip RK3568
Date: Wed, 04 Sep 2024 18:43:52 +0200
Message-ID: <4091366.iTQEcLzFEP@diego>
In-Reply-To: <20240904-imposing-determined-mayfly-ba6402-mkl@pengutronix.de>
References:
 <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <86274585.BzKH3j3Lxt@diego>
 <20240904-imposing-determined-mayfly-ba6402-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Mittwoch, 4. September 2024, 17:10:08 CEST schrieb Marc Kleine-Budde:
> On 04.09.2024 10:55:21, Heiko St=FCbner wrote:
> [...]
> > How/when are you planning on applying stuff?
> >=20
> > I.e. if you're going to apply things still for 6.12, you could simply t=
ake
> > the whole series if the dts patches still apply to your tree ;-)
>=20
> The DTS changes should not go via any driver subsystem upstream, so
> here's a dedicated PR:
>=20
> https://patch.msgid.link/20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengutro=
nix.de

I wasn't on Cc for the pull-request so I'll probably not get a notification
when it gets merged?

So if you see your PR with the binding and driver getting merged to
next-next, can you provide a ping please?

Thanks a lot
Heiko



