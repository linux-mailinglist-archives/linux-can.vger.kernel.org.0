Return-Path: <linux-can+bounces-5542-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A42DC77EDF
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id B4CFF293DE
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10BA28640F;
	Fri, 21 Nov 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CvmWkSpJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oLjEq6Cc"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850A2FD679
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714086; cv=pass; b=QByHAWjxU/dn4dcPkjg8GUjq+GC5s/P71Vp5fkJpDGLOtknDQ38ElZEmmaRle7Q9VLgsSUXNLdBlhwihvfZrmyePGZR9RSI7WxhEzsSPm92YMVnjqk79t6/M6kjQPC9stthbtM+rfJZn1NDE5I8mTfvQhxQnXN0V+aEeFIpytng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714086; c=relaxed/simple;
	bh=s+lADGieyXp5NWDUjGmEQumpNZetzYKO0b2m4eFKE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnLHE8VhH/QeKdYgHwjvxXYdmCktr2+1b+w4Ha6p7a0ryWpd9AhSKk1M21YYWiPaqO7IBVBlvn2Wr3GLQyZWt5NtnZg/77TTUNimVUzJzs47aWKKdxYx4YMQoqLJyVnRF277RJ0shKW5nbGLi9CzciGol1S7PMYW7HA1XUXF3RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CvmWkSpJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oLjEq6Cc; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763714067; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FYXakE0xdISRJ2UKwwMm6mIL9mfxkrRImR5uuBHu4oYdHPjDY/rrYfQKen/ovez2sW
    IwAjCPwlH3p7x+Ua4uj6X/n9czeV2P5miAJM1G10hcu7x0GviWhABfC9TgffpEdXlC3I
    zFRjgxSHvDC5wYqKdQ5e7POtsePRqFdl6MFoF4ItsXMoYJH3ZnjRiLXDmy4kEn6y0kLd
    LJT7+AzPri0ocWHcj5oH3rqxurcqYeLn7zKSBzvXIxlbD/n1i5+1GALYFvnaJ+oxykIy
    00rYw31unB9ExCHzJFBhiagGhMhnEUCUkLHEaiW7gNwRS5zQzzTz/kMmRGu8G67Y+XNY
    MSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714067;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=TSly7rDMTGIaRX/D2y0LfCMVfd480zSm6Dalr0JC7M57CuN9CEvn1Q2on0YlRX2bo4
    XGNJWLbESV43/RCulOW4DpCmJIfZVgPqA22zL0kYU7wfEJjy1iuwoVv1iT2sV+kjYuLj
    8MLRbSA0J/Fq+WvgiJkOxso/JlVxdQAnLSaZL87smsPnBP9dEWKkHLLSSq62vHWfeJ3N
    sxCdJu9VZIz/tICUn7jgz0lYKLWdFKswxnxrr53LIffWOD8E5rJgtwZy8BIypjL69k2e
    BkgbZ5RVNT0F3fqV2xOCm2Fbx3PFW3Ye1BKzJ8LTZqw6YAqBG2Rs4CiFqeLoBvrxBH+j
    MaYg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763714067;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=CvmWkSpJUEBoX9omxoZv7ObJN20SMW8pG4ol/QVo+pLYWYcFOPBOp/HiZpAuOOc17Y
    ENn3l7xMd2Ds8Ywylz0hvouSdPHNyKpKZw9+vk1fNFOLqdE0wsm3ndPGIVg9Xt3nVwHy
    3P1NfKhnyUAEqYrtq5JbYseOh1VEaMDlX+WWv4VuPlg1qVxd4uRSoHKjclZP7jRXY+4s
    ZI28MJwZy+NYx5Pt9ut2abLw2A1tRyCegH5+DmfRaGeY8ExjLiMsuBEhAOLFiEgtXFcU
    Ogl9YytnuShMMK864Pb8ihMjn7euzO0Lz/UH3yHu71kj7WLUhCLu/H7rabR00MDybc1g
    CzUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763714067;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=oLjEq6CcEGtElyBMgWrFVn9hKWij5cVpvqiw60SakQPfrYquq2TpJwHi5cQbyizX7J
    QamLfyelLsvNT38R6xCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL8YRAfn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 09:34:27 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v4 01/17] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Fri, 21 Nov 2025 09:33:58 +0100
Message-ID: <20251121083414.3642-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121083414.3642-1-socketcan@hartkopp.net>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
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


