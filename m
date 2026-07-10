Return-Path: <linux-can+bounces-8294-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xA6CEFX8UGo79gIAu9opvQ
	(envelope-from <linux-can+bounces-8294-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 16:06:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A633573B976
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 16:06:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="p/xUx0SR";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8294-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8294-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5AA130378A1
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6F82253FC;
	Fri, 10 Jul 2026 13:55:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2923E342
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 13:55:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691725; cv=none; b=JjWlSp6UXiQPvAN5vVMxk1c4tCAmqigXNqdB6vyUrLDWXoDdO0f2qLjWdFQP0gLfMHuMHEnyp25+nhi0xRWqtwDlgX4lqB94HN7Gv6nQpHIY/5nUN0gVcIdAw3temIPyr/xRS86O6dZYlZZBYE9CNWvk7QYBB81EXfHjo1o8wM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691725; c=relaxed/simple;
	bh=HMCf/sMtSY435Y33n/bdt/7gpQXIRFRkQIZGswGYkVY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hPMgQFUlRZKFzcoVfO2W3vqx3B15jPJMfQiMp6KDf0erQf4132lxnYTGGiUqVit0YFlZ9jQN+KzPU+7UCIayDADR3uaBjvZirM7Ta8jSTr+GrJhbJ2BUFacVhWxCEL+0zHxajf3wbt7yJjd+/YftKX4JtcKGvNTX8iEgiGFZdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/xUx0SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC7BAC2BCB8;
	Fri, 10 Jul 2026 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783691724;
	bh=HMCf/sMtSY435Y33n/bdt/7gpQXIRFRkQIZGswGYkVY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=p/xUx0SRsaMAXjEGTxCwKYDl57xMcj4neUbAG1y14av4UUFWzG9b5iMyNP15XIABp
	 WYEC6R4H6WrSCTcrCMCKuu/1yo+he2jAHmyZvP7W+dJYHzTVpjthOCelqpWL64u0lx
	 qdW0HUHlxmUamkKRYHTjP08OuIDWNNusA/b/vGTdkFEb7yB5onahmpW+QZoKrS57d/
	 5UT8Fo32UxPhnyUFB8MXu8mKH+cyKOE5AgJJRPfKsUZwVRWGtXYd6Q2QXpyxsc9X/E
	 wkMekvUVmDsmLwNacM8W4tvz+3MeWjRAFISk2JZJInapynmfGio6A4qd+Sr2wa7BZ7
	 nZUJVDvKTysrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCEC43458;
	Fri, 10 Jul 2026 13:55:24 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v4 0/2] net: can: isotp-fixes
Date: Fri, 10 Jul 2026 15:55:22 +0200
Message-Id: <20260710-isotp-fixes-v4-0-2a4af437f61b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMr5UGoC/33NQQ7CIBAF0Ks0rMUAbaG68h7GBZSpRZNCAImm6
 d2FujNNlz/z358ZBfAGAjpXM/KQTDB2yqE5VKgf5XQHbHTOiBHGiaAEm2Cjw4N5Q8AgtWg6orl
 QA8rCeVgPGVxvvxxe6gF9LBOlMZoQrf+s7xItve3lRDHBopVUU6qFHk6XUfr4tM4dJ4iojCe2w
 1nmqm8FMN6eGsU2eL3D68xJpxXvgAlN1B9fluULB8Tl7TkBAAA=
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783691723; l=1563;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=HMCf/sMtSY435Y33n/bdt/7gpQXIRFRkQIZGswGYkVY=;
 b=TabnPDUgayw3YvOVbspvj7tA0T70owGGpUXmAMPOwo2KYcDdy584Hs0Xn++nZ32fuqvCa2wDk
 UnNUIX3y2ytBqW0F8Rx5DklR15pEhNlPZ+uHQHkbmK/CutAoYO7B1O9
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
	TAGGED_FROM(0.00)[bounces-8294-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A633573B976

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

It covers two fixes reported by Nico Yip and sashiko-bot.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
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
Oliver Hartkopp (2):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

 net/can/isotp.c | 96 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 29 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



