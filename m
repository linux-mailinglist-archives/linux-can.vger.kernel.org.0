Return-Path: <linux-can+bounces-6443-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKTXMfFvfmnEYwIAu9opvQ
	(envelope-from <linux-can+bounces-6443-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 22:11:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8EC3F48
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 22:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A777F300D322
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 21:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C9378815;
	Sat, 31 Jan 2026 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0AG5qIc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1E3783D8;
	Sat, 31 Jan 2026 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769893826; cv=none; b=RQmkNP4JYyEjBFpo6Difmr1rJ1TQkaMYqzbc8Zx3nVGAVXk1143KSd5ds6Ty7ekk+OI1RAIPX4ok56cxKk/tUEdp+blFNd0bCvA5ytXORxpTmFqeGeBFQbFtXdldIPsdQkMbSgs1/Nct+bhqjZIfXV+K4+qhpqcTTgPkBILjN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769893826; c=relaxed/simple;
	bh=gvXayrJxzKDgM6XOk20ZQRa/7PD9/sfSDgdlzXGer6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FsG15+pDGdBzxo9KmlRcTcFslJwLMNU14TJiiGF/ysPnFvdRVIAUkVAnVufkFdbCLdHbScOeLv0cF3qmW724gw4ib9684i0sDyVM7OK4mYZTAjrd7C/dGt6foGsEouFOfWzk/PGTEITXFYt8nUJXuvw1FTVV8X6busgNAG9d32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0AG5qIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4240C4CEF1;
	Sat, 31 Jan 2026 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769893825;
	bh=gvXayrJxzKDgM6XOk20ZQRa/7PD9/sfSDgdlzXGer6I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0AG5qIchPVs45yc6aDvr8/rUbY1SDszK/3VplYXUj6rpsJreQflj+j0V81kO3ycx
	 Jcqz/0wiHSfpNy0eHnHOBZFms4ewI/baodpuzMyz6SxKISbsUqi9tZfnwudtgENG4+
	 AxEdQprlsEc8cwyVRXS3nF1+f3ZsKAyMt1uBN9ljy+idA2y9+VHlJv2d8Wfh/zFmSI
	 NtVKMvYvSGu4ZVP6m27rP1IAhzHNBiSDTeVDVT3CJJ9DnKpFkLJE0YG1BPh3zJpKKU
	 2LrpY3Vwvc4D8s0w2LSC+oC6Ae833aF2MQuQ7JHsdpt+aYBlwBU2P5OH6H/Vl+bflt
	 Q/0kMjL01jdKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8F30380DBD4;
	Sat, 31 Jan 2026 21:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/8] dt-bindings: can: renesas,rcar-canfd:
 Document
 renesas,fd-only property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176989381735.4191188.6064478977042976575.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 21:10:17 +0000
References: <20260131101512.1958907-2-mkl@pengutronix.de>
In-Reply-To: <20260131101512.1958907-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, biju.das.jz@bp.renesas.com,
 krzysztof.kozlowski@oss.qualcomm.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-6443-lists,linux-can=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 2DA8EC3F48
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Sat, 31 Jan 2026 11:11:42 +0100 you wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
> Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
> Classical CAN frame format is disabled. Document renesas,fd-only to handle
> this mode. As these SoCs support 3 modes, update the description of
> renesas,no-can-fd property and disallow it for R-Car Gen3.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
    https://git.kernel.org/netdev/net-next/c/1766de15a571
  - [net-next,2/8] can: rcar_canfd: Add support for FD-Only mode
    https://git.kernel.org/netdev/net-next/c/9a2b56a48c21
  - [net-next,3/8] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
    https://git.kernel.org/netdev/net-next/c/af6b427c7ad0
  - [net-next,4/8] dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
    https://git.kernel.org/netdev/net-next/c/c74ab6275c34
  - [net-next,5/8] dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
    https://git.kernel.org/netdev/net-next/c/1e3710b1fe91
  - [net-next,6/8] can: rcar_canfd: Add RZ/T2H support
    https://git.kernel.org/netdev/net-next/c/e8e46378825b
  - [net-next,7/8] can: sja1000: sja1000_err(): make use of sja1000_get_berr_counter() to read error counters
    https://git.kernel.org/netdev/net-next/c/a6c89d75fd33
  - [net-next,8/8] can: sja1000: sja1000_err(): use error counter for error state
    https://git.kernel.org/netdev/net-next/c/22ca24978337

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



