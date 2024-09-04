Return-Path: <linux-can+bounces-1354-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE7D96B568
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7304EB27D89
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D75C1CDA1E;
	Wed,  4 Sep 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="x876MY7l"
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3821CC892;
	Wed,  4 Sep 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439680; cv=none; b=ql7drligYf8GEbj2xa8+Mmg09mk38QjIt4XyHiPlGf9FZJCgwZyw3rbczl4FP3BZETo/iKla+QhgA8k9aj3gpp97eo4F5a3i3o/b363sfeCQWTo3HFvHN/ekgSDVtnb87TPTpZSZC7b5HH1hRXtv3WOBHCsUEbXqlIvKoEAo/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439680; c=relaxed/simple;
	bh=uoYs5UQ1Mynjjh7jDZ/Q1YGQKSz5wNc7lOPINw5gsJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0o3jQLuqyA0t13SlYQb8ym3JgZzQuUYEsc9Ppwm+xysR8DHmMrFTRp3Iady9HVUXQKZnoFJa3M7iXnsG9av9ZUfAyTygdfuNM2dpa/C0/fM0egMrrBWpQRSHgI4VLcQwD+0uCiiuJAC8hAjAs9sHoVLlN+0R0LmwS5yNa3VgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=x876MY7l; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qoFZgLgVnrovJxCSL6kRla7wvSjvRIxlgDdGXEy63CU=; b=x876MY7lZBy2oep5/nnHQ1se95
	sQMt37m36ZHal0a5GYHe0u04Sl4A4XCuAA+Kec0o8Xyg8dqTib8mYGWs3DEG13gDG3fxXICD+eyjv
	j/BeqqnvkNiArF0pNd0fVtcHSw9pJGLNHF1tmCMATcPJ5cUwJwXauBko6vN4DW5T98OiQoEkgIz9L
	YGecHiN3NHPKb/RclmaS7HSrNUzmPznYAEEuVtLiY5gwDuJ/MEvTuJrXNkPFNgE5FFI22UW4/X9om
	ed4r6R9rqkzOEaxzRjf6vDqb1p+Q+btQrkM5KNjHbOE6YVPJT/KAMDVlAD8oJW3KnyPvy/15EdO2W
	vkpzTkNg==;
Received: from i5e860d0f.versanet.de ([94.134.13.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sllfr-0006XQ-9V; Wed, 04 Sep 2024 10:47:35 +0200
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
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject:
 Re: [PATCH can-next v5 01/20] dt-bindings: can: rockchip_canfd: add rockchip
 CAN-FD controller
Date: Wed, 04 Sep 2024 10:49:19 +0200
Message-ID: <4326989.Fh7cpCN91P@diego>
In-Reply-To: <20240904-rockchip-canfd-v5-1-8ae22bcb27cc@pengutronix.de>
References:
 <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <20240904-rockchip-canfd-v5-1-8ae22bcb27cc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 4. September 2024, 10:12:45 CEST schrieb Marc Kleine-Budde:
> Add documentation for the rockchip rk3568 CAN-FD controller.
> 
> Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





