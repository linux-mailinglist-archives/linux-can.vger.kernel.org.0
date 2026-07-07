Return-Path: <linux-can+bounces-8027-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fi1GIxawTGqioAEAu9opvQ
	(envelope-from <linux-can+bounces-8027-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:51:50 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA95718B09
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 09:51:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="J/EzISlw";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8027-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8027-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2608431281AF
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CAE3DFC67;
	Tue,  7 Jul 2026 07:27:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85D3B42F3;
	Tue,  7 Jul 2026 07:27:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409250; cv=none; b=ARWiGEA3pPxY6KnTqgR3XAV2QO50L0QOk5xUXxw4S6NlIbC58YaCZiB7tBTa3ChjuWF1Zw0w4MJHrPdmCQ5XGxrb0yYBPbVRwLWCb7BtyT/IXQbxSph2ENPj0d8UREHTvufchxnXZQfzBmO+cKmhxVDGjtgmzO13FIUMicvGhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409250; c=relaxed/simple;
	bh=OapFFK86guigjYAJG/QuZbSnA9Lh6LWNJ1C6zs/wHGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FqzgeYo+c5oxVuIN9mku2hOo6Y15z3mA7mtnT66rm8vPzRseLQM5NI1BuKarj6fi2/hMMGxOa84N+9ZJjjTMjt7bI3YI8P62wHejZ1j+PBl454tMvOcPhLT1oU0LzyOg0sbTvZMOv/Kh0PenR2IkM+YgwpsekDf7BhjDD2a2/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/EzISlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB7EDC2BCC9;
	Tue,  7 Jul 2026 07:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783409249;
	bh=OapFFK86guigjYAJG/QuZbSnA9Lh6LWNJ1C6zs/wHGA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=J/EzISlwnRZj0UpT9wQqFush4/zUsQ7LEanJm/1xk9lsgXqUabrgmGzPPNGtDdsKC
	 Al7mAEIQjHj1kC53g+Sio/sDvdxsROq54wa9nSc1H5DrAwSfhk1S3tWJHiHLhrEeFZ
	 /45i/aCBSMLgoFnfK7TiLXkCSrQdvGPUQAWU7Gy1Hy6CR4mGNdIQfkxiIHWNUYGhHz
	 LSC2H1SzTNu+2gThChxSsDq+Iq5fbx/dRoq3448tJ+hKo06TK0OVksU4NR3dI5XcmX
	 ihh7PCXlOEOXmfL3NpGHFFpzpb02rBi+wlYfMXVxhpI9zFK0xZLBX3vOJ0tVTRe476
	 W3PDZi5WxvN0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA3C43458;
	Tue,  7 Jul 2026 07:27:28 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v2 0/6] can: bcm: collected fixes
Date: Tue, 07 Jul 2026 09:27:10 +0200
Message-Id: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6qTGoC/22NwQ7CIBAFf6XZsxiKTaue/A/TmAUXQSNtAImm4
 d+FevU4eZN5CwTylgIcmwU8JRvs5AqITQPKoLsRs9fCILjoed8KJtXzou2bAtt3WnaIhx0qAcW
 fPa1D0c/jj8NL3knFGqiGsSFO/rOepbZ6/7qpZZwpFBr5QDRwfTLo42Oa562jCGPO+QtpNvbMt
 wAAAA==
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783409247; l=1303;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=OapFFK86guigjYAJG/QuZbSnA9Lh6LWNJ1C6zs/wHGA=;
 b=1d0siPwaXaqUGsWus+c4ZDZ7xevHl1xgzbSYsIFXUMXFHHD+FleSE7MHJDTW3nHCsgL5eLUSN
 ixVf8zPiZB5BHAvEC62++THljbhllEV5z11RL6qwYs3LG7pX5Lw7HEi
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8027-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:lee@kernel.org,m:ginger.jzllee@gmail.com,m:syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com,m:sashiko-reviews@lists.linux.dev,m:gingerjzllee@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[hartkopp.net,pengutronix.de,kernel.org,gmail.com,syzkaller.appspotmail.com,lists.linux.dev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-can,75e5e4ae00c3b4bb544e];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EA95718B09

Hi Marc,

as there were different patches flying arround to fix CAN_BCM issues and
AI assisted stuff pop's up again and again, I've created this collection
to be applied.

I'm not sure whether sashiko-bot takes the sequence of this series into
account when checking the last patches. So let's see.

Best regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v2:
- incorporated all sashiko-bot concerns from v1
- Link to v1: https://patch.msgid.link/20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net

---
Lee Jones (1):
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Oliver Hartkopp (5):
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates

 net/can/bcm.c | 370 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 276 insertions(+), 94 deletions(-)
---
base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



