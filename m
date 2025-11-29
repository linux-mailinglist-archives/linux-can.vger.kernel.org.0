Return-Path: <linux-can+bounces-5778-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AADC940EB
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F06E3A6FA3
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590E30FC29;
	Sat, 29 Nov 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQgKqAZa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E941F4CBC;
	Sat, 29 Nov 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430204; cv=none; b=NwlEsqgDWaKoanC407AuezxoLWi9hwQBiaFJBYiwqDcdOodLXhJp7/TMduOIA7ZwqVXxfSk5X0Bqlo+VdVyseIXDhSV453eljmSH7TkZDos+ufF7p4x6Kk5ZtxqSceTJbW51urezN3O+hUuhBX+Ns3UJJu/EJVeVMnsJlWc/6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430204; c=relaxed/simple;
	bh=VmlCwOmbLraO0q+f17W68Vp2cULBJAlHJpKgkRtYdJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZeRYAiIXvVLusie7nYYfOKKjkTDD0yDjcT66HCelxS/dxiDhvyvI981DL0Qxhp7AxDdUCJYduylRMhJ3+dhWN8o7hls0kRn8/JRDgT7u/YHlJUDJ7KRqZ8Ff6kG7JrjCRX48R6qmLkXrpSjcg3f9lKPYRWtBA6zvS5heULtC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQgKqAZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCD7C4CEF7;
	Sat, 29 Nov 2025 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430204;
	bh=VmlCwOmbLraO0q+f17W68Vp2cULBJAlHJpKgkRtYdJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mQgKqAZaO51fJ/ACj+Zu91dgBNna/1z918W36PRNM8CRxcwwCRsP8H1GTz9rqH/v2
	 EzLRsc7gGRvYnoVr1BQDmz2yfEaB51fxqDzgV6bBorTomtGbm0oX59r93+SbFOfi8d
	 UOsZT245ML+qww6k8lPIRvI6BTZBeF6azpkJWGnStxaJNw3/weVcqAI/skTefAirjl
	 cEUbChw83QZYV8k9AIHNtyGAp9yb/g6i32Ms3t3FyvyahYLhaEQ1UtmapE4eJMR5Ad
	 FsNtmjRZJYJB7dRy3Cr+8VD9IITypX+nJMO60H9xS+eG8vF8gHzlwFbP9xgvZSX3PO
	 gytT98xvsgm8A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 29 Nov 2025 16:29:09 +0100
Subject: [PATCH 4/7] iplink_can: add the "restricted" option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-canxl-netlink-v1-4-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
In-Reply-To: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=VmlCwOmbLraO0q+f17W68Vp2cULBJAlHJpKgkRtYdJw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnagtGHdz49HVb74N/C1g7PN73tTB63prN6ezlYqMz41
 8D4SLO8o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQWFDL8ZHxzI6YqmtPR+9jT
 zNIDNT3f7M4a98geqqj7cjyB4eq9VEaGxvdd5wyFIj4dMRdTOrbldr/XEaOj+96Y3WDZ3bT6jkg
 gLwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This is the iproute2 counterpart of Linux kernel's commit 60f511f443e5
("can: netlink: add CAN_CTRLMODE_RESTRICTED").

ISO 11898-1:2024 adds a new restricted operation mode. This mode is added
as a mandatory feature for nodes which support CAN XL and is retrofitted as
optional for legacy nodes (i.e. the ones which only support Classical CAN
and CAN FD).

The restricted operation mode is nearly the same as the listen only mode:
the node can not send data frames or remote frames and can not send
dominant bits if an error occurs. The only exception is that the node shall
still send the acknowledgment bit.

Add the "restricted" option to iplink_can which controls the
CAN_CTRLMODE_RESTRICTED flag of the netlink interface.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index a2f59764..aeae6185 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -42,6 +42,7 @@ static void print_usage(FILE *f)
 		"\t[ presume-ack { on | off } ]\n"
 		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\t[ tdc-mode { auto | manual | off } ]\n"
+		"\t[ restricted { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -116,6 +117,7 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char *key)
 	print_flag(t, &flags, CAN_CTRLMODE_CC_LEN8_DLC, "CC-LEN8-DLC");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_AUTO, "TDC-AUTO");
 	print_flag(t, &flags, CAN_CTRLMODE_TDC_MANUAL, "TDC-MANUAL");
+	print_flag(t, &flags, CAN_CTRLMODE_RESTRICTED, "RESTRICTED");
 
 	if (flags)
 		print_hex(t, NULL, "%x", flags);
@@ -257,6 +259,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
 			}
+		} else if (matches(*argv, "restricted") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("restricted", *argv, &cm, CAN_CTRLMODE_RESTRICTED);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 

-- 
2.51.2


