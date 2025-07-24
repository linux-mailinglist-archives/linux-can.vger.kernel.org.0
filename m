Return-Path: <linux-can+bounces-4112-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B13B10C2D
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE537B3E97
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6A2DEA87;
	Thu, 24 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLYVxoAG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874382D94B7;
	Thu, 24 Jul 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365149; cv=none; b=FriJ7FBrv+ol7qj/4/eD/TGKSBRZotWJ1UWnltwAwLHPPbbrKCnLvxzZ0jF/6B9QJ2g6kR4gayWSySI49VOFiPipi7+AcUfbflVNFVqfQTs0jK10bdycit5snbYO6KiHbklH356b3/Kz4GOu+WFmIn5/4WYe2tnCgucFPZE/Zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365149; c=relaxed/simple;
	bh=0PBz12B4Woa2oNmckzFPatQZyQ6TcDZHQdFuoa0Q7dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRyRyuaX2YtVxF81gypp1JzKxaaGkXLopX4FI1AKBGPAYLwrHYtmxIjax88N5Mx9Q7sAckRiIJg8Ys6gdcge+sXKGLGaKsa0NoH3Crmn3LbvDoIuYtS8CgLoCMBdtdtvPgSkubGTAGVLuDGtIXjR/sPv51KJ4X4fX3POdRq7LYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLYVxoAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E958BC4CEED;
	Thu, 24 Jul 2025 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753365148;
	bh=0PBz12B4Woa2oNmckzFPatQZyQ6TcDZHQdFuoa0Q7dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLYVxoAGXA2K2jBJPekNX8COHCIuv6wPKpWqJm6tHJp84rbyAAFaD8Ly8ThF+nMhT
	 dGckOBr6/NaTT02UJIhrfzr/yFizJXB6ITLOIx0Of9Rlj3StIMgTSs0NOUvonBPOc6
	 rsC1IknAUGKFKXFeTsmZ3TFBHeW++hHqmwzDZ8mftzrqz/l9867LUghOWpLrjGmH7R
	 N9GbZws5lcFeOUE3IrlQyHpPRub3cSREofg3gK+KA23ojjhch8+fg1x3gQmTCTVZ1b
	 wDVkyAsjGHONflPLJ76a+YgNkLjmqk10brnB6iHCuclcmSJTr3ezeSEww+R1eTtmgH
	 rJBrBSniK8LAQ==
Date: Thu, 24 Jul 2025 14:52:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/10] can: kvaser_pciefd: Expose device firmware
 version via devlink info_get()
Message-ID: <20250724135224.GA1266901@horms.kernel.org>
References: <20250724073021.8-1-extja@kvaser.com>
 <20250724073021.8-9-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724073021.8-9-extja@kvaser.com>

On Thu, Jul 24, 2025 at 09:30:19AM +0200, Jimmy Assarsson wrote:

...

> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> index 8145d25943de..4e4550115368 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> @@ -4,7 +4,33 @@
>   * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
>   */
>  
> +#include "kvaser_pciefd.h"
> +
>  #include <net/devlink.h>

Hi Jimmy,

Please consider squashing the two-line change above into
the previous patch in this series to avoid the following
transient Sparse warning.

  .../kvaser_pciefd_devlink.c:9:26: warning: symbol 'kvaser_pciefd_devlink_ops' was not declared. Should it be static?

Thanks!

