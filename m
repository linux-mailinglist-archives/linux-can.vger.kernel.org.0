Return-Path: <linux-can+bounces-8322-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OJ0DNwkyUmovNAMAu9opvQ
	(envelope-from <linux-can+bounces-8322-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:07:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24792741741
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="Rk/jUg9O";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8322-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8322-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20B51300EAA6
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F533A9DA9;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1923921E7
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771636; cv=none; b=NGzxlUx5odivbsyCq38Jcn31kfBmv0MFWdbSPa8t66k6PXLztsNPy1EH+W6PBMrcxD6FbIBPmS70kA+ZgqtaAXSF124KWWhmEgSETVreiiCGbukMUw/TZZjjfySWb0HsJ2VxjpwLLANpCYo6oeY7VfgdbNjHeB2ONMujyX9tzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771636; c=relaxed/simple;
	bh=cifrS8XB2M5Sb7Mga4Ht3Xqhy5uFkAiqFJeObjOwE/8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KPkppkw9VSoAH/PNqP7z9zgFxH9Qw1fRD0W0GADPGJgsC+EqRoV5jDIsIYYuzvVHEaY4uEKsrICm0S7bTtkuN33kwDGDzJ0FJRYO6hSjcVnXjI3DAEdJN9yszHzq+kJKU0tZu9U3EjvJxctM6PCHBmB5IPCwLF8aoBm3C8tD79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk/jUg9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7342C2BCB3;
	Sat, 11 Jul 2026 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783771636;
	bh=cifrS8XB2M5Sb7Mga4Ht3Xqhy5uFkAiqFJeObjOwE/8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Rk/jUg9OaYWYPf3QPSboPO5MZlneWzFvykCVvETHBPUpL6JGQsWUUNwV4uWrn2lrM
	 Q5Q2Wc8E0XlH6VH7p+cBvkwpttuAGnxMfZKrPVeIc5UdspLzCfxhexHJyZfarZvDq9
	 v62oOdKPf9FefX6QuOXFn59xWHSXZr5kD0tfXY7GZhRKig4ItW7rAno9CWgHGHv4R2
	 1lB0Dw80aqkfpbJfdYpznA7f0rNNyxdc8wo+d1J6K/LYstcGHyttbz6kgbFVyPYrnb
	 UfGqHg9ebeFtKfUmPP0xZbV9BUBHlqa//PYIwGSvZwEmyL02c9+ZkX6LjXUXC23/vU
	 5tQe9LUusyO2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5871C43458;
	Sat, 11 Jul 2026 12:07:15 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v7 0/5] net: can: isotp-fixes
Date: Sat, 11 Jul 2026 14:07:11 +0200
Message-Id: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8xUmoC/33NTWrDMBAF4KsEraui0a+dVe8RupA8o1ot2MZyT
 Urw3SunuyK0fMz73jxYpjVRZtfLg620p5zmqQT3cmHD6KcP4glLZlJIKxwInvK8LTymO2VOHp3
 uBFoXIitiWel5KOD2/pfzd/ikYTsnzsaY8javP893O5y9+vIOXHBnPCAAOoz92+jX7WtelteJN
 naO77LBZeFhMI6kNb0OssJVg6vCRYfBdiQdilDhusF14dJrH7Vy0UKNmwY3hYMBp7GTaCNUuG1
 wW7gHNUijetEr/MeP4/gFvgg5ifYBAAA=
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783771634; l=2690;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=cifrS8XB2M5Sb7Mga4Ht3Xqhy5uFkAiqFJeObjOwE/8=;
 b=UT4NjMaFQBDQ49o54nSwMvUrf98o2pyFhcyyYMwXrpMmIXyEgUSG9nNU1K2oxExKtYFj0/m4V
 dz+gDyMNSrJCxRrhH/YiOdHAu/fc5ppd9DwcAuwUBeT8FNrnybr8dnI
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8322-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24792741741

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

Fixed the remarks reported by sashiko-bot of V6 patchset.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v7:
- patch 3: add helper so->tx_gen to monitor new ISOTP_SENDING attempts
- patch 4: prevent missasignment of sk_err report with new so->tx_gen
- Link to v6: https://patch.msgid.link/20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net

Changes in v6:
- patch 2: check for rx state and tx state to be IDLE in isotp_bind() (sashiko-bot)
- patch 3: double check rx/tx states after all hrtimer_cancel() calls (sashiko-bot)
           move ISOTP_IDLE in err_event_drop for the same reason
- patch 4: use READ_ONCE() to prevent compiler load tearing as remarked by sashiko-bot
- Link to v5: https://patch.msgid.link/20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net

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
Oliver Hartkopp (5):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: fix race between RX/TX timers and frame reception
      can: isotp: fix lock-free state transition in tx timer handler
      can: isotp: fix state machine corruption on signal interruption

 net/can/isotp.c | 176 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 135 insertions(+), 41 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



