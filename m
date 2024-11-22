Return-Path: <linux-can+bounces-2183-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A09D65A1
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37BCB22ABD
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A618C32E;
	Fri, 22 Nov 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aJdx3DJh"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4617C215
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313818; cv=none; b=SXCmu3p0ENT4NnJk1ONDP50Mc6JFm2INhPkk0lEvEvqLIulG6wQ/poaBLOfhQ6JaP+lkDHiTfjTaP27ktooCBoEtxV/CLBSMW6oD29QZL7KG6D/LSXch8ICROkpq8PhRte/Txcorg/89uwo7r5MhRaxWP8Xg2HjRi+N2EWuatOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313818; c=relaxed/simple;
	bh=qotsxHOlhgnrVQByYtlhooxKse2Dv5ppiV/7dnSBU64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erH9rHHOccWVWh+50WE35Gmxn+2AjY0jKOb3ZB+ZfAzFZM2BhLTxgaZ0pCbbVLtVjj2Pjj4Fj5TddLUmSEYuu47tAIiH+HsZvwEPqj1v0PeHLy1sRdGwaBJs+Yo6aHj5hrp4UDGJujqK4IQUdP8KabqiDMO8jmtIYdhbWF4Z83Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=aJdx3DJh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso29025551fa.1
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313814; x=1732918614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KotHSsdWfu+c1NcMh6OyQCxQ2KHZlyrz53b2aXYhfLc=;
        b=aJdx3DJhELpO1OFV/MFURaxQLW1NdLqo7H0Nm1jlyfe7waYIL5tfK/spmMkmjtvry0
         aG6qd9tA0iLnSfE24qxO/p8Sz4ojYnOgtVlu5fdrQPGoSJ5ltCmbTDEhprO7pf7hKs6F
         QGsP2ZmAXpO6vuBuP5/vfv1iS1CnkC/6XfadY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313814; x=1732918614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KotHSsdWfu+c1NcMh6OyQCxQ2KHZlyrz53b2aXYhfLc=;
        b=m8cdDFehzj0V4FYqUf4EItOSsoLzy2hxFNorOfF6CA8yVqN9edUzaZvi3zepK33lg9
         VKM4UKOFIjXRYdKLzgiUmv6TVkBjpyXpqB8nghuzI3g9wFEpov/NLzO3BhumHrQRJPNo
         Gt7NxnUwXfGT1Ebd0Kk/yqfcEiaG9qZlIWr0cUN/KEMsILwqRItLRD5lOdn3e9aYaAIp
         dHFBJ3aSz9O8by9BXwbbnpk/gAonP8k6GQDAx33J6JegHTtsRsm75ZlsolFQ2h6CrUqT
         ATgG7iUb7DnYrgTzo0aBNpJf7eZ2Jy7w1KIXuJDAG0Qs2H9pHrzFCOxufrphAW51U8eJ
         LFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVblwdzSrUcx00DY3Ggc7K5A8GX/7qA6Kb/iMwATODfb/nI5obT5deZOcn1g/+Nxi1GB+ebqWBi8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGVMXRAWCWzlEtQ7UiQSO4nmW36o+4LQhbZzTxO+NTVrFfWeN
	pJTUhvaJmtxMFxodULA+TVvNADRz/hH9a6bh0C4tu48eiqfZ/eD4djNtJ7hdEKg=
X-Gm-Gg: ASbGncvUbmnqNWg+JUl8gb9fch8qnfbiHPDB0eo1TlBRjVFWHbL3OhwQXw8nDLyXeBZ
	/WqWstvsYgyGcAcudgGyY90rlr+nDLxvP99MUzBeFSTtCalmbFEeCvqG+qJd0M76b5P1n9LeG7Y
	oiRtoOCpR6rPgXUpmOkKyCP07D/Dmn/tl1ISTvWJzZRDMznJ8dRfjdS85eQgNGKgdIH7ChB3kNO
	GuvFEjKra5e227qkFSVM40DfQBRusKKph8sMCAvjOVdVf7cpBV53E1xcM1c2YoGdru0bh405AXx
	llGBSfAmAioI+5aaNCJ9pPNEDdFoZdmsZpBUrZIqdjHNiHgrVTfq5Stp9WoCXguLcUsPOID4IMz
	m2fZLL5Zbmr4hj01W
X-Google-Smtp-Source: AGHT+IEgYJNLEjwioZmh1uhCLI6hNlRYOYRL36bIZjSJEVburbMq8ZOQlpm6AI55EqEPC9fLmZ418w==
X-Received: by 2002:a05:651c:150e:b0:2ff:9269:ac1a with SMTP id 38308e7fff4ca-2ffa6d214bdmr30427781fa.0.1732313814248;
        Fri, 22 Nov 2024 14:16:54 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dong Aisheng <b29396@freescale.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Maxime Ripard <mripard@kernel.org>,
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
	Samuel Holland <samuel@sholland.org>,
	Sebastian Haas <haas@ems-wuensche.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 00/12] Fix {rx,tx}_errors CAN statistics
Date: Fri, 22 Nov 2024 23:15:41 +0100
Message-ID: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the patch 4d6d26537940 ("can: c_can: fix {rx,tx}_errors statistics"),
already merged into the mainline, to other CAN devices that similarly do
not correctly increment the error counters for reception/transmission.

Changes in v2:
- Fix patches 7 through 12 to ensure that statistics are updated even
  if the allocation of skb fails.
- Add five new patches (i. e. 1-5), created during the further analysis
  of the code while correcting patches from the v1 series (i. e. 7-12).

Dario Binacchi (12):
  can: c_can: update statistics if skb allocation fails
  can: sun4i_can: call can_change_state() even if cf is NULL
  can: sun4i_can: continue to use likely() to check skb
  can: hi311x: fix txerr and rxerr reporting
  can: hi311x: update state error statistics if skb allocation fails
  can: m_can: fix {rx,tx}_errors statistics
  can: ifi_canfd: fix {rx,tx}_errors statistics
  can: hi311x: fix {rx,tx}_errors statistics
  can: sja1000: fix {rx,tx}_errors statistics
  can: sun4i_can: fix {rx,tx}_errors statistics
  can: ems_usb: fix {rx,tx}_errors statistics
  can: f81604: fix {rx,tx}_errors statistics

 drivers/net/can/c_can/c_can_main.c    | 26 +++++++----
 drivers/net/can/ifi_canfd/ifi_canfd.c | 58 ++++++++++++++++-------
 drivers/net/can/m_can/m_can.c         | 33 +++++++++----
 drivers/net/can/sja1000/sja1000.c     | 67 ++++++++++++++++-----------
 drivers/net/can/spi/hi311x.c          | 55 +++++++++++++---------
 drivers/net/can/sun4i_can.c           | 21 +++++----
 drivers/net/can/usb/ems_usb.c         | 58 +++++++++++++----------
 drivers/net/can/usb/f81604.c          | 10 ++--
 8 files changed, 205 insertions(+), 123 deletions(-)

-- 
2.43.0


