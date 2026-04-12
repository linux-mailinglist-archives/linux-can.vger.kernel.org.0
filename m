Return-Path: <linux-can+bounces-7364-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fa8FwzL22lnGwkAu9opvQ
	(envelope-from <linux-can+bounces-7364-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Apr 2026 18:40:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD823E4E19
	for <lists+linux-can@lfdr.de>; Sun, 12 Apr 2026 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6282300538B
	for <lists+linux-can@lfdr.de>; Sun, 12 Apr 2026 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C642C11D6;
	Sun, 12 Apr 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqcifXMx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51E2940D;
	Sun, 12 Apr 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012041; cv=none; b=eTEJukl7VEhdx2C7KbM+EA50jGRjcrC6EFntlNXIR+RZFbGUiNgPhw+SLIV1hg7AxlrtK2xPMViR5vztJVPK/8ePpI67X9duFym7oPLHnGAPPnSY8Ye7tayeWpDKQ7eOv/wn/tdPLtXipMJUlFLklFRU6fbYKimI7gi1XFdZQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012041; c=relaxed/simple;
	bh=yfvYKjvfe6VfNgpCX5sn8DqOYdWmN3CiusmCGMfQzCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fF41ixZr/LCIiiQ4f8EVUTBbJYp26scfeljnCSvaWi5YvxThGW1OMsEbZjwlBq9pEQCbJG2fHy3Dlb3UgrZMhu3YgP+dd7uiH9ckUzbLcYZ8tdrb3UwNvTN/z5b+5lgXceGjs0snon1NLha+jNoYSnFL0UXfVP+cmb3VZ7c/kNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqcifXMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA4EC19424;
	Sun, 12 Apr 2026 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776012040;
	bh=yfvYKjvfe6VfNgpCX5sn8DqOYdWmN3CiusmCGMfQzCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MqcifXMxSnPkgJLxUdmcAPVwPqhWiUGu/O6L06u8TrD72GZ9sLTv/x5lWRQw+KmDf
	 BL4l5RIJlgGHMD0HRDdXebICNa13U4xbeAezbI4nXlWTBEinAiD89PGgSMfZnAj7TF
	 wbQO1VeRC15hZ95d4eJ/6pXOqKhLIq5gFLcKxSetdB+MyRLfoF5ytZoMyLMsxUBAIm
	 owDITFzjf4ozHUFxwFLOeRgHzu1AoPx7/yoOokxu8EHqeWPwKChJ+qAnXobua+scPD
	 SdNadxFEKDv5QJGDmQw7FMWdKwSsaYaKt5eAoM6DZybweqpyY4sXGbbGz9FxXqaN4G
	 2nIckDZJBOlUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA93809A8C;
	Sun, 12 Apr 2026 16:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: ucan: fix devres lifetime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601201296.3337647.8959317568301522098.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:40:12 +0000
References: <20260409165942.588421-2-mkl@pengutronix.de>
In-Reply-To: <20260409165942.588421-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, johan@kernel.org,
 stable@vger.kernel.org, jakob.unterwurzacher@theobroma-systems.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-7364-lists,linux-can=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: DBD823E4E19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu,  9 Apr 2026 18:57:07 +0200 you wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> USB drivers bind to USB interfaces and any device managed resources
> should have their lifetime tied to the interface rather than parent USB
> device. This avoids issues like memory leaks when drivers are unbound
> without their devices being physically disconnected (e.g. on probe
> deferral or configuration changes).
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: ucan: fix devres lifetime
    https://git.kernel.org/netdev/net/c/fed4626501c8
  - [net,2/2] can: raw: fix ro->uniq use-after-free in raw_rcv()
    https://git.kernel.org/netdev/net/c/a535a9217ca3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



