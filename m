Return-Path: <linux-can+bounces-5436-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF57C608C5
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39AB74E8691
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD32FFDF3;
	Sat, 15 Nov 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="D9cQERQc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eXqoquWr"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0122FF659
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224689; cv=pass; b=GE7ap8drAPz6zNTBVxNUEf8g4f+TG1m6ullNumsatc3SKVK/D5jvJ6x7GWnmngR4gBhNGj9NB+kRgTMpRSxhjA4T3bFG3NJK8NAtWfq3vbhFy26gHq+YQHtD9NdC8bgfAso1oz71GxeWE/Gc/dRVR2kKed86wtYI0C9wK9rgcDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224689; c=relaxed/simple;
	bh=gbMkdgBxoqLOT4Dw3HDIbFvkqqkDfM8ZDKfFCfPHsHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlxO20gLZxgaEgMlwjs+JxpI2zqFjDORzqvzfhpx3KD4HQWV5P2ebtp//dh16oCsOkwm1eZNWlHytliodEsnUOgfW3yJfyKwpBjLdMxdkfM+HZpoGSsM6+3kENv6wdUTSJ3sUdezq6Nt3JJX+YJHRccxU9HgZYkXaDOijFOEhX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=D9cQERQc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eXqoquWr; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224673; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TdoUpGCFNtEaVfS9jxPyXcyG/cMmkJgy35eH2HfkdDpHzvCbB1DfOltAg2Wl7+CcpO
    ObZyTHSCafw0ZUsAg+qyoE6PIjq1+vOBez5QuP7YcpslJqje6lGYkF4tvESK+5/D18zx
    KpwuYbKPMC7pAMdF2odAqla2P/hb/7yjIQ2Gpod0XRtAEirx9FUzO+7DYpLS4pkl4d4F
    mjb2/XWV0VEVeNWpoNhNt7gVFCZn1WOUGHtlZYQTJ6BCBMbB9qcqgAughIySXsVjyIkb
    mIXn+xwWVaX+lD5JDSGAwDquEuvNr5qNfc/TXRSm/0Q1pxIuU9C4BsjPxy+aqMJhtVEL
    +yBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZjI1zd+QZ7pIR+0xChcwTNi5sfn7SG6gRTU/9ExXOr0=;
    b=CutUsJleE7aaJhtnlYcFfj3OP7Oih67cjoM29VNR5lROyWDZIIcnrV6PEzkTNHA2dX
    RXLHKVKXl9NBXCFzgFOm0+JEVM+UlKArHV2YWYIOi7hgn/hOsXk8Wh9J6SOvazZDRJF6
    IM1yW5DtNCWor7bxIFaAz+Uh82J4E7rIohharhNe2xLfF1AwVpXyAMwHw8AGlvG2kZFI
    iwAyMeLcM5m3ZfbFnRN4TURGD+bW7jeccMAIOABKk8VHssyvs9gUsgKH07pNZMhUtQRY
    G7As4m5POyq+XQ68oAoJQhaeGR75neGp+qdfs/hzGSiSZ1cxtfPquKpHph+7HGbHx5iF
    aBEg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZjI1zd+QZ7pIR+0xChcwTNi5sfn7SG6gRTU/9ExXOr0=;
    b=D9cQERQcPFNiQmgdItnifr0nOG/VBp6+ip6E3hyhzJomnRYoj5VLfESDjn62N8gCyS
    2v+MvwgTidk1A3ZICC38oNy+KgRA43VjsVKZIF1EmGBSc7x/st6vW4lgVirE4T1UEMB0
    uWT98GcF7zbchhsvZqaOFVi/JoVMfPEfTj1lW9udMXM4b6BpZRTgLLzqOeJM5o1qi7Om
    x44BJ/6NDlH1IC6Q/hhcEJVzYjhT4WP2+e0Uxd23OjrEpZSXTe2xJDWeYPiJjMbNwBRF
    FH9Ik1rKWzWtI7heWfu7I+myBJREBNyeXBeIfmcJ0ZBXRzR8Ges4e5pq1RF8Fjd5CcPx
    /jRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ZjI1zd+QZ7pIR+0xChcwTNi5sfn7SG6gRTU/9ExXOr0=;
    b=eXqoquWr9gIQJdkrgo4zHxujAA9gBP4VO3BhEyBcKD9edShqiGOCkP5CSoe4/yXCRT
    6itgWyT23zstl1IEI0Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbqeQk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 01/15] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Sat, 15 Nov 2025 17:37:26 +0100
Message-ID: <20251115163740.7875-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
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


