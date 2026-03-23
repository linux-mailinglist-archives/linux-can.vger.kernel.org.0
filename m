Return-Path: <linux-can+bounces-7212-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOFJCiAXwWn5QQQAu9opvQ
	(envelope-from <linux-can+bounces-7212-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:34:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB92F027D
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A8B302F273
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DC35C1B7;
	Mon, 23 Mar 2026 10:32:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E33876AE
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261951; cv=none; b=rLlu7pV8Wi2vQRxEteao7oJSY3CRTJk1lnaDHFYakzpXYFXDDaUUYSdfm9elRMrWYHYGQD9RQ6u3sO8j8qmZqYiVseeCSxyA1SpDp5tpQFCyW32gtHH1Mmz+mIBPNEmdt5wXS/by5EuYM2/HnS3jQvwwImXGkOKnDliVP/I0N/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261951; c=relaxed/simple;
	bh=qwzvvUNhdDlokAMOJCKWzDGLMwAqk7EOigcLTqyEIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPa0hiig/d0KxsE+0lfT5rakvV0fyrf2O34I2yfGsuUW/jyxN/2Zm2A3aUAwZrknTLn5PIqh+ABRpxrUWfQwY8TWhxNQ3q1CcOdb3F99Og418so/EmVb1xW8/lVSyt9F34d48AcCev7xW7Uzo4FsBvv+s+JRnA37lTY5SHuxpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4caB-0008F8-Jz; Mon, 23 Mar 2026 11:32:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4caB-001i5d-0L;
	Mon, 23 Mar 2026 11:32:27 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C798050A7BC;
	Mon, 23 Mar 2026 10:32:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/5] pull-request: can 2026-03-23
Date: Mon, 23 Mar 2026 11:27:56 +0100
Message-ID: <20260323103224.218099-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7212-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: A6EB92F027D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello netdev-team,

this is a pull request of 5 patches for net/main.

The first patch is by me and adds missing error handling to the CAN
netlink device configuration code.

Wenyuan Li contributes a patch for the mcp251x drier to add missing
error handling for power enabling in th open and resume functions.

Oliver Hartkopp's patch adds missing atomic access in hot path for the
CAN procfs statistics.

A series by Ali Norouzi and Oliver Hartkopp fix a can-Out-of-Bounds
Heap R/W in the can-gw protocol and a UAF in the CAN isotp protocol.

regards,
Marc

---

The following changes since commit 8a63baadf08453f66eb582fdb6dd234f72024723:

  net: mvpp2: guard flow control update with global_tx_fc in buffer switching (2026-03-19 10:31:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.0-20260323

for you to fetch changes up to cce598ffc6afd01e7a780051f3ac624b60aa2ee4:

  Merge patch series "can: fix can-gw Out-of-Bounds Heap R/W and isotp UAF" (2026-03-19 17:16:03 +0100)

----------------------------------------------------------------
linux-can-fixes-for-7.0-20260323

----------------------------------------------------------------
Ali Norouzi (1):
      can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Marc Kleine-Budde (2):
      can: netlink: can_changelink(): add missing error handling to call can_ctrlmode_changelink()
      Merge patch series "can: fix can-gw Out-of-Bounds Heap R/W and isotp UAF"

Oliver Hartkopp (2):
      can: statistics: add missing atomic access in hot path
      can: isotp: fix tx.buf use-after-free in isotp_sendmsg()

Wenyuan Li (1):
      can: mcp251x: add error handling for power enable in open and resume

 drivers/net/can/dev/netlink.c |  4 +++-
 drivers/net/can/spi/mcp251x.c | 29 ++++++++++++++++++++++++-----
 net/can/af_can.c              |  4 ++--
 net/can/af_can.h              |  2 +-
 net/can/gw.c                  |  6 +++---
 net/can/isotp.c               | 24 ++++++++++++++++++------
 net/can/proc.c                |  3 ++-
 7 files changed, 53 insertions(+), 19 deletions(-)

