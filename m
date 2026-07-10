Return-Path: <linux-can+bounces-8290-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tm3TGJTtUGp78gIAu9opvQ
	(envelope-from <linux-can+bounces-8290-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 15:03:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7870673B062
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 15:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="l7KV9G/D";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8290-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8290-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A44F9300C597
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04574428842;
	Fri, 10 Jul 2026 12:56:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB940DFC1
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 12:56:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688171; cv=none; b=ZDWoMArsbHelPlavcA0ccFKUesRkFdsLKPMCmM/R3RXbVM1IByxmMyHaLj2VWR6WZiCeIZeKVG8p56GXx1ph62vXWpNfFjfPISovO6fGPR92Xdbkx7DqpnyK0oMgJxo+pGnrIyay3/2jU98i516sUhOe5nPcrJtgB8+VD9X9ljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688171; c=relaxed/simple;
	bh=NS3KrhXR+AT+krE9/hJaYqMZJwCyWS2T+FlG0a2iPJc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=unz8SPcb7/vEY0qm8Jy38j6aHYdo5eM5sniQZZ6Fh3jscrqbq+5deJtZzLlg5S0TdgyeKZo0DPXcftdH5d10yiQU+fHqdoSnDo9pE6xF9JGoXB7DPX9+4aInCBZNVzatGv3MPh0k6r/k0B7zAPAP9nTB7cERfFOd5tNWTUJde1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7KV9G/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 687BDC2BCB8;
	Fri, 10 Jul 2026 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783688171;
	bh=NS3KrhXR+AT+krE9/hJaYqMZJwCyWS2T+FlG0a2iPJc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l7KV9G/DikDaFoszWXm8hm4CHU12pihPZwBFSwt2lDm8obucT8TjW1f10ifW1TqJS
	 Fabjwk8CF8CVZ9JzA9RiUUF7rU/6KfzWcwUgGbfm+uT/LgaMkW6+jyP7L5kIfYRdA9
	 8ZpQ2WTL3pOqc3dByBB83cgvS/G316hQWauJoV/LETKUguvVeuYbUPzSyfMc264C+I
	 pIpJ8olnDS+NkjuKpS/bqAtilasfLj5Md5fXAcYnEtzj1dh0eLFEQRGbAtKS96Sw5d
	 SVI4ekBO+0ZoBpHzRIoxclAokTtWBvSkZ/DOmYlEuS4batsZNed99INDPIUuBIuE2+
	 c6vy2XecKP9uQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4571DC43458;
	Fri, 10 Jul 2026 12:56:11 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v3 0/2] net: can: isotp-fixes
Date: Fri, 10 Jul 2026 14:56:08 +0200
Message-Id: <20260710-isotp-fixes-v3-0-08db68e27d0b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjrUGoC/32NQQ7CIBBFr9LMWgxgW2xX3sO4gDK1aFIIINE0v
 btQd8a4fJn/3iwQ0BsM0FcLeEwmGDtnOOwqGCY5X5EYnRk45S0VjBITbHRkNE8MBKUW9ZHqVqg
 RsuE8bocsnC8fDg91wyGWRFlMJkTrX9u7xMrudzkxQoloJNOMaaHH7jRJH+/Wuf2MEUo88T86z
 7oaGoG8bbpa8S99Xdc3YcVhe/oAAAA=
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783688170; l=1321;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=NS3KrhXR+AT+krE9/hJaYqMZJwCyWS2T+FlG0a2iPJc=;
 b=1xtEEa1oOQ1lEXaobnia4Mu1Sx7rRrwF+NNuC24TMmPOgK0s8uJ6h+rMB+fsT6bLylHyNmbje
 sfFiaE0zz66Bw0N1GXuIonFCNhQHQlbRFD/QJitS9T+wz7Ux5gxybbg
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
	TAGGED_FROM(0.00)[bounces-8290-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7870673B062

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

It covers two fixes reported by Nico Yip and sashiko-bot.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
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



