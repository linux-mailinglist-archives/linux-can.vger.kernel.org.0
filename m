Return-Path: <linux-can+bounces-8299-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WtsSDWYjUWpt/wIAu9opvQ
	(envelope-from <linux-can+bounces-8299-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 18:52:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BE73CC46
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 18:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=q++mYayk;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8299-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8299-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E550F30013B9
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C743E497;
	Fri, 10 Jul 2026 16:47:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653543B49E
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 16:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702073; cv=none; b=lxKUmg96+OpDzWlh6GiQ73WNzUtMuLPv+sIgIXZjV27mDLNAVUsjx3eWrvM1AfQyBkz6E+m5L5BXK4VoJDX6a8/Won0vSkvaqkiaiNJVrL9xLyz08vV1Xigx1PzmfW1eqEfXD3CIehaDd0mUzIFc17PptjdgW+SOlY+DOUhBrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702073; c=relaxed/simple;
	bh=fbxpnqfv2gG/Jdn5a5VbX4NTrrS0xeNjf5CXffBbNDE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PC/HR/+gD9h0VEdmVXoBJZ9h1eeyiQbWU1ZXP1+mROS8zJyWTnmllXdxBepREU1xW5rYUvIQ87BmQkQumt4wL0fSzX7C9RgtlEJFxxBeiCdHR1QMxRz0qYly8I4ss/GGcgpyVDdB4v11PfyWvlwxh4mcH3b8DLddRYtznjF9c34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q++mYayk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C5FBC2BCC6;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783702071;
	bh=fbxpnqfv2gG/Jdn5a5VbX4NTrrS0xeNjf5CXffBbNDE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q++mYayka21stt/cnan9IGc+lPlzEH7T75QqHsingS5emXO1bNarL4X2fUMScdNsw
	 hn86g5jNEMOg533lXaYAldQISdpstdOcW+HQdWmCrw3qK37xn7Egq674meJZ2JWWmz
	 eIsZi/NuRPmHFN45v2+KF2scg/9au9Q6hafh9lfaLJahUbDu/fVTQTNkcaCfbbtGul
	 UBt/pJXJehMfQ09rCmJppSTy4OGaKDUwdQeTcpBQDKmg74f1tFV52lve54PyocmdIZ
	 K/y0z7V2iyF7m26X0F359nxeQOQixL3ZWARyDoWaPDrlBei7uv25QX3RMdgB7xC+8Z
	 d0xqxY13khbYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6603AC4450D;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v5 0/4] net: can: isotp-fixes
Date: Fri, 10 Jul 2026 18:47:41 +0200
Message-Id: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0iUWoC/33NQQ7CIBAF0Ks0rMUApVBdeQ/jAspg0aRtAImm6
 d2FujNNlz/z358ZBfAOAjpXM/KQXHDjkENzqFDXq+EO2JmcESNMEEkJdmGME7buDQGDMpK3xAi
 pLcpi8rAeMrjefjm89AO6WCZKo3chjv6zvku09LaXE8UEy0ZRQ6mRxp4uvfLxOU7TcYCIynhiO
 5xlrrtGAhPNiWu2wesdXmdOWqNFC0waojc43+E8c6a4sryWVtB/vizLF5OcUSR4AQAA
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702070; l=1941;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=fbxpnqfv2gG/Jdn5a5VbX4NTrrS0xeNjf5CXffBbNDE=;
 b=8JrhUMxKG9HhMxpugwadJCykOBkRxd2onARoZLDGiUn4oRTVWhHkqhvlZLRaZF8gAg4/2QKSB
 Q4ng7YXbdHqDkQDJoJQ4IPrhevpNgebi/Bj9Pd6cOQwkMglOSdDcpaQ
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8299-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email];
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
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F41BE73CC46

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

Add another two patches with fixes reported by sashiko-bot.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v5:
- patch 3: new: state change re-check after hrtimer_cancel()
- patch 4: new: handle state transistion with cmpxchg()
- Link to v4: https://patch.msgid.link/20260710-isotp-fixes-v4-0-2a4af437f61b@hartkopp.net

Changes in v4:
- patch 2: use a simpler method to reject a re-binding that can be implemented
  inside the lock: No waitqueue waiting just exit.
- Link to v3: https://patch.msgid.link/20260710-isotp-fixes-v3-0-08db68e27d0b@hartkopp.net

Changes in v3:
- patch 2: go back to initial idea without hard resetting the state machine and
  timers but let these come to a graceful end. Even a new bind() at netdev
  shutdown now leads to this graceful statemachine shutdown via the wait queue.
- Link to v2: https://patch.msgid.link/20260710-isotp-fixes-v2-0-bc57e26594b2@hartkopp.net

Changes in v2:
- patch 2: shutdown state machine to fix sashiko-bot complains
  Link: https://lore.kernel.org/linux-can/20260710094807.A50DD1F000E9@smtp.kernel.org/
- Link to v1: https://patch.msgid.link/20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net

---
Oliver Hartkopp (4):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: fix race between RX timer and consecutive frame reception
      can: isotp: fix lock-free state transition in tx timer handler

 net/can/isotp.c | 115 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 32 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



