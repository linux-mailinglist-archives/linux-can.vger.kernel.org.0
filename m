Return-Path: <linux-can+bounces-3707-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC2AC5B21
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 22:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCBE16AD58
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D522046BA;
	Tue, 27 May 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="A5lJy1zV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="vKW74fkb"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08601202C49
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376007; cv=pass; b=lWE/vlvE4i+Le8unpCiom2hdSBpwsEntV105kNf/JxrHSh41tfsuKx33SuR2YVBLfzDPBIr2PCPLBrIA+K1iJa6GEKlQnXarZ0/LEVJxec569if8orn9nLWPIvJxIrBPsmdT63ukCmPLI2nQSh7tTxghn0/b9am5duBf4GII2Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376007; c=relaxed/simple;
	bh=aCUx5Y1AE3ZhIiF5xhuu9NCExxnSIqcgVn6OgBiFPKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2MzlR9y0MsSlPRR3L5cxW9+gzryIVTmYfneb8wBKjt+PhlDQIp5uyw7pANmEI3vUok6Oa6s75SSUA9dIFfzDb0Mhtazzt/mjgNmqMz3YP7HcbuUhZztR2pNrUwfETkcPjVDUp/LIFPW9+V705siimshhvYM2hQZqLdyzDUKd98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=A5lJy1zV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=vKW74fkb; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375822; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SlIdIuCshqZhhKpXSL79Rajhvs6jJhXx3t8L2T55e2AcAI27K2VgfYKF/WccdqjSSe
    d7KUesNlmoF7woNe8euagHxOEdJPl6N4gaip2/s9PTRd0MV0FFCdczKG/JRWHvbU+zk+
    8Mkdt2SRw/O3glQDq5O7u7YuHtjxttu/P0lT3aRG8ZAp6pmO8JGPQW6QZefsLq5khqye
    PhDQ6/Yrs9WNnCO88tGodYnyzelLLGR8djuUNyQeHNpqp62RwWPACozMlKe7ByuuvJDS
    Vj8tbBCJy4b4K2Vbfs3WeZxHnOBZKWNmBw8lfAevpgrQoJjm277avSWsGbq8nbSex2ma
    A2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=44wgBpPX8aWtxkLfjsKJXpqQYlIL+4KKZgtZ/mN5Ra4=;
    b=PS1UeXE8kWzjf8Onk2DuzGHxG7kGWms7RGEEWRLo8b5qgJGnl93hF4FAsuVbU3/VAK
    IvbGGH+t0vIyKv3EHE6txehBnNyLF5n4ZDKIUFoYtwJ4XLniiXICNbLxCMhEpjI/77sD
    l6aEUvSJFCty+gnbZo69QhcZECJ3M1ofPi4G+C8daDPJqFCwlfFH0r6fFIs2Rkai8qn4
    bnMT2Xp28Z3N6HetpmsK5mHADTzI8ZaULhCtgacwIzOkEvwmBOgq82xwRdDG3Kz1bXwh
    vyMsknpCllNhz2nUbXW+3t8jCck2lNb/oQmxr3V4BnPjNc8vFlXWYDyh8e2kbEnLNyrc
    LZuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=44wgBpPX8aWtxkLfjsKJXpqQYlIL+4KKZgtZ/mN5Ra4=;
    b=A5lJy1zVdsU2BhmYTH+5lmEv8iupnjQP1LNt2pOI1Tf5XpUrn81F9jCyslh52E6sd4
    b2WyzclfusZNntHYMlbsZkzIBWyGaUwtcOK+73nPwzboMwOReeq5KENNrdqng1+6OKil
    AGPOzHr42W9kGfWgt4Gi9G20VKtZeY8eJfCYrf8050jrA2vT5WhiEnzjNXxz3ZXA6lGI
    KoZQjf4u17TVHtARiXnStsZzRhT80XL772kC4saGwg12uQw50720WXAt7DSL1IFVeDP7
    bFjysIF7A55TTVJhtI/0YyAoEjCxTYAtpuB8djQsCiu6ifURThs4+MTzY1gIk/cvp2JN
    Gu+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=44wgBpPX8aWtxkLfjsKJXpqQYlIL+4KKZgtZ/mN5Ra4=;
    b=vKW74fkbdPSchBcqs+zQEtzzoVqBBS3+70h2ihHSL3f/uAHyKoW/jGdgI1C3mvp1Gw
    tE06X23gMHNL8Bxe8ACQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJv2iWI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:57:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 4/5] iplink_can: canxl: support CAN XL error signalling switching
Date: Tue, 27 May 2025 21:56:49 +0200
Message-ID: <20250527195650.65306-4-socketcan@hartkopp.net>
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
 ip/iplink_can.c                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index bea58373..903d7f2f 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -106,10 +106,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
 #define CAN_CTRLMODE_XL_TDC_AUTO	0x1000	/* XL transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_XL_TDC_MANUAL	0x2000	/* XL TDCV is manually set up by user */
 #define CAN_CTRLMODE_XL_RRS		0x4000	/* XL enable RRS bit access */
 #define CAN_CTRLMODE_XL_TRX		0x8000	/* XL switch trx in data phase */
+#define CAN_CTRLMODE_XL_ERR_SIGNAL	0x10000	/* XL error signalling */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 18854c2b..766eadbe 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -42,10 +42,11 @@ static void print_usage(FILE *f)
 		"\t[ tdc-mode { auto | manual | off } ]\n"
 		"\t[ xl { on | off } ]\n"
 		"\t[ xtdc-mode { auto | manual | off } ]\n"
 		"\t[ xlrrs { on | off } ]\n"
 		"\t[ xltrx { on | off } ]\n"
+		"\t[ xlerrsig { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
@@ -127,10 +128,11 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_RRS, "XL-RRS");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TRX, "XL-TRX");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_ERR_SIGNAL, "XL-ERR-SIGNAL");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
 
 	close_json_array(t, "> ");
@@ -345,10 +347,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				     CAN_CTRLMODE_XL_RRS);
 		} else if (matches(*argv, "xltrx") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("xltrx", *argv, &cm,
 				     CAN_CTRLMODE_XL_TRX);
+		} else if (matches(*argv, "xlerrsig") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xlerrsig", *argv, &cm,
+				     CAN_CTRLMODE_XL_ERR_SIGNAL);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
 			addattr32(n, 1024, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
-- 
2.47.2


