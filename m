Return-Path: <linux-can+bounces-2325-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A59E34D1
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0570C1667C1
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D235188012;
	Wed,  4 Dec 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TDeAIyQm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3CueW7QV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0D18FC84
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299053; cv=pass; b=ouZ99dssAgzN5Lybz+X/Zw0jGkImqu+U12QzVS88xLOngmV7CnzRDB4lNoyMgK41TuEhEKt9Y0Rs80H9HlzHvfH+1GXyqEa029mvVrBKpasSDwEGcCoq2WK8179qbRbbBeLL1w6O0RmCmoBlWAEFO5aKnBF9VhmA1/iBA9NNPmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299053; c=relaxed/simple;
	bh=J3Kd55gLU1To5md7wNdnHEnoqhyw8jJgCiRRRuDITbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP6JD3Kd9iF2QrppXYP1AUAJVI3AcfTL4esmNbry2ZCEjl4EhnTZafRFbdEeLPttgu+idIZhSxkoyP7d3ZaNehdZymeuSGSSE54Tauj2JwG0ozw9x/hn12hzFkXpvWBhs/Rj+smeI7dH1y7NMyBXIooq84qWv+I9k7QftAHISfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TDeAIyQm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3CueW7QV; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733299043; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qtdcL1hnlxuxYWXg7omRKLb3BNsTVkyIprKfpNHbRMcJlk9ZmtVzQrjJ9FLQHcoQgb
    qwDUDMGTkA3rz8zU9pvrySx3EsiDslO0xWB9rSiIwECtyMl4vmKnpl12kEX4XJRPn1Qd
    ebD9gGKaEZY1E4XM/2gHmlJ2qUfhdIYX539EhoS3Nlda+6ODEvH80RepBYhcr5DC35Gq
    qJuArSUDqvQddg35nxVCY3SSn2UYQ/svQtSJqg8eXwcqiIT/pr+Zyai69oeGgVJEQLx6
    l3vfk+nEhBn6qLKHHH+LrF16TlKSfD+tsttklsV5BCm8dl/fFynH0Wh0NPtykVaiP4gO
    HZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299043;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0FRsCkC/JNffuirHZ/LmirjCMVKPAhK2HP9ypqyqUE8=;
    b=SjMvkrenYyzDIL7b7Yyh5fbXyPNnoDvrlDNsbfT8ucTmZIqNTlZQmCiQuPoShq6UOQ
    n0ickMyrZ4zzME6kMixTeuP/JOHbDLBG5PVHDp15Y+bbESIj46rvaPBUo17Psmyvlbmd
    VxcXf84+JMy7hnyqGJitum6MMr8AMd0n+NvawvqXUzBOQTgBWSUGeQPl0NoMyCknTfXb
    YJL1TCLJQhBqw9E/tuOyB0l+Bn8MWmmtkKXzqXa+c/wUQMJeIBDT1Qg2WMJfSVLAgXCY
    KumX5gQGVZ0khRcNyxDbO5tn2t2fbJ1/npTLnxEqY65n3AeZowxTWxZzKgFSVHC/vUEx
    LrIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299043;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0FRsCkC/JNffuirHZ/LmirjCMVKPAhK2HP9ypqyqUE8=;
    b=TDeAIyQm6UbaYCVWQ4otWlMFn7bcY0Nfe/UU2rPxBrYTpp2P1+UpeSEtRExkzp2ZeE
    ub88/S/qjKuL7wrSjHl47wqY2Mu2dhdv/1AoojthAuwH02nb1EYMUOubnJZg4Ekt0T8/
    fPPn/0GWXpeuqKS3z029NjNgKRxiEuSwOeojdJCsnI9coMrayPGkxB+nIjDczH9+wKtI
    U3bwv8iB51DlAvO3PNAYsKbyYhU1wGHHeYK1sgJMW18fqH8Q1s9n8fMbCRlikKaJ2gW2
    41Yqs/2wAyCjBISBtH7AHzYbrHCA1DLbafMvh5PMrppS7iKsJFUrY3DG4ymSqLozV0QQ
    lhZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299043;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0FRsCkC/JNffuirHZ/LmirjCMVKPAhK2HP9ypqyqUE8=;
    b=3CueW7QVH1ys+cy8/MnzN2Qk4RZnwpcAmDWzAec0qES1OUspeXovgiywakppkTFgOy
    FJw8frf7c+jJYQkT1VDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47vNsr4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:57:23 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 3/4] can: canxl: support Remote Request Substitution bit access
Date: Wed,  4 Dec 2024 08:57:02 +0100
Message-ID: <20241204075703.3699-3-socketcan@hartkopp.net>
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

The Remote Request Substitution bit is a dominant bit ("0") in the CAN XL
frame. As some CAN XL controllers support to access this bit a new
CANXL_RRS value has been defined for the canxl_frame.flags element.

To read/write the Remote Request Substitution (RRS) bit in the CAN XL
frame the CAN_CTRLMODE_XL_RRS has to be enabled in CAN driver.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h         | 5 ++++-
 include/uapi/linux/can/netlink.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index e78cbd85ce7c..77d3a940beb0 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -180,20 +180,23 @@ struct canfd_frame {
 };
 
 /*
  * defined bits for canxl_frame.flags
  *
- * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
+ * The canxl_frame.flags element contains three bits CANXL_[XLF|SEC|RRS]
  * and shares the relative position of the struct can[fd]_frame.len element.
  * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
  * As a side effect setting this bit intentionally breaks the length checks
  * for Classical CAN and CAN FD frames.
+ * To read/write the Remote Request Substitution (RRS) bit in the CAN XL
+ * frame the CAN_CTRLMODE_XL_RRS has to be enabled in CAN driver.
  *
  * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
  */
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+#define CANXL_RRS 0x02 /* Remote Request Substitution */
 
 /* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
 #define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
 #define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
 #define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index f4fb8eea8f35..55b8374ab094 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -104,10 +104,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.45.2


