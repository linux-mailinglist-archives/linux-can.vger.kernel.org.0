Return-Path: <linux-can+bounces-8343-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6hIfGsiaU2rScAMAu9opvQ
	(envelope-from <linux-can+bounces-8343-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:46:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA3744DBB
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:46:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=onCqd9GC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8343-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8343-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B393036EC0
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D083A5435;
	Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471E39656D
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863847; cv=none; b=q837V6nrs57Ut169wdNnZ71rI4YAjGP2+uY1P5o7pz6ESgMpx8RhpTJ46+fZHFxo7OxJVu4VrYCnIbOmbIH5UgV5Sq0A0csNMplk7FaJIIv1wn0wrIO9rjWOcWtiP/lKHJFXlObSwvlznMQwfrcwM13uGNtTMaV/O7pqUdsNdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863847; c=relaxed/simple;
	bh=FSrfVZrwwzE15HNSz1SU20TdCyh17KljLIlTF9UHTbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K+Hw091NaRx0kk+iROGCpJ3eqYA7S3ZPFxjO13CpBGvnW2JoCuXl412rkWpecrrKN1aDloWUTwIKsa9FfHVdLmgGw/fUiSOCBfIB9xfNMXZb8GVyQW9eRxlZlHBg9PR1zYZnK9MFevj/CExfk8GEBHa10tHmkvSPwXF6rAToxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onCqd9GC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E62E6C2BCB9;
	Sun, 12 Jul 2026 13:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783863847;
	bh=FSrfVZrwwzE15HNSz1SU20TdCyh17KljLIlTF9UHTbE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=onCqd9GC63vGbLBKRRhs0BVn/s7j+rHGi9iwP6av3jsujf7PkWr68tDZne4qUXeXB
	 xYtiSroRMYn0EGHcuZ3h8Amb40bWIqQlGWqPWMKzv71VRZKA5+3Eve4kjqt+m1Z9MK
	 rkc2glmrdjrts441JyngmScb3ybe9u33yVcyBd1g8fyH1TEIeab1yuV5Vv/RZ36Z9B
	 fl47Xq3OQoASWPjayppyXDCO1mYZfwhLzPwBT7Bki7p6U0Oya8a9OfBJnMYOHgum45
	 3wQas9QzuJMEqXl2vBfIAbtVu4ZMZmMLHMvZMS0jdxQ1gAZmzXfyOa2lvf4n0kPs62
	 hjPi3hLVhCJkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED5C43458;
	Sun, 12 Jul 2026 13:44:06 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v9 0/4] net: can: isotp-fixes
Date: Sun, 12 Jul 2026 15:44:04 +0200
Message-Id: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSaU2oC/33QTWrEMAwF4KsMXtfFlv/iWfUepQs7lhu3MAlxG
 lqG3L3KdDNTTJYP6XsCXVnFuWBl59OVzbiWWsYLBf90Yv0QLu/IS6LMQIAVTgpe6rhMPJdvrBx
 DcroTybqYGYlpxtuAwOvbX65f8QP7Za/YN4ZSl3H+uZ1b5b7Xbl4lF9yZIJOUyaXsX4YwL5/jN
 D1fcGF7+QoHHIjH3jgEa7yO0ODqgCviokvRdgguidjg+oBr4hB0yFq5bGWLmwNuiEsjnU4dJJt
 lg9sDbokHqXowyguvUoO7ey4fuSOehQoZ6L7yrsG7ew6PvCPeKw8ggkat/39+27ZfSGedWnQCA
 AA=
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783863845; l=3097;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=FSrfVZrwwzE15HNSz1SU20TdCyh17KljLIlTF9UHTbE=;
 b=NO8cVjPYDJjJe5Qz+w19UqMbK9acC3YKyA0cbydraN5d/zpfKIBJS1mTfMTX8QU7Z2N8ommAN
 eAa46JuYYMfAPrhF07Q5GZ7TopsPNgUpIIw0vLGT49L+Y+e5gmxb0y4
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
	TAGGED_FROM(0.00)[bounces-8343-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email];
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
X-Rspamd-Queue-Id: AFFA3744DBB

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

Fixed the remarks reported by sashiko-bot of V8 patchset.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v9:
- patch 3: fix two reported issues and explain why issue 3&4 (-ECOMM sk_err
  handling) will not be changed
- Link to v8: https://patch.msgid.link/20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net

Changes in v8:
- patch 3: properly terminate the former transmission before starting
- patch 4: formerly patch 5 as the former patch 4 is squashed into patch 3
- Link to v7: https://patch.msgid.link/20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net

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
Oliver Hartkopp (4):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: fix race between RX/TX timers and frame reception
      can: isotp: fix state machine corruption on signal interruption

 net/can/isotp.c | 286 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 220 insertions(+), 66 deletions(-)
---
base-commit: dd3210c47e8d3ac6b4e9141fc68acc03b38c0ba3
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



