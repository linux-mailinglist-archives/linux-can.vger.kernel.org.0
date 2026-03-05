Return-Path: <linux-can+bounces-6920-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mo8eK6jVqGkqxwAAu9opvQ
	(envelope-from <linux-can+bounces-6920-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 02:00:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E0209A60
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC34300D33E
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC70E22FF22;
	Thu,  5 Mar 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG7I0r8f"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C79199FAB;
	Thu,  5 Mar 2026 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672421; cv=none; b=bVB2yRi+qfsEyqlYtZIAtTL3WOFL0odWQG1K/lYfAjVB1/Q2SCMTbvX4NQj85HEREiQ0GLGf2NDpBwljidu6Uv06IVmNI0rmRzHNPP6P/gqp+CXlFLKHcIUr61c8WNooJcCyG2WCwpcCNFvjB49xxNrdpkqBFUzlR4iFJ06H/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672421; c=relaxed/simple;
	bh=4Vlhs8TEbUVvJxs5pZPDdqYQ05RZzGOscrWv/EF5nXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pI2zcF+IiH9Fykrn3e0W9k6XFdeIXaFtyD4KloMcAkdWNczLzOSAdzyghJrNR9KdpvizcFcSdKnMSr8g3GDz/KWn+HWyzm146b+9cfuAuQgchvFILa4CsePxHBS32ywlKRkf290Q9ZEydCR5o3dkWVeEY3h2Fo33qk7zP+q04i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG7I0r8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C5C4CEF7;
	Thu,  5 Mar 2026 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672421;
	bh=4Vlhs8TEbUVvJxs5pZPDdqYQ05RZzGOscrWv/EF5nXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IG7I0r8fdr6L1WFKgIwiQ4rB5wTWP5bRDbdRE/6kOKmjVFcBJUVFMdMSl85ocSHlB
	 XElMhSvq4YgE0hr8j6SKtY55anZnyPLqs4gzkymcdSX/BQ6XaKLbF/SuO//irObiX+
	 vLg9fxlfChfZp9N84srUCbXJjm2QesYknU+whDh+SWtyhO7GncqRrSqYhUFK4dzakS
	 UNRWjdGu/VRoZnAi4Kf5Z+rpvmlvzBN7LgHA8Z20Vpy5OY38n3TuJNL1LFBY4ChjEu
	 WzvchW8DbfozMLOdIISOr0FKJN7l6mqTxHgkpxAbQFqutYHq1WcubizOF3LShYa6Co
	 kyL92YPWRUgOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02ED73808200;
	Thu,  5 Mar 2026 01:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/12] can: bcm: fix locking for bcm_op runtime
 updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267242168.2463633.16799782659117559019.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:00:21 +0000
References: <20260302152755.1700177-2-mkl@pengutronix.de>
In-Reply-To: <20260302152755.1700177-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
X-Rspamd-Queue-Id: 0A9E0209A60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6920-lists,linux-can=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,5b11eccc403dd1cea9f8];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:email]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Mon,  2 Mar 2026 16:16:07 +0100 you wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Commit c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
> added a locking for some variables that can be modified at runtime when
> updating the sending bcm_op with a new TX_SETUP command in bcm_tx_setup().
> 
> Usually the RX_SETUP only handles and filters incoming traffic with one
> exception: When the RX_RTR_FRAME flag is set a predefined CAN frame is
> sent when a specific RTR frame is received. Therefore the rx bcm_op uses
> bcm_can_tx() which uses the bcm_tx_lock that was only initialized in
> bcm_tx_setup(). Add the missing spin_lock_init() when allocating the
> bcm_op in bcm_rx_setup() to handle the RTR case properly.
> 
> [...]

Here is the summary with links:
  - [net,01/12] can: bcm: fix locking for bcm_op runtime updates
    https://git.kernel.org/netdev/net/c/c35636e91e39
  - [net,02/12] can: dummy_can: dummy_can_init(): fix packet statistics
    https://git.kernel.org/netdev/net/c/c77bfbdd6aac
  - [net,03/12] can: mcp251x: fix deadlock in error path of mcp251x_open
    https://git.kernel.org/netdev/net/c/ab3f894de216
  - [net,04/12] can: esd_usb: add endpoint type validation
    https://git.kernel.org/netdev/net/c/968b098220e3
  - [net,05/12] can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
    https://git.kernel.org/netdev/net/c/38a01c9700b0
  - [net,06/12] can: ucan: Fix infinite loop from zero-length messages
    https://git.kernel.org/netdev/net/c/1e446fd0582a
  - [net,07/12] can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
    https://git.kernel.org/netdev/net/c/5eaad4f76826
  - [net,08/12] can: usb: f81604: handle short interrupt urb messages properly
    https://git.kernel.org/netdev/net/c/7299b1b39a25
  - [net,09/12] can: usb: f81604: handle bulk write errors properly
    https://git.kernel.org/netdev/net/c/51f94780720f
  - [net,10/12] can: usb: f81604: correctly anchor the urb in the read bulk callback
    https://git.kernel.org/netdev/net/c/952caa5da10b
  - [net,11/12] can: gs_usb: gs_can_open(): always configure bitrates before starting device
    https://git.kernel.org/netdev/net/c/2df6162785f3
  - [net,12/12] dt-bindings: net: can: nxp,sja1000: add reference to mc-peripheral-props.yaml
    https://git.kernel.org/netdev/net/c/7e1e6d684532

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



