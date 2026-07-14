Return-Path: <linux-can+bounces-8399-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7urTNtQdVmqAzQAAu9opvQ
	(envelope-from <linux-can+bounces-8399-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:30:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B42753E60
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:30:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=SSxV+2A4;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8399-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8399-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF74A3009897
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA335CB6E;
	Tue, 14 Jul 2026 11:30:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D235C19F;
	Tue, 14 Jul 2026 11:30:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028625; cv=none; b=aoLZIwzGyE1mrogLEEH8z8VSEUvaUtUj4Is8RN8NyYnMWYLvkrNAaDhwFmYWSZV+9+6A5WxzSo/HQ7hN8KK4pVsnsv61+nebV7a5mks3/j/S/ppDg5TNz3wUckUci63IFoAu3p56B8vB+N+X3cLkggt6HSrRVDJBlfANhQ3fjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028625; c=relaxed/simple;
	bh=WeZw4ZV/vNJLk2Xk1BsZayWB7+u4PFHP/A4pQ0wljis=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kcAQSsg2vT4Uwz9TNt0fpoXwpJ70tbfQJRFjpDxmqnTf/5KcN57iWYbuFK1F/nr2pplsdr4D2uUoHzdGBpylL0hsPsrhhP7xklIAameO6tnBs4oF4YtK6YsEug5tTHEJiGjLJfaiFTHkQkO956mxeylrpNok31AgBI2TnLL2yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSxV+2A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3FA6C2BCB9;
	Tue, 14 Jul 2026 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784028625;
	bh=WeZw4ZV/vNJLk2Xk1BsZayWB7+u4PFHP/A4pQ0wljis=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SSxV+2A498whutE0nvwT3lBwXUhgXpIovG08TRfiuEB+VRk0Dqi4bt5i8z8sUz7rS
	 C0WEOh8G3+IqtrvyzqN/BBLi3bAci0myEli34EQMNotNqwj5aMpNl8l9nebaOENXdQ
	 PAMTzt4OpJhMkziHG4hhoMlPodQBtHNaNZKVdsA1XsYxyFF23cH/a9aOV8VdhkK3tl
	 xLg2a+s4JFPSryi7JicNHp4Bh2J4PoSbrWBSPbKvoUM0jg/ogPzU06YAZP87D/R/8d
	 l8PpBqn0hcSQxUXhmnwYoCPYQFFBDSzv66Wwi+FBRiTJfigt4QgoU30P3+ppuGqlOX
	 iwHlP6Jmzp9bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CABC44508;
	Tue, 14 Jul 2026 11:30:24 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v14 00/11] can: bcm: collected fixes
Date: Tue, 14 Jul 2026 13:30:21 +0200
Message-Id: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM0dVmoC/3XSzU7DMAwA4FdBPVNkJ6mTcOI9EEKJ67CC2Ka2T
 KBp704yDhSUHJ3484/kc7fIPMnS3d+cu1lO0zId9jlAc3vT8S7sX6SfxvzQKVAEhKqP/P6cpk9
 ZemdSNCF4HVh1Of84y/Ujpz8+/cTLR3wVXkuBkrGblvUwf127nbDk1eqesIeeg0oBrIiF9LAL8
 /p2OB7v9rJ2pfRJ/WILdotVxp5IAQ/aRDtUsG5inbEzBMCBRud8BZsmNhmH4Gx00Y9a18Yemng
 oO2u2JrnRpWQrmLbYbTGVscEiBBVZe1fBtolt6WzzshS1UWIq2DWxK51ZpSHpyApVBfst9lvsM
 yaRGK1jTrGGEZoaIfPBppS0E21YahzbvFwZkI0BMQoPXOOqzcudETKQ8hgTVvn20ND84eXS0kh
 kmRC8D//45XL5BioIaaKcAwAA
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Feng Xue <feng.xue@outlook.com>, Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784028623; l=5202;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=WeZw4ZV/vNJLk2Xk1BsZayWB7+u4PFHP/A4pQ0wljis=;
 b=nXHorN2mJe2YRkMazagM0nccqhQBJE8tpI39xwSBbMaf/4BdQBl6oR5lu90l9K6hQsyv5Fzb8
 nZvs1VvCnruAAqMwkEmrz8zGS21aunWo83GNyCB/JnNsWJDek+6V6/W
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8399-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:lee@kernel.org,m:feng.xue@outlook.com,m:ginger.jzllee@gmail.com,m:syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com,m:sashiko-reviews@lists.linux.dev,m:sashiko-bot@kernel.org,m:gingerjzllee@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[hartkopp.net,pengutronix.de,kernel.org,outlook.com,gmail.com,syzkaller.appspotmail.com,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75B42753E60

Hi Marc,

as there were different patches flying arround to fix CAN_BCM issues and
AI assisted stuff pop's up again and again, I've created this collection
to be applied.

Fixed issues reported by sashiko-bot for patch 6:
[High] Torn reads of ival1, ival2, and count lead to corrupted TX_EXPIRED API notifications.
  
Best regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v14:
- patch 6: add another lock in bcm_tx_timeout_handler() to snapshot data
- Link to v13: https://patch.msgid.link/20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net

Changes in v13:
- patch 9: cancel timers on re-registration failure and comment why.
- Link to v12: https://patch.msgid.link/20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net

Changes in v12:
- patch 11: fixed sashiko-bot issues
  https://lore.kernel.org/linux-can/20260709184351.723F71F000E9@smtp.kernel.org/
- Link to v11: https://patch.msgid.link/20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net

Changes in v11:
- patch 11: new: track a single source interface for ANYDEV timeout/throttle ops
  reported by sashiko-bot
  https://lore.kernel.org/linux-can/20260709105031.1A39C1F000E9@smtp.kernel.org/
- patch 2: added Fixes: tag (mkl)
- Link to v10: https://patch.msgid.link/20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net

Changes in v10:
- patch 4: fixed new issue reported by sashiko-bot
  https://lore.kernel.org/linux-can/20260709083119.015901F00A3D@smtp.kernel.org/
- Link to v9: https://patch.msgid.link/20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net

Changes in v9:
- patch 4: fixed two issues reported by sashiko-bot and mkl
  https://lore.kernel.org/linux-can/20260708173935.10D021F000E9@smtp.kernel.org/
  https://lore.kernel.org/linux-can/20260708-beige-tarsier-of-mastery-b73d0d-mkl@pengutronix.de/
- Link to v8: https://patch.msgid.link/20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net

Changes in v8:
- patch 9: fixed two issues reported by sashiko-bot:
  https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.kernel.org/
- Link to v7: https://patch.msgid.link/20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net

Changes in v7:
- patch 9: new: fix stale rx/tx ops after device removal reported by
  sashiko-bot: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.kernel.org/
- patch 10: formerly patch 9 as new patch 8 & 9 belong together 
- Link to v6: https://patch.msgid.link/20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net

Changes in v6:
- patch 1: added Tested-by: tags
- patch 3: changed commit message and comment regarding a wrong claim
  about synchronous delivery from dev_queue_xmit() as remarked by
  https://netdev-ai.bots.linux.dev/ai-review.html?id=6105ebab-87ef-43db-a085-7c190b9f119f
- patch 4: rebased patch 3 comment
- patch 9: new: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
  reported by sashiko-bot: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
- Link to v5: https://patch.msgid.link/20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net

Changes in v5:
- patch 6: changed comment for bcm_op::bcm_tx_lock (mkl)
- patch 8: new: add missing device refcount for CAN filter removal
- Link to v4: https://patch.msgid.link/20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net

Changes in v4:
- incorporated more sashiko-bot concerns from v3
- patch 3: omit hrtimer_forward with zero interval
- patch 4: put bcm_update_stats() under bcm_rx_update_lock
- Link to v3: https://patch.msgid.link/20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net

Changes in v3:
- incorporated more sashiko-bot concerns from v2
- patch 3: make snapshot of currframe
- patch 6: add error patch for memcpy_from_msg()
- patch 7: new RTR-reply validation in bcm_rx_setup() from bcm_tx_setup() 
- Link to v2: https://patch.msgid.link/20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net

Changes in v2:
- incorporated all sashiko-bot concerns from v1
- Link to v1: https://patch.msgid.link/20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net

---
Lee Jones (1):
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Oliver Hartkopp (10):
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      can: bcm: track a single source interface for ANYDEV timeout/throttle ops

 net/can/bcm.c | 606 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 464 insertions(+), 142 deletions(-)
---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



