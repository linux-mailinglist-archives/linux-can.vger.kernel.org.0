Return-Path: <linux-can+bounces-6105-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03911D137F2
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA7C030011BD
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E42DECAA;
	Mon, 12 Jan 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kKUL/wEr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BZfQvae5"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1826CE17;
	Mon, 12 Jan 2026 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230620; cv=pass; b=MtiKJa9+9Ef08cn3+FpByc9f8WlovTkt/R5NAlS17ym0u5q1HvLqaPmxjG8gksVT88qP9qwqnkAvqin6rVgDmMHjXX8ou/uSF8fFoRzC15mrzGZPbfsrMqVBpIA1JEczBSc0nBANhK8D5yM6UcTJuWiAMBoI5PyCxop5L6J8cnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230620; c=relaxed/simple;
	bh=phJ1egiL07CDhkhbRtjLsCyTN2zLbNvqVXQpgeu42P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0GKzOho78BAiAFlh3oyefthdFL+VIdo5yP6Npq1EDNkJyD3Dy0WpU0NB/8hIt149svxcQzZ20fcZcLQhhChFNun3rCyDNAPQ6ZDsADV9klj4UXd/tdERInux3TGjX6ueZSodgSSqcFLK+rueGfjgnxowr2k4HzOlAMxnxXygSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kKUL/wEr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BZfQvae5; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768230592; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DGc1jlzJZINvtmQdH5MrrdCe9NcZ7vk3XTqYsIAFjPvUfINe+TYCX0Xt1Q6JhgLqqO
    PBl8Zw0QCl0OWxyArDuj0I4E/GjcPgCIUzvsutVMphfdiPQ+HWzK8cLiWfhPgGv/omXF
    55FuLv9QBLsW/3SNt4nXc4AVoIsAT5ck/0TaWZHIXG5rvhpNO0IN4eLWDoud4WkxSa8m
    XNrR0Xw1X2jWkKGc8KhCOB981iL4Ni32Yha2ukPdlccg+y9XKFT3FbdKu4Oh7ObLFruu
    M95JAYbS6yrtKk1FAUsBLIdAlI0LtGhVDa5uz7fkJ7WNjiIDKSrgxNwY6NYx5UA9x3Ds
    +6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230592;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PwF+PWV0gzKI30axH7UO1+I6xzy51hhjb1M3qGklEa0=;
    b=tY5985GJyd8nVtD678coeqKJyf4Oi/D9yY8VajuKVSODIgX6K0puB0pQppa7mjV7do
    +YlFstCJmHsDBEqCdDFNDLKfUq4EIKEyflVDu6IBHgLnoeratcd/8kKEWUouY9sM8bmS
    e1/nIdFvTdQVfaFSpMi0q0CNig60Vi5N9HPpdLhelBddWY0/vgi38Z3iBmyKKtMgfIHx
    KgQfWlq2JzGRF8ijnh2HoDcSThvo3LPHVNiAi2D0IM9iU+mPWKn8P757dCSYZBOJPJBr
    eKruOgXci51nRMQ1yEjbARIEfEtD4o5PR7jhp3hYZwR/P7ENOYoLqU1ElbKcYt3e9+2y
    TWoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230592;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PwF+PWV0gzKI30axH7UO1+I6xzy51hhjb1M3qGklEa0=;
    b=kKUL/wEr0FTMlQkh0tZtPdNJ4j9TeZSOzOV6jQh9WmeZ8NE0rxBOK9wK88g9qWizVZ
    XjqNseK58pqffKmz/vxYa36HIcBMXDjsmMbaZ6C5gh1inwFfXR3L4NcAuAJf71iiHHKc
    YqzmK7j3gTEiJo4NX/n+ME7nXtgMm6bLk3mJNxxK0Z64MuZjdpPhbLJsLKQ45wfLtAmv
    EDqDoFIaBu5CXMaLX/hP8ZEEQgUq3j7SoiRpSK+A7fEJP8X0CxrGNdsPQ1Ewm3GiAF0P
    Xm2I8iFhAiuHdD6+HmEuQzZo5efblyfao9/+7tjH5KenUE4Q4ECDBk3CnPHBpMBVczD4
    z/ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768230592;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=PwF+PWV0gzKI30axH7UO1+I6xzy51hhjb1M3qGklEa0=;
    b=BZfQvae58Lqw1Pjr9DF5z1f7ZUaWgY7jQakndNwkAzUOk7b5uu/rqs0Qp2jktxIQ62
    uLYnwYgLMIIw3Uz+66Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20CF9pgmA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Jan 2026 16:09:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 0/5] can: remove private skb headroom infrastructure
Date: Mon, 12 Jan 2026 16:09:03 +0100
Message-ID: <20260112150908.5815-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
CAN bus related skbuffs. To store the data for CAN specific use-cases
unused space in CAN skbs is used, namely the inner protocol space for
ethernet/IP encapsulation.

[1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/

Oliver Hartkopp (5):
  can: use skb hash instead of private variable in headroom
  can: move can_iif from private headroom to struct sk_buff
  can: move frame length from private headroom to struct sk_buff
  can: remove private skb headroom infrastructure
  can: gw: use new can_gw_hops variable instead of re-using csum_start

 drivers/net/can/dev/skb.c | 45 ++++++++++++++++-----------------------
 include/linux/can/core.h  |  1 +
 include/linux/can/skb.h   | 33 ----------------------------
 include/linux/skbuff.h    | 27 +++++++++++++++++------
 net/can/af_can.c          | 35 +++++++++++++++++++-----------
 net/can/bcm.c             | 13 ++++-------
 net/can/gw.c              | 25 ++++++----------------
 net/can/isotp.c           | 18 ++++++----------
 net/can/j1939/socket.c    |  7 ++----
 net/can/j1939/transport.c | 13 ++++-------
 net/can/raw.c             | 14 ++++++------
 11 files changed, 92 insertions(+), 139 deletions(-)

-- 
2.47.3


