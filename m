Return-Path: <linux-can+bounces-3711-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B4AC5B2E
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 22:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B4D8A77A7
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1D1DE4F6;
	Tue, 27 May 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lj1vrBLv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6tdU9Gvh"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C01B040B
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376186; cv=pass; b=TdKJkq67+3U4GuEKgYtlY97c4HHnhljY/d9RSUPX1wrIVmrlblgjntcX4uli31Y3pkdawX4Mfm+IRef5DPAok0Rw4c122ALXbR245tq5WCPQISJfEjCvQEqDULnmVTJziWG9XA0bxAN3Ki759tzePoTvGG+N2fI/cTmE2AcQxEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376186; c=relaxed/simple;
	bh=v2prOfWSCghXXvQgRilL9md7cdc1mBGfpIudymV6Y7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggwRruIurGe2MQM4TA6xEwJGVfM84dp8DLcaEmQ0vgatKOq97Uir7HHpMQMMoTOKzMg2UL7ln7hfXRGgeqp/FzVqEzfQSogZbasBuFYzVUH2ouUzO9mdguUFP+NumtIR92xdIdzbEYlxPK1vWQ8/6tyCvMcjeWVpjRhb0dqf5pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lj1vrBLv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6tdU9Gvh; arc=pass smtp.client-ip=85.215.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375822; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ls3xg52OB2G2rXc2adS811PAmUublpNQTOho5UTehYE3vNfmTxMRhm/xZWfGjOz1Aj
    32Hgc1cgrmo2jbHKKidCt0ZSdsozyBtEwbbGnzLzWsN1U8YJ4H45znGWlbCU7vtA2KIi
    cpNI4ZnyG/H2pf+z5fnVq66G2UdqyrAn8MiVb36QZ3GENZkKskq02emOI3qwwHQNU4N6
    r9pmm0BFAoV+8MF/IqzPFMqqstC6RHM5ERwdxgv9u8BoGT19BMDEB6oyoa5vfyYhOFVZ
    HsF2zAC5Gk5ytBqGKfF47yWavLGdkS3SY8f4yfmhdgj/mFqOD79wWPsiDtYTZcI5mi9C
    pLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CQmTlxaijcRoJjL12LTFfCYgPtk3pRnTY+wKTKupQNU=;
    b=ezI/U54oEJfuOs+X0Wy7SdnV23vSOpVxBoy/XGSUdSwYNKhcbRkiykHaRRR60an+5m
    ru5Qv1Zyo4YOcXfhB/ONIwSnCRuSP6Hqo635GCMAXuC/Y3zoRUFa/vCnWZyqeNNWjRAs
    ufLka1RTShhnpKnESknL0dP5w9jLVyBqFhGXtPJRP+GPbAna5lL0yHTHoRbsPUm/22h1
    HyYx+yKdrh6Cx0T5VQAK7SesF7AsBzVunXlMPPfKcbaqATWXFSItlQUeWGAZHzsWRKCP
    i7zdJAPVSt/58COQ0EtVUdU+bpw+pT/fb5nN0Fi9G8PM0JgwXCAgunQkD04EmR2Mqtle
    ZynQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CQmTlxaijcRoJjL12LTFfCYgPtk3pRnTY+wKTKupQNU=;
    b=lj1vrBLvw/lnP6Q+wSe97WWIfEiWBkelmpW/B7pDsie1377Ykd/QV5CQ2bhMz//Z//
    8rmgHh38Cg/KDT5MY9kdlJFzDzMQNnoxfnwqWvCi6izGO6fggbbw+waYQ3Cu8nWd8kxd
    ZAVYNcrUmtKllezn0OHvO5o1rqlXk6csPsY6gp0HwqVcZBHAm7gerCrL4H+ONadgVkOB
    w/NTha1HA3Fb3GPO86YLlDlN/KLjPajdjeDi/fV9QgjgtRdbVrPyOEsLhwM1o+t41KPW
    TbxDZAKHVHD8XXWvi69ilOtD1HhQQfqKJFPPcWGu9ysU3D6e63RzCmL4FPSTrda9b/5H
    IbTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CQmTlxaijcRoJjL12LTFfCYgPtk3pRnTY+wKTKupQNU=;
    b=6tdU9Gvh6Zwjd2sefkECrF7824X/9fHoRARhvHHCUCzQ9pPTEAHmi7j01qjsPerQKo
    O41YYSVlobXTqVJDP6Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJv2iWH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:57:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 3/5] iplink_can: canxl: support CAN XL transceiver switching in data phase
Date: Tue, 27 May 2025 21:56:48 +0200
Message-ID: <20250527195650.65306-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195650.65306-1-socketcan@hartkopp.net>
References: <20250527195650.65306-1-socketcan@hartkopp.net>
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
 ip/iplink_can.c                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 19267678..bea58373 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -105,10 +105,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
+#define CAN_CTRLMODE_XL_TRX		0x8000	/* XL switch trx in data phase */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 9fe9ae6c..18854c2b 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -41,10 +41,11 @@ static void print_usage(FILE *f)
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
 		"\t[ xl { on | off } ]\n"
 		"\t[ xtdc-mode { auto | manual | off } ]\n"
 		"\t[ xlrrs { on | off } ]\n"
+		"\t[ xltrx { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
@@ -125,10 +126,11 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_RRS, "XL-RRS");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TRX, "XL-TRX");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
 
 	close_json_array(t, "> ");
@@ -339,10 +341,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			}
 		} else if (matches(*argv, "xlrrs") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("xlrrs", *argv, &cm,
 				     CAN_CTRLMODE_XL_RRS);
+		} else if (matches(*argv, "xltrx") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xltrx", *argv, &cm,
+				     CAN_CTRLMODE_XL_TRX);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
 			addattr32(n, 1024, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
-- 
2.47.2


