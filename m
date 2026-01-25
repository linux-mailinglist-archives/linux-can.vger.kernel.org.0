Return-Path: <linux-can+bounces-6305-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKjmH0KJdmncRgEAu9opvQ
	(envelope-from <linux-can+bounces-6305-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 22:21:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D80827DB
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 22:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B5B3301486D
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00F30E0C3;
	Sun, 25 Jan 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4ki0f0q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AC30DEDC;
	Sun, 25 Jan 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376019; cv=none; b=p41SVdsMmlDzFxkUE98IxN1wEcRNBVW9/RFlwL7A5BbkvuA2V0EN+qnXCUv9foyfPVekC6z2grw4hP+KAUO56RwODHw9OIgvmGswcUkxGACksJkKCHW1aFDdPD96tkX6102gzLKInWZ8HRvOD7tuWEE4dNZ5Y7+6wtO6+yWhndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376019; c=relaxed/simple;
	bh=fFc5GWOjATI8wU50Ou3gyc63w8hj5PkBp259xRZdrL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FxBXWTbVzCG1o9u+6XKymwcEjJeZ5WYhZvf5vBQDYH+iEVT1jqLTWECxqkTKh1hQxwwhxs/B/ktFbC5W/k7U08W7JtE6HSIBIcyQNeFvjadTUEGwq20gF5Vfp9eeEh20EVnQ26EYwYXdKpvEz7IAwz2zZZAiAEdNPSfTSTJScKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4ki0f0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5EFC19425;
	Sun, 25 Jan 2026 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376019;
	bh=fFc5GWOjATI8wU50Ou3gyc63w8hj5PkBp259xRZdrL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q4ki0f0qTeGm7qwpj2VD3V04u4Vho8hCYaNIK7GIyIOugtCINtEymNuGb2EwIyILu
	 /gw7JcZTxwB9zq5saF3ilM7qg6OBIi1w1jJP4DDhHkPUMlgNaebN0u4jMMxAjliQRA
	 nScvraNIr4gjkxT6Nj5caiRZqZyPHUWYI+xj39Zl9S/hzesoztvCX/Kkklds63FxdI
	 PaJdBQrJR2ri+kpFEKBRnPkEMjAgd731b0uKo1QEpyvN+8V0VmMUI3WgAKZlgyWrFF
	 hI7P5ZTAZvXyYaWlD/5Xz3cE4DA8n3e7zshbD1/du3YyU9i5kRGI674AaLdKb27G/V
	 EEeRiu9wSUssQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBAD3809A15;
	Sun, 25 Jan 2026 21:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: at91_can: Fix memory leak in
 at91_can_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937601410.3588307.10395345975668569922.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 21:20:14 +0000
References: <20260123173241.1026226-2-mkl@pengutronix.de>
In-Reply-To: <20260123173241.1026226-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, zilin@seu.edu.cn
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-6305-lists,linux-can=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20D80827DB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 23 Jan 2026 18:30:06 +0100 you wrote:
> From: Zilin Guan <zilin@seu.edu.cn>
> 
> In at91_can_probe(), the dev structure is allocated via alloc_candev().
> However, if the subsequent call to devm_phy_optional_get() fails, the
> code jumps directly to exit_iounmap, missing the call to free_candev().
> This results in a memory leak of the allocated net_device structure.
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: at91_can: Fix memory leak in at91_can_probe()
    https://git.kernel.org/netdev/net/c/0baa4d3170d7
  - [net,2/2] can: gs_usb: gs_usb_receive_bulk_callback(): fix error message
    https://git.kernel.org/netdev/net/c/494fc029f662

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



