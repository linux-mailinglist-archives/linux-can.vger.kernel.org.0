Return-Path: <linux-can+bounces-5409-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AEC60454
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFDAD4E492E
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD829BD8C;
	Sat, 15 Nov 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Pv3QVbDG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pTXDfkfM"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C95298CD5
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207482; cv=pass; b=TMN/6dhwyB+DtNPOrSFwb8w8WCO8Z3IbogSGdIjmbNdacPSNdlJiJcGAJoTKDSh7MMuVIYnciIMCvsRZrs2CCFNm3PRizkhNSAste6LmmLUCQxdvr+CZPD92x1tBdqajiR/T5ACcAKy5b2AJRYiBgwdGr1jbRt08AJ0wwAL1BAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207482; c=relaxed/simple;
	bh=gbMkdgBxoqLOT4Dw3HDIbFvkqqkDfM8ZDKfFCfPHsHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmOFrinL9VdKcrd5Vlf2uD/6GKH6gwVcZ8ONdafhK/BcDPyBqAMiaPiVBXSu/qkrMLk1JFuFrExQh5OVqJWFgBjed730wQFDUV+ghUfhpUCfqABd8ZEt3jAxSP2+TCVEQlZ++f9WcIueD1f9ZRPP9XV2UUGF8B5JZl665FwJQ1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Pv3QVbDG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pTXDfkfM; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207464; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BSqsCbT/HnJr7s5VMEkX5030Tm/eGFl++RjAw8hxSRd76QgwDnJNKMBUXlHealXg4E
    b21oCsy6qUk33rWxP7NKFVJUSvNDBSreqA5jgUqVOTZTVfh+0cu2b7mTqqlF2tIWsW7k
    F0ap6hb0dd6jsFaG4CuVnpl8jHfAV9P91TcHRsxt7pKLLtFsWT7rCMKhpaIcln5H1G8Y
    j01wvf6ppzDTMJMuoGnI30SKuY1wEO2oKtIZSbAxbHb+g5doQhjXHKj1Up/ttqvvDdGj
    /GuHE6iOpdS/Yv8DQdra04gGyj5CVUk7bsLSzn1CDv80pm5VxKLjC4J7XcnmefCoRm86
    5mUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZjI1zd+QZ7pIR+0xChcwTNi5sfn7SG6gRTU/9ExXOr0=;
    b=hO6xx/KJx8aREKBtDgIbowDIaEtuo+5kHIWTqJgqvdXe3KmGxK/vfQkDGfHWEOyomq
    bKShdpdO12/nYh/OCDE32Pq87lu+6PZOEu1h12L9okoTZ8gLHMZSVR7D+fyrsYvk7HId
    GfseOotysMDoFfBb3CRv/AN8byxSLjE5wPFrgWsn+px6oshrUMcIymXKzSsCbVG/Fv4P
    11utRXF6XQJyrCy06CACHufCYvPCWKcMJB492G2l0s+itdJ32EKG/juqigne7T7PuNFH
    rAoOm5qlnxfi+YGwNfV15eDBkBQYx052x5BipF+sd/AAM5hDOM7wChW8l+cDGGQajOBF
    d60w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZjI1zd+QZ7pIR+0xChcwTNi5sfn7SG6gRTU/9ExXOr0=;
    b=Pv3QVbDGPAPynD6pasU6bojFui3qbY+mPgf9p0pas+fgoQ8OrBCGxWT5CmyfXGS5ki
    OqWb2dL0y5/IZwlPt1QAFAu/Cvnqt8a/V/R402/fsUB3kHNZXjbL5CZjZr+i3PfIgZ4z
    z/tuJxTadrRNsbUOb7vTGDoI/9xDIqBkeRplAEq2yTLVtGt9Rla5ymjPp/66FySo8Jh8
    T2POcpUCAHSvgg2sHWbe9gmoz2X8n4WT9AAMIMOh0MDCJr0Jj25yKoOUjBPkmXqBMWeo
    jQ6oFOd6ggD6MNmESdxdrnBwDLxaidhzuN/QpuzAzj5Ng9qJMsENBKvmiNLjF6J6ZxMx
    MePg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207464;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZjI1zd+QZ7pIR+0xChcwTNi5sfn7SG6gRTU/9ExXOr0=;
    b=pTXDfkfM3uOr/tkcIW+GeZnfc1r/xpAwnlREwRAo/wLAyH1a16zOOLDSFO0ydnxfor
    SBG1IdwCEiRGG4ksFxAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBp4dZg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:51:04 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl 01/10] can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
Date: Sat, 15 Nov 2025 12:50:44 +0100
Message-ID: <20251115115053.72673-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
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


