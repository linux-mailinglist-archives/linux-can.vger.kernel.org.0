Return-Path: <linux-can+bounces-6299-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J1JEIB6dmlLRAEAu9opvQ
	(envelope-from <linux-can+bounces-6299-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:18:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FA82578
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 21:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77353001F92
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3463009CB;
	Sun, 25 Jan 2026 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dAEGDbiE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6C2MVFmp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CAC2749ED;
	Sun, 25 Jan 2026 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372277; cv=pass; b=Bbmy6mXWnagoVkepwghPMA87UjlAmUJde8SNz2usC4XHpT/xGCA/7DmhcRD0CifLFqRkfjZKDyDMzXXxKSX0UyuQuhw+r0UctOhaAUwKw002XuL7wi7dQ0Uvir64k4Kdk1F82r385DVwnYJb8R7FAKIi640+2bQJsbMF98lShCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372277; c=relaxed/simple;
	bh=I8MixfrxLNziBKBmQDlPf9/AUezQATlV80rHFfy8Y3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VimVSoprIa3Ed8pzCieyosyw1/V7ks3qlD+kcdAHjXQy68L4Aqpw71KpslfLuOL6nevq3bfs7NTsJj0NrX+sx/DeFZHGZvLz0QDaUWRuJLSg2VOdWV29+ViTHWZI6wQutnjY1dW7poNZBb8q3fyi/LIsb53x8kcBuU5smSFXYE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dAEGDbiE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6C2MVFmp; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769372267; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c/ZH8EIfDYD7Hu/0W9qKydBR79aAUlsTSWq2b855s3C5liflY992s+Y3YeKD2IAlkV
    x+gFDPVTf6ekQryV7W7E2kChYzF0IUrm3wLdWLQfMGasL3KLH4JrmWJdxbnDAnipixaH
    WASH95JwncQ6imylC2PndMsHF0j0DrLcodQrTnwXoaMdKycWXIT5gpXAC+6NXaikYB0E
    O/w9wf0IdNlxxRyncdBTuEN3Zi8Dgy7DscHSiuV58RvvDGFg5giMbtcvLcjhDMQCd1W9
    ZOygQgOKzB19BVbMYOP2rIu70Qx+Lm1XqpndmzCWriIfPHI/VR2FYTjAfjyxtK9ZMlMW
    47KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769372267;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nHKqd5cJMudFFZuvLJl24nOnCqoSBuTF0s6DvV4s9jE=;
    b=CS6rEu4Rvz4I9tgJQ8z+Jo6nn7fIZFGc6aVjyKpNFewwT9s82OQO6o2dv7WGXwIsCo
    bcKjKG00z+mq6VAYYUdiNa2HD0sBCTw7ESuLaOKFgAp/FRskBf6f7e5MFUHgCmK3MGxq
    hw7d0n0TEZDLp1bEtSyCzNbQouGJW7u5+fWlJ+ERFCFecPt4U+NIFDCz8ir1OI9NDaZJ
    N4cSEq7NHmex5Ecaqe/mMj1n9HAfU9HVwCREwqumbqAckTYoyTReyQHa6lBAhVOPw1Ul
    Xk68/afOAbzmKmh+JXx/yaabHi4UPexWOqiPgjApAfb1MLonitUkoJ0OTLziNiFKPOJV
    y/rQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769372267;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nHKqd5cJMudFFZuvLJl24nOnCqoSBuTF0s6DvV4s9jE=;
    b=dAEGDbiEel9SffKpptY8DvoCwG1gK+oaAcsJqPoCVKej/n//eZeYq9udWrZHlZZTts
    ZafMBONYNAvvTYdpUzL4iF40W3n3RXmCAa9R5LMRalXlXUUsy1rybIBVdXsMcrQ5li2S
    QbtNvZ6BLrYufxlw6CgT0++/fouqVL3xm8sumlIUv1d2vkxcQfa39Ev3ok/QuLMobb+s
    +x2z2e98tF1iZLan63H+U8PimebHzQ4kQq8/h2rDZq0pjr08LC1HDnirnlMRXb58RPvc
    aO3afS+wqUsRU1UhfrN/nXmfQcVS8MJ8GHt8OUfGQ++3yCPn4wyo2KRteCcsWKVfgagr
    7P4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769372267;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=nHKqd5cJMudFFZuvLJl24nOnCqoSBuTF0s6DvV4s9jE=;
    b=6C2MVFmpCKICjrz9Ivh5AwqtU4Wou2EPGt+EwN9YSOvW/Y3IJgC1W3PQBpgvs15/PB
    tlgkAtvdL2hhB/l8FfAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20PKHlYsR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Jan 2026 21:17:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [net-next 0/6] move CAN skb headroom content to skb extensions
Date: Sun, 25 Jan 2026 21:15:55 +0100
Message-ID: <20260125201601.5018-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-6299-lists,linux-can=lfdr.de];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[hartkopp.net:+]
X-Rspamd-Queue-Id: 2A3FA82578
X-Rspamd-Action: no action

CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data.
Those CAN skbs do not have network/mac/transport headers nor other such
references for encapsulated protocols like ethernet/IP protocols.

To store data for CAN specific use-cases all CAN bus related skbuffs are
created with a 16 byte private skb headroom (struct can_skb_priv).
Using the skb headroom and accessing skb->head for this private data
led to several problems in the past likely due to "The struct can_skb_priv
business is highly unconventional for the networking stack." [1]

This patch set aims to remove the unconventional skb headroom usage for
CAN bus related skbuffs and use the common skb extensions instead.

[1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/

Oliver Hartkopp (6):
  can: use skb hash instead of private variable in headroom
  can: add CAN skb extension infrastructure
  can: move ifindex to CAN skb extensions
  can: move frame_len to CAN skb extensions
  can: remove private CAN skb headroom infrastructure
  can: gw: use can_gw_hops instead of sk_buff::csum_start

 MAINTAINERS               |   1 +
 drivers/net/can/dev/skb.c | 123 ++++++++++++++++++++++++--------------
 include/linux/can/core.h  |   1 +
 include/linux/can/skb.h   |  32 ++--------
 include/linux/skbuff.h    |   3 +
 include/net/can.h         |  28 +++++++++
 net/can/Kconfig           |   1 +
 net/can/af_can.c          |  23 +++++--
 net/can/bcm.c             |  26 +++++---
 net/can/gw.c              |  38 ++++++------
 net/can/isotp.c           |  45 +++++++++-----
 net/can/j1939/socket.c    |  15 +++--
 net/can/j1939/transport.c |  28 ++++++---
 net/can/raw.c             |  21 ++++---
 net/core/skbuff.c         |   4 ++
 15 files changed, 248 insertions(+), 141 deletions(-)
 create mode 100644 include/net/can.h

-- 
2.47.3


