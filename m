Return-Path: <linux-can+bounces-6448-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDG4H0xkf2lNpgIAu9opvQ
	(envelope-from <linux-can+bounces-6448-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:33:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE420C6261
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CDC3007CBC
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C4350A12;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huODRdQa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FBD1DF985;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956421; cv=none; b=tJCtATLd6cJ23FPBeBGk7/BUs1URrQv2ytzvYjFGfd3I69wnFlsjr9XzMcWh0b3UQQBCAInNQOiUyDEuCshwbEY1MYp0srOQ/V+s65v6x1vIFQQ68qqIHbpWv57xG1/Lr92/8Fai2u0ugeq7lAakmSHTn5m6ILzCVTW8hHZsog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956421; c=relaxed/simple;
	bh=0yW/m2RMnzKOSyHSfGPSc1BiRUjwlUxvIIqoWplTL+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OX6BCEWwOTQoNg1c2sxHUPtezaGQTjWxROBILdyw+XFCvbiQNwADERZ1TSj3Qgd6sLq45rhCSY8DNjX/Og+hsga7TP8HoNa48KzPI7zJoWLHSkEhXiQjk+392FIytVenM3eCwuBG65VZ6uZD8UqmBxzo6GjJq3xAzcTHI5O1EGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huODRdQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EDB7C4CEF7;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769956420;
	bh=0yW/m2RMnzKOSyHSfGPSc1BiRUjwlUxvIIqoWplTL+Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=huODRdQaKaLO3wjZdV5i6hSpjyG3XKlRZ7n2nVVNCl1TvgTrT8dxeBnZzREawOgsW
	 2bQuOulrc47dMaIL9NJ6gCJkOwYICfrEE6fUFErXf2lvnVmM9dyOcnkRRmPdXdc+Vj
	 RhaOjhD6ei9Uydy5lDmyAPRahvaFWrJCdWI1bsN6bO4jV6fcxwrweESH2HsMISTdgG
	 MJ1s+hsTW9XURqTiLNE8AYPgHVW3K9MuVKcMZs6u/AYWQLF6rNFe8aAmIPXmomL1nb
	 I0KEVlxdXh9ZLfz/WxMdn7OMfzTlNxH39wLGa9ivJ6nL9104l4Ymi2yINaFIz2tZN0
	 9tBaNAJWcvbLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE1E65284;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH net-next v8 0/6] move CAN skb headroom content to skb
 extensions
Date: Sun, 01 Feb 2026 15:33:15 +0100
Message-Id: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtkf2kC/23NTWrDMBAF4KsErasykmP9ZJV7lBIUa6YWAdlIx
 rgE372DV3bx8vHme/MWFUvCKm6Xtyg4p5qGzMF9XETXh/yDMkXOQoM2oLSTXciP+no+cJkkoA3
 eY1TeXQWLsSClZVv7EhknmflKfHPTpzoN5Xd7M6utP12clQTZNEAGKLbR4r0PZXoN4/jJe9vU3
 O65P/KWuVa61RQ75wFOuNnxBo7cMHfUYaDwtKTNCbd7ro7cMo8RyJG7BtfEf3xd1z/Azg/pcAE
 AAA==
X-Change-ID: 20260128-can_skb_ext-0e7a99ed1984
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769956418; l=4501;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=0yW/m2RMnzKOSyHSfGPSc1BiRUjwlUxvIIqoWplTL+Q=;
 b=lI1XAqOOLQAt6dwlAdR4GxB4ZFeze5hn3FhTfQJDEfC9HIc2Xm+rs5ICkS5k1O587YfO22s/b
 NmYOgVRla5fDA6Bt4L+jkmtp2aZWnhzswCfHANHO6J9EG1UijbUTE0r
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6448-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: DE420C6261
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

Changes in v3:
- Patch#2: new patch: rename dev_put() in CAN subsystem suggested by Checkpatch
- Patch#3: use netdev_put() instead of dev_put() suggested by Checkpatch
- Patch#3: initialize can_gw_hops in can_skb_ext_add() suggested by AI-bot
- Patch#6: add linebreak in sock_alloc_send_skb() to fit the 80 columns (Checkpatch)
- Link to v2: https://lore.kernel.org/linux-can/20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de/

Changes in v4:
Solve the netdev_put() / dev_put() suggestion from Checkpatch in a separate
patch set. Therefore these changes are based on V2 again. 
- Patch#2: initialize can_gw_hops in can_skb_ext_add() suggested by AI-bot
- Patch#5: add linebreak in sock_alloc_send_skb() to fit the 80 columns
- Link to v2: https://lore.kernel.org/linux-can/20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de/

Changes in v5:
- Patch#2: use skb_ext_add() for the cloned skb suggested by AI-bot
- Patch#2: use netdev_put() instead of dev_put() suggested by Checkpatch
- managed to get the receipient list with b4 prep --auto-to-cc
- Link to v4: https://lore.kernel.org/netdev/20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net/

Changes in v6:
- Patch#1: drop extern prototype in header file (Checkpatch)
- Patch#6: vxcan: correctly reset drop counter with skb extensions (AI-bot)
- Link to v5: https://patch.msgid.link/20260129-can_skb_ext-v5-0-21252fdc8900@hartkopp.net

Changes in v7:
- Patch#2: common handling for cloned skbs in gw.c j1939/transport.c vxcan.c
- Patch#6: vxcan: correctly reset drop counter based on updated Patch#2
- Link to v6: https://patch.msgid.link/20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net

Changes in v8:
- Patch#2: Fix double free in vxcan.c patch (AI-bot)
- Patch#2: Fix missing return value settings in error paths (AI-bot)
- Patch#2: Fix an indention issue in the original code (kernel test robot)
- Link to v7: https://patch.msgid.link/20260131-can_skb_ext-v7-0-dd0f8f84a83d@hartkopp.net

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
Oliver Hartkopp (6):
      can: use skb hash instead of private variable in headroom
      can: add CAN skb extension infrastructure
      can: move ifindex to CAN skb extensions
      can: move frame_len to CAN skb extensions
      can: remove private CAN skb headroom infrastructure
      can: gw: use can_gw_hops instead of sk_buff::csum_start

 MAINTAINERS               |   1 +
 drivers/net/can/dev/skb.c | 123 +++++++++++++++++++++++++++++-----------------
 drivers/net/can/vxcan.c   |  15 +++++-
 include/linux/can/core.h  |   1 +
 include/linux/can/skb.h   |  38 +++++---------
 include/linux/skbuff.h    |   3 ++
 include/net/can.h         |  28 +++++++++++
 net/can/Kconfig           |   1 +
 net/can/af_can.c          |  23 ++++++---
 net/can/bcm.c             |  26 +++++++---
 net/can/gw.c              |  42 +++++++++-------
 net/can/isotp.c           |  46 +++++++++++------
 net/can/j1939/socket.c    |  16 ++++--
 net/can/j1939/transport.c |  39 +++++++++++----
 net/can/raw.c             |  23 ++++++---
 net/core/skbuff.c         |   4 ++
 16 files changed, 287 insertions(+), 142 deletions(-)
---
base-commit: 239f09e258b906deced5c2a7c1ac8aed301b558b
change-id: 20260128-can_skb_ext-0e7a99ed1984

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



