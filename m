Return-Path: <linux-can+bounces-2324-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B171E9E34F8
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FD9B35615
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19917F4F6;
	Wed,  4 Dec 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UDMhcCeI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BHffvRQT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5F18FC92
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299053; cv=pass; b=IUSNJCOgIWHLDd26hSdVACtf455fMFQnm8scizpSZ6OIFL0NONGlTlBNxjL1TI2+2r/wNNymxZT2tDVg4ZTL4XpfHLVlkSYhDedaqgzDe/nBu81Bu/mrZq3aL2yGXY8oo9BrFsThBZtRqshb5cRIXZmo8HJSmFd6gpmEMnVQzXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299053; c=relaxed/simple;
	bh=WldPZVWLFbPUZ5QueCcJ4QkDms+dFg9oHKq3tVF7Pao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGK5IR+d8HVwuKIu5tbin6ye94Rm5U66fukX2ICmphDBeA5mWlOfPzW/tzBAALOcToXMCmetQ97JZ7+g3aKdQzDjpdjWvep+c29QvUCDIk2AgzwoztxCpcHc0O4ccBVdDFAeGbbre7VbYnVpXLowwqkqSbpYrKeZePHiDD6K1UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UDMhcCeI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BHffvRQT; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733299043; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pYKe8w0qOQj1Ock4Un2ckWWMl+Qn9dC3P1Gb5jKWVKttRATXbn2PRLlQJxnXDXhVfb
    4aoow7en38snO9NQ06zYxbH68mx6SSaZOxwTCatQoEN0xrQ9zm8fMDxrOSM0ZuJ/QnQu
    TkqdAxeTiWRkjkYWbRfytldZb5N7y7d9cyYgUTnUBw6dnp/zKkKypVI0Fp41/+ILWlJX
    3EttkgsvYTtj/M1GI3o+SsokimW3TvYO2+GukLdhqQ3I1VFzf8ohzMRoXHMPhuLTJ/Xi
    J4WcadRHNtWT/OBfJc9ymUbLHaAbqFYC291SSRrzgZqQAQpEWchTpfKpfVojdgk65zXK
    PDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299043;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Cex9gk1XHjewDfw/ij/DEzVXcjQhJG0goWnKpg8ns+w=;
    b=eWx2U8N4D4QXESBf8BvLoZx45fm5NL3FO0kdNVgenyPVXCNiJxW5PF4/cM8swxp0cT
    PhDkV91i+uXTH6tU9n1gM8XbV/6GSEFSDhbnzrq+VUNrd5dHX7RFrcT+PvepvfcGeZvU
    JdA/1yg/hhItdmiRmdTwNnd8l3IDXMcTZ8dvp107LYSbx4RH7X8sJoKp9MNKwkwNnzQc
    w0EyNXm9pEEQvX0Mz+kAROedGgNSze4tyEalQzIg/BkkH8UpQ2uhjNZiieJwavvET/p7
    IIVh5QRoXl+RoQJsrNiiX9N+p03t3b7jHB0Y86qSS21/bzbdUCDPAMr2FcbUsVzs/Tqf
    YTiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299043;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Cex9gk1XHjewDfw/ij/DEzVXcjQhJG0goWnKpg8ns+w=;
    b=UDMhcCeIzOzls1VsEzrl3AD619enSaWU7WuPZ2PW9N6L7ID2Z2LwX3Ps9CR7/QYjLE
    z8FKB59jBq2SVD9OQ1xAs6EliKq1M3UKBhj8N7+IkGY7zjZThgGsEQtaiPBiXgB8Lcim
    /eCq+VgKNDODFZO9ANKwEXvrHxQCvJCl5ybxWFFXQXi2xMCsOcStvi5Nu7O2Co9jj6RR
    W+uahYer7ZAsvpVaGnIUWhSIvTKbcxYTGsWL0rDk7f4KC/J60BrSha1RLILK5powRW68
    e4WNztNFp603xjUCwEPCCuY/O3yStr/ecnM2Gb//TVd5Hpo/AqnG3t9CnQcGuMHfr2nh
    bSIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299043;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Cex9gk1XHjewDfw/ij/DEzVXcjQhJG0goWnKpg8ns+w=;
    b=BHffvRQTtryYJ1CUbvyjNhbYVRQ3LCz+dq7xcH1cjwufvok5YHWVWeATR+Oic5KBx6
    JEMT218A35GRY2+OM8Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47vNsr5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:57:23 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 4/4] can: canxl: support CAN XL transceiver switching in data phase
Date: Wed,  4 Dec 2024 08:57:03 +0100
Message-ID: <20241204075703.3699-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204075703.3699-1-socketcan@hartkopp.net>
References: <20241204075703.3699-1-socketcan@hartkopp.net>
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
2.45.2


