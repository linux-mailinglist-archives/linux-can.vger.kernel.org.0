Return-Path: <linux-can+bounces-5512-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F1C75F66
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3835AB79
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9281A3179;
	Thu, 20 Nov 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hpnK3zCp";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="09c0599O"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64D36D4E5
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664334; cv=pass; b=OYnOyQxdWmQZHEaCvowMj2YsnKm17tlfG5ihizG/XO9BkpSyLlQQIreOSNlUbKUkUs40sPt1VXUoP5azqXgBFt+jHd8a22uwz1BI7C/EcbY0FPHX9PK+vcv+xd1yEsAqp8/P2xVWkJPRLl4Xpp/7OJwcSWHrmmutyEYBliTBRGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664334; c=relaxed/simple;
	bh=s+lADGieyXp5NWDUjGmEQumpNZetzYKO0b2m4eFKE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRjdSN4LhrLX+FTaEBpjETCyrv9yMwBByyqHyLtWiI3jjRLTisvkzErKlrZ2c9h9IDp4W7lE4XPsibBqz+hfLYh7Jtxq3fsp9IPGODH0R+MQmaude/8OpI9hfTiO5Og8rEJiG2JqHGR7LM2Dg4wowzNJ0gMd9NX58XbQI845zBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hpnK3zCp; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=09c0599O; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IMqb13IDHcvynPXP/Vj3PKj3R+GO+E/z4m6///4DFL8eA9+1+Jzq1WC0n85blfaGcg
    50hzTRW8xRVnzaLmwtjRZZRDaHtUJ07PpMoBfp8A/4QSXWRyn6mX2bAdB/1bMFrXwB95
    UdddDnRLmthlsn/5e5XgjxCbnf6AcgJ6uKolgJYDoRESv2byMxtIDMTATYZQXVRPqBq6
    GgadgPkIMsNMI5yLo9rRMC0VmoJI0yEqFhaeQkmmfBe0hKBF3dDwzF5J7eVf1bR6Vtgx
    xeMl91gzpahODLHgpmjnBQ0hvOihv/ryHe1FHhL2MzyBhGOSO51DSD7I1G+3QcGEmZBY
    8k7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664320;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=hbFSHR9r4OHjk3UESJkXdpBhe0vG5Y6Os89hz698GaiyWITaaR59m2cmGFEawXqaou
    Uf6Sp8MplPYlPUTWfTxLlympC2EAN/TXn6bJNqGTNBIDh8tWJd0raLEduEa8ISntvbHn
    YHuXF2QH5poPGdw6o/1tCcPlwu6X46gWQq8BJ2Y1bVeYznf6UgkLiVxGBhC8cR/3nDob
    cQMESBKr9xXBMmtQgXh6/hj1FdQcidwlD31gFvaeSOJ+Ic1H8B5s2mMiN9sBa/Bmxihv
    US95o0E2D+e11XJCda5iOYp+gZu54ujbfBvmdlK8k6qcb0KBJYt4D/AOuxbD5rnccik2
    d7/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664320;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=hpnK3zCpFmbBm6FHrnuUK69RJ3+TbLwAbGx+Hap3YSiw0F17vXT+pDB1QKXXa5jrHj
    DQtjKDXSKf5zFrZvUevideMWaXUptYzNf8fGoY8VvTUFBQrzihVL5WjRyUr900ycF223
    Xy+jhQ+B7fFJ+Aki6fJticOn5YUIyJXee0KLSd8PF5PZ9ypylvRLYNs0ZBIk1n80x+RV
    u3ZhZkHeAqJlln2VdUV0tyx5sLgZqFv2J8c7Uxlh7DUhgH6wjV+c3LkwdsGhmbjdImnW
    SjJ3ooqDxXFd95t2AN4d9hRQ5MSESt5FvQ7vC05O+6UTruU4zaRmV0NumAfCJh9x/rJm
    5JPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664320;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=09c0599OGOVq7bdqEtpfU6+0TWFi8Uy6YRgj/uAWqzAJZfFzb+NLBZvTCYkNTGxnWh
    CYBRpqKHS0eso1gtpvAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjK9DL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 01/17] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Thu, 20 Nov 2025 19:44:45 +0100
Message-ID: <20251120184501.27597-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184501.27597-1-socketcan@hartkopp.net>
References: <20251120184501.27597-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

When CONFIG_CAN_CALC_BITTIMING is disabled, the can_calc_bittiming()
functions can not be used and the user needs to provide all the
bittiming parameters.

Currently, can_calc_bittiming() prints an error message to the kernel
log. Instead use NL_SET_ERR_MSG() to make it return the error message
through the netlink interface so that the user can directly see it.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/bittiming.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index d30816dd93c7..3926c78b2222 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -139,11 +139,11 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		   const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
-	netdev_err(dev, "bit-timing calculation not available\n");
+	NL_SET_ERR_MSG(extack, "bit-timing calculation not available\n");
 	return -EINVAL;
 }
 
 static inline void
 can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
-- 
2.47.3


