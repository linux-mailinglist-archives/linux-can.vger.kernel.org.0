Return-Path: <linux-can+bounces-1942-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFB9C33BE
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A422B20AB0
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BF85956;
	Sun, 10 Nov 2024 16:04:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775784D29
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254678; cv=none; b=ZJL2NGMiDHVfqMrKBGIoMy/6sGAl/RUKORMU/WFmD1bzOJGbEV4RCOqW1+kQqURYWW0jtkI4i9lltYzW2x/rWsRYCw9Vpxrgf7SFJyVOXFLKaKx0GjN8ieghOG1XXlgBJSVC/SvW+SL6wgwyu2DwkEevDDcMoZlJcSgXCgQbtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254678; c=relaxed/simple;
	bh=7FnXsvqFfzuc6K+DFA83C4AxAjQf4VGEe9KqZWRm+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXiHaL9h0GJC3wjz4J4XUvKMSRFHymu/8acAfo2IJROnyzMBcVF5s1Yhw+dLl44X9MgW1v/RCf8rrsVJvcjEv0rR1bSCc8LgGicI+2/JH4dC051FZfGpAwpO3OCHTH/Pq+TxVHX7YUniRCFwpqkRRxW4U/2L1aRe6LotzAAPPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so2962629b3a.1
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254675; x=1731859475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ladKTuk532Z1shnZimW9LswzJAbuJNJ+7xuSU6/sH3s=;
        b=l+KDTiDZLi6NtMB3pdoMxT6az9pituLZdGqxMrtweeXyKzPfT049TkN+71sF2QpfNW
         KFgBYqMzwVOpCefQhYtnvju4Kv57Y2EjgcZnlgnuUX4R+P9wFI0kVi+X6kkpv6MnFpur
         8w0Qkb4gXTyb18t7AvylgsRN7Gc47nfcAP9/BbFuk+lHJioh9URow7mKvzk7xwmD3DPO
         1RitrH2hQHgze5YAADEIPEvL7jo/yPpTRC8wECOsVaGXmveyuUfrKtYUFWvdqf1d0of4
         R9jAZ/I5ku+5jfxeWcNaWWV6W0FWTir5Zwcp0DgHyneZtsJ9MFguXzCLSgT80bUVV0WR
         ilzg==
X-Gm-Message-State: AOJu0YwBKMbbKGuMuDElyGGa2iD5acJBNKx5SVzeu3w5O2buDYRloX25
	bLE7nyLBgc15ENJtYTabEYkAWwv1y7Gl5eskgGJgCEVRFn6+wql7Wikqmw==
X-Google-Smtp-Source: AGHT+IGB0hK3E7TBrkjxJ3nXuKqMa5+h0y3Ug0GNJYyk6pP9/NYwhR9pZ76bISa0QaSPBFxG+9MNDQ==
X-Received: by 2002:a05:6a00:3286:b0:720:36c5:b548 with SMTP id d2e1a72fcca58-72413359a4cmr12804512b3a.16.1731254674831;
        Sun, 10 Nov 2024 08:04:34 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:34 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 6/8] iplink_can: add struct can_tdc
Date: Mon, 11 Nov 2024 01:01:36 +0900
Message-ID: <20241110160406.73584-16-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=7FnXsvqFfzuc6K+DFA83C4AxAjQf4VGEe9KqZWRm+2g=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNyuW1SSGasfcSf1foTOdTfuY3r3VO71Uwj+u5ViiF 7S/8+PGjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABPpfs7I8Ofhl68ljiqTXi06 VNyizHKIi9W4nT362xxuJv7DPmrTfjIy/KwS9/eWK1526KvswW3vPMtKJP9cmPGL3+9S+5qPurb C3AA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Add the struct can_tdc to group the tdcv, tdco and tdvf variables
together. This refactor is a preparation for the introduction of CAN
XL.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 928d5d79..f7faaf14 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -123,12 +123,18 @@ static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
 	close_json_array(t, "> ");
 }
 
+struct can_tdc {
+	__u32 tdcv;
+	__u32 tdco;
+	__u32 tdcf;
+};
+
 static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			 struct nlmsghdr *n)
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


