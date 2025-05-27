Return-Path: <linux-can+bounces-3696-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82911AC5B0C
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4613AA52D
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58B1FFC45;
	Tue, 27 May 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qxcGY6Qv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XHl+q7Yy"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1C1E32B7
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375808; cv=pass; b=jBOnNrSu0yE5ZCzmgKcyATqzoMfYpT97UZujSsesOdch5ep69HPoyy/uIfc1JQ5l5YvNvs9NBajwHnnoYBe+lA+CZeAYo0/J5xnnd63okcohwKm4P40pcjmH9OgQQzSGdbe32ZWXe3nHZm50Y3f0Kss+76r7mwAYdkajnu5EAag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375808; c=relaxed/simple;
	bh=0yptF4MJlU+1ZO4uoS9klTVPEt0Gcqc+TlSwpHwtsks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4vexviQUjlhl4OxVXhc0qjpXmWtP/VEvo29g2CfOwwZkqB7h4wN1aR/jGxF4LfS4F7ADNNosBm5b9SuBGtSe92e0g9+EFcvFqpZo5CwUxLebk0vpdr2wKxHK51kcY3BqWcRn9Wm0L4t+NxFuSNskytf+Q+NnmTa7OD6VFSLHFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qxcGY6Qv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XHl+q7Yy; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OL/99m9sXIjfz93nkZ7jX7kNmjjqX2yorT3TTA+lcA/DV/tkf3OZpRvE8dxHaGeb+U
    ruFQL6nWBtSnjsYnpbXEF5nMBvhVqezQ9bUzaHdguJUwsqW+h+r8hVapLc8F0Jm9TO1i
    vaIXus0WNtwLJPUKMgckM/q1eFszMXWMs2gWiwlCH4zEXudjZdpjsLQnh5bhPCxdiFqR
    PjT9APQDUo4GTvoJ4NMtgs4ksAWwbkDZP2Qq25MuEidvFIEBrlrO6s7Mgxz2MtvrWeMp
    9Nfbp+giMv8igeoLE/dbMMUOVqatY/TODpHwfxWduTCz9ZXdh/dHU3kfekI1uPbBCXvF
    dMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qGw8MT2UEJI+cC/rLu+Gf9swuMa+gBrcT8KnXHw/Pts=;
    b=JlQrXKLVerjtgpufFURkb6S25CmhAYiKtgs1zJCDz69JcNN7vbsQsCScVZPoKAvdaV
    ZddC1fun9SOCnEHv88wk2VlKRMBiVopS2sEHKsqu5iHuJqPD/RuBuqJVPXl+2unHKrWv
    KPCzE7G9yprjaRC27Nb8ISrE6hNuaN0JboaLw3BFvT5iEUHq41ygbq5eNHNtHkR7BaGG
    luXn4EaV2UIe80qlDg6nHBA+eZPLFKpAgy08gcLwEGk85Dcbl4anOzn31AfndULSH8sK
    1oeQ69MtWS9zseRi84Hx7Cs/+iviECiFb/jKJqH59hBIdkgc8r2UgzL/SR67re5WpIrs
    fxGA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qGw8MT2UEJI+cC/rLu+Gf9swuMa+gBrcT8KnXHw/Pts=;
    b=qxcGY6QvMxidJwNjCl47Fv6KbXINIdCC45wWkMUEkMD/kRvEdu5OuPBwGaG3oT0ldQ
    GzlXCH1EzpoB/mQjbO2mnw9ZyPINaChDTRcrRAWIA0AjMTqLvZPOlTHhkFKRN+w14Ecc
    dfyoXW/tuWMLpBkT8xvOOnlSu8+Uuo5XtAyxR0CH8s1b/09UJFzozS6C3nfqhwNN8GRI
    CPY87SGfYNsZVuNbMbe9HL5RRaRfQnL6BkoOfJyN4W3exCJyvtk0q2FUX2O/6js5nBRa
    AVWyOi8bbeP0wtIQH1VIN6C5dhMCAux9RDLurLfD1AILd1PUW94DTKhcDkbinpNIqHB4
    uO8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=qGw8MT2UEJI+cC/rLu+Gf9swuMa+gBrcT8KnXHw/Pts=;
    b=XHl+q7Yystb3V8fdZJuKKViNBlbfnyxV6ESqtFp4ypUXSeX+bKGrouQQHk5EncW9DT
    9AMcCv+YneEMw6rb8QBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJugiWA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:42 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 08/11] can: canxl: support CAN XL transceiver switching in data phase
Date: Tue, 27 May 2025 21:56:22 +0200
Message-ID: <20250527195625.65252-8-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

In the CAN XL data phase the CAN XL controller can advise the CAN XL
transceiver to switch the physical layer.
To enable this feature the CAN_CTRLMODE_XL_TRX has to be set in the
driver control mode.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 55b8374ab094..652576234f63 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -105,10 +105,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
+#define CAN_CTRLMODE_XL_TRX		0x8000  /* XL switch trx in data phase */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.47.2


