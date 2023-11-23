Return-Path: <linux-can+bounces-51-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D67F5C0C
	for <lists+linux-can@lfdr.de>; Thu, 23 Nov 2023 11:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18AA281880
	for <lists+linux-can@lfdr.de>; Thu, 23 Nov 2023 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C22233A;
	Thu, 23 Nov 2023 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1Zdc31y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FD224DA;
	Thu, 23 Nov 2023 10:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20063C433C7;
	Thu, 23 Nov 2023 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700734539;
	bh=gL4xFcxmYSSh7kOgDS87FN5NgH0x5Jtwcq7nF4+rREM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1Zdc31yNztmTAbJjB1MoYlplWFujXy+xSZ4Fau875psGogC/LQdTAJx0lMBirJXd
	 LX8IF4gocWJwnQJDcfOC4Txuyzk5v3KvC7u/AhnXJLG0ic59OFEJCxLpmpHTWAx+DB
	 NHYfsu1ohIg/HsoRrpPMuaW0SsUaX6mBit2Ko7ozGvmZ/jwqv/FH2FJ4zhCiH7L5Ku
	 RF7t+3pdP8exkNe2GPWkbFxmf2TpdpCh0XhkidqUqYCqr+RCzk9QceY4eCW+5KuPA7
	 EQgVztpU/Fpe+oHlumhI5R0/HHLBzwLd9ltRQc9+E5LajGwDG+qqrde+gj6x9pt7jY
	 acBV9lv+RN+ug==
Date: Thu, 23 Nov 2023 10:15:34 +0000
From: Simon Horman <horms@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] net: can: Use device_get_match_data()
Message-ID: <20231123101534.GC46439@kernel.org>
References: <20231122180140.1432025-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122180140.1432025-1-robh@kernel.org>

On Wed, Nov 22, 2023 at 11:01:39AM -0700, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Error checking for matching and match data was not necessary as matching
> is always successful if we're already in probe and the match tables always
> have data pointers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Drop calling "platform_get_device_id(pdev)->driver_data" in c_can
>     and flexcan as device_get_match_data() already did that. The logic
>     was also wrong and would have resulted in returning -ENODEV.
>   - Drop initializing devtype in xilinx_can

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

