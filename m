Return-Path: <linux-can+bounces-5780-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38456C94103
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684DD3A8B97
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4E3101DF;
	Sat, 29 Nov 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDVty03f"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFA3101BC;
	Sat, 29 Nov 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430213; cv=none; b=BP8xPNv/z1hhjEN8JgEnlMuSNyehb37NbqDcBjctrc57XMrzCm0A7W9Z9kR5qjOdWntS10OjJzNcoW2wXqkasPjkZbxnVdAr7eiUGNJcKjTKacD9lggBRzfwBAsuKHzYpOuvIz8HAPMZlLj2W2vX9Fk1zT4ORG5V+c1bEKANqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430213; c=relaxed/simple;
	bh=3TP7SNqp7tWdCwXEIzykODHN5BrAV73rkGehEawXc4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0CMyAkf381m07nu+kMVagabEnnaWmYq4DIi/YSCS2yjAVzeDzWgX3QhPyiIqetFj5qLtxeSChvuZTLxE4OQXs/PBag63s9lK4aAsdfDozAJOIbGdbvlBoffpdUEfUo6fNdpXKzB1gJP/trmA/7XMCQLFh4akX0koorQ4LWqbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDVty03f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27114C116C6;
	Sat, 29 Nov 2025 15:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430212;
	bh=3TP7SNqp7tWdCwXEIzykODHN5BrAV73rkGehEawXc4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NDVty03fRNXdboV/4pft3+zqAvBaRf6WBukaCK5RL91sbZa7Oye/UGfHlSb9rEAHq
	 IsxdZL+ocm+VCg5sMZZtY4XKAkGnMGIA3ucqHExC7trvX7mDxj0ya/CH59p5YwXrfq
	 LyQxsR92MxiETHXi/ecMaDRCytfRBiPrxLypVV3BDd6QkSUuDs6TPVA7zE8t5WsTG/
	 QpgVXcmVNEMMs14ndjgKmoE3GMfTc8a7x1st8DeP9wBudJl5fZ8tfgg7KyBcXtMP01
	 tf3nk8Df4zFJ3lAn/v9covIMdNroQsjyzaalzw+VMvihk0+IW0+fkrEi6/aMFnIZHQ
	 ex8CZPzI2C85w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 29 Nov 2025 16:29:11 +0100
Subject: [PATCH 6/7] iplink_can: add CAN XL's "tms" option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-canxl-netlink-v1-6-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
In-Reply-To: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=3TP7SNqp7tWdCwXEIzykODHN5BrAV73rkGehEawXc4E=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnagol5VfOjf3rzfONkzut6Z8BdO3H9zdhFac6GoQJvh
 H9UzejpKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJFNhxkZVtjM/B68kHGLzdZp
 E7nUgu67Rp3sPvR+Okd+tvnOB9sYjBn+iqp1G07vubT/QeHDk88YhPXt92zfmlyvMkfEI6fM8PM
 3FgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This is the iproute2 counterpart of Linux kernel's commit 233134af2086
("can: netlink: add CAN_CTRLMODE_XL_TMS flag").

The Transceiver Mode Switching (TMS) indicates whether the CAN XL
controller shall use the PWM or NRZ encoding during the data phase.

The term "transceiver mode switching" is used in both ISO 11898-1 and CiA
612-2 (although only the latter one uses the abbreviation TMS). We adopt
the same naming convention here for consistency.

Add the "tms" option to iplink_can which controls the CAN_CTRLMODE_XL_TMS
flag of the CAN netlink interface.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 24f59aad..3e7925e8 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -49,6 +49,7 @@ static void print_usage(FILE *f)
 		"\t[ restricted { on | off } ]\n"
 		"\t[ xl { on | off } ]\n"
 		"\t[ xtdc-mode { auto | manual | off } ]\n"
+		"\t[ tms { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -127,6 +128,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
 	print_flag(t, &flags, CAN_CTRLMODE_XL, "XL");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_AUTO, "XL-TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_XL_TDC_MANUAL, "XL-TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_XL_TMS, "XL-TMS");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
@@ -333,6 +335,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("\"xtdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "tms") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("tms", *argv, &cm, CAN_CTRLMODE_XL_TMS);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 

-- 
2.51.2


