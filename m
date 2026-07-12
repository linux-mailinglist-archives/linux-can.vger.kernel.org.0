Return-Path: <linux-can+bounces-8348-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VHBVC0XWU2rUfQMAu9opvQ
	(envelope-from <linux-can+bounces-8348-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 20:00:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A897874593F
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 20:00:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=mT5GIKwG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8348-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8348-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 970E53010253
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B2366557;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B23655D7
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879183; cv=none; b=R3PB0xToti8OJ5wSF/wlSq/iF8DePcMBCzFIYciTtTQgtMvtJwN/J8EEWroX24vrohH8h491ug71mat8ZloNZu5Vb5lipO1npv3eDJUK7kEy5DIiJZ+b/nLGozGtgbMZwcZXSwAiuXyk//u+DgTqY6ggF/BHztEZa6cstGg57zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879183; c=relaxed/simple;
	bh=wQzK7diEY7mwturZH27anZx1aIWycKmqnYgS5wUYbzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LTRjvAhqreYf7cYpfmWEfj0+PWx2N75765NrmujT7H9dZGUxfKpyNvLRfAqWD703eKoKyjvcwISA7UIllcXKhqa0/uUbUKFAzN6IJOgHMkI41xxc6g4Hy5jQPgooohZciblmnU2W38pg7CsWabQswRwuOMw0UZ1f+ky9XEm8aSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT5GIKwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FD58C2BCB9;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783879183;
	bh=wQzK7diEY7mwturZH27anZx1aIWycKmqnYgS5wUYbzc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mT5GIKwGAW3T2Q5CeUxVI8AKkunVx86HecjE3/4eACqkUUHn2yt5moEcX67L8c6dX
	 MmAA1LjpiRV0DT0h3JApCHd91sRVaEKv1i1oTRUB7Gl4IzfDKXZv++sUDQoPWeANk+
	 WoivxCL6fdHqVR7MdGI/Bu3dg8CNc8KXqWmQm3UsqDd6QM2+sKoVCgaFWyKsFTZG5o
	 7MeOnyctw2vfx5Ys4URqvNfu109I8l3tqDslXxDUtRrs/yzmfGj1IwzfnA0BrROxIt
	 24g6oy7PXv56vjNwzeHt5SQenGWYgRC800WVvU9blvYlijCJ1C/HJKPJc1RWHYRRnS
	 iU815ZtfoWMKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4EC43458;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v10 0/3] net: can: isotp-fixes
Date: Sun, 12 Jul 2026 19:59:40 +0200
Message-Id: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAzWU2oC/33QS07DMBAG4KtUXhM0M36M3RX3QCyc2KYGqYniE
 IGq3h2nbFpkZTmP7x/ZF1HinGMRx8NFzHHNJY/nWiA8HcRw8uf32OVQG4KADDBCl8u4TF3K37F
 00QdWFoLhPokqpjneBhW8vv3V5av/iMOyRWwbp1yWcf653Vtx22snr9hBx9pjQAwckns5+Xn5H
 Kfp+RwXsYWvtMOp8n7QHMlop3pqcLnDZeVgQ29sJA7QN7ja4apy8sonJTkZbHG9w3XlqJFVsBR
 MwgY3O9xU7lEOpKUDJ0OD8z3HR86VJ5A+Ub0vHTe4vef0yG3lg3RE4FVUqvXzboe77e2SrYLAC
 ZL6x6/X6y9Nc7GktAIAAA==
X-Change-ID: 20260710-isotp-fixes-ead7480d67bf
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783879181; l=3360;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=wQzK7diEY7mwturZH27anZx1aIWycKmqnYgS5wUYbzc=;
 b=r6y3rVX0YZoimS4xtvYYG9WrZEdRm6ewm8OI7KDrn5OyOiVb5gU/8Qvf1fuW1ENmeSQPnjt6A
 5jRoP/1oMiVDZKZLwlvTNTZSJRAPy/RR7SblUQFZUrKjL+rD/yn7sih
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8348-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A897874593F

As sashiko-bot was not able to check the second patch this bundle is
re-posted with b4 preparation.

Fixed the remarks reported by sashiko-bot of V9 patchset.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v10:
- patch 3: add so->rx_lock support to sendmsg() and remove the former cmpxchg()
           concept to have so->tx.state's of relevant path's under lock
- formerly patch 4: removed as separate patch: integrated in patch 3
- Link to v9: https://patch.msgid.link/20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net

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
Oliver Hartkopp (3):
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: serialize TX state transitions under so->rx_lock

 net/can/isotp.c | 298 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 227 insertions(+), 71 deletions(-)
---
base-commit: dd3210c47e8d3ac6b4e9141fc68acc03b38c0ba3
change-id: 20260710-isotp-fixes-ead7480d67bf

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



