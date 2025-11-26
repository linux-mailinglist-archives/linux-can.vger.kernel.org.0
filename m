Return-Path: <linux-can+bounces-5670-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB91DC88CA0
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 09:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB6C33455F6
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB431B10E;
	Wed, 26 Nov 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="F/c4oWPC"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF031C584
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147452; cv=none; b=Bf+VLMENG0mgP6/9Ys6Fv9Mcwo2HuTiP/NOrhJ0//PLk1gwugzOTY7Dl9zGuPxuj3/ibl37Z5vQKxGi18/nAFSW9xKYxBdvVwvMX1kdtqsGYnQ8AfuepZI2Sgaq4yoscBuzBIFkRs/Mhyl6e0XEBQomeOmbY9fstBtIo1IVRb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147452; c=relaxed/simple;
	bh=R06W+thWG4PUh9RpwiJNVqt3xWqIpJdtMoUwNagYTwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FfhQypY7EzX51r/p/YOhIB+iJeniGAEvid24v+dpFHe3DKwo+C5jevPcelskn7wtJ8H5cYbJaiBVrE0H2iZwF/Vv1+XUw0DhUUMy8+MnI/fn/G/HH/fXawzOYRsa9/ztrUSHdMHUT0HjZkFrDrqQH45eJPUBVF4Q+0IYrHtOIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=F/c4oWPC; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297e982506fso90606245ad.2
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 00:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764147450; x=1764752250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayYGT2wjXVviNIIw08APqOoUIe5IIlHXHG2yMmRJMdA=;
        b=F/c4oWPC0jKVz19SCB48xaX+RG67NZD5ZNN0QlnA5uvpl6C5kPGNnnbSfIS9xzv2R6
         H8805MDnGN7tMnLrnvPE1ZU9eMaYzn+Dy6LND72Sr2hEuW2upQj9F2qBd/NIS1xyM+EV
         AJoBp6kCveqMT7ZkHTAzc4VDVbzGaN0mKO6oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147450; x=1764752250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayYGT2wjXVviNIIw08APqOoUIe5IIlHXHG2yMmRJMdA=;
        b=DZb0ARMa75b4a+NwQFQIIKJIafaMSTjpu8/p6bKCCjCMB/27fb4qYTbtl1nLoi1MCF
         ojaWbnedNT373baOUewO6GtAvrMSvN+uei4XY7HgYSNKj9AqbqlP4s4Wh4/M19/DM+ES
         cqZLujft35rCrRDVwH5htMhzyyOH2ImAN9RKzWXKVPtbm90sDDqF70h+96DiGbmfdVVT
         0XRaqGS71aIwKQkxv0mSTCBAmSOJu140xCx40lJvEo+Yljs1jgBwsu9XxuRs6g5HyA8k
         ztxUv+Xfpd6ecMA5ZdRP3GxvzTuQ5sf20aGj5nkGsc470A5SBYdwJKeHRG+DAQHrKeqq
         6EwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7AwiZLFS7bToUAkIv18PSrplJvdqflnDP1JNuRxm9q7X1n6KLTWdTyg+wzTsvSnmoxhLsLzsFjwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QwrEr0dau4i/GRPhO3RsH/Rn3Iamre88yxjBz00Cfazp/hv9
	2QkvhPwe5wNoaYFlQI09fhKNjt/yoJHsHPOJ+qiAeBGsjTlOfFyVB1wO5wTJOBRSgL7ZHOeIdam
	h73qE3RF9LBJK2Rg=
X-Gm-Gg: ASbGncugyFXzwJulDAES4mmjnAaI/OW5Aetr99Sz+o7ktaN26uQ2oWgkTMM0sFcM5yX
	c7Q8iEeKPH2m+U9mn2/Yv+cpKB4pWg2bldmC0IS2W2idLM0k4PLiZR/QAIUXQtgVX1E/AMX3WQE
	CoCSnuEkMA8/fx3zjFuBa9omdFojnIrjD4MHJDSKYb5JR/c7V0bQOgNBEwZ7qsb0zuBGsyRfjsx
	4diyGzhuQbFavtCWiKu204dvoIaRsRamEcHgXkM2dEDn8ktineJDhdd8Bh6KMlWFERImWy4Bb07
	vE4C4MSDOqbqMnzV2sB427HYCAc4HUV6t//M4vc5fJAMmzu9HjRHG+rzi6w7AB9cs93OgSq5D5Y
	bsERZ0SGdm7ajgq4v2dhaWijZ/rAI+p5xAVuUbLe/0XMiF4HtewETmloFOKXtJVCZ/QyeIl/kKX
	Y08wtNDFC8++E/C63Qmh8B+ulndDd3Hcxt5b0r/BgqERZxpINMLP6OZB0j
X-Google-Smtp-Source: AGHT+IFmMHF+sAkjyYcySvUSftDXvHC79EDpe+15m4p1J1Zg1br8SbDaOQhsYeTCo/U/KY3wrXQL2A==
X-Received: by 2002:a17:903:17c5:b0:294:f310:5218 with SMTP id d9443c01a7336-29b6bd580aamr237265665ad.0.1764147449992;
        Wed, 26 Nov 2025 00:57:29 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:9fd4:f657:3c3c:9fd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25c104sm191816515ad.54.2025.11.26.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:57:29 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rostislav Lisovy <lisovy@gmail.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Subject: [PATCH v3] net/sched: em_canid: fix uninit-value in em_canid_match
Date: Wed, 26 Nov 2025 14:27:18 +0530
Message-Id: <20251126085718.50808-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Use pskb_may_pull() to ensure a complete CAN frame is present in the
linear data buffer before reading the CAN ID. A simple skb->len check
is insufficient because it only verifies the total data length but does
not guarantee the data is present in skb->data (it could be in
fragments).

pskb_may_pull() both validates the length and pulls fragmented data
into the linear buffer if necessary, making it safe to directly
access skb->data.

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
v3: Use CAN_MTU to validate a complete CAN frame is present
v2: Use pskb_may_pull() instead of skb->len check to properly
    handle fragmented skbs
---
 net/sched/em_canid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5337bc462755..2d27f91d8441 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
 	int i;
 	const struct can_filter *lp;
 
+	if (!pskb_may_pull(skb, CAN_MTU))
+		return 0;
+
 	can_id = em_canid_get_id(skb);
 
 	if (can_id & CAN_EFF_FLAG) {
-- 
2.34.1


