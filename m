Return-Path: <linux-can+bounces-5814-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A51C8CA101A
	for <lists+linux-can@lfdr.de>; Wed, 03 Dec 2025 19:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19BB5300215D
	for <lists+linux-can@lfdr.de>; Wed,  3 Dec 2025 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0032D7D3;
	Wed,  3 Dec 2025 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehUAoF0o"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3131D38F;
	Wed,  3 Dec 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786366; cv=none; b=Tr5khLvcaZVVI0xTFROGDfYmTl82fX6Ch8Ky4hWwhVv9kK6FfK4Bq0AsXatUd93zUcwlueYrrOtUkFzOjUEGbmTZhz0vTEZvFRgybXi+iYY6BxRH/7DxG1BRXqelO5/BMmeHOFvAriOArwQWI9oybbrt/Ijd/dMuDSt772C3kX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786366; c=relaxed/simple;
	bh=QYZzNQBvCFLI2EZ4rvf8uqgFG68QjGj40iNCH+8qleg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNZRA7jWPJYIdD8pizUTfjMtFtW1GrDnxw8en/2eDphXpRhtyhFScXHKIVTLiDLvre5EhCGamC9TKJFrh0s7ovQbsIpNIDRGE5A//alrZMvHzsqHfQ2UdE37SjnyPS0NROhhb/vdTnUV7MTCxXguw1Znu7uivU/rogMtsZqdUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehUAoF0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F1DC4CEF5;
	Wed,  3 Dec 2025 18:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764786365;
	bh=QYZzNQBvCFLI2EZ4rvf8uqgFG68QjGj40iNCH+8qleg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ehUAoF0oGLfjbAk6YnpfYK/V7DsUNJpb4MImWznqrlDUVQVy7kzTpNG4zzXpJcgW1
	 rP6+F2srhdNv9ELZtWzDpUwS90mn8fCOxtlP8DYslpvhxPND4E/8vfrFc4XQwHkwKl
	 jCV1a4whkF5O1VZ74a2w8lnoL8lhnWQopSBJD1qNsi7c3pXLUPnZiwVfs8dnVW+fhy
	 snIJyEQveW8dzSsu0eKSTKpCM/+MZ1cwqejNUrNpdn5OaVOefNCGFu3GrnpvMe2ytu
	 SL533dfgeJ7r5LG7VNFDhLTLKNXikQmPhQYgQhyND8LIfpsE6sHgSxSsTqPPRFGKJw
	 73daiYEx36LUg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Dec 2025 19:24:31 +0100
Subject: [PATCH iproute2-next v3 4/7] iplink_can: add RESTRICTED operation
 mode support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-canxl-netlink-v3-4-999f38fae8c2@kernel.org>
References: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
In-Reply-To: <20251203-canxl-netlink-v3-0-999f38fae8c2@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkGDYvcWv9djn5hJtAYlMuU2TKH59h5NqVdKum39j13k
 /t5u2FzRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInUxTD8D+GvzLV4+UV/9Zkd
 H2Y5fTPg+mU2dbFrw/YPC2cuWnM5bT8jw+dwvhmM8nmaXxQanitp/rdI4njuJeny5tCsiP0ii36
 LcgAA
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


