Return-Path: <linux-can+bounces-5760-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91478C90539
	for <lists+linux-can@lfdr.de>; Fri, 28 Nov 2025 00:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE03AA93C
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC22314D03;
	Thu, 27 Nov 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="inrillPD";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1XuMhubk"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585527E049;
	Thu, 27 Nov 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284970; cv=pass; b=R0OHb8PqL2+FaAFsgYNElE/NS7gkQVPTGVfO8/a0QzLI5c/QZ22+OIQc/eCIo5Ujm3zgLCR/ha1tQetbQTRxJWs/aXXbKgZyVAg5LYCqQT7qtzU/aMS3WhxBvdJ5F9qAyWwPin6j4Os6FiMIzmie3CBC5oU99Re6qAo875gqR6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284970; c=relaxed/simple;
	bh=5ap+5G7uWxSy9mV7IXSMwGKAlXd5kBWYyUcpjoyDIZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FcXOjoFRe+TheHKzBoDC4AsP/65zLvJTT5jjk9gHidONi7XmGpp+kVzGta7cIzwjXtdp6h5VG0iomj1nWPE/sWp8zijq7gJiC0gI6qDePEitKgTANs3AvF/mXEIqfd2a5ul3PfQuc9FnomcjIfXTlJLaQ3HETJ5Ph+fyho55djw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=inrillPD; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1XuMhubk; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764284944; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iFnQNJKF9q02J0SIXrH6OvbPyWnYV4yYUTdQahKZcjXE6ZPYxDBlTrQwr3KCv+nVlg
    b3k0g+JSEJ+n8W1XbVtt8da5BUOhAY1G5yG3/Gh9OW/PQykVPUe3xUpHbAn92iBd2H6f
    /BZIfXesQZtsmSN4GM4FU9uBFjpqXAVSPoAi/cohDP7JJs6VUf8OH9c56cQXMq/V9w5t
    yJoWqq4ds9ecJTpcqBKnbTtoPFb+FAwOqIG/46Z4tqKJosMjFON9G6hIPSxNMe61Hu21
    M2KdiyqzhvjLt3zBYYlFatcGL0sK7SiEoJuwh273JXm7oSziUmitabrJXnqd29fC79K9
    EuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764284944;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Cw62b+Pp/XnTEPIggKYA5CbNBXbEJPQUIO/ABk9Bzi0=;
    b=MlPIACBwB0Co+XvPbW3twUAVWKouuX9dlSl3usxMAmt2S37G1PDdeIeGoMyQRVWV+2
    KW8iRmtSdlkLgXaaBLCC6U/9wcNXcKTDMYX+X9vI1xwVwtHoLNj8fWTdc5N+BFABj7zo
    8lBxp5teqY3foNW1CevRDGeNYkth7ui9vWW+Fyl8N3GOiSs62j5bQ7WD25+jHA/m8D71
    fLWzKfE2yzahD6L8TuyAzAgFZprtFzUZO6gOouoN31c11Bju/pN1mqcMR9xEih/E7w0q
    mPuWYJOM58ZUEhrwCQJpJ6Ewrcem1i+7Vq30QvXM1whqtQmQLG5nEkzsYzG5Ncaeh6Ks
    hs5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764284944;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Cw62b+Pp/XnTEPIggKYA5CbNBXbEJPQUIO/ABk9Bzi0=;
    b=inrillPDgUu0sbAtxgKZPch5aF0w5jHyqPpo5oBPmYKcq1vgo6IW/yBzcvDQNAWqNL
    Ket6nt/M/smN4PeRphFevN1wD7nSqeDou1j1/VxbXL0U5PcIAje2i9g+MOWkmxkOAjZ6
    2tg+c1yXmBIgH4bKLgVWQw7fb7owhCz56QAx1rn46KOA9oXiCE5f3DWxkqVHtRjJ+4Lr
    HugyE+xTAALIAvV/99bHNtC6ORGG+v5SjZGG98DbYRECxBLNKvv5Kf3xQhXCJMFz/swb
    xbWcUv8lQWDWq68tPCUCw5xnLKLilcQ+AdLbp2+pYQfVhlcPl6nh/o4XYmK/vHTJgkO4
    I+fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764284944;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Cw62b+Pp/XnTEPIggKYA5CbNBXbEJPQUIO/ABk9Bzi0=;
    b=1XuMhubkgI/ZeZN8ypDKiql++9Nl50KIXN3MuINFeHn7d0FdMfip1YvFKvylSsR5DI
    YDUFNm/aPijeVEtGkkBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ARN94dLz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 28 Nov 2025 00:09:04 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	kernel@pengutronix.de,
	mkl@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [net-next v3] can: raw: fix build without CONFIG_CAN_DEV
Date: Fri, 28 Nov 2025 00:08:57 +0100
Message-ID: <20251127230857.96436-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The feature to instantly reject unsupported CAN frames makes use of CAN
netdevice specific flags which are only accessible when the CAN device
driver infrastructure is built.

Therefore check for CONFIG_CAN_DEV and fall back to MTU testing when the
CAN device driver infrastructure is absent.

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Reported-by: Vincent Mailhol <mailhol@kernel.org>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
v2: use #if IS_ENABLED(CONFIG_CAN_DEV) instead of #ifdev CONFIG_CAN_DEV
v3: adopt Marc's suggestion to solve the problem in inclide/linux/can/dev.h
---
 include/linux/can/dev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 13b25b0dceeb..9f9e54e41702 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -109,11 +109,18 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
 	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
+#if IS_ENABLED(CONFIG_CAN_DEV)
 struct can_priv *safe_candev_priv(struct net_device *dev);
+#else
+static inline struct can_priv *safe_candev_priv(struct net_device *dev)
+{
+	return NULL;
+}
+#endif
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
-- 
2.47.3


