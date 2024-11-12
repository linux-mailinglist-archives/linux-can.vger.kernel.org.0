Return-Path: <linux-can+bounces-2005-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2C9C5EF6
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 18:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BE5281D41
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6C2170D4;
	Tue, 12 Nov 2024 17:28:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D3216A21;
	Tue, 12 Nov 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432512; cv=none; b=HNIBqj0dHuljXpWlg/9tbjoWMIK1WhCY01fHoFxHa2vO116u5YiJZxoVcWtWB1IRkOOnJG//v9Vu7f6ChMj7on7ClWcGbDkF+ZDSFF79V3GFRcz110jjsuysdGBkMlPmFD/KKl95Hul7Ye1qgezxP1eo1/DooQSq8/GI4K1CEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432512; c=relaxed/simple;
	bh=VRj8ayRFTUjZHnQUKvEZevbO2uAVhkR+BhHZIaXxWGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfyH6R7bqyAeq4tHn3Tp4fmYZHZqpn3qi6P6ha1Lx0d+fRRM/waDCpNXC7TeIZdeSUyeLp1LmrGB/72Mf5gIEZ4+VSmde5kUa26HIEzQ32lQkNVtxm5M0rskV8gbzdMi7KenuSjU3FY6/ox5rx4vKjJnqlvFfpIIjT7keFePhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7240fa50694so4575259b3a.1;
        Tue, 12 Nov 2024 09:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432510; x=1732037310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC8D1Pz8tMytQDN68Bru7WV7nL9afanIdOXjzLOpnm0=;
        b=VZlyFclUOYRRxikf2lGqgPlawNmzjqxJRXUpVWenqGq3zN7ub8R5nDNjiTo1ORNtrA
         Qi+WFUrcwCVxuf8gUW9DJ/Njc331jnI5ANmpqSLMN+fxwTP6vCryy05KVaFEXDxGVuWK
         XOY53mY8b3T+HYdOxc651BcGGvaoxl9MximmXNheYKXlhNTdeUn6Khsku71W32wkRKMT
         D9rm4DqJHk4cafAZ1ZNu2r45+0O79fXDNe1EecWva1qsKSoAd5v4RJH2mCY7uuUNouy5
         W62T0l5O4xECQDfgxYIiMM0g770rS5q2P/caGCtmKO4ml2VLiUGXdlhumgtHAHyJCroK
         Jtbg==
X-Forwarded-Encrypted: i=1; AJvYcCV61MhrUXkdSq58BGM22tWKr2X2PMtnLZHGsmploXrXxhyvIO5iAXRNJ2cqzzpi8HFRuXFG2tqpvUA=@vger.kernel.org, AJvYcCVKtC+Y7lCoq9o7hxtXly12sa9L05bRcd0dpu9bNcxoxHDoPfN9pGVsW0l1+KcT2szNnCuI1+3xRgQEFv3f@vger.kernel.org
X-Gm-Message-State: AOJu0YxCInzBkms6prMGORFRhZfXLsZ4P6qQXxLtxARusNn9ZHGCJkow
	ssm+KWBi/COCymwyQGMh0w0uwdnik7xUJ9MR+ra89YGTT/C/GEmD0g0E9uqy
X-Google-Smtp-Source: AGHT+IG6fIF2mOiBWqz0HhnMM5UtyJ15ZpNQPcWVg8qCiW/FxVaJ2W22x6AKPTqspZM7rBl4VgEqwg==
X-Received: by 2002:a05:6a00:1399:b0:71e:6743:7599 with SMTP id d2e1a72fcca58-7241329f565mr23747475b3a.7.1731432509872;
        Tue, 12 Nov 2024 09:28:29 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:29 -0800 (PST)
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
Subject: [PATCH iproute2-next v1 4/6] iplink_can: use invarg() instead of fprintf()
Date: Wed, 13 Nov 2024 02:27:54 +0900
Message-ID: <20241112172812.590665-12-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=VRj8ayRFTUjZHnQUKvEZevbO2uAVhkR+BhHZIaXxWGc=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3QvT2kqenx7/nGVjjnxlt/kzV18tEs1G9inKc/6O e323Z8BHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACay1I/hv1OM4Lyw213zSv7Z VRxvs436uPJmKOttH3Wb4I1Rd5wVhBkZHmioyfxKb+q/fGV3kPiazpOlJ2+7//5Vo+72g+0dn/V HPgA=
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


