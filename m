Return-Path: <linux-can+bounces-6461-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAHFBWtUgWngFgMAu9opvQ
	(envelope-from <linux-can+bounces-6461-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 02:50:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494CD37B9
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 02:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD5130226A7
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686CD2D47EF;
	Tue,  3 Feb 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1e/3kg7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D317BA2;
	Tue,  3 Feb 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083412; cv=none; b=uA46nHMdGnz+RHPi6C4YA+upV2olrIaNXgsZcf1qNSzGhLmmSH5n7O8zS9aCX7bRD605hwKN/z1Qv0Zc3DCxw422bi1hHMBhxruCpGXjRLVEHJ188dfQx3Dxp2v4CAkLKjj2PkXgysPHN/banvHaTewQxzfphND7RA52SKsB8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083412; c=relaxed/simple;
	bh=uC+Gk1tnDz3hZniojbGLYZH4mga+ylzwZ9IMYLv2nrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n3cRqDC4Xf4Vp4KJrZgJITcvEURzmkIA7z8JsZOI4oYMWJAm6p35To5XEOOA1QguqP1G6ai6kv/2mN4dfySORU7HEYQ5CTxu8kTvyihrdInleaVWTM5T/G+lfhuXtw1GJWQ8POHwXaYGEeboaXSQyjIHet3F+BmhEOpdsCsXyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1e/3kg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9EBC2BC86;
	Tue,  3 Feb 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083411;
	bh=uC+Gk1tnDz3hZniojbGLYZH4mga+ylzwZ9IMYLv2nrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X1e/3kg7itGeER+8hQaPRXwd63X9VI3diCLF61zaJdzNOq2Zkx8dpdssmh4nYk7YK
	 XuN7+ZfG0bByTOOKjRcnNQxGGFJUkSMICLQ5i6Ei2b2nugyXUZrj5dsiqNJaPjzNd4
	 4cpoNOjV8cebwGoguPWL+9d95qZVILM8U263tnwiBNl3a4H4bMekJESfUMxrhRxqiv
	 Su6T4olqkWvjnFki5BcQrmcSiKu+9fpKRcKijLPcLW10otzAx2sXCk/dFl9SphSphP
	 mazFtuzgY4qSuRwp8lN/cBslvv636NK5ntV96cwm4TE/3H2wnhHx3AhM59RDJ36157
	 UBZ6F237NbS8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CDEFA3808200;
	Tue,  3 Feb 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008340837.1270041.12095382235661500510.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:50:08 +0000
References: <20260131004327.18112-1-enelsonmoore@gmail.com>
In-Reply-To: <20260131004327.18112-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org,
 linux-wireless@vger.kernel.org, m.grzeschik@pengutronix.de,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mkl@pengutronix.de, mailhol@kernel.org,
 idosch@nvidia.com, petrm@nvidia.com, sridhar.samudrala@intel.com,
 toke@toke.dk, pkshih@realtek.com, tmuehlbacher@posteo.net,
 socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6461-lists,linux-can=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6494CD37B9
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 16:42:56 -0800 you wrote:
> Many network drivers have unnecessary empty module_init and module_exit
> functions. Remove them (including some that just print a message). Note
> that if a module_init function exists, a module_exit function must also
> exist; otherwise, the module cannot be unloaded.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove unnecessary module_init/exit functions
    https://git.kernel.org/netdev/net-next/c/e0221553436b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



