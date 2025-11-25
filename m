Return-Path: <linux-can+bounces-5647-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C4C85009
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE3D3B1901
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832131D726;
	Tue, 25 Nov 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="edx7d1PX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="G7qje0rT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441831BCAC
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074372; cv=pass; b=YuPeLZvM8nuyzvPoydVcpb4gOa4QTiomwbyNPNFzlK4emePerVx18NPBS521L2yZrFsJ5M5Krvo8/4yaPuOlpDnQakVRwB0DTmQEacBUkH1WoOOqHR9Cdmr9pgWy2Iw6kjnWY9MSfCsuTe9GoHn/p3TWO3LaI+RJSpLZTWZ0nUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074372; c=relaxed/simple;
	bh=s+lADGieyXp5NWDUjGmEQumpNZetzYKO0b2m4eFKE7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPTe6G/ExHqX/yt3wumZjmoRDJRNxm2fRdDuatEBQFyrmJnv8ZuuwwYobil+YuCFnTrXZlimCuroaEnAMXJLVIeVgeBtC4apLnXrWKCTrNhDsmQWKD/X9NmOt5Nmn1cSsNPtdJuOxI0iyQHbiegLubdUDENELF1Z0I5HoWExiac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=edx7d1PX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=G7qje0rT; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764074353; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WDAaFwBeO43rS6tv1hhtxYB4Sh8avg63tt5FcndROvLCaW0ta+96RDWa8uiTtUkY7a
    zJe0Wr8cQIty3woXlZQ84UmJQLvN9SArMv5/cmz+Rt+PLx2OGjJyBi4ikqdUvbg5r3qO
    WtHP4ZSHAj8Ectgr5Cbtc745QKJNB7rdn/yAt0S/QYaIm2tPU61F1D/7c8AXMeHNGFpy
    kc2/7wD0yIGV7LI20pBcOXyuD74BVunJzrt8g3/Z8jKV1fPpQmnKozohtHvHSnxjmP2C
    os9Ah4G+6YeLRUSMQTYSK55+EBIsswbAZOQuzGwb4ry+7MZfEAtRkHXmlDAhhIDCrH/x
    o7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074353;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=Ui9GXHkE6Sh9ub8Uv9RaCzQVYJIQ8kGiBDcjoNbXHnCpl5tTltJmxWjiGi5nBaQzwm
    dZOrdIiDNIkEHxsUyZ4gT+woCdHhcmdKT5/NQ00sHrjqom8AYYa5w2ce0SXYktdmmSRZ
    0zjCNFIaldjIGQH8KZ2n9iSH70FJd/eR2dlfbW2ojb8rer8xL06zS9scY1fPTmlJjzt4
    4BcczwfHohw/8lheMkzAStkX7AOIUs8y6VCuQFo6ut/jGmCjBQ8msJMBUUzwXGcKNT2M
    EYuAjksMgCJ3o5eJ9QSw8Z1LjHNzDBQb4RVcHizVrCUB0s7mdLXRLX3TR1eyLJSd/31Q
    uSAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764074353;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=edx7d1PXu5q/7YxQE2x0ncZ88K+/7yAlj4gYlZAoHuT6jg87rpkSdZWEye1eGbkC5w
    cvGi2FYb5+iiRw1inus8UxVslrS4cprHM0uEqYqa3JpfnEBVcJZVNvmoFtxUXUfLQBfM
    3F+OkkvEO1nKwqD3O7B45qYnwlBE7yKPJOEyLClAkYHsa9r0fMiyafJl9ZP4Jnz9VIW8
    ufvcFWQNdJYPyD4pPAOugNkYosE74HZbo/cszWnh3Kb2vdLzkLqzVAjnAgd2VAB8WgxW
    /JTYA9u0cjoFFlhwckO1Zy4j1QoPEZzoZKIlhHWBjvAE48e1VQnanLJTLZPym9LBSLHB
    Hq0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764074353;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Vn4gsB8kwb7mn6S98lacK3xTSI77EQiiURCmYom8g/E=;
    b=G7qje0rT5UXlYsbBIRECQu1SHqZ1AroWZScurbfT6PlgrY8xPOvjIYIrg9ArtVwiBg
    jfUyqKK8QMiiOHForsAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461APCdDT8M
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Nov 2025 13:39:13 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v7 02/17] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Tue, 25 Nov 2025 13:38:44 +0100
Message-ID: <20251125123859.3924-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125123859.3924-1-socketcan@hartkopp.net>
References: <20251125123859.3924-1-socketcan@hartkopp.net>
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


