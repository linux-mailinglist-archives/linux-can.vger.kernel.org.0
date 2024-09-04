Return-Path: <linux-can+bounces-1357-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066A796B595
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2C3B2B30B
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44D1917DF;
	Wed,  4 Sep 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GgfuF/Qp"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94BD8289A;
	Wed,  4 Sep 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440029; cv=none; b=Pd0uIqP+qTriL/flV8tIep6uATlMBizA6GyGK/TXQ2USW4+CAghxXxEzYVzObDlX5mo98mOBSLaldrX5DL9+zc4+gJyWQg4W7dnMmIBUHz+eSi205+B6cH6RA3OjbbSbZec3MznOTS6gTMTrB7DlI3ATj0f1dzvLZymMGrabYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440029; c=relaxed/simple;
	bh=xDOtixfDSwSBhOx7DpJOxwD5l4RYsjuHLQgoS2DZvwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bt+okKnXHYm0XWpymI8B64hBk/k04Cmoa/4m26LFsvjbH0R9KaNGyM/N0SDYIesORTOg5sm9rNuTKTfqbJiysyoqvCUtoyaripAZmGhw+gKSdFSx4TtuiRq1KndHonR8xxWcEIMFbZuSvXQlD+b3E+CW4NNP3993kvlZ4Ni6jM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GgfuF/Qp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9PwaYbaAsjGodOj3kkWc4OgSwCX03oGVeuMglgQqXjg=; b=GgfuF/Qp4Y58HFKKkPnDohJ68c
	K+xNOcFJFpXLdHbQTyUma8NIMfCmHTgaqhXY6itFYE6Sml2zgt4dsSlUgm+J4/PFp7lUi4y+44ilU
	tLKy1ybsxi3uWRbYU0rOp5P0x6sS3u22nZXFgV9rgqzBv0OxT6FMR670dm2C2mj5rS8awYfQnSHsQ
	xXswXRgc9l9YQAepWNfwlS95arLruzSXp29VbABCj4EIZopPGYBM+NUk7HnX1CWMgR3AiZUzsORcR
	g0dExD9rp2u4sAtgNVF9DfpkSGOB8ANV/0DNm7d5zkrROF7kReZf2iD6GBZrige4/csy1pyjXkG9Y
	AyCHc5ZA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1slllh-0006c2-C9; Wed, 04 Sep 2024 10:53:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 David Jander <david.jander@protonic.nl>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 David Jander <david@protonic.nl>
Subject:
 Re: [PATCH can-next v5 00/20] can: rockchip_canfd: add support for CAN-FD IP
 core found on Rockchip RK3568
Date: Wed, 04 Sep 2024 10:55:21 +0200
Message-ID: <86274585.BzKH3j3Lxt@diego>
In-Reply-To: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

Am Mittwoch, 4. September 2024, 10:12:44 CEST schrieb Marc Kleine-Budde:
> This series adds support for the CAN-FD IP core found on the Rockchip
> RK3568.
> 
> The IP core is a bit complicated and has several documented errata.
> The driver is added in several stages, first the base driver including
> the RX-path. Then several workarounds for errata and the TX-path, and
> finally features like hardware time stamping, loop-back mode and
> bus error reporting.
> 
> regards,
> Marc
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I have neither CAN knowledge, nor hardware to test, but the integration
itself looks pretty easy and straight-forward.

Not sure how much it helps, but at this moment I assume you know what
you're doing with respect to the CAN controller ;-)

Rest of the series (that hasn't got a Rb):

Acked-by: Heiko Stuebner <heiko@sntech.de>


How/when are you planning on applying stuff?

I.e. if you're going to apply things still for 6.12, you could simply take
the whole series if the dts patches still apply to your tree ;-)


Heiko




