Return-Path: <linux-can+bounces-2823-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C2CA38BDF
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2025 20:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A0B7A17E9
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2025 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A922DFBF;
	Mon, 17 Feb 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMRZd3r+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FF216605;
	Mon, 17 Feb 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819052; cv=none; b=Tcq6cDNjYH5ANfQ8Qu6BT4xrAtAznK4GaNCx81BXf01wLdIk4B/lLIfOQLhj1/l5rkkrhsI0bvH4QagYNBphfQvEPRN1GwYmFzhkRh1EvNpih++x6f4oIHs48AsRjB2VGsjwvBoKvESwgzljcvWKz7mmjk36VxdcSRivsPsk9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819052; c=relaxed/simple;
	bh=KO2kfgFS56BUZdOcSTHtjmZFrdN1FXtNYPlVSHH+yw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4/wSu/YnJ6Xt/VYZaknb4zlR8m4y8XH3EzlRM9m4pwMcoJrnhUyuluCCgvEJx3kHYjPNxL0ppC6CtSpefxAVGe5SKX4etr8k6vopdm5ozf4v3LLquYYpj9ZD6qGFV+txtT8W9Eh6kSbaftywW4JzzELsrAsZX0qE4vMiIbmMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMRZd3r+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2212a930001so33890195ad.0;
        Mon, 17 Feb 2025 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819050; x=1740423850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzkP+pgnUzTb5fXTNKSxJCrrQ506fnmgvA15C64w6yk=;
        b=QMRZd3r+VWunZbhKdbHi2Dip4aj6kxJCi9rGRodqtZbxKosM/ZElxqqy/rFOkO78sk
         FYxqqWR+B0CZiqRTB70JnDV/sQTCQ1Jup1jNY14qIg0b9De6p9vT0Ql6JSL2igd2rFX1
         BThqvjT/sL4bL7Ep6e/332+reWV4oArErK10EDNLiTZhRckKYBCMYEjFrhRImEMTnJK/
         67KZyq548nuYRQss0+ZyO9cwpqQpsB2TmK/hOdC6bIjA+4onErKAMCCNjUfnHn1h0NNj
         lcZj+HQdHgOzjTb7qzOSGn6NFSTlcYyd1ukEwSfeCBMtTsIdsRcEscYe2U7IlQ9H/pnZ
         OL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819050; x=1740423850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzkP+pgnUzTb5fXTNKSxJCrrQ506fnmgvA15C64w6yk=;
        b=sE1F3etiBuo/P4/kruEwbFX7gsOwe93Lz45i2B3/SFWGF4gC+k7hIsdvMy76Pf1Vpm
         7OQm0aj4Iv3P0C8IemThqJ/aINgOe0urQLiq7TJwrfvRrhBCshmCzy+1Oyu7IIvWzSdA
         YfuodmUjSLFRF6XFAb0AwkHRlWJ9IeMbxEmr1IeTv7fq/8ePyxbmtctaHFBkxfLtqAH2
         qTQ/vrRm3LqJ12q6J8vf4+81frhb0LsjFZITDs2TILFMEmjpIgvQ4KxflX/DYTYs+99F
         K8X7Vl/6VdAjiGp6i/RPWj2nvI3+9IenT3jewAm7wo6lNxQAZdiTGPZdV0KzIqhRT1yX
         yMBg==
X-Forwarded-Encrypted: i=1; AJvYcCU9kusX4re+HlsoA/mhpl+VJNI1Ii4+VsZg7pk7+EZbFbeAYjDyeyEt8S9yVKa/9trEJhejE3LE0tQ=@vger.kernel.org, AJvYcCW43EeMzaXyRNF7YhaCgfkgMQJlT2EX0IFPabwC8b7UXY27SfUdW9eWizBbErYx3wsyyRJkj5jRh98+eZhP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo77RQYHLJEjMWVoCTyrdblK7lnwwKmtEbhmYJif5pUGy9Vx2Z
	t7922ISo3OMtL6/dTHmX1FmGoKPSl6YRWIbkY4Z3/WAAsftna2MB
X-Gm-Gg: ASbGncsyEDD8jIO2LYmkfCG3779q+nVooZdiMG6t5yq1PabLJmNgLMrnnIHgztvolTl
	qSqjsVZ+SBob+ZWEvnYRJf/YTyo3PhEnGDj/l7xU9XWT47dRKHiUFi3NPttiygmEHfXe6PmDIOh
	kn6x1mlKd2mmzJHCt3U/5KShaPwJkgVkj2V6HGe3cXd1KNJHLFaiGWQ422jykdn+nEjtWbTlCUU
	24rXa0mKJ+WZHl+owVw2k0JMY563oE8h2VMbddaXnr9xYn2JWBQWq2ihdm1E7x8GsuUoyw5s7MN
	MJkCx1GbjCMDKtc4W3Mv8d22pDpBWL+qn3ZgS9V/o5eptXR8WXi7U1twI0mYYpi/3EWEOQ==
X-Google-Smtp-Source: AGHT+IGgqgdJzgTfl69t4Ey8DdgeJrgVpz4clUAOHWF+w725HPTqhULI3J8MpIpecy/ABG9SZDPbHQ==
X-Received: by 2002:a05:6a20:7287:b0:1ee:4813:8a93 with SMTP id adf61e73a8af0-1ee8cbe818cmr18150837637.27.1739819050580;
        Mon, 17 Feb 2025 11:04:10 -0800 (PST)
Received: from TW-MATTJAN1.eu.trendnet.org (61-216-130-235.hinet-ip.hinet.net. [61.216.130.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326a38ff76sm4322087b3a.160.2025.02.17.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:04:10 -0800 (PST)
From: Matt Jan <zoo868e@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matt Jan <zoo868e@gmail.com>,
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Subject: [PATCH] can: ucan: Correct the size parameter
Date: Tue, 18 Feb 2025 03:04:04 +0800
Message-Id: <20250217190404.354574-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67b323a4.050a0220.173698.002b.GAE@google.com>
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the comment, the size parameter is only required when
@dst is not an array, or when the copy needs to be smaller than
sizeof(@dst). Since the source is a `union ucan_ctl_payload`, the
correct size should be sizeof(union ucan_ctl_payload).

Signed-off-by: Matt Jan <zoo868e@gmail.com>
Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..1ccef00388ae 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1533,7 +1533,7 @@ static int ucan_probe(struct usb_interface *intf,
 	if (ret > 0) {
 		/* copy string while ensuring zero termination */
 		strscpy(firmware_str, up->ctl_msg_buffer->raw,
-			sizeof(union ucan_ctl_payload) + 1);
+			sizeof(union ucan_ctl_payload));
 	} else {
 		strcpy(firmware_str, "unknown");
 	}
-- 
2.25.1


