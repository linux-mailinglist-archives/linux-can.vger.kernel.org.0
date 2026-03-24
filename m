Return-Path: <linux-can+bounces-7240-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJJ8F9h1wmkbdQQAu9opvQ
	(envelope-from <linux-can+bounces-7240-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 12:30:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD7307539
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C693058495
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986B3E867B;
	Tue, 24 Mar 2026 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq81SL5K"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC7363097;
	Tue, 24 Mar 2026 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351825; cv=none; b=CiOBsQ8hZ1SyDxQAyIfZIdhg/5iQI5+NC90dBmX1e8uRruGhpBvoHD3t4BQKIdulSY6Q/iF0ZxiGqFzpFhQKCiDfkuRVqjrz8afIqgV86lR0REKtg2NfjssrpkR+Dy75MwzVWnCiAxz+NIgZA7Qc+3wAfU39H6fZDZ5N9H/0rfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351825; c=relaxed/simple;
	bh=YC+Fp3qrF99uTNmycP09wPtKPzfClEtMIxUpFDuzuIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QlP3K1lq9Kf0P0eplLedLi0dTzvS3s/eUDUJ2KSrKKKBtw8YWxpon9kxAUYtAPLGcOJccqXWmRWBzA3PzFe35664XZC5jDkvf1I8rNqAAXsXEiI7PIaMAhHONmfCOpLB18z7VNF2t+1PE1n5C4Mp6SD7pqF0g+c4JBP6ISSYS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq81SL5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD0C19424;
	Tue, 24 Mar 2026 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351825;
	bh=YC+Fp3qrF99uTNmycP09wPtKPzfClEtMIxUpFDuzuIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uq81SL5KoKGwFJeFD/0mYMA9NlRuqE2mIwd5lYxfsyzUgmkipBV/V1tJMhxyIFAAD
	 1AvxCJAVs1pGhHN388Xa/K9QfhvTmDMfimwvQTdxq7bh6SqyeB9cT2QC9252YdyT/3
	 cTQ/WKxvN5ylXOFcSc67q7UZZ/wZQ8Xn5yupwE9SCSg3WTxg2FL44OgN3Cs82+6t8+
	 NFdzYwjngVUhWGjTuu8iO/ehqvhRMYS+FFVHk7FkSQr0dzfQPwaSajq+UFZJA4J2R+
	 8jT7BSppNklTxW7an0S//TWeLJFEBtUVwhQUzJYQvCMm/XLTb/DU4BCqAKh2LJ1icl
	 2BtH53eqvB2HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFEE3808200;
	Tue, 24 Mar 2026 11:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/5] can: netlink: can_changelink(): add missing error
 handling to call can_ctrlmode_changelink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435181329.632762.6895120809485752388.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 11:30:13 +0000
References: <20260323103224.218099-2-mkl@pengutronix.de>
In-Reply-To: <20260323103224.218099-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-7240-lists,linux-can=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: D4FD7307539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon, 23 Mar 2026 11:27:57 +0100 you wrote:
> In commit e1a5cd9d6665 ("can: netlink: add can_ctrlmode_changelink()") the
> CAN Control Mode (IFLA_CAN_CTRLMODE) handling was factored out into the
> can_ctrlmode_changelink() function. But the call to
> can_ctrlmode_changelink() is missing the error handling.
> 
> Add the missing error handling and propagation to the call
> can_ctrlmode_changelink().
> 
> [...]

Here is the summary with links:
  - [net,1/5] can: netlink: can_changelink(): add missing error handling to call can_ctrlmode_changelink()
    https://git.kernel.org/netdev/net/c/cadf6019231b
  - [net,2/5] can: mcp251x: add error handling for power enable in open and resume
    https://git.kernel.org/netdev/net/c/7a57354756c7
  - [net,3/5] can: statistics: add missing atomic access in hot path
    https://git.kernel.org/netdev/net/c/46eee1661aa9
  - [net,4/5] can: gw: fix OOB heap access in cgw_csum_crc8_rel()
    https://git.kernel.org/netdev/net/c/b9c310d72783
  - [net,5/5] can: isotp: fix tx.buf use-after-free in isotp_sendmsg()
    https://git.kernel.org/netdev/net/c/424e95d62110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



