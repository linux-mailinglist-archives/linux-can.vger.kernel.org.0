Return-Path: <linux-can+bounces-2003-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1D99C60FE
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4213B624F9
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8377D2144C4;
	Tue, 12 Nov 2024 17:28:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDB21500F;
	Tue, 12 Nov 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432507; cv=none; b=XLMyaAlySepdSNWZBDphnN0t3kGH7N2h2ldG1zN/JqinO7qL9079wsCxILsQFTwaG8h2N1bFVrM/vBJixlfxH7H0BhoM130PdJMbdqc5NAjQaChWPvPi5MlgV5Iy961rj64AKsS2Jthi/DVDCD6/jRxcGHztTeYZIelLkNA6ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432507; c=relaxed/simple;
	bh=p2ZJs9LEo4UC1JUgCX9uDAJ3fbxuZzju2aIA1KDx55g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h35X4quCkOflhP8FiZMfxWWN6jZZojS8J6d2Up8m93AhUWGBK2EY/wmlEN+ysSkjLw8oxFROpIYXJYjOpuKELcjuT8zOdU7CwrE/8LV5aNDPYDepoFnGtSyHXkTosvFPbchgTgT9Xdh9yqdweaduGxC+oSSqxFKLflykeSOktGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so4448788a12.1;
        Tue, 12 Nov 2024 09:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432505; x=1732037305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHzuB2QQz9MeIpBdKnCySArAOpMo77+xEhghKdzSO1Y=;
        b=PCqVCZ/LIfKm7ox0hHj93myUpiELP26xcgByqbHB33hfqPVzTyRYsFMvZ3rnb7uBBi
         bc1+okII7lHxBWHkbG+RtltlvpFEyq++h9p2cxshryWDWdFWTydnJOOR6O7sXXivnIoo
         ynLSPQ9UILBzrXdKYN1tfZbjisL5kcFmDcbtam/WjmqyLH5w5bOWzL5LhY4sHta2+5l6
         BwILuyKlRbqj9TTQPAQHedaOAAJb26DDPYe02lclgFj/82wzCfK6s2t4m3Mv0yJGcDzz
         2sZtJTuUjSW3/OnjMmh17PcJ4/n+am1zIkfNrwJnkNW42UIzs8ZG0HbYZeSqyBBkQwPv
         no1g==
X-Forwarded-Encrypted: i=1; AJvYcCUSTDRYbw8FU/ZYL1U57T43Ce3bgjJ4ruXlgbqUtJgpvEmydrZuGuPgHnCQYTUmwrSIaN8bZofhHQrW7g9Q@vger.kernel.org, AJvYcCWtVzxSSpAo2xWmltQjkvDnEkmpvCH+NzzMoypwrnONcdcAeNG/9BESJmvp5bIZvbUiL84yj/Hy4e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIc29ae7Y/Sh3a5x/q7UVpSsZlHi4iEbjrgV+B5QA8gB4pBGb
	CiXc6mf7g0/JBq3tagAiH5o0cve5xrF2Ulq9dN6QIB6Fkha5C8S2IPwavMdS
X-Google-Smtp-Source: AGHT+IGnvo5ho6OokHcy0r/KhEHzroMBM2h/2L08BzuMHZPPpP37gXPXQn52T02MeQ/6LbQ682LMVA==
X-Received: by 2002:a05:6a20:7492:b0:1d9:a62a:b8d4 with SMTP id adf61e73a8af0-1dc22a60b8amr26843388637.27.1731432504688;
        Tue, 12 Nov 2024 09:28:24 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864f78sm11481439b3a.33.2024.11.12.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:28:24 -0800 (PST)
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
Subject: [PATCH iproute2-next v1 2/6] iplink_can: reduce the visibility of tdc in can_parse_opt()
Date: Wed, 13 Nov 2024 02:27:52 +0900
Message-ID: <20241112172812.590665-10-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
References: <20241112172812.590665-8-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=p2ZJs9LEo4UC1JUgCX9uDAJ3fbxuZzju2aIA1KDx55g=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGE3SyeL73ivssrD45W6Th7I5dCeZrp2mcKnER1Eh83 rH+3BXFjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABO5s5+R4dSZP1McHaebBzub X72+drYnUzyrqsSL67u3N3jXXlyiJcfwzyJm/oovIV0PD/QIsomK7P10/UWrtb/cFkU73tWf34c wcwIA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

tdc is only used in a single if block. Move its declaration to the top
of the compound statement where it is used.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 01d977fa..3414d6c3 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -128,7 +128,6 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 {
 	struct can_bittiming bt = {}, dbt = {};
 	struct can_ctrlmode cm = { 0 };
-	struct rtattr *tdc;
 	__u32 tdcv = -1, tdco = -1, tdcf = -1;
 
 	while (argc > 0) {
@@ -298,7 +297,9 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 		addattr_l(n, 1024, IFLA_CAN_CTRLMODE, &cm, sizeof(cm));
 
 	if (tdcv != -1 || tdco != -1 || tdcf != -1) {
-		tdc = addattr_nest(n, 1024, IFLA_CAN_TDC | NLA_F_NESTED);
+		struct rtattr *tdc = addattr_nest(n, 1024,
+						  IFLA_CAN_TDC | NLA_F_NESTED);
+
 		if (tdcv != -1)
 			addattr32(n, 1024, IFLA_CAN_TDC_TDCV, tdcv);
 		if (tdco != -1)
-- 
2.45.2


