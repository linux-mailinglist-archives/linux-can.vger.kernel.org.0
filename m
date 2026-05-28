Return-Path: <linux-can+bounces-7717-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ5PJhCIF2oCIQgAu9opvQ
	(envelope-from <linux-can+bounces-7717-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 02:10:56 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72815EB2D6
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 02:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA06F30C5360
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA29800;
	Thu, 28 May 2026 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElKnlSrB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4464;
	Thu, 28 May 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927001; cv=none; b=Rh7qHIfTrOmpRu40T7JjmyiYLY+rciOV3pWbzsjslPyEpGX2dcWoKsmkfm6u//xPpcX8tl116No8oa/44p9ls0ShFTBRtpVV7q57E33AZqkmN6LKkmM2AxEnG50P9ECFuBB278JV6w9TlG5Jx+RfLFzao6rIwl2LfbkCTmQSqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927001; c=relaxed/simple;
	bh=eol0tiIwyCFO72RMZ+pqsax9PY6UAqssZwJesaYv1t8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pv+03pTrZ3RcomU3zTKFfFMTHHIdi3Hyf2HN3MMtm3Z6ZNdM2/52p0Pbm1rpM/4qQfM9b06xWWqHQDp1gd9Aeh8r1ggJCuJzr3PNL1iv67WTUEKMMwk5NxfLvA8kfGF13zDW3gUFoOVXsiGdKHnUn1pyjBbcaD2eEGak2uHlurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElKnlSrB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91901F000E9;
	Thu, 28 May 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779926999;
	bh=mKYl/HYfTJ3OVVkadqysY0EZuCoSgDnZPFRe8+oBmRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ElKnlSrBcCPlABcdn1361XNSHyUc5VdrjFpEsv2GMqriFw8atCIbDqwkciR5BCDvY
	 HiWjsA3qqT3Fs/3dwdvZrvA38pyhSV6/Hw5Orz8KR/i4lp4aqXdiuun7vMvDLWBFcF
	 uoqtvFoxNg+nspUFjpgDSkmVeAmNfWcKvSByDv2v6gdQmZDgbxAWOizlPp2vlILbJm
	 5JDbK/ZSU078v2mO8U9PO5W5iu2aO2455ptiGIt534X92SbSy//ukAB0YMQ4B4hAit
	 QmcycPzOwIHCPgpYFyevmezY14/ADFUxeEhFf9ybywXjihQEfdA/cMn+7AZBl1tAoZ
	 V6wqVj9WwGFOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 09FF2380CFDE;
	Thu, 28 May 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bonding: refuse to enslave CAN devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992700483.690389.17074233805341820738.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:10:04 +0000
References: <20260526-bonding-candev-v1-1-ba1df400918a@hartkopp.net>
In-Reply-To: <20260526-bonding-candev-v1-1-ba1df400918a@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org,
 syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-7717-lists,linux-can=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev,8ed98cbd0161632bce95];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E72815EB2D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 21:33:19 +0200 you wrote:
> syzbot reported a kernel paging request crash in
> can_rx_unregister() inside net/can/af_can.c. The crash occurs
> because a virtual CAN device (vxcan) is being enslaved to a
> bonding master.
> 
> During the enslavement process, the bonding driver mutates
> and modifies the network device states to fit an Ethernet-like
> aggregation model. However, CAN devices operate on a completely
> different Layer 2 architecture, relying on the CAN mid-layer
> private data structure (can_ml_priv) instead of standard
> Ethernet structures. Since bonding does not initialize or
> maintain these CAN structures, subsequent operations on the
> half-enslaved interface (such as closing associated sockets
> via isotp_release) lead to a null-pointer dereference when
> accessing the CAN receiver lists.
> 
> [...]

Here is the summary with links:
  - bonding: refuse to enslave CAN devices
    https://git.kernel.org/netdev/net/c/8ba68464e478

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



