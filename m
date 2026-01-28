Return-Path: <linux-can+bounces-6371-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJX7AZR7emka7AEAu9opvQ
	(envelope-from <linux-can+bounces-6371-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:11:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87971A8FB2
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 489E3302DB6C
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 21:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DD37755D;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYx4Sleh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82ED376BF6;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634699; cv=none; b=Lgk6mYUv9WBCkNagLzpJw40IfaUPTDIFUqGbRx7jU2q23/qGn/9ZApcyu2c2T37iNqosWrWDVLxYIfS73g82MVVEOdz8VD5BI2U8x0ILC6C+jpdjhIx+x+A1gznPVRSjJv/a8lfdFGNQlqmdijJkOYEEnR6fguY7rba6Ng7JBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634699; c=relaxed/simple;
	bh=+P7YkhWUYfROFGEk9Uci7jb1bDo4Nx8GaV5SD6PP8tA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mH7AnsjCKstgD+J4eyYBBZc9xfAKFBCvrXCoFFmO1LIhnzdWZvG4OV303+GbzbrWpiWMU2ONIcqVrTizPJEVTjyxZuHY72+A93nT6ht3B5EByTQINZZKcxU3NdyPACbaJaXSC/E5konPbklvhA2KOzrDe/1e7SDP/Fwq0w/83a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYx4Sleh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53370C116C6;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634699;
	bh=+P7YkhWUYfROFGEk9Uci7jb1bDo4Nx8GaV5SD6PP8tA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VYx4Sleh3s8JEuve3phuoI1rFWCG0WUkr1llTrWgYBJeU0KHqfd46zSwI+cgm7N49
	 OAgiIOL6y4gm2KwBzdkN/jUl0q4LSs/3d2AzraAGnzeErFioNSyC2OLY95tG9kwglK
	 B+QGOa6L0Y1W0bNBl302ouOTTG2x9EHFaV50I59k8jVQk5mprbzONDHQRX73ptXaNe
	 w1b0GWGiLtgg+1Bc+fYDaW0IYRCxSDGACnG85+nUtJApRIILuNOTj+EUX8E8UXS9NT
	 vtZvvdGf6e+rBCg5OKWmEto3BicXDWuCqrJLEwUT8AfJXbRuZtyuARAmz6qXHD/XK5
	 jjrWH9YSHZkww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F854D46BF2;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH net-next v3 0/7] move CAN skb headroom content to skb
 extensions
Date: Wed, 28 Jan 2026 22:10:50 +0100
Message-Id: <20260128-can_skb_ext-v1-0-71b8bcbfd8cf@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFp7emkC/x2M0QpAMBRAf2XdZ6sZFj7Ei6SZi5u6tEkr+XfL4
 6lzzgMBPWGAVjzg8aZAByfIMwFus7yipDkxaKWNynUtneUx7NOI8ZKmcnNpiqaxroZUnB4Xiv+
 tB8ZLcrJEV8Dwvh/V86+magAAAA==
X-Change-ID: 20260128-can_skb_ext-65cd46399ac8
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769634697; l=3019;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=+P7YkhWUYfROFGEk9Uci7jb1bDo4Nx8GaV5SD6PP8tA=;
 b=jXfNqyLFnxEi14d4Qz8uRT3xnHdFWu3LpCq8QL4gkW+8k+3uFm/g1HixWXY2w3VZww2BAp4V9
 2XKc4FLLfaVCish3ofz9UYNpxuAQUUo1FidfUDvWF8c/l9i47d1X9o6
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6371-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 87971A8FB2
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

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---
Oliver Hartkopp (7):
      can: use skb hash instead of private variable in headroom
      can: use netdev_put() instead of deprecated dev_put()
      can: add CAN skb extension infrastructure
      can: move ifindex to CAN skb extensions
      can: move frame_len to CAN skb extensions
      can: remove private CAN skb headroom infrastructure
      can: gw: use can_gw_hops instead of sk_buff::csum_start

 MAINTAINERS               |   1 +
 drivers/net/can/dev/skb.c | 123 +++++++++++++++++++++++++++++-----------------
 include/linux/can/core.h  |   1 +
 include/linux/can/skb.h   |  38 +++++---------
 include/linux/skbuff.h    |   3 ++
 include/net/can.h         |  28 +++++++++++
 net/can/Kconfig           |   1 +
 net/can/af_can.c          |  23 ++++++---
 net/can/bcm.c             |  44 ++++++++++-------
 net/can/gw.c              |  38 +++++++-------
 net/can/isotp.c           |  63 +++++++++++++++---------
 net/can/j1939/main.c      |   6 +--
 net/can/j1939/socket.c    |  23 +++++----
 net/can/j1939/transport.c |  28 +++++++----
 net/can/raw.c             |  28 ++++++-----
 net/core/skbuff.c         |   4 ++
 16 files changed, 283 insertions(+), 169 deletions(-)
---
base-commit: 239f09e258b906deced5c2a7c1ac8aed301b558b
change-id: 20260128-can_skb_ext-65cd46399ac8

Best regards,
-- 
Oliver Hartkopp <socketcan@hartkopp.net>



