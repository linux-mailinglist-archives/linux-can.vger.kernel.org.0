Return-Path: <linux-can+bounces-3697-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984EAC5B0D
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0972F18891A3
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1020298E;
	Tue, 27 May 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="aikGKFPv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="D4prK8/D"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C6202962
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375812; cv=pass; b=G1qbFlUgrBRDdeMZ1Y+kSQFbhtt/F45d/G3xde+21hJXNAFqRl7zhZUgAzDMP+z+dzDrvKx46zPdCfkcJUFuoQmDEvbkzC2c4/I6kmyzsU6Cn79cXXxh+yKMDRb1r9T/dx/b4sBkWMWPo47hAxo5NYEiNTzVE7rt0BwrdoHlS+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375812; c=relaxed/simple;
	bh=Jw6VdD8FT7Qt42zjm9Qpt5vTaKHHj76WGurGGX1C0Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9HC6XzSCqiMaOiuq/1c2YcKmIabd/A+bcuC20v0D2sQQnUf05JNveNf7WPwyHYnlNaB/UOTLpA8/uNXGbZIN8KwneAru09FlKDuJqHJMxmIXjHCE5jWRvVtGLDV4I1++JGj5NdZY4r9yjadtA8qsKJ0xqm64UUvliNqOgIPcgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=aikGKFPv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=D4prK8/D; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cP9tCaoapD4w2pg/Sjh6neJP+u2HcpWnYGH41tlaSkrQTk4SPyckfDs+0+xpaGBtP7
    /jx34XYiiSM/GPmFdm3RydJZWiDw3hV1IROywttHGmRg1R4y0F0xRNsXYz2JBNgoa+zA
    ZXz/zefk94OVPyg539Td7hxRpob9mt7Ne4ezcrFJYQCIr7xPO2JCcPb5zbt5dZOdMEBc
    O/ZBlRzd9Ol8b6DsPk22xfbxKtE6gwaHxPh2dLFMp95DEv/ni80AqqGnEtiGfix98iHC
    zmMJBPrbFNPssdgtgWUx0m6paShlQN+n3qccsmUMaxxavsEyrayYkG1BdmBEWWqcSe7J
    Ncvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ob4kw/27uzKJ49ocPUKhdcZbmSIcTwv9fq03UO792JI=;
    b=VdQCeALa8APkJwrsKnhDrv7rP4M6vzN1C0E/Up2SJkpMktC7X1D+QMKU4mtNY6PSc0
    +FD0EhReGlicWRjgJLHboqn0JWxxJzjSsouy7GxFkiYMHR4qIPe1y3QR+czzlhuQQBLG
    lgd1L0oGf/IcbYMHfHrLeu1GpBK1yFEyJJ9N6+jgPRdUep5UouTH5v0PB+owhv4m2CB3
    ftRjGLoL1tZDmu7o2zlykJimhpOjSL37g6kVsNHdqOx1XnReTNMxkCx66s1jabTOAanN
    oZONHlOOtipHJKTMSnXmiBosl0QMBobnmzDdmX8TnQ7JwICVGKkwDt92LwYaY2dWgrF3
    rKRg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ob4kw/27uzKJ49ocPUKhdcZbmSIcTwv9fq03UO792JI=;
    b=aikGKFPvDF04cFqKuJ3Ge9mmNI0s1iofJpXxA5mNlvJAb1NbOEgcWWfrGZ4hpcfNOM
    6GdWu+7Z42NIEO9Heaq01/EOc2srJKOn3ZV4s8HhuFzCqc/ZXKZuMnhhFLc+Bl5qdBtM
    X7wxXpbnsWbGV0yX79mbtPRSut087UplDCgTv0DUHbZHHM7egjqtR+qB6JuGcGrcPSOl
    XIzfI0S0DX5y/74QfyrWIueg9Xzb/FNypfzzgiZ1pN/hywKqYDSDydevbpluUwjRPQyE
    cqywRtJnQLnhOh/9WVZXqAxKo5uoJzlBydYtiqaQfPIqPhc7Y4Ul5EqX9jiwMq3IgzZf
    GbSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375802;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Ob4kw/27uzKJ49ocPUKhdcZbmSIcTwv9fq03UO792JI=;
    b=D4prK8/DU2oA0+3RVGZOTZGx0Soz/seXoOu+Jie+oC+D+FiMgbs3+l9cAMkjW8SiDn
    0EWjqnhJEtlcRFlyIVCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJugiWB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:42 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 09/11] can: canxl: support CAN XL error signalling switching
Date: Tue, 27 May 2025 21:56:23 +0200
Message-ID: <20250527195625.65252-9-socketcan@hartkopp.net>
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

For CAN CC and CAN FD the generation of error frames on the CAN bus in the
case of detected protocol violations is a mandatory feature.
With CAN XL utilizing a switchable CAN XL transceiver with a different
physical layer the error signalling is not possible when the transceiver
is switched into the new data mode physical layer.
When operating a CAN controller in CAN CC/FD/XL mode (XL = enabled!) with
a 'normal' CAN (FD) transceiver that does not switch the physical layer in
the data section the user can decide whether the error signalling is
enabled/disabled for all CAN protocols.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 652576234f63..163a6167264e 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -106,10 +106,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
 #define CAN_CTRLMODE_XL_TRX		0x8000  /* XL switch trx in data phase */
+#define CAN_CTRLMODE_XL_ERR_SIGNAL	0x10000	/* XL error signalling */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.47.2


