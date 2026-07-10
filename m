Return-Path: <linux-can+bounces-8273-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YKM8K1jBUGpY4gIAu9opvQ
	(envelope-from <linux-can+bounces-8273-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 11:54:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A138E7394A5
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 11:54:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=LVWr4r6S;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8273-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8273-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16213303C340
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E03F58DB;
	Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AB3F4823
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675971; cv=none; b=OcnZGSCVILJ3mXKMvI9TqxHpEQZ4Oc4KfjkolanXpuVaXa0fK2N6eVmx+Yf3Qw1Dr2LzQzhYCB+Hi2CjQcnlyK/EgmPRwF4QmpAstfkLa2V/fEUQTMCAqbSMv9ExWTdePhGMx02hogoXdpc9h2NR2mc5U3pf/4e5w3oER3MjpuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675971; c=relaxed/simple;
	bh=++/bfR+pKzCQEjfPDXoWjC/JtL4+USopQUJI5PGVIN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UTPXCph3IY4Zoqe5HfBdsfWojfEwbDttvhqyaBcnzV9T3fnGeZGJz5nrfEs4P3rV+b3RNqqcThxaZ3R+0GP9rFBH6cnuxC2mS8ASbwT9qRXMbAUoYEOTqwlNeCTzW5vJpyrOUJqwK+ereDT5dR8iepOnjYA5tpdQWFMpp286EQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVWr4r6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A437C2BCB8;
	Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783675971;
	bh=++/bfR+pKzCQEjfPDXoWjC/JtL4+USopQUJI5PGVIN0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LVWr4r6S29xfw+6pPBwMMcSX3rGoBa21gWcwaNd/hng37t0D2EqYvs5HUae9MIPx+
	 8Np/0xTXu6W7xujeG6w/QN3pMW1+q0zRIO/784u4u3XNp79i4NYsxqlgoq6ySXYRwM
	 xMX6o9yKzTaKGphBPQdlrJVClnX4XQRlGLeCE6nkJn4xVPg3yC/faCrn4Bzc3VE9rt
	 bwOldfH1+KdOriqs/VawHH1YP/Ja1wVSPdXBl85e1HteQuHJy2B7iihEmOFxy20dUP
	 dJgdMKSpEaJVAwOpn4HoFt1rkiGwHPmyifVhp7D8ZkLhzJ2OSRe5lk+WFxjFlgUqyh
	 dqkiQ3m1uSGAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E2C43458;
	Fri, 10 Jul 2026 09:32:50 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH 0/2] net: can: isotp-fixes
Date: Fri, 10 Jul 2026 11:32:43 +0200
Message-Id: <20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADu8UGoC/yXMQQqAIBCF4avIrBMsQqOrRIvKqaaFhmMRSHfPa
 vnx+F8CxkDI0IoEAU9i8i6jLARM6+AWlGSzoVKVVqZUktjHXc50IUscrKkbZbUZZ8jFHvAbctD
 1v/kYN5ziewH3/QAW92AvbwAAAA==
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783675969; l=706;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=++/bfR+pKzCQEjfPDXoWjC/JtL4+USopQUJI5PGVIN0=;
 b=Dj2f4pFfZxOZVb5Djy6avpd7IqBhx3LF0f8mpvFa21tCmQX9mOFGfIsTtEtyo9TSkDBMExMg6
 hNx+xGnx8rtA2VKSLzkpzvnwhGbQKMqj210MD3uX00NeVNOAfDStWcO
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8273-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A138E7394A5

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

It covers two fixes reported by Nico Yip and sashiko-bot.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Oliver Hartkopp (2):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

 net/can/isotp.c | 77 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 29 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



