Return-Path: <linux-can+bounces-3153-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1BA6734A
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543EA172596
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E420B80F;
	Tue, 18 Mar 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBLk3THi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B420B80B;
	Tue, 18 Mar 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299200; cv=none; b=t+3Mcf6b/Dgdri4hQjSYvss/OqkYk3/AhHbSnuB/A+z9TLrp7fa7ws3P57ttwvK0uGKBOaVOwilbRM4nA22qe4mmz7zDJwHFgtcPXZgCJLaBKOXsOdA+kK5wlTraS2vxKy4bllaTJvc+eom57I8cxbkPK7ChVIAUqSMALgK9j+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299200; c=relaxed/simple;
	bh=rnDHqckyn9U1HCzf6rXs1dnXcs3qHyIMa6/uX54o2ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RjdXwZE6MCO9UR3jSlNE0WrPQLpa+xIfybeHDZsspO7zk232pQzUo344On6P5HMV3gzGgKQ7hhDARgl/4oFHsDwEvUrviTP6lmzaz2RNGnXIL2ab2zoVZRFAlMTiDJyN7Y5Bsj7ygShy/rtvnc3WL8jIzLlLo1/+e/r6xXA2V5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBLk3THi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2381C4CEDD;
	Tue, 18 Mar 2025 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742299199;
	bh=rnDHqckyn9U1HCzf6rXs1dnXcs3qHyIMa6/uX54o2ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PBLk3THiqqVVB4z45f9ytNgcZ1L2e9g7n7xHfB32u4+LhHw36HalulU5e0eX1Ba+Q
	 3/b19srTQO+crPwLRF8UbsEhpb0bxdfmn5ecCjArQRkx99rzqhhTTqvPufsNs1BqpB
	 ggmmdmHzhp8UXdH9RrtiNEGXghwM8PSnA3ntm5MTN0dCey+naE1TqdtsEjqF3RV09c
	 0VBPMTYBS+DnmQXqqUvfyIv2b+MLbWGO2Ql+4QIKlOnxEG93e3NrsC2bwhSaR2XZYV
	 1ikKyklcGdUrFmHEIINBhpEb8oy4VpFM0QmxohHUzDjfVLJPdz/hA1QzXWBKJjqcaC
	 koq82/1/K8SKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713CD380DBE8;
	Tue, 18 Mar 2025 12:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] can: ucan: fix out of bound read in strscpy() source
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229923525.283014.13510532442848295902.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 12:00:35 +0000
References: <20250314130909.2890541-2-mkl@pengutronix.de>
In-Reply-To: <20250314130909.2890541-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
 syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 14 Mar 2025 14:04:00 +0100 you wrote:
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Commit 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
> unintentionally introduced a one byte out of bound read on strscpy()'s
> source argument (which is kind of ironic knowing that strscpy() is meant
> to be a more secure alternative :)).
> 
> [...]

Here is the summary with links:
  - [net,1/6] can: ucan: fix out of bound read in strscpy() source
    https://git.kernel.org/netdev/net/c/1d22a122ffb1
  - [net,2/6] can: statistics: use atomic access in hot path
    https://git.kernel.org/netdev/net/c/80b5f90158d1
  - [net,3/6] dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties for R-Car V4M
    https://git.kernel.org/netdev/net/c/51f6fc9eb1d7
  - [net,4/6] can: rcar_canfd: Fix page entries in the AFL list
    https://git.kernel.org/netdev/net/c/1dba0a37644e
  - [net,5/6] can: flexcan: only change CAN state when link up in system PM
    https://git.kernel.org/netdev/net/c/fd99d6ed2023
  - [net,6/6] can: flexcan: disable transceiver during system PM
    https://git.kernel.org/netdev/net/c/5a19143124be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



