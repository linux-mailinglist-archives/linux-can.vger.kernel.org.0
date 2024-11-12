Return-Path: <linux-can+bounces-2006-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1139C5EF9
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD9E284467
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726B21766C;
	Tue, 12 Nov 2024 17:28:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557E21764E;
	Tue, 12 Nov 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432514; cv=none; b=aovoQN/8nF8f5apx2CKFXg3S8mPOhbPfncIAhm6D9qucB/smBZhqXAdKDcjyzYPyzANMLzwo1W9dyK3ACCzGMS1fFCGdp5jsuwbd4QzIK6GRwbzEJSKKy/BQsUau4DDZolIR6clK/byIuSX65hGrrngYbGD75msdnVCEgrgS1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432514; c=relaxed/simple;
	bh=l+6NUzOXYhXtEryxl5pt51gE9c/WX6SBeH0CzzxTXNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFQsofPZFsf5eciRMXG7qIZI48vbE8xjbnATHJ1SHGZgphKOhwULWpxcV61tlUebJ5Ay+roIs/XZGROs77i0JIA5qT60C4y+ImYvBJJCf7La4byUevS8mwk5ptYf332wM/1tRau0HlsgaHifshVNbMfqVJxp3p72bowvvuzVu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e625b00bcso4852266b3a.3;
        Tue, 12 Nov 2024 09:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432512; x=1732037312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+lY6YW9eHHlxzUfS6J7/cug/odMVhqea2GaG9YKUyA=;
        b=cdmLoXho1irdUwN0izN2xzJhfpaC2OnywVLqZ7A5c/yczxg09LIn9i4dgGT1HVX8vQ
         6hdyU4IvzYGA0kdhrzmxe60/j3Th2EnsH8rrMmoCpS3Z/Nomc0PvDd11FHVDxYfRKmml
         +g8I6e7L8z22mghfiFN0L9NluUJ/FNOn8/XPcH1p4E8QJsGx9frKLSsgd6CxQXJ9Gao6
         3KAcF1vhcr8U5QdN7a9czApMUiD/BEJmjWiFdOTts2xleTvz/ZfBjuRg/pKzLWug5jYv
         sCo/6Zup7NR1kG26A1iQQsMoX0dWbwoe2ZwAnzYE7Q10wQwJLf8iDHeeWf1P6QL8uzF3
         UUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUboy/cYaJXJZ+/K9wQTboY6QtIQ21+6D3CC04BBAexFhsy1EykGlVBSlahOnfbZAm8B3qx0pShhJE=@vger.kernel.org, AJvYcCW/vXA5z9udUKzq8W2/+Vmy+M3BtSyYPgpasnsx91PC6szXMSEh8iVJ3z3Un1ok3w5N15m+b2Fd8I7/cR80@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JTvQPe4MyiCyrL1xlUnUKxKrMlgOUG5VP2ZipKAfQ5gDTvx1
	l3iTzJlqy2VZQTveQDdfmpx/oSK/YhXtQKLS4o0zp6Kz0/rKqnkVx35HAfDo
X-Google-Smtp-Source: AGHT+IEoaGNUn7E6rHbBCgKGntSxBnx2XYOaiuFqW3EEuI0mNxeIukhYSG9NjXjwgkAOeBvID84bIQ==
X-Received: by 2002:a05:6a00:4fd0:b0:71e:4c01:b3da with SMTP id d2e1a72fcca58-724132618c6mr21601770b3a.5.1731432512419;
        Tue, 12 Nov 2024 09:28:32 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:32 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH iproute2-next v1 5/6] iplink_can: add struct can_tdc
Date: Wed, 13 Nov 2024 02:27:55 +0900
Message-ID: <20241112172812.590665-13-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=l+6NUzOXYhXtEryxl5pt51gE9c/WX6SBeH0CzzxTXNU=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3TLxRRuKd76466ZPaWmUVT0jK/mCdavGv4T7ObpZ HwMz/HqKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJGjqYwM/T8/n196Y/a2J85v 0ybyp+828pxbcuWw95TyNc6NjkVSuxgZOqytJobsUNZZXM4i8Ouxy+6Nxne3/WirjblRcMLsqhc 3NwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Add the struct can_tdc to group the tdcv, tdco and tdvf variables
together. The structure is borrowed from linux/can/bittiming.h [1].

This refactor is a preparation for the introduction of CAN XL.

[1] https://elixir.bootlin.com/linux/v6.11/source/include/linux/can/bittiming.h#L78

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 928d5d79..325a4007 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -15,6 +15,12 @@
 #include "utils.h"
 #include "ip_common.h"
 
+struct can_tdc {
+	__u32 tdcv;
+	__u32 tdco;
+	__u32 tdcf;
+};
+
 static void print_usage(FILE *f)
 {
 	fprintf(f,
@@ -128,7 +134,7 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 {
 	struct can_bittiming bt = {}, dbt = {};
 	struct can_ctrlmode cm = { 0 };
-	__u32 tdcv = -1, tdco = -1, tdcf = -1;
+	struct can_tdc fd = { .tdcv = -1, .tdco = -1, .tdcf = -1 };
 
 	while (argc > 0) {
 		if (matches(*argv, "bitrate") == 0) {
@@ -196,15 +202,15 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("invalid \"dsjw\" value", *argv);
 		} else if (matches(*argv, "tdcv") == 0) {
 			NEXT_ARG();
-			if (get_u32(&tdcv, *argv, 0))
+			if (get_u32(&fd.tdcv, *argv, 0))
 				invarg("invalid \"tdcv\" value", *argv);
 		} else if (matches(*argv, "tdco") == 0) {
 			NEXT_ARG();
-			if (get_u32(&tdco, *argv, 0))
+			if (get_u32(&fd.tdco, *argv, 0))
 				invarg("invalid \"tdco\" value", *argv);
 		} else if (matches(*argv, "tdcf") == 0) {
 			NEXT_ARG();
-			if (get_u32(&tdcf, *argv, 0))
+			if (get_u32(&fd.tdcf, *argv, 0))
 				invarg("invalid \"tdcf\" value", *argv);
 		} else if (matches(*argv, "loopback") == 0) {
 			NEXT_ARG();
@@ -294,16 +300,16 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 	if (cm.mask)
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
-	if (tdcv != -1 || tdco != -1 || tdcf != -1) {
+	if (fd.tdcv != -1 || fd.tdco != -1 || fd.tdcf != -1) {
 		struct rtattr *tdc = addattr_nest(n, 1024,
 						  IFLA_CAN_TDC | NLA_F_NESTED);
 
-		if (tdcv != -1)
-			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, tdcv);
-		if (tdco != -1)
-			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, tdco);
-		if (tdcf != -1)
-			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, tdcf);
+		if (fd.tdcv != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, fd.tdcv);
+		if (fd.tdco != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCO, fd.tdco);
+		if (fd.tdcf != -1)
+			addattr32(n, 1024, IFLA_CAN_TDC_TDCF, fd.tdcf);
 		addattr_nest_end(n, tdc);
 	}
 
-- 
2.45.2


