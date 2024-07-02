Return-Path: <linux-can+bounces-938-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410B791ED54
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE912828A8
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332CA171BA;
	Tue,  2 Jul 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+XCo4p1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC715E8C;
	Tue,  2 Jul 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889828; cv=none; b=M+tGnre1yCDuHIDiKDX1BJgAFvUCrtgF+kSaFa3tiCPI4KN/93AvLvgTq5GU1GsMUtpdzziRHHU5MVUsW6mv/joZMnzAuwGbXRR0SBZJw7AsvemULAHGwyxgZ7Y/MTR+Xl9/cbb6YJOyp5jaZ7r5kJsQJWKCUX3l5Paa+vOE00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889828; c=relaxed/simple;
	bh=McvXrlIAb0Df/RkudyuvJDZeF32sxxPSd3dTl3D/b/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j4a4Pxo4lTrWgmtF1m+H2K5uE6ZZn8MngBKDQ1mXByzKQLhesGv6CtpOsEOcte+mW5ZakqJRMMUQNePfIQdFgl7IQ2IiGotcbYrYp7j3DXHqQZHPvG7ZJMmJecEpITf4UrJ+OKm5F/EKtQ0YNH7Xr9bsz0sDyztnwcI4uC/7Gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+XCo4p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4B6EC4AF0A;
	Tue,  2 Jul 2024 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719889827;
	bh=McvXrlIAb0Df/RkudyuvJDZeF32sxxPSd3dTl3D/b/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+XCo4p1WdlPUz3lyfIT85Ugwz6EHnY8mKPP1mFWNIxl2hwtxa9CjtijUcx8f8Fcn
	 SX5Ah+X3CXxbT8NBHlIt7f0LiAy6oMyC+k/9w+MiaK8/SwxlkJbpX7QYRRtJ14NMYK
	 eV6+uzXIb4r4uF8gkLDdc+Czmiw7eHniE85gU+3mfL0SCExGWw+ARGKdcNe7e/denb
	 mvOwcwTweuaAmmrWBLVzuoBkNFUpjwhF+/R5R9fTogEYHPSMVQ/9oSRNJ1ZWSn8C5T
	 sSd0ZtG/jAoUg77hERevTN7EWwm+SAUDeUL/X0R/+ZB8L1zh3mX1y+tQmlflV4o9XO
	 ZnUDzR3R6awUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B20E9C43446;
	Tue,  2 Jul 2024 03:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] can: kvaser_usb: Explicitly initialize family in leafimx
 driver_info struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171988982772.28007.2255372828790530709.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 03:10:27 +0000
References: <20240701080643.1354022-2-mkl@pengutronix.de>
In-Reply-To: <20240701080643.1354022-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, extja@kvaser.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  1 Jul 2024 10:03:22 +0200 you wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
> 
> Explicitly set the 'family' driver_info struct member for leafimx.
> Previously, the correct operation relied on KVASER_LEAF being the first
> defined value in enum kvaser_usb_leaf_family.
> 
> Fixes: e6c80e601053 ("can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression")
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> Link: https://lore.kernel.org/all/20240628194529.312968-1-extja@kvaser.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net] can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct
    https://git.kernel.org/netdev/net/c/19d5b2698c35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



