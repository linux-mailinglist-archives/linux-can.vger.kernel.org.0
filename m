Return-Path: <linux-can+bounces-5602-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7745C7CBE5
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 10:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1AF14E43C8
	for <lists+linux-can@lfdr.de>; Sat, 22 Nov 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A0C2F3C13;
	Sat, 22 Nov 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ISIBwrcE";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Xe5nrCPp"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28622A4CC
	for <linux-can@vger.kernel.org>; Sat, 22 Nov 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763804187; cv=pass; b=eIUgRB4sJ+GaNIiAzugGHF1Q2zg1YI+R+XKo29avCORmoIuRCFrBXkgdzpvlir6zTeBs7mmfz5xGgnrmcEO/zNjbh9uIjlS+a1kIk2uzicA5ZXXUGec4FIOZoZnj3uswipbF5YjvGk2Ev3UnZnxyc1Ub/gJWnFGhu4mSHzg6HP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763804187; c=relaxed/simple;
	bh=s+lADGieyXp5NWDUjGmEQumpNZetzYKO0b2m4eFKE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar5GPvzO5oMByhqIMpFFzA3svmwZRvb1FrtDQdQR5ZrWk+JYFyPQXcBOLr52w4F+HWNWdHexOPLHOcVu7uAgYPup8VgEpzpI6PO8aFXk+z9W2Do3pldY1uYoZHoZ2Wu7jUROtUj1Vbg94+9/Jha+BgfktJgPyw/R3ai05C5SMH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ISIBwrcE; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Xe5nrCPp; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763804169; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EzdGGEKrwWfzxw9SEKolisNWad1ifyZfNM1vaVg06imDqJF+rGx8201+QMP3/5LdWv
    FdPlHvkl8cUStj1xua4tmRYu7LovHjDC/gFdsjFf/vzBvuMFL2/wOSsKLG5A3D7ulxyX
    wjJNtL5vDe1YdS229VvNZHA9s75j6UMYeCwkm91iEVpKh28nwLtKzNbmTqvF9rUkYqJe
    LCQLBi5yi0QigA226Uhc6/BY3U35S7zx96ua6VkgaxRsYqJ6sQMWIG80tEOblFDnbb6o
    BlBqBgKpfV6tVn/nRevEUYeRfRH+lJ1hWkrFrisNEjvXxUNyGT8Quph6SbpoHM+F0TWF
    Jwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=Wlvy2QLw8g6xoL2BXWkYfZWrtZX9npT4UCVGd/HTz+1UklZyOSgJHs+a29D+4OsRh6
    HyYkediam20MySUQlXNnytPBcsOgfG5vMvypbgjL4ffe5mDcifMeoQ2aJbmUwsiBLwe+
    h0T+COu7oat7mu4BIs8E7DuvcVkgHN0ULikbJPIGLWw9hsqpE75fMxfxOkreyCW8JJtM
    ekczVOl45HMzqYVu/sef9of4GZeHYsvwBL4HRxqGOrRbD4VQCVBOBuWvlaUgA0IGw/Al
    al9NOkZvyItMhvy2gG6+VWz+aB4E2FGco7f0YKmU5nxEjpBTPUhshbNQl3U0JMKLcN/C
    T3aw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=ISIBwrcEN30QDBWt5GrOuxWM1j8foj7fQUe53o5g8Exux8+QFsyfcpVZ5Kifq6TgzX
    2CUNz25VkGalMrGTtPglqI+yvQyoUHLFxsnFZdGnyRVQLIP206DsDrjOyEmd8MhV9YeF
    68QqKeTD60zdmx7KCZca8HfSXtriMr9JmdMMPNnpMUpDmYcIlL3LCczsjT05sRGkvRZX
    wd0T6bo+p3wDjOlnPcQ0Um9fP8K9eROuXlrGGA/bqDGd9KJ/KMHz1wyKWQvvWHxHZyK3
    AE9YHJP1QbvowKmwWqU/15JmeA4NCOArEFTqeYRiDGDDOUoWK5KN1ayj/ppUh6Hk03CF
    AKbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763804169;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=Xe5nrCPpEyZE/mdblVPfKvOsfp0NsLFUB09JCEet0FDkVQiLwXXrA96LmLKOKkCn1D
    MUefv7JcnxwDm20MatAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AM9a8Fdm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 22 Nov 2025 10:36:08 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v6 02/17] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Sat, 22 Nov 2025 10:35:46 +0100
Message-ID: <20251122093602.1660-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122093602.1660-1-socketcan@hartkopp.net>
References: <20251122093602.1660-1-socketcan@hartkopp.net>
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


