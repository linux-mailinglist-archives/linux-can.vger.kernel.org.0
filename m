Return-Path: <linux-can+bounces-5801-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A3C9976B
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D05A3465AE
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11082BE642;
	Mon,  1 Dec 2025 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M95tZye8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B482BE620;
	Mon,  1 Dec 2025 22:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629798; cv=none; b=CqXVcbd4+nzibPkrbOLy+AlCuEqgpc0b052YZ8e0XZ57nhmSjFDW/n1brRBIeBvicUbD2BHsxg7JOKSXwSlosF7PN968tNvNZT2d3AGtHeejzGmF2L5Z/jZYvvgOh9rmHE+5CCLszlnUVWk3YDnB6Z57hQIoUN0PSw+/jo5uUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629798; c=relaxed/simple;
	bh=QYZzNQBvCFLI2EZ4rvf8uqgFG68QjGj40iNCH+8qleg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ge51qykoCVvazJMUA9qZ4WtT4SGw9Q/sBUtFaodyb3J58in2H8ZE6PoqCFxNtv+njtveIWBypmv3IfqRzNex61mDzr6/HDh31K6v7/LMwQIpGsMdVBR7VfGC1iMBkOmhlebkbd13ae8STPji5pl+Ku0e4EOlrzk3cUqYNKZVYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M95tZye8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D821DC4CEF1;
	Mon,  1 Dec 2025 22:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629798;
	bh=QYZzNQBvCFLI2EZ4rvf8uqgFG68QjGj40iNCH+8qleg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M95tZye80aXIxis+r6xfNK1/IyInnpLTHgHPyfdiiA1cy4tWltIVKyCgDdGrBwXKI
	 3wGX0FJNt3G72MZsqsLyU6lyMzggs/QXB9k+Hqg5nz91LAqb/7d1cDL/T5pPQ6e8U5
	 c1wa5q1FG99yjc1TyWVWcSYxBTAE0zjiqV4j/XAyZc/+3AiZYYnSveYK1r3htOop58
	 tcWYxUp5qmpfAvVjCAe3ZmoH3vaIB3MTSR3V7LjjOQ+wo4FxJRxodnAXXqDkzphPLP
	 +Ii8yisyYCwA0NZkLhEtYXxGE6E41QRD6Dk8xv8pCstYZYY9MN/29kwVjfTeb1wGmK
	 W7Z+wqeEAf8RA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 01 Dec 2025 23:55:12 +0100
Subject: [PATCH iproute2-next v2 4/7] iplink_can: add the "restricted"
 option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-canxl-netlink-v2-4-dadfac811872@kernel.org>
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
In-Reply-To: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=QYZzNQBvCFLI2EZ4rvf8uqgFG68QjGj40iNCH+8qleg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJl6shwuVx56bN5fzLT8QvKE3UUn0i+VfnGptuipPzpr+
 w3XbXP2dZSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjIjliG/z7pnpc+SLEddVyj
 GnDHrSDK5KZq7d/sqOk5k/+du+gd94fhN9vHfQxuH3dOZq+bEsPw12Wm6yenuOYtcybteB90+dL
 eM9wA
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
Changelog:

v1 -> v2:

  - s/matches/strcmp/g in can_parse_opt()
---
 ip/iplink_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index d5abc43a..0ba86550 100644
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
+		} else if (strcmp(*argv, "restricted") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("restricted", *argv, &cm, CAN_CTRLMODE_RESTRICTED);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 

-- 
2.51.2


