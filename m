Return-Path: <linux-can+bounces-8308-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id by9qKnJZUWq9CwMAu9opvQ
	(envelope-from <linux-can+bounces-8308-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576C73E72B
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=qyuH3B22;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8308-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8308-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E3B93018287
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479A3A6F1B;
	Fri, 10 Jul 2026 20:43:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87C3A63F3
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716179; cv=none; b=CLuCaqchC+Na8mni2+rOXG3xBnpISAhr2zdzym8RPz/buhj/ZujX/bMglceX+c5IcqJr+5QpSa06ZjqZsMqTnpbdUoubn9onaxOG9nkXXjzRDdZoK1IythG9G9kXfsZ+9iZnwV5BnDrM46kE+pbhI0SQCL+geBFM7/2f94J+Yng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716179; c=relaxed/simple;
	bh=F1wyvrvRF+nWvIfcUA4gqhfZFnraNE6gSWRt3hbKNWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fAA7SfZxu5e1VK5YIeI/xWqVAHqzIMELDUKoe8t4kG9ECP16ukuNCYP3u6LpTqE+fzpNNau9Iyi/raiQ/sQX+yYGxqtQBe9XSLig2DQsykZQoWd41jS9JEuq3cto51WqiGy49L+ZJ9NQFfow8rUxl5BxyUN8TdkNuK2i69+u3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyuH3B22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBE83C2BCB8;
	Fri, 10 Jul 2026 20:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783716179;
	bh=F1wyvrvRF+nWvIfcUA4gqhfZFnraNE6gSWRt3hbKNWY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qyuH3B22xOi4KNZLJX05dmzvF7d/v20yMRkFnYPABFnSj+wIpdZXx/satvWDMlZkA
	 ZXMEdLPt/J+24xeGicbSfn9Q5XRrNV1CugDwkID891ssJm/ap/hoNDFUajoMQG7Dfo
	 pc50VnXZ+9ZE0WEK/agmvOfzW277v/8kM0KqgnafsVDEz7h7r4Qh3Yrqdd5ruE80aw
	 iXmUJdd4xlKqLWwbUH3Z7XWLRMi5xM99+ZC2H/4gLYqL9m4HdlXTGADEEt2o0cP5J5
	 eFSiLUfmRmT5VPDtLJYtd7wCO92SQchYCHAGuhzLnyD9UzR5oxQG7ftm03lmXnKR3B
	 TuvdLqzQObObg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C856AC43458;
	Fri, 10 Jul 2026 20:42:58 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v6 0/5] net: can: isotp-fixes
Date: Fri, 10 Jul 2026 22:42:51 +0200
Message-Id: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtZUWoC/33NwU7EIBAG4FfZcBbDUGC6e/I9jAfoDBZN2gaw0
 Wz67tL1Zpoe/8z//XMXhXPiIm6Xu8i8ppLmqQX3dBHD6Kd3lolaFlpppxCUTGWui4zpm4tkT2h
 6RQ5DFE0smR+HBl7f/nL5Ch881H1ib4yp1Dn/PN6tsPeOl1eQSqL1QACEFK8vo8/1c16W54mr2
 MdXfcJ142GwyNrZqwn6gHcnvGtc9RRczxpJhQNuTrhpXHvjo+kwOjji9oTbxsECGuo1uQj/+LZ
 tvw1AiFC3AQAA
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783716177; l=2437;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=F1wyvrvRF+nWvIfcUA4gqhfZFnraNE6gSWRt3hbKNWY=;
 b=2Zn+7bYRPJ6BWkuC7AeLM1igxSVrWD3Y+4UOWcDT+cKChrcMFkwRFuT5noTTW8sjKzwdsi74o
 fmfBmHbVmZaCmzFaYmMHNyMSTe/5rmaiqKQ7aRncL1tyeaUqqqRWeZF
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8308-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0576C73E72B

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

Fixed the remarks reported by sashiko-bot of V5 patchset.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
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

 net/can/isotp.c | 137 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 102 insertions(+), 35 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



