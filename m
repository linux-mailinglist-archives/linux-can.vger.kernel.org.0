Return-Path: <linux-can+bounces-1790-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A642C9B183A
	for <lists+linux-can@lfdr.de>; Sat, 26 Oct 2024 14:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61DA1C20DC9
	for <lists+linux-can@lfdr.de>; Sat, 26 Oct 2024 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93C1D6DDD;
	Sat, 26 Oct 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojfbFI5J"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD101D6DBF;
	Sat, 26 Oct 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947246; cv=none; b=oPC443YlG9ce2MyNkZh1YDyugZbZ7VqzhnDantlfQlSqFnWostBwIJ9Yca1JI1t5CGHvCGcGDkiZvXxv/Kn0gE3YU7FXHM7SX6UA7ZED207lpJooV76uZOgXf1AE4eNThWhltfGbcjO/8SvQDeXbJ8x//VgHyA2c4kyN2KSZoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947246; c=relaxed/simple;
	bh=CJGpXk4JE8FDwb3q0K8U4S1HXQZXc0+eiMpLFAaiKlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psP3X2GppyUXoGLvYbiG8o66UnQHYDlbDGfPqpk9D9sYUG8KHNcue3P3emL8bYvYVJQOpJlB/CSHJYfvM7aIHtP8tKXQZ6pmM/aOF1tSlDpU6QTSwhsoDjC0MQFDor5+ufAz9mEGMqCSIP/yI5ClzndpwCu1VNJcIIcAbE1yIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojfbFI5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3846FC4CEC6;
	Sat, 26 Oct 2024 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729947246;
	bh=CJGpXk4JE8FDwb3q0K8U4S1HXQZXc0+eiMpLFAaiKlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojfbFI5Jc8AzkzpnaW+zWn01L8scZ72QaD7i3Jv2bXTlCjTmBIQ7/k4EkR8bljFBz
	 pE1nFW3AVrkCXgJBzT0f+6YvqIpONVKqUMnam4pal/2a+58BL1LJizjPMjIU/qTWtm
	 RVPLKm4QVSPw9Se0NLVrb111uufJ4+gdvCy8Ir7oWQb8Z6yiXpg5f9pMO4mwbL1mpy
	 qA1IuW/jyQPeDlMes30BhaHGsZhqP+VnHKBifRXVQJcgCzZkkDio/04S8eEgAPnxr8
	 8t4LT3NRPPwdxjJgGakaKsbauBOBIWwPW6WhPSE7vKX9jDU2HgUiqymYDB5rfFEUNV
	 dFy3peBkIYtxg==
Date: Sat, 26 Oct 2024 13:54:00 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can] can: mcp251xfd: mcp251xfd_ring_alloc(): fix
 coalescing configuration when switching CAN modes
Message-ID: <20241026125400.GD1507976@kernel.org>
References: <20241025-mcp251xfd-fix-coalesing-v1-1-9d11416de1df@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-mcp251xfd-fix-coalesing-v1-1-9d11416de1df@pengutronix.de>

On Fri, Oct 25, 2024 at 04:47:19PM +0200, Marc Kleine-Budde wrote:
> Since commit 50ea5449c563 ("can: mcp251xfd: fix ring configuration
> when switching from CAN-CC to CAN-FD mode"), the current ring and
> coalescing configuration is passed to can_ram_get_layout(). That fixed
> the issue when switching between CAN-CC and CAN-FD mode with
> configured ring (rx, tx) and/or coalescing parameters (rx-frames-irq,
> tx-frames-irq).
> 
> However 50ea5449c563 ("can: mcp251xfd: fix ring configuration when
> switching from CAN-CC to CAN-FD mode"), introduced a regression when
> switching CAN modes with disabled coalescing configuration: Even if
> the previous CAN mode has no coalescing configured, the new mode is
> configured with active coalescing. This leads to delayed receiving of
> CAN-FD frames.
> 
> This comes from the fact, that ethtool uses usecs = 0 and max_frames =
> 1 to disable coalescing, however the driver uses internally
> priv->{rx,tx}_obj_num_coalesce_irq = 0 to indicate disabled
> coalescing.
> 
> Fix the regression by assigning struct ethtool_coalesce
> ec->{rx,tx}_max_coalesced_frames_irq = 1 if coalescing is disabled in
> the driver as can_ram_get_layout() expects this.
> 
> Reported-by: https://github.com/vdh-robothania
> Closes: https://github.com/raspberrypi/linux/issues/6407
> Fixes: 50ea5449c563 ("can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


