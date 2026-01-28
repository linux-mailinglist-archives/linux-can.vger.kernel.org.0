Return-Path: <linux-can+bounces-6328-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cODPDP7WeWlI0AEAu9opvQ
	(envelope-from <linux-can+bounces-6328-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:29:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2D79ECA3
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6B39300691B
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF4345CA8;
	Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA8344DB6
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592570; cv=none; b=dI/LHDwlS6g3W3EToTUcbKp0m5OsHcdjMo393D/ptbp3qDeik7zedZwvNvnSz0QTylv8RWwzQq4PCBwm9P/MepLVGz8XV1/2Xsz8GUnMzCEro1Y99poSaHdtH2y0T2WoE82opriuMsz6DP6tZa2lamxaWHtnLhWwnj/Jtz8y6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592570; c=relaxed/simple;
	bh=GnZNfoUiZ6IRt2OPQJVfWleZS5n1ath7fscProSofP4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tfRS9mt0zkOUWvi0B/CFfp2yjbaYNHpwypKAxQWdUo4/BVse0N2vws7v9UpoVCVXnaZFCTNVkay8RQrkhpkh01z92ZoFcbSqTxXzCV2Kyoycod70hFT1ZE4GE9GAzS1GLFD3EAISAj0H7LWT8q2Nbr4Y6msOZsndo/kvTF/Blbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-0007xT-Mu; Wed, 28 Jan 2026 10:29:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-002tQB-0R;
	Wed, 28 Jan 2026 10:29:12 +0100
Received: from hardanger.blackshift.org (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C3224DA02B;
	Wed, 28 Jan 2026 09:29:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next v2 0/6] move CAN skb headroom content to skb
 extensions
Date: Wed, 28 Jan 2026 10:28:52 +0100
Message-Id: <20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANTWeWkC/02MQQ7CIBREr9L8tb8BtLZ25T2MC4ofwUYggKZJ0
 7sLunE1mcybt0KiaCnB2KwQ6W2T9a4UsWtAGenuhPZWOggmjoyLAZV0mOYJacnIe3nQfC8UnXo
 ojxBJ2+Vru0AFXaHg+lvSa3qQylVWWR39E7OJJP/9nWC8ZNsxPiDH5NVMuZjORsY8+xBaRxm27
 QNri4+IuAAAAA==
X-Change-ID: 20260128-can-skb-ext-17a4f132ce97
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GnZNfoUiZ6IRt2OPQJVfWleZS5n1ath7fscProSofP4=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpedbappWq+lqDfrSvfSvtE7JNLyffFZQyJ/30Y
 n6ze+9vK4eJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXnW2gAKCRAMdGXf+ZCR
 nKTaB/wL2KLFyhRqkBAZ+8ZobrquNx/oHwqTMY0NjgdUkCCj+9uMxohCPoa6eJVfeN8qNCbBweu
 NWv8wU/mArVN5P1WGP7AafbiIDgPhmFMdgIu2vBFTLEy2drwEg2Mf9WNS8nBHHXaH3JyuZ/4LPt
 oS+bFVPrYnpAasuhoFR3UCTwLXQubaX+lWzQbr6oAuUeif8NUgVxHTi74dpH7l44IeUVs8fDW6p
 ux2gq9bup3ynfr6TRHy0AAWlxUhpH/2llPx5D3BWe0hGukLq5IlD98cZu80d/9HyJBsUQWFAZz1
 AFfE9UVwhnVv2mPBqLnN2aEh7D8AwSeVKhuJdTv26CEB1ISZ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6328-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B2D79ECA3
X-Rspamd-Action: no action

CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data. Those
CAN skbs do not have network/mac/transport headers nor other such
references for encapsulated protocols like ethernet/IP protocols.

To store data for CAN specific use-cases all CAN bus related skbuffs are
created with a 16 byte private skb headroom (struct can_skb_priv). Using
the skb headroom and accessing skb->head for this private data led to
several problems in the past likely due to "The struct can_skb_priv
business is highly unconventional for the networking stack." [1]

This patch set aims to remove the unconventional skb headroom usage for CAN
bus related skbuffs and use the common skb extensions instead.

[1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/

---
Changes in v2:
- Patch#1: use u32 instead of __u32 for "struct uniqframe::hash"
- Patch#3: use u{8,16} instead of __u{8,16} for "struct can_skb_ext"
- Patch#6: add missing patch
- Link to v1: https://patch.msgid.link/20260125201601.5018-1-socketcan@hartkopp.net

---
Oliver Hartkopp (6):
      can: use skb hash instead of private variable in headroom
      can: add CAN skb extension infrastructure
      can: move ifindex to CAN skb extensions
      can: move frame_len to CAN skb extensions
      can: remove private CAN skb headroom infrastructure
      can: gw: use can_gw_hops instead of sk_buff::csum_start

 MAINTAINERS               |   1 +
 drivers/net/can/dev/skb.c | 121 +++++++++++++++++++++++++++++-----------------
 include/linux/can/core.h  |   1 +
 include/linux/can/skb.h   |  32 ++----------
 include/linux/skbuff.h    |   3 ++
 include/net/can.h         |  28 +++++++++++
 net/can/Kconfig           |   1 +
 net/can/af_can.c          |  23 ++++++---
 net/can/bcm.c             |  26 +++++++---
 net/can/gw.c              |  38 ++++++++-------
 net/can/isotp.c           |  45 +++++++++++------
 net/can/j1939/socket.c    |  15 ++++--
 net/can/j1939/transport.c |  28 +++++++----
 net/can/raw.c             |  21 +++++---
 net/core/skbuff.c         |   4 ++
 15 files changed, 247 insertions(+), 140 deletions(-)
---
base-commit: 239f09e258b906deced5c2a7c1ac8aed301b558b
change-id: 20260128-can-skb-ext-17a4f132ce97

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


