Return-Path: <linux-can+bounces-6596-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NwiJqk/l2lXwAIAu9opvQ
	(envelope-from <linux-can+bounces-6596-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:51:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D0160CE1
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8183012211
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C634CFC6;
	Thu, 19 Feb 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGll/OL2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1E34CFAD;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519909; cv=none; b=NJzscfjWoGvOKEZiJQVjCBTXuMIfUfLGdW/JMcA+SHyVRMz/fT6RbgstcfUIoMLybch8DUX+Fs5ci7FDORmxeoqinMJeV5Wdcs89xCRwrhjPaO+Fbhz6zXZLPmMmg/LZInNdnEgEBJaQ0RAEx6ecOYYaTlXhw4ilCKOdgPjzVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519909; c=relaxed/simple;
	bh=FX/CbMPTMHFx6PJAqRVJn6ooY06+Q38yaEEBkyuTcGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qxe8LlVUdBqtITw6c2yPKG6uswwhfpaKPffBY95wracN6FVFRQnZepYzgpHSzJ1xRLw6q2D1/okelWZdBVOdjjN2DW1aPjsMpdl1qR9+mwAkPMqWdRJVXsnfpp2N/f31k4ydMgqssL/oo/jciK5Bz4uo7vbZDF2pNVDN3Dxka/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGll/OL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2FA4C4CEF7;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771519908;
	bh=FX/CbMPTMHFx6PJAqRVJn6ooY06+Q38yaEEBkyuTcGg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=fGll/OL2hvOONf39c/mRSZnJo0aS4lbhR+NXdrCOtYB2izO6G+EMCn7aa5LLN4M26
	 mqs5BPyjOEQi5PJtk2MakYQBpJi2OaAbq607egoaQ1cusfClTLjUwi0psrmUy1dkS8
	 QQhO4E05l5omKenNCiSSRii1ib285C9Bi95ItaS+YsMVB9M2JMQDAl6oot9QpyiPbj
	 i3TT6EKfANYq1ShSGZuJEW78/4oyDKZhhdQiKBf8lhUbe0QsZK4YKRJctFlIT2TcCD
	 9cRO8PWfIR/rd+5lPx1TaiL+MU1YQnmWwh/at0AseKnzFZ3gc+pOt/KqQQZVbwT/eM
	 x/ty8dUN+JLKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91182E9A048;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v3 0/3] can: bcm: add/fix locking for config updates at
 runtime
Date: Thu, 19 Feb 2026 17:51:16 +0100
Message-Id: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIU/l2kC/32N0Q6CIBhGX6VxHQ1+hWFXvUdrThDzz0IHxGrOd
 0/tprXW5dm+75yRBOvRBrLfjMTbhAF7N0O23RDTVu5sKdYzE2AgGXBFtbmVYUBXXnvTlegwUhB
 cWa3qXDBO5uPgbYOPVXo8vTnc9cWauJiWRYsh9v65VhNfdn8DiVNORQEyy42qhBaHtvKx64dh5
 2wkSyPBp6X4aQHKqCzyTIBuTCXhyzJN0wsXgEGcDwEAAA==
X-Change-ID: 20260218-bcm_spin_lock_init-2518eb8d4501
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771519907; l=1272;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=FX/CbMPTMHFx6PJAqRVJn6ooY06+Q38yaEEBkyuTcGg=;
 b=tZTXSv3ygDdMjIucb6FBaPaLJg77BzmIBjTfOEGen762JZ7wa9bBf9fo0/+NL7AE3bUUWQ1l3
 7hKCupNJD7fCjJ0cdKLAkWTVXX6oxCbiRv9dHg93hlu23GnGry+lVIx
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6596-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto]
X-Rspamd-Queue-Id: 3B5D0160CE1
X-Rspamd-Action: no action

Address three locking issues detected by KASAN and KCSAN.

The first patch fixes an unintialized spin_lock in the KASAN fix.
The second patch addresses the update of content in bcm_rx_setup().
The third patch adds a missing atomic conversion in can_rcv_filter().

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v3:
- Add a third patch that fixes a KCSAN issue that showed up while testing
  patch 2 8-)
- Link to v2: https://patch.msgid.link/20260219-bcm_spin_lock_init-v2-0-694352bfca62@hartkopp.net

Changes in v2:
- Add a second patch addressing the KCSAN report
- Link to v1: https://patch.msgid.link/20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net

---
Oliver Hartkopp (3):
      can: bcm: fix locking for bcm_op runtime updates
      can: bcm: add locking when updating filter and timer values
      can: statistics: add missing atomic access in hot path

 net/can/af_can.c |  4 ++--
 net/can/af_can.h |  2 +-
 net/can/bcm.c    | 40 +++++++++++++++++++++++++++++++++-------
 3 files changed, 36 insertions(+), 10 deletions(-)
---
base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122
change-id: 20260218-bcm_spin_lock_init-2518eb8d4501

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



