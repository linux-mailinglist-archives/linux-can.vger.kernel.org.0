Return-Path: <linux-can+bounces-2329-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D39E34D4
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D792168160
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0809190055;
	Wed,  4 Dec 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CTdO+tu/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xxPB4zAW"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBE18FDBD
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299078; cv=pass; b=LUqtNbusqJNQsUT7yiIgKhR8dSFGF2531Gs35e1zpbuXHgj4CRh7TQTWgPcHvJ86DMdttvNKOVNTHeJektL9WmKjlRPNzcTZ9Kcwr/cQlgq1dhMkOz7618XaBvweiwjhfJhg4qb5CivvcMTBx7jNCoen/sX1IxMfdFzAqq8rvmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299078; c=relaxed/simple;
	bh=tGgWOoRGyioAsjk/lZj0XsGzRkADvuhCoZkvzTZf9qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSJ17h2kGWPNuNmg61K5D0PdpZfN2Iy76NO8ZjD4TjUE+wsoVcknD7BG1dDLhMIn9KqNTvIaBP/f0wM+tGqa2EDiKHVSG22ze+/mzZLmdEaiK1+oK7zUcrYqSCLfvS8GtHBS+eqUHoPJBkSQ6VDPsY0W8ShBatdAtbq9ucnredQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CTdO+tu/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xxPB4zAW; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733299069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g65jPJboNnqhQaH6ZSi6iOvyVaGXOn78Q8km7GGEQEgEnN+s6xIkPHTb2tpSc8qmh8
    KGSh6LGtFvt3kZVYExhs4mUQNGjw/YI5xf/Fb/EOGIJ3YylqhnhL2EGFQbN3uvM06zKo
    2UA53hq15uitObN+Rh9jX09LjyZy7YoSAQeUPECedTHMmYYo2m4fbVvC7cLXmOXFiidF
    Fm7A40zIDoetcW7gj61qfKCfYaHlJ8FG4blqeJ2nK0fkeAmszhNyQGO5amfJ0Es6Q/Fs
    jxhq146fx4jBngdwwbPvAjDI6h8bi8WRJt3HdXa3mvaogoHBj1CYuP3F+rBKZf9pPyXY
    C7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dBh1e1anBOsJrXyjHlEsEQV3mx2mk47rSevvD78NUuQ=;
    b=qU7cjvfEFCjeg0+UO0Pt+Lsoh1+WRuM53CGJiKf6+SMEsMOIEEIiB1eGBVlrB/qvay
    ObWMeGGntdJCYJ84PFWWpYVgErXYt0J8LyXu2JGx0c3QPSj/v38ZYFvPMMnoaFbgNA2M
    8sMp/TnH1xnFRbC0kxn0Wpzpau62xIXrNll97CsCiRc29/owchiBRMo8CN6CRHY1hTWg
    /mWzkFNynaezPvZzCeVAxBBn5iEr6i+12tghseO9qSfYcW52Ozy5T04dMKdobbXz2bf3
    qXGjze+5juG+DxHTyr02fn3dqJidJy+8AIEZb2j6U9EbsmPg429IPVJzvhHp7V7jALtu
    P45w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dBh1e1anBOsJrXyjHlEsEQV3mx2mk47rSevvD78NUuQ=;
    b=CTdO+tu/bgF8jI0v6xasfWm+n5YmLM66unoT18fpC69H7wMBqzaYasuDWp9p3xQZrT
    5hmS/DiqqquH/PVEkEhCXugibwY/OMAVhoQJbj7auSTYyqbOLLlZSs/53lykDU3HFPuu
    rC5p9idKZPDLNqkGzGWFz+NA1WKbDdl7o4U0GsLxH9WXv8RNtK0pLmMt4MfjZ914/l80
    2Vq+z2dMatHzzhm2QLDVfN94KuyA+ciWwmhbHg4mgofUgs4cp0iLifN87YGd/phGfr9w
    g8rSNUwe+OJuL/0zRgfjSNBp/v+Jf2JX1xirFYp6yDPYcd70L0CZ9ygHrQl2ZsbSVgWc
    8W+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299069;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=dBh1e1anBOsJrXyjHlEsEQV3mx2mk47rSevvD78NUuQ=;
    b=xxPB4zAWZqmimB9zx8jpmd37MgPS9caEhgXimx+QWtLjL+DcX8IdWopoqDMXN+SBLT
    qituIIY5EmFOkFZ+xUBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47vnsrG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:57:49 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 3/3] iplink_can: canxl: support CAN XL transceiver switching in data phase
Date: Wed,  4 Dec 2024 08:57:41 +0100
Message-ID: <20241204075741.3727-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204075741.3727-1-socketcan@hartkopp.net>
References: <20241204075741.3727-1-socketcan@hartkopp.net>
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
2.45.2


