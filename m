Return-Path: <linux-can+bounces-6588-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQzAmsGl2kWtwIAu9opvQ
	(envelope-from <linux-can+bounces-6588-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:47:39 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CE15EAD4
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 13:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FCA30247CA
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D8339858;
	Thu, 19 Feb 2026 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUGOB9ND"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD2329C7B;
	Thu, 19 Feb 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505256; cv=none; b=M79P8lFZHGniSdf+mpy6GzcBUhABEBPnIozaWrwRJA8g1AKERaxJPFkidZTtaiWgXiIQZoJveabuSyfa/muoGY0xT1oocVBzIm8t2GQDR0bLm7Asf9gkjSjgqohvNsSw5JKNv6yrUB2bJqyvna1P3KbrvdE/ASnpRoltpCzy5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505256; c=relaxed/simple;
	bh=cpBnC8pH/PiD3SRicQ3PJ1gVjD/QbqD3gNTHM2XRWnM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N0BGMKebIH3T8DH5tb1ix4/QevKWesb8qSjOqumFjccKbrq6OvEjG9Lx5pw+P8kUKy1R4llWuOrYl3CpU8GKbBwIjiYtHiyxTypQnySwKTDbDP3DCzKoxPmOSsQ1tCXhCPpD+IcnG41rAw9wV68mvHG49WPbi7tKwG+ji1fDDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUGOB9ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E9DFC116C6;
	Thu, 19 Feb 2026 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771505255;
	bh=cpBnC8pH/PiD3SRicQ3PJ1gVjD/QbqD3gNTHM2XRWnM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GUGOB9ND6GrNbhx1nueQFBxE5wwIckOmpyV6eYVb9XoT3QwBKhtxPZ7ACc4ZGYYHQ
	 iDbSlVeTnuDWoYEEipWZB798q5kPy4y/vDDfg1r9hC6qBSw83PKG0/T/ZtZr5MgBb1
	 KMCvV00AbzA0n5E2lLhHXH1zueTyVP9Uv88jCjrkLfWbp5kfCLg/tjMLdLy5ilt2uD
	 PaXeG698vEmMYEOPmq/gE0upSxWLeNa2EqrpBbn/ZAIZywPuaWaKQ7UGttYW0PMN7V
	 XngANcg3xbLCAHww51u2WPJLeEEu2HLXZlwBHfnEEgSQ1gDN8BYcQKZUTS59ZMeMK5
	 eo+Adl6eg3TaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74106E9A049;
	Thu, 19 Feb 2026 12:47:35 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v2 0/2] can: bcm: add/fix locking for config updates at
 runtime
Date: Thu, 19 Feb 2026 13:47:30 +0100
Message-Id: <20260219-bcm_spin_lock_init-v2-0-694352bfca62@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGMGl2kC/32NwQ6CMBAFf4Xs2RpaKame/A9DGlpWWdG2aSvRE
 P5dwLvHSebNmyBhJExwKiaIOFIi7xYQuwJs37obMuoWBlGKuhRcMWOfOgVy+uHtoMlRZkJyhUZ
 1lSw5LMMQ8UrvLXppfpxe5o42r6XV6CllHz/b68hX7+/ByBln8ijqQ2VVK408923Mgw9h7zBDM
 8/zF3H0nk7JAAAA
X-Change-ID: 20260218-bcm_spin_lock_init-2518eb8d4501
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771505254; l=869;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=cpBnC8pH/PiD3SRicQ3PJ1gVjD/QbqD3gNTHM2XRWnM=;
 b=UfrzPc03KntdzKKCeEksDrBUy1B0dRbzpJbA9/PqKuCtStIfLZ/rk8mEH4mC4kRBXQ75eQuNp
 qRMUx/fj9/IDy0cRqXyA4yemjjiVb2ELzZDSs31IvhDLt8PsfYXvq1Q
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6588-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,5b11eccc403dd1cea9f8,75e5e4ae00c3b4bb544e];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto,msgid.link:url]
X-Rspamd-Queue-Id: 603CE15EAD4
X-Rspamd-Action: no action

Address two locking issues detected by KASAN and KCSAN.

The first patch fixes an unintialized spin_lock in the KASAN fix.
The second patch addresses the update of content in bcm_rx_setup().

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v2:
- Add a second patch addressing the KCSAN report
- Link to v1: https://patch.msgid.link/20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net

---
Oliver Hartkopp (2):
      can: bcm: fix locking for bcm_op runtime updates
      can: bcm: add locking when updating filter and timer values

 net/can/bcm.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)
---
base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
change-id: 20260218-bcm_spin_lock_init-2518eb8d4501

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



