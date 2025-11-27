Return-Path: <linux-can+bounces-5750-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99706C90006
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 20:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C753A80C2
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE2A3016E5;
	Thu, 27 Nov 2025 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqNGUIDp"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B432DA760
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271178; cv=none; b=SglCYbnwlch2dzQ9+2fD5xsPvgBpHCv+yPLskzc/EsVbCVhm2v9hN6b1izaemgz/FBbddj5UDLjobytAA1L7IKVDFKpn0rUbhUwEANVf4CaZLod6f+bu6Hd1YFBOiwlnka7vNtEVVP6fXZtnSEogqWn3RNEuXpVcCt30zKeTxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271178; c=relaxed/simple;
	bh=QiQubMv26zYAKcBaIcJDXjIhFZMBqqNoxcxStSi01jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+YCD1ykCtSLpoiVsbS8RfvRIK5NeM52oaTPHrEQGrBN+HgbdSX/aocHV20z8Te7LRSANDmsdEEaHnTlyn6U5zOoT0FXgpw9LwoILH8dj/mmJFcNYdDHTmrf3dfLYxBRfTHGh6p80EXydStKe6YeTJHxyn4VQlZKgLtucW3Ukv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqNGUIDp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso1734539b3a.1
        for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764271176; x=1764875976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc1zInQPA3mOeFCysXnI54YAVIuQEcNbca5dzFQtVUQ=;
        b=VqNGUIDpDcPw4i0vgZxIuSIzOBex6b71ayKxYCFqy87dHLuTnxjWPdQVyavnujqsks
         MM8kOYNT7uynj+ThC8k6IVvii4qer7BteQalhPvFO1AqhGM7Kw029+GcQZwby5dkixVa
         5GI8yXiT8g+vmrLz5MciFz9orMyCVewVYQSiRyRAhG96Jr+YEAQdiajUmtjIDY2iwnHE
         17lXsUEnnWl2J30RJJsgw89TsxwtyLNvYJcOjDJvzi2NRkIQgWE92SrIRHgDIw6hnxRH
         o9yAmDDLPyj6EcanT4irp+i5kIlylcl0sGamfoO9Y5P8EgtMpegbeWqvw5Mnz5l1ozRW
         JYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271176; x=1764875976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bc1zInQPA3mOeFCysXnI54YAVIuQEcNbca5dzFQtVUQ=;
        b=aeZD1/exySw7pfGL7mcpu2i8KnOz3+PC/tcaSnIL3MRRLAPM63kJMzzreUFtVwmVaq
         j1wDL9xC3bUZ2Lp5ZW9ctB0+XtVj1lDIB3xH/sNcPhEy/acbQVfmj+2ob+xmrubA7ZxH
         houygEOBxf0LW6+lvPLXQna/iZnlQq5QPYguewfWD9dVbbZPffDxU7zesP27YR3q0Esy
         5tPz9ZA8jBA+woozJMdZL34ve3U31omLQS+jZJXfKmfogyD3tyAicQ4YdLoPaj4I6PU4
         2SCGh2J4fLzWlSur0PR2lWVA9SPGM/pQ17DyW8+UnR0eMWetJvplX/DTT2oHiJhCaIM1
         sy2Q==
X-Gm-Message-State: AOJu0YwRiTklrOaSyQudP5n5b5W1O3Bdf7Zzd2s7LGnabf6MyiwX4CMe
	a3VDz64wAorBfJuRaFWJJxInNZ0434loRtsF50XE9DosmiU8IJDt5waRCfOUTH5/Dio=
X-Gm-Gg: ASbGncsjrTD5MnKrJ6snNWTWWa5JFUECu3cY3kDB2hrpa/bqaislME7r49nIgaG9/VZ
	qN4XX0w0Fu0x9BrHyMIjx8/6pDoGmEyMTpeWjXg17UTYTc76FeRu9op+4jRsC2RDrtxPcV7q8D9
	409kF5w5fa3oC1Z5FB6OV/tuUq9dO2NtFuKkmnbQ2YXA4H12LM5OOV2sCoTwnpkZGcDeUfvu9SP
	LPhGlSrTZ0Ac7EfiacUfcWLxehKLeT6tx1ZyKzvB6s+GrhxSt/drRAI/zxAULZ6hczQElSJvSnr
	bJjD8/l+YvSqDyrq01RtAV+/rWwN7aaKTxvi6qKjvhCAUuuJkxwXWcIURKNxBtk2+bOL/DFXbm7
	et7NfSbGBZwlCf39ThM0KNzOr5ku5M+zdacsYfipZxGGLJdF3luD+50rxQ77tooSoUwBFeQaEqI
	hCgpSmKCUKezZiGCHe
X-Google-Smtp-Source: AGHT+IGhP0W8lcI8uELg/tQPQCKcVo14Va1mvj+bMVqnMs/DZ2d195Ll0cMh0zJjIMvRCX2xb6uVyg==
X-Received: by 2002:a05:6a00:2d9a:b0:7b6:363b:c678 with SMTP id d2e1a72fcca58-7ca8760d166mr14107945b3a.6.1764271175664;
        Thu, 27 Nov 2025 11:19:35 -0800 (PST)
Received: from rakuram-MSI ([2409:40f4:211f:b50d:1190:e256:8b21:a462])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f176096sm2620703b3a.57.2025.11.27.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 11:19:35 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	socketcan@hartkopp.net,
	mailhol@kernel.org,
	khalid@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rakuram.e96@gmail.com,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [RFC PATCH 1/2] can: dummy_can: add CAN termination support
Date: Fri, 28 Nov 2025 00:48:07 +0530
Message-ID: <20251127191808.144723-2-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127191808.144723-1-rakuram.e96@gmail.com>
References: <20251127191808.144723-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring bus termination in the dummy_can driver.
This allows users to emulate a properly terminated CAN bus when
setting up virtual test environments.

Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
Tested the termination setting using below iproute commands:

  ip link set can0 type can termination 120
  ip link set can0 type can termination off

 drivers/net/can/dummy_can.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
index 41953655e3d3..2949173547e6 100644
--- a/drivers/net/can/dummy_can.c
+++ b/drivers/net/can/dummy_can.c
@@ -23,6 +23,21 @@ struct dummy_can {
 
 static struct dummy_can *dummy_can;
 
+static const u16 dummy_can_termination_const[] = {
+	CAN_TERMINATION_DISABLED,	/* 0 = off */
+	120,				/* 120 Ohms */
+};
+
+static int dummy_can_set_termination(struct net_device *dev, u16 term)
+{
+	struct dummy_can *priv = netdev_priv(dev);
+
+	netdev_dbg(dev, "set termination to %u Ohms\n", term);
+	priv->can.termination = term;
+
+	return 0;
+}
+
 static const struct can_bittiming_const dummy_can_bittiming_const = {
 	.name = "dummy_can CC",
 	.tseg1_min = 2,
@@ -250,6 +265,12 @@ static int __init dummy_can_init(void)
 	priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
 	priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
 	priv->can.xl.pwm_const = &dummy_can_pwm_const;
+	
+	/* Advertise software termination support */
+	priv->can.termination_const = dummy_can_termination_const;
+	priv->can.termination_const_cnt = ARRAY_SIZE(dummy_can_termination_const);
+	priv->can.do_set_termination = dummy_can_set_termination;
+
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
 		CAN_CTRLMODE_RESTRICTED | CAN_CTRLMODE_XL |
-- 
2.51.0


