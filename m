Return-Path: <linux-can+bounces-1292-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C89966F99
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 08:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF851C214A4
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 06:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FC13B2B2;
	Sat, 31 Aug 2024 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neayYJS6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E1320F;
	Sat, 31 Aug 2024 06:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084124; cv=none; b=ku6VLiOO2SBq6BjHW5xHrTcmeeuhXRkJeOKMNfxDwvW/8zRg5M5tJA6GS1Z5m7KJ9EM5yGPIB5nvYoqu4q1Bsm6qE5I5NBPgEQaR6Piflc6vIseD49OKOP0c2ap9nfaweUJ40DSt94XwMcPFhmjocgP/CBYdsXXo3frWZ3aX/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084124; c=relaxed/simple;
	bh=q5otYUXCmcRRQaIS/CDJPlk+t95npFIXn2p5Mj8FmQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX20hbmMWEYFMYRXAHJDknSOIZ24UQeUYHp0HFv/JpwjxaifR1D+8L5Unk/3a6ejPO0j8gli7B8Kco41qJP5YgUAWiGrR5n1l03t5hkBJHk0ejF7PIi3yHoD54HlCB7hqBYitly8pPpbudZrhS58oZnQhEBgt2R4Jk9yvS20O8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neayYJS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83938C4CEC0;
	Sat, 31 Aug 2024 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725084124;
	bh=q5otYUXCmcRRQaIS/CDJPlk+t95npFIXn2p5Mj8FmQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neayYJS6jQqJ0B5QAvUMLo6Kur102JeHu6b+CHM4FSdmm0b0I2Q7Ag7TIXl6ebtqG
	 rQCBGvfpwjaDiib9698az8U4UNV/+aqLi7fhdoWKHl7aY6Kiei/TuUZFt11b1zyLOJ
	 5utsJZgUKfq0SnDXakgk/8Ck+JeyfUwYXkJH/Vc7iATsDMQRRG1kwGORndOQ1YeKFN
	 9K5k8Xpt5aioAF+0/NbuKTqpFc9IA8CA4i9xai1l1fyVR0EhN/R1zenoS1F7e/5Vqt
	 N+xL8G2XVaoISXoKzgT0lLvAM9m+uY9iFeGU/WPcQNjJst8w/FLBfPw5PCzFz1vspV
	 Cs0WsED75PQCA==
Date: Sat, 31 Aug 2024 08:02:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, David Jander <david.jander@protonic.nl>, 
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH can-next v3 00/20] can: rockchip_canfd: add support for
 CAN-FD IP core found on Rockchip RK3568
Message-ID: <ecj2sv7xhmu6plfnrq4ezejn3d43cl5mwutvkwh4u2bqcmna3k@2jykwgizuxmb>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>

On Fri, Aug 30, 2024 at 09:25:57PM +0200, Marc Kleine-Budde wrote:
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
> ---
> Changes in v3:
> - dt-bindings: renamed file to rockchip,rk3568-canfd.yaml (thanks Rob)
> - dt-bindings: reworked compatibles (thanks Rob)

You never tested the patch before sending.

Best regards,
Krzysztof


