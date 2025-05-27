Return-Path: <linux-can+bounces-3705-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37CAC5B15
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 21:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2E71887CAD
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D319202962;
	Tue, 27 May 2025 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Amlsi9W+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="4wE+p79t"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A81FFC45
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375826; cv=pass; b=lkhPec821K0TG39XbBBGwgJzWHBIstM6RXpFvsyj+glg+G+bPZklXe+qmZGwZqodTbBZJcrPqvcjs1PS8yM7kJPjUBUr5bKUG4Gxi/4VMkDcXms/11MHwlpSDrIfmcKpCQVgZCbUkRMI7wyF8hKSxmDnkGvhW7mLlAzWD2PBzA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375826; c=relaxed/simple;
	bh=JxvDcC2KwsH+VvRKBuxLPk1itW2fFu3dQjT3+y7PmPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irgome2WC9wZpo6ZDdCV4o6LTOKwHdCSTZyocxVpK+99FXsdTgUFJiSUzmKazzgFyDIi916FE0Q17TKY1X9zOR6cRmx5zlqUNnnkeKnrbA6kU8ARctl4HLeDS5AtUuutTrTj4t1oCA6o2xHN4doYuPCsmRdzryU4nP/dozIGlEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Amlsi9W+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=4wE+p79t; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375822; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mBkPDJslDcQGmy43js7B6F1WKAz0kByeVYgnKgNiLWIirExbsvt8zvOxJHpIZ7CrtA
    sgWjwubQJMzCtTezzRqTzPkPePySSFn4AuOoh+xyyKw4vkRV4RPGZyEjihUXbVErb3XA
    c2t4CtoG9czOmTwTKXbzCNk1hoWbQB8KhHFFuo83/9HDb7sqgn5MzOoqxckpd4DnOgh8
    X4GQ+leTu+5dHV8SARCwShzkS0VRhew33r/KqkBhqhDDq0vmt3qM9ihrcX0oozjjcXGD
    +XwgwVw6drLsTJ0w1gdxRclCYoY3YLNWtdr7wF0neNXBCR0AAUIbuXaYifN0fmqqyU+N
    xFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7SC904xI/ELwpttOwP+lFrbJ4uDZxwzG1Ze2Dk06UtI=;
    b=XV8K/JHw8aPIqbbKouILEzZFOu9ON9iITkAaslNoAR6X78VyiiLMsq2007yj7EGmbU
    kHNj4DbdraS98NTMP2W3yL3k4lCEBpK6ipL4k7BFilaLWq9Z1+ztXBXOoAu5l7JkGhe+
    IW813X4SGtFsuWVMab7HG1iTi+nIXQ6vJblq6RUm0g8teS2L45y92RBXBdVAHDHcAuSR
    yrx2SCWAtM0Xi9Pny8jN7zAojA/ejcTOcxYi36bhz34DyiYpLxNZ+v3orx3SaXLxcEQl
    xkJcNgMm+wSDy2dkHUVB1UXyKx0Ftt/w/qxeBxcX+LgCZHyiRIlc0suFbQQwkV8Nf8mH
    qzBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7SC904xI/ELwpttOwP+lFrbJ4uDZxwzG1Ze2Dk06UtI=;
    b=Amlsi9W+9PaOP/FiNyWdvf2KI4q9P+Ba3EjaZVB/NT0hg4Kz6sfSNhPB0v06rbiqpL
    7J/DhykuMjwNMUZdubodc/cYjW+0idM0wxnF4R4YiNJzOC7wUD7cHOEDf6QUrNktNSGg
    GOAZdDJBixqAw1VFx4JlXgNQVlvZ0cUOQcBntLXSRuXmDidb0wTbftP0S5kZ5jKYcyr2
    ZmeT7AxDtsBpi8zpiQFUttwAUGtUsV4w1lnQ9SLfV1EPFVxeFWv0tLYWaAYeEebI0B2R
    S00269O6K1TtSTFvWL+25gUBTaVwxcSrU/lJ26D6P4gKt0K346ce9jWekJJduAqsEafg
    s6tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375822;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7SC904xI/ELwpttOwP+lFrbJ4uDZxwzG1Ze2Dk06UtI=;
    b=4wE+p79tgd5IVqxKVBlTB8ubZYhpLJcr60BhFHvKBRFbqw7GlGZHl6b6wbq0NnmgMA
    uBPenRcsJBXiREDjfwBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJv2iWG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:57:02 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/5] iplink_can: canxl: support Remote Request Substitution bit access
Date: Tue, 27 May 2025 21:56:47 +0200
Message-ID: <20250527195650.65306-2-socketcan@hartkopp.net>
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

The Remote Request Substitution bit is a dominant bit ("0") in the CAN XL
frame. As some CAN XL controllers support to access this bit a new
CANXL_RRS value has been defined for the canxl_frame.flags element.

To read/write the Remote Request Substitution (RRS) bit in the CAN XL
frame the CAN_CTRLMODE_XL_RRS has to be enabled in CAN driver.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h | 1 +
 ip/iplink_can.c                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 416e2feb..19267678 100644
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
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 8dc9229b..9fe9ae6c 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -40,10 +40,11 @@ static void print_usage(FILE *f)
 		"\t[ presume-ack { on | off } ]\n"
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
 		"\t[ xl { on | off } ]\n"
 		"\t[ xtdc-mode { auto | manual | off } ]\n"
+		"\t[ xlrrs { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
@@ -123,10 +124,11 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_RRS, "XL-RRS");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
 
 	close_json_array(t, "> ");
@@ -333,10 +335,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 					   CAN_CTRLMODE_XL_TDC_MANUAL;
 			} else {
 				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "xlrrs") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("xlrrs", *argv, &cm,
+				     CAN_CTRLMODE_XL_RRS);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
 			addattr32(n, 1024, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
-- 
2.47.2


