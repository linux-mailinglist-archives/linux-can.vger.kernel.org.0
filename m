Return-Path: <linux-can+bounces-8113-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDCfF1UXTmroCwIAu9opvQ
	(envelope-from <linux-can+bounces-8113-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:24:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE5723AA7
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=IwjFoOQG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8113-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8113-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 323D93015C1B
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC571409138;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8877407CC7;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502569; cv=none; b=WhwoiwP6A3B7BuYZ3EQwc6PammsF0BBS1YyRmj06ttDvPhHB2pImJitP9kNx1oQVx4LhB1t7xms4VLa8hp1o774M8pCCty/r7pLJhoyf+D+lYK5XOs9FyMvT/w41Qt0Ad6h2OMJObQ4fSFkAN7Cq77yW/Jem3y9VXEp5G7En9vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502569; c=relaxed/simple;
	bh=TmXFOBkgQXuh/lphxNg9YKyBFII+72JGehB0s3XF5Xw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TviicMWL1EsipM6GLrpK3+TPeEiSEd7MfQKEExp15fLJ72LSJt85DzkRSGIeTxW5XBBIrIhwDvQCB+U2fHjfFWuiysV0huBJXclnf8ZDWNYKTD/wlFMAqmZCHxgFQxlxo95Rwn6hJd6xjkpfbUhXcG1eIYhA7hGSAYHNiMnuieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwjFoOQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C1EFC2BCC7;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783502569;
	bh=TmXFOBkgQXuh/lphxNg9YKyBFII+72JGehB0s3XF5Xw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IwjFoOQGik7XXo2f+MbecY+awfwn22WszLCD0AB2njZ61jbAyau3zVBExhBZZQ03c
	 ZgbwjIt1gyKfyfJaCvb4msMoJmdUJRATAfVLal+6O0Zb2fw2hRp8AAK73hpzeo1h2w
	 tVpcXUpjfzA4GSFtXGvFg5UL0n4DL6BDwp3uzkEL67doDI8FeDvDtmsFHsk/0SegO9
	 H6lEFFtQ9HPNvlM1nxiGh0jinn6PPDzqVt0gUmcMpA3FSi1TUdzxs9MNGTi/mg1AVe
	 lR9ITLA79Zajja1KFdAgXSKd9Nrwp9JthFrczP6rvyCZR+ak6+/YFiMxHpbiu2pS+S
	 4cBOWRO3IT/nQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C47DC43458;
	Wed,  8 Jul 2026 09:22:49 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v6 0/9] can: bcm: collected fixes - final
Date: Wed, 08 Jul 2026 11:22:26 +0200
Message-Id: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANIWTmoC/3XPwU7EIBQF0F+ZsBbzChSoK//DTMyDPiyaaRuoz
 ZhJ/10YFxrTLm+45wI3lilFyuzpdGOJ1pjjNJagH07MDzi+EY99yUyA0KAbwZ2/vIZ4pcytCk4
 hdhK9YKU/J7oflPrL+SfnT/dOfqkDtTHEvEzp637Z2tTe3u7acOAeRUAwRAbC84Bp+Zjm+XGkh
 dXpVfxiA+YvFgV3WgvwrVTOtDtYHmJZsFUawKPure12sDrEqmBEa5x1XS/l3rPbQ9zWP0tvVLC
 9DcH8w9u2fQNiuTKqqwEAAA==
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Feng Xue <feng.xue@outlook.com>, Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783502567; l=3105;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=TmXFOBkgQXuh/lphxNg9YKyBFII+72JGehB0s3XF5Xw=;
 b=23CWX4DHykvgw75qMc60s1sFJPDihriJOeNuVUJfXAW/QWVq2HOd4tOhuUaiKRkNDD0HIWcSY
 xpJv04CR1g8CN3RYWDWNUG46f2kH58uS7varN/Pfj1EoH4KmYlJWG5X
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8113-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:lee@kernel.org,m:feng.xue@outlook.com,m:ginger.jzllee@gmail.com,m:syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com,m:sashiko-reviews@lists.linux.dev,m:sashiko-bot@kernel.org,m:gingerjzllee@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[hartkopp.net,pengutronix.de,kernel.org,outlook.com,gmail.com,syzkaller.appspotmail.com,lists.linux.dev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9BE5723AA7

Hi Marc,

as there were different patches flying arround to fix CAN_BCM issues and
AI assisted stuff pop's up again and again, I've created this collection
to be applied.

The patch series fixes ALL issues reported by ALL kind of AI bots involved
and the fixes were assisted by claude code and later rephrased and shortened
by myself.

So the potential new AI reports on this patch set report problems that are
solved later in the series. This can not be resolved.

Best regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
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

Oliver Hartkopp (8):
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

 net/can/bcm.c | 484 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 355 insertions(+), 129 deletions(-)
---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



