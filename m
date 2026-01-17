Return-Path: <linux-can+bounces-6205-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E2D38EB0
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF62C3012BFC
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F613376A0;
	Sat, 17 Jan 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Aax9GRSN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mFNuVwxM"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB172836F;
	Sat, 17 Jan 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768656595; cv=pass; b=A8rO6dP1/EsVGPvXGmup9ssnHO+sLwBA/ITFkfNA6vmtE/5WE92kF2sgbqEPhfeMd1Nus/mbiwC9zqdHbuX04WocCJljEZiG77OHXyXbrT9j9SOnYKS3BnZWR6rXH7CHQdd/Gpe4BAsAh1BVDTWeNJOjLQolrtP3pDebSEVhRhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768656595; c=relaxed/simple;
	bh=9P+3xlXjxvz9449kzK+nMC1TMX66NiHa3aGhSrkHE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pec1maHpOsu8Tz9SQVUfYYdOxzg3jyUp89JccHl9L98ia6pIbSM8USp96eFzZSMW+C9Zjcy0mM/m4Rr9w7wtec9jr3qIKT3154y5Sq1PLjw1KweIa+VQZRUbxW6l3fQVbWlCl0pci8E3J/dktteNe7YWcfPVIh5/7ITAQsfsUcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Aax9GRSN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mFNuVwxM; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768656566; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TzPizOrCCDqKYUAmSR1KdDh0VF2PDycGyXUQnYEhOcWlznvzhGUktI01y1FT6nDkcn
    r5KH2zI7gaYuWib2FVCh2+LU2Ya9b9EblfpH4u4SvMOTezM6cyFkN6rBNRgbMecGDV1Q
    r0r3EdsFue2NGuVl+rsCGeZelrXaq684y8EDmZF8BYByuJG23GymF8Kasz5hRxn6GOmB
    dG6e0krnzxA0IRDl0wv4hT3ymZuPEDGoLH9QO2KgVJqAmENwx06+yIa+L6IA2dnQ2YMQ
    abWeGrMGJfpyr6Yc1eWDkSG0Tshl+F+sHi+i/i+WreBRp+d19iJno8P4LQZcTdZaEEzT
    hrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768656566;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0Hw2zSqE0IESJac2aNRNQF8Msez8V6lAtJ9uWVBEz+8=;
    b=COazKPwwvH3xDtX02y4OSjp9Jfh4mY4mxnqNGnmHnr/r4sjrZmtjlp8IjT3d5ycAoU
    odUONUzEZtsvHUEVzejsUOElxS1Yc6eebGqmG/QeMdW3nR7vqI3X/zapKC2g1cRJXbQq
    jEwH92QPLvQBJXPsYk0/Kv6RajJP4ubpDwk7ODkcqLNltAlKQBg4EmyZvTgv4C6GZNub
    tBMbqZo8ZiJcWq2vVgQoSqEk1rUxgxUr5fOR+zBXCH1MeuTABNHaT4aK8FmAdyTSJK72
    79J5AXPFlzcbChI7AzTZmhfTBLdUsWjqvFrISqFRCzmpG4QeToBtG0jIt+zfPyTetAiq
    E17g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768656566;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0Hw2zSqE0IESJac2aNRNQF8Msez8V6lAtJ9uWVBEz+8=;
    b=Aax9GRSNR8SFoA0dEwwN0apqRShfbf0yv69QI2XNtLb60Q0Buqb2MEE2rasuGCB7Jw
    MbksiaUHgRrn64WRUtbd4BR3vNnCS6L3qDdCvmQAq122QBWHlC5Z+/1OGh8gQfqfCc6X
    j8l+KrJBAZnLliNXi6q9wnMkeDhkRFGvD2mewqhz0XuC/cDClfHZ/q6Bek/zmEe9bMP3
    ah9H6kaHfGftWyBs5nrRqu6X7C6blDp41estu8EZqIbh40WJ2s9iNHYkWzzeteusitXL
    lXlqpYTNIvARWdlvD7AH3Yzqf0V1lXIgld+GsBulL579PbBs9fkZZKAK7+kgPuzJ+MiU
    Yq4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768656566;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0Hw2zSqE0IESJac2aNRNQF8Msez8V6lAtJ9uWVBEz+8=;
    b=mFNuVwxMJd+drpZVa54Yhl1R3I0kcv8wiqRnrt0I19LloMqrLtLlbfVIApxSKqk+sQ
    /hFaBbwYN/S26Qr4E+AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20HDTQGRy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 17 Jan 2026 14:29:26 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	davem@davemloft.net,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next v2 0/5] can: remove private skb headroom infrastructure
Date: Sat, 17 Jan 2026 14:28:19 +0100
Message-ID: <20260117132824.3649-1-socketcan@hartkopp.net>
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
ethernet/IP encapsulation. The skb->encapsulation flag remains false in
CAN skbs so that the ethernet/IP encapsulation (tunnel) data is tagged as
unused/invalid in the case the skb is accidentally routed to non-CAN
targets (netdev/netlayer).

The patch set reduces the potential interactions with ethernet/IP code and
builds skbs that won't harm the system even if the skb is evaluated or
modified by other networking components. In such an invalid case the CAN
skb is dropped in can_rcv, e.g. if skb->encapsulation was set.

[1] https://lore.kernel.org/linux-can/20260104074222.29e660ac@kernel.org/

V2: - net-next rebase due to net/can/raw.c fix in commit faba5860fcf9
      ("can: raw: instantly reject disabled CAN frames")
    - extend the cover letter to address concerns raised by Jakub Kicinski
      and Paolo Abeni regarding the safety of using the shared space for
      ethernet/IP encapsulation for CAN skbs
    - extend the commit messages in patches 1/2/5
    - Added Tested-by: and Acked-by: tags from Oleksij Rempel and me

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


