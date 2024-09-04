Return-Path: <linux-can+bounces-1355-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3002B96B56B
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1FD1F23FDC
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4301CC17A;
	Wed,  4 Sep 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XI+3BHKk"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4116F824;
	Wed,  4 Sep 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439764; cv=none; b=VD9UeXSnPvh6Kj75HdLUJgEgRq2QU6QiqIQYiNsB7BTnnpfHiNxC4MVeV0KFDiS0quU/f9yqTJHWdqdVVRVe+zmBpz0DiDoMRtYCEzwf2g1lu3h6JDuyxAEocAwm7xc0WvE+WVDtFhf0PcDxXIMtG5ShVcTdvzpgN5NtySxdcD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439764; c=relaxed/simple;
	bh=Nc1emj1+sVtZbo4IHO9UaqkbgItQAQDWG19sR8DLfgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBGRl2sB3dIG4oeRBZaV4aGW16Di7cZfNV6ync/5TBSCCGJeIQdpoir7Up83vExSkkUWmLjiHOyaQlfwONedS6nAyB2B6e8R650xACdzOcYhp/ptwN8GxRTrB/lJqPcD5F2Zebo6a+5onk/be+LKXJT8qD8SIEx7KQW6EpCenMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XI+3BHKk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=64Jy7Anr49mmXZNGV3iO4Xkyk9gN0bNX/x2F4h/amIA=; b=XI+3BHKkmeSYSxudJttkjn+QY6
	0lgJBVa1nlNtFNhR+YTCrDl8ZAI+5S3SdHjveyAcb6bYLic7L2rQjEs0w7ZiCJEECh3IB2i4h1et/
	Oy9dGhztMKznM9Xu8t6vmjxZBvO9vuL7ZL3sh0uvKAYHnIJK+YsxkHpnYlcFB2ABh36nQNkXg8DVC
	+Wh1SMHzCVZcJzjrZ31V3E073ho0JuSs3Ok1Dsj4vkSkgJePSe5izJQrKlyv3YQyLiNa9JEhpxM9X
	K76Sdl+OhPnw5STBApwkKNzT385Vt96fb6CBdlxVI5v4g+8fsob2CpSBN7k5neckjtwvUpWQphIyc
	GqW+39iA==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sllhQ-0006YS-QX; Wed, 04 Sep 2024 10:49:12 +0200
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
 Re: [PATCH can-next v5 02/20] arm64: dts: rockchip: add CAN-FD controller
 nodes to rk3568
Date: Wed, 04 Sep 2024 10:50:57 +0200
Message-ID: <3673727.WbyNdk4fJJ@diego>
In-Reply-To: <20240904-rockchip-canfd-v5-2-8ae22bcb27cc@pengutronix.de>
References:
 <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <20240904-rockchip-canfd-v5-2-8ae22bcb27cc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 4. September 2024, 10:12:46 CEST schrieb Marc Kleine-Budde:
> From: David Jander <david@protonic.nl>
> 
> Add nodes to the rk3568 devicetree to support the CAN-FD controllers.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





