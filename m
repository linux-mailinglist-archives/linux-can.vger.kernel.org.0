Return-Path: <linux-can+bounces-2010-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 958019C66A7
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2024 02:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA58B27FFF
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2024 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D2C2FB;
	Wed, 13 Nov 2024 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEkPE6u2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED1382;
	Wed, 13 Nov 2024 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460985; cv=none; b=EkaugF3CJUXh97hldDxjKNvd0zhNH/2Iu+B6Hpq61pAsQWzQgx4pWz1qsBAwt+2ZBP2rZGztFy/UJ3oAh4kgB/dlmy7Ngdq9NmgQHzFAVBCJrg+EUKoUuLSG1TOzlrPiHuOOy8Pt/ExydQmtfpSkJ2ibA5DzNJZ1OYS6TSeh1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460985; c=relaxed/simple;
	bh=KzYtezsHHZd5EyINMqqHGG51cXOLpemJwiEUUpvOkA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jR1+MKoKB/OF9oY+HOxc90/mccJI2DBFgn/j5vfZCvT4drTgw8YdUMofnv5+z2cA+DbQAl+m2H8xmw64RgGy6L7ePmE685VeFAEzE3XWeqQXhkx/pB4rX5HcI3VLrfoakjUheSGNil4b5hBncUvZvMrO21mBwbKznXGwvosZa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEkPE6u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7378C4CED4;
	Wed, 13 Nov 2024 01:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731460985;
	bh=KzYtezsHHZd5EyINMqqHGG51cXOLpemJwiEUUpvOkA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OEkPE6u2U1WuKnADIOhylmi3CfE92O+1fH0PMk2OcC97uHIF+rD8uPt98OdIcOFX9
	 mBHnkR5vQiCHCFBZWV4FS+jfrBZtscCc5p17M9osJzRLrVx8uMnlviKNu52llsksUI
	 nfbdlsdAAR5V8jJOI4kK4pxjs+qrOaioOp+7aR58hBHoabKdA1qGfXOgO0zMLHqxFR
	 aJSkCG41lRt2Of0Iavy3zRQiuErE3Q23RHcNwXXI7fWGrChlM1ZuKGJBFhtbxsuJQv
	 zfQVeL5tRPZVRYJ03Vn34rjURJ6jgx/w9/GNCbhOYjCi2u9NZ3I6577l4olYOkP7L9
	 mM9NSMb5hQveQ==
Date: Tue, 12 Nov 2024 17:23:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Pantelis Antoniou
 <pantelis.antoniou@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Byungho An <bh74.an@samsung.com>, Kevin Brace
 <kevinbrace@bracecomputerlab.com>, Francois Romieu <romieu@fr.zoreil.com>,
 Michal Simek <michal.simek@amd.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Zhao Qiang
 <qiang.zhao@nxp.com>, linux-can@vger.kernel.org (open list:CAN NETWORK
 DRIVERS), linux-kernel@vger.kernel.org (open list),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi
 SoC support), linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi
 SoC support), linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC
 FS_ENET DRIVER)
Subject: Re: [PATCHv3 net-next] net: modernize IRQ resource acquisition
Message-ID: <20241112172302.582285d3@kernel.org>
In-Reply-To: <20241112211442.7205-1-rosenp@gmail.com>
References: <20241112211442.7205-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 13:14:42 -0800 Rosen Penev wrote:
>  drivers/net/ethernet/moxa/moxart_ether.c      |  6 ++---
>  .../ethernet/samsung/sxgbe/sxgbe_platform.c   | 24 +++++++------------

coccicheck says:

drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:130:6-26: WARNING: Unsigned expression compared with zero: priv -> rxq [ i ] -> irq_no < 0
drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:124:6-26: WARNING: Unsigned expression compared with zero: priv -> txq [ i ] -> irq_no < 0
drivers/net/ethernet/moxa/moxart_ether.c:468:5-8: WARNING: Unsigned expression compared with zero: irq < 0

Is this really worth the review effort? :|

Please do not send any more conversions unless the old API is clearly
deprecated. 
-- 
pw-bot: cr

