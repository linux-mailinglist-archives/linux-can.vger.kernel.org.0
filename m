Return-Path: <linux-can+bounces-7070-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE8IC/42sGkKhQIAu9opvQ
	(envelope-from <linux-can+bounces-7070-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 16:21:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 905EA253395
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 16:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F07E3623A2D
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482F128AAEB;
	Tue, 10 Mar 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdX8RV+3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D0264A86;
	Tue, 10 Mar 2026 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152410; cv=none; b=a+UYG/hfwHQnzZjVOkmnFmGiX47KB+mnGvfx5y4hrCMGVIDy2NacP+KoU1Pdrv/RHQBnBBMa6YMh3m3czipJ8ZvmQU+1lJ6dgvxz8zCwGmerTBGj7P0ncdZnW2YiIMGnGJlWpae47vljL/rGcJdgDaGl8o7bR2Ro9/EcGLCcSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152410; c=relaxed/simple;
	bh=eHDWrTDITuNgMqSqSrldrd/UEcFS6yg2dwCtvhlFQN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jiIHJRUGEnReGT/fi3LHEQrpBAVlybjeOX1BOpjkG9wKLmn9I1PEu16p/40iVqGQpVyN0Kb9DZMGohs/QC9mwiSJ+EelAIBWDLef6ElmN9x0K8gKs6OPqSPg009N2Q/FtPbBhFeoVCCNS8wv3LHg71deJmPmWHw5iK1pJzI+wMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdX8RV+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A0C19423;
	Tue, 10 Mar 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773152410;
	bh=eHDWrTDITuNgMqSqSrldrd/UEcFS6yg2dwCtvhlFQN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZdX8RV+3KnpheEgwyP1EfHypS+/VeaKMyODtUrOUpgMLJVAqQr2haUFo5hQEyYr8z
	 oR2Ul33m+jz4SMk4eXtF2LPJJ6fGeNQuwymahXtlQ3rwD2eJ66JS9sU7Yb4jvzrOod
	 xpnpc1SWVXg38kKdFWqrWetx0YALSQbBb5ozAjuRudNNQJk2NrqoP0/RlR14cie6bR
	 AU2eMN9UAnKfmiDb1ZWGKP2w5fdYhYY0g2CuVyoVqxJXhJJtttw0UxYny7dWMgeH7q
	 9Q5VCHxurUrV0SkEJPkN0kZ8PEUTaAuWaOhCn9MxBorKmYvCh43mGxMXp3IdIIorsp
	 btS3rsJdn5WXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DE43808200;
	Tue, 10 Mar 2026 14:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] can: dev: keep the max bitrate error at 5%
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177315240680.2324285.3081385915384897372.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 14:20:06 +0000
References: <20260310103547.2299403-2-mkl@pengutronix.de>
In-Reply-To: <20260310103547.2299403-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, haibo.chen@nxp.com,
 stable@kernel.org
X-Rspamd-Queue-Id: 905EA253395
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
	TAGGED_FROM(0.00)[bounces-7070-lists,linux-can=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 10 Mar 2026 11:30:34 +0100 you wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Commit b360a13d44db ("can: dev: print bitrate error with two decimal
> digits") changed calculation of the bit rate error from on-tenth of a
> percent to on-hundredth of a percent, but forgot to adjust the scale of the
> CAN_CALC_MAX_ERROR constant.
> 
> [...]

Here is the summary with links:
  - [net,1/2] can: dev: keep the max bitrate error at 5%
    https://git.kernel.org/netdev/net/c/1eea46908c57
  - [net,2/2] can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value
    https://git.kernel.org/netdev/net/c/47bba09b14fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



