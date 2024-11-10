Return-Path: <linux-can+bounces-1941-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4687B9C33BC
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788991C2029F
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE75588E;
	Sun, 10 Nov 2024 16:04:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B984D34
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254675; cv=none; b=iuCENo+SLvBU/KJ84p6HUpbw3OzC1gNbalrMjWFFXZ6PLPyDhxq/EjQPJNNtkwRU4mpAZH+P/A6WaXGg6DO/zM3qPB2l6c7cKFdyz2QX9/TgKqpD6u6joCVXtY4Y+rur/JHhKSOCllLr/uJskwG266c3W/NxQOkUF7P3U8KDoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254675; c=relaxed/simple;
	bh=VRj8ayRFTUjZHnQUKvEZevbO2uAVhkR+BhHZIaXxWGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaCmuo6Tz4Q0Z1BxDKqccPUo7INjYJr0zAb+0ICvDfuvmGBu0oHRFFcLCI8q8RCtzPBhLCuL4JfWHc4gWHXfRnsoltsZ8QLnj5Vh97GK/c032XN4y/2SgS+NyjIKb3vVZaGZ1YR2GtcAljQqxoDxOY4cHgEZuUuJUGVsS1p5/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso3011015b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254673; x=1731859473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC8D1Pz8tMytQDN68Bru7WV7nL9afanIdOXjzLOpnm0=;
        b=eDMQjMcOcE0GdUOqRpxZvwSilNv081N9uMG+BKMXel9pmq+B8mhQPLjoZGZANyW8KT
         XRKcrhj7Kr3WP1Mgm6fpyK7BxT83RqNyscQBBwy2fm4a6wCEM91YcW51W6mIjvf3NAty
         JpFYZoTrbvT3a/7r1iR9ToSwWyN2Psgdn1myd2Qw4GU5BXI9pfflruoKGG1u1+pF/AE6
         h9munPW5oL6txr60X8iBC+PC2lwlXYFPDyc2pP5sfYOD772EiPYMwV43WZf70aY+e4YB
         LPCacLs4GRd1WX3dXPaae9zH+gih1G1VcB97+0cluHMiG+w/avtJQrQ5Gk+z2KVYRWW9
         3iEQ==
X-Gm-Message-State: AOJu0YxBNL10q9kFTRapmbjJibo8gpPZuXa2+G+n6do+gJj62Pvr6VQn
	XqO+Lmryl1jiVe/652wtN0/+YepVMPpw0GAfF1ByHywpiFcsh1IS+I9n7g==
X-Google-Smtp-Source: AGHT+IGf2SRs3PMUl7SO0j8R6eLgG2e9yALAPKl7TyqGGZEgIofitdoo/lswBAD8B+7bZz+ML0jICQ==
X-Received: by 2002:a05:6a20:7350:b0:1db:f823:109f with SMTP id adf61e73a8af0-1dc22b00f32mr14605123637.31.1731254672914;
        Sun, 10 Nov 2024 08:04:32 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:32 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 5/8] iplink_can: use invarg() instead of fprintf()
Date: Mon, 11 Nov 2024 01:01:35 +0900
Message-ID: <20241110160406.73584-15-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=VRj8ayRFTUjZHnQUKvEZevbO2uAVhkR+BhHZIaXxWGc=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN8svT2kqenx7/nGVjjnxlt/kzV18tEs1G9inKc/6O e323Z8BHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACaSupuRof3Hs+gS0dtT3nzS v8dSLsfYcPKjRK7nklVLpkSzlS2W28nw30n+zu453Ty5vr91g390H+7e9M8ofMlWL8/ST9o7tp1 +wAAA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

invarg() is specifically designed to print error messages when an
invalid argument is provided. Replace the generic fprintf() by
invarg() in can_parse_opt().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 6c6fcf61..928d5d79 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -254,10 +254,8 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				cm.mask |= CAN_CTRLMODE_TDC_AUTO |
 					   CAN_CTRLMODE_TDC_MANUAL;
 			} else {
-				fprintf(stderr,
-					"Error: argument of \"tdc-mode\" must be \"auto\", \"manual\" or \"off\", not \"%s\"\n",
+				invarg("\"tdc-mode\" must be either of \"auto\", \"manual\" or \"off\"",
 					*argv);
-				exit (-1);
 			}
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
-- 
2.45.2


