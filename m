Return-Path: <linux-can+bounces-5036-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6134FBA3E5A
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950EF1C023B7
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281AA2F5A0C;
	Fri, 26 Sep 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dy5OA5S5"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF1267B07
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893437; cv=none; b=EMwNEFam+9jdAO7S1eMgS/zkYdlykFrv7+w42Mp5UEznfXd2IDhHeBeM9CvFZ9M1sN53/ihqlGAjYNcIo1MaG+FPI2ep5IX1uSgLlB1RIBlg/1+JkOV6dSgMvqBPeCDoBDfvNduWm3yfFJSwDLa0bp0pBx0GSQ4ir26w9HicQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893437; c=relaxed/simple;
	bh=9tMx3D8608utTcEpPMnkdtIuK+d8YCm/4QGWcLPlEvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVMcWdw1GhQD9/NnJyAAGYdkBDhz30HF6GqgnrkNmuj283TwQIKLj9vFWCHM/VFuwnwngV3uCVA6E/hYjptWtnCJCWqKicY8IWMqpq/+I7Oz/KwXSTinyhsAhUYpl084/5DUkcdQ8hVv/7k9fNHheUDywnSN8Ky1JpNlayZ679E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dy5OA5S5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vduk028819
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=52JKwdjjF6T
	43Z0oK2sV6asg8JQDNCAzfJwR0DaXYts=; b=dy5OA5S5m4cdg8N7uMETnSuDF/p
	UIHx5SPVG7wfSCzYB7qDX4NGGy3Bt9Foyv5ls1YhMQEoUTefpgYfWKUzI8KrNlRv
	/zCUbUychw0qfqTlyN6xaaHE9EfDtsx5aR22TBIVKom26DCTn/aEF7LfSqTyn9Ox
	83EORVcQFkJYSVfMn07VLJcajgusjaJ+BSblsJPBkud5lPfwfrFeyKZCk41D3TTj
	b9uOFhMoAp3MLBG3NN3OXlUFmFawOTu4uI8qgpFMQtYinu3bhPstsi5r/xpQDgJB
	k+/lf41PTiGfMAwTSY8AUvyRp1lQEBZ23SxPUSjtpTTsb9yVVRbKD29+R6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db322y4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810af03a63so2954843b3a.3
        for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 06:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893433; x=1759498233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52JKwdjjF6T43Z0oK2sV6asg8JQDNCAzfJwR0DaXYts=;
        b=MLj+N4bekjr4+9yk0jknZS28JAllYgeycYGvDers0Twsw6lD3aMqqbSx2vRyCP7u1d
         me0hzNhon/DW0//GvJ3gKzrD7XV+Nmt1ebQUr1eKnungAx4RQLtNY7Wz5BzZI+/BF/aP
         6Nguit3Po2Gh7bloEkyGa9IGK0taDtW44aRSi9THfd9cVPGmdEmYsWOXu0uRoF5aawjF
         psrLnBK/n0vMZxM9wqKRrRokAFJZ48LVKMCf/Fb7OgGD2KYOi/VW3u72HhlJObwUDa7U
         pFPTRd1NxdjTe5sAHziuwe2MFwkYt9nUHLj7M945rbpSo5TQSql8YRmkQ4Os8Uu711Ah
         LAJg==
X-Forwarded-Encrypted: i=1; AJvYcCV9vXnpgFNcoxcIO5TBFzPI9eR+xxATObM3XV0lmemO5msPDbFQPPGUsae8OOwp7WW9pM1br3p/Mas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY+2hCK4nJCLF9AsvKALVvk/XyhaZpIM/k4ENIMKiudIXxf3D5
	mK6tfjwI8lTeCLjCLYawpluTD0fny0Omp/TilL2NRYW5HJqfZhtgkeeAoVAzTSzwHhdMR7HHnzV
	oNw6y6xk4E+r6B/FPgzfAGp2cjziCaPTjSttC05gVdbS+s8ijFnigy6D8ajHv7IO8DNzzmzQ=
X-Gm-Gg: ASbGncvmZIZsAAOLAZAWzmXTcXHtAoxeukApZcs+fkBJ2cs/ydx62SrgnO1OSSL6Vde
	CrpkKCqsntMnDXVkcDI8ZzxkP8F4460r80Sgnjln9ge6VNPoBQBEh85sJW47EjDbTFFfgW3PkK7
	/aadf+ZTPvP4YoLaxf/VExUICx5R19qZf72G1EkSxjzV5Z77rxFs2aTFr1yIfNwbkolBRRdRJpO
	8Pg4SHwUE9tIRSjvJ4HG9D3pIHI0/97ekny0QEBPKUT185Muz2AtCGjKDjwXc/zU4M+AzxLizgX
	4nLE31et/V3ePX7OC2cy5I9zRYXO8UWlW3D0Gr3V6wZ/O3edo8GtyKTUJUHLSMAGwdCYR00TOKt
	a
X-Received: by 2002:a05:6a20:6a11:b0:2b8:5f2d:933d with SMTP id adf61e73a8af0-2e7c44125d5mr9295217637.12.1758893433325;
        Fri, 26 Sep 2025 06:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9vJ7dSnobiw0gNzFaPZhNDl0sU+RMma/SjzJVzdYzcFJ5zLjBs4955Ly/ZUBsj/+Bq19zoA==
X-Received: by 2002:a05:6a20:6a11:b0:2b8:5f2d:933d with SMTP id adf61e73a8af0-2e7c44125d5mr9295173637.12.1758893432713;
        Fri, 26 Sep 2025 06:30:32 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:30:32 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 1/6] can: mcp251xfd: move chip sleep mode into runtime pm
Date: Fri, 26 Sep 2025 19:00:13 +0530
Message-Id: <20250926133018.3071446-2-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ao6/yCZV c=1 sm=1 tr=0 ts=68d6957a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=6KGlMJUpO0AhJANn3KQA:9
 a=IoOABgeZipijB_acs4fv:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: nPbNz171wClSLu3JgdrhKujI8iJ7SyXX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfXyxItH87dFBlc
 Eg+mGp4IWd+MYVDfZIe6A1uCJroD0aMk2kOw+SypBNA2ZVR01Yh4i4pp+StJ9URI3RQgaCqun9g
 +gFnaql3UAyus7nkaqpqV4seNwV9asWe/6LLvSJOYG8rmbEd3EpA2pPjMjsmZ+Z/QuDkKu/n5F6
 3Qg+m9K+UunzUv1AIi6ucLkmr3ELpCltR0/O+qDrvQXARmcJNkopfG+5vnxiViNtLiL+J01qORE
 YlVaNsdo4L6ptaD5orixMxUKYqGVEnu0HFzQ+ZfiUOH/Lp0NdLjIQl+ZnUjImlEZ7AhhOnnEU0/
 hrh7SIihczdADHfFtBD89sozFGE5FsjGUxk1GFWDtvcy4UenNl+VINQB1eGdnhtHlHiXNZ9R5kh
 dqsGAN6NmBOud8uLTuXLOdhtUR2z3A==
X-Proofpoint-GUID: nPbNz171wClSLu3JgdrhKujI8iJ7SyXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

From: Marc Kleine-Budde <mkl@pengutronix.de>

This is a preparation patch to add GPIO support.

Up to now, the Vdd regulator and the clocks have been managed by
Runtime-PM (on systems without CONFIG_PM these remain permanently
switched on).

During the mcp251xfd_open() callback the mcp251xfd is powered,
soft-reset and configured. In mcp251xfd_stop() the chip is shut down
again. To support the on-chip GPIOs, the chip must be supplied with
power while GPIOs are being requested, even if the networking
interface is down.

To support this, move the functions mcp251xfd_chip_softreset() and
mcp251xfd_chip_clock_init() from mcp251xfd_chip_start() to
mcp251xfd_runtime_resume(). Instead of setting the controller to sleep
mode in mcp251xfd_chip_stop(), bring it into configuration mode. This
way it doesn't take part in bus activity and doesn't enter sleep mode.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 91 ++++++++++++-------
 1 file changed, 57 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 7450ea42c1ea..f9eabb1810cf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -767,21 +767,13 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
 	mcp251xfd_timestamp_stop(priv);
-	mcp251xfd_chip_sleep(priv);
+	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 }
 
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 {
 	int err;
 
-	err = mcp251xfd_chip_softreset(priv);
-	if (err)
-		goto out_chip_stop;
-
-	err = mcp251xfd_chip_clock_init(priv);
-	if (err)
-		goto out_chip_stop;
-
 	err = mcp251xfd_chip_timestamp_init(priv);
 	if (err)
 		goto out_chip_stop;
@@ -1625,8 +1617,11 @@ static int mcp251xfd_open(struct net_device *ndev)
 		return err;
 
 	err = pm_runtime_resume_and_get(ndev->dev.parent);
-	if (err)
+	if (err) {
+		if (err == -ETIMEDOUT || err == -ENODEV)
+			pm_runtime_set_suspended(ndev->dev.parent);
 		goto out_close_candev;
+	}
 
 	err = mcp251xfd_ring_alloc(priv);
 	if (err)
@@ -1907,53 +1902,53 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 	struct net_device *ndev = priv->ndev;
 	int err;
 
+	mcp251xfd_register_quirks(priv);
+
 	err = mcp251xfd_clks_and_vdd_enable(priv);
 	if (err)
 		return err;
 
-	pm_runtime_get_noresume(ndev->dev.parent);
-	err = pm_runtime_set_active(ndev->dev.parent);
-	if (err)
-		goto out_runtime_put_noidle;
-	pm_runtime_enable(ndev->dev.parent);
-
-	mcp251xfd_register_quirks(priv);
-
 	err = mcp251xfd_chip_softreset(priv);
 	if (err == -ENODEV)
-		goto out_runtime_disable;
+		goto out_clks_and_vdd_disable;
 	if (err)
 		goto out_chip_sleep;
 
 	err = mcp251xfd_chip_clock_init(priv);
 	if (err == -ENODEV)
-		goto out_runtime_disable;
+		goto out_clks_and_vdd_disable;
 	if (err)
 		goto out_chip_sleep;
 
+	pm_runtime_get_noresume(ndev->dev.parent);
+	err = pm_runtime_set_active(ndev->dev.parent);
+	if (err)
+		goto out_runtime_put_noidle;
+	pm_runtime_enable(ndev->dev.parent);
+
 	err = mcp251xfd_register_chip_detect(priv);
 	if (err)
-		goto out_chip_sleep;
+		goto out_runtime_disable;
 
 	err = mcp251xfd_register_check_rx_int(priv);
 	if (err)
-		goto out_chip_sleep;
+		goto out_runtime_disable;
 
 	mcp251xfd_ethtool_init(priv);
 
 	err = register_candev(ndev);
 	if (err)
-		goto out_chip_sleep;
+		goto out_runtime_disable;
 
 	err = mcp251xfd_register_done(priv);
 	if (err)
 		goto out_unregister_candev;
 
-	/* Put controller into sleep mode and let pm_runtime_put()
-	 * disable the clocks and vdd. If CONFIG_PM is not enabled,
-	 * the clocks and vdd will stay powered.
+	/* Put controller into Config mode and let pm_runtime_put()
+	 * put in sleep mode, disable the clocks and vdd. If CONFIG_PM
+	 * is not enabled, the clocks and vdd will stay powered.
 	 */
-	err = mcp251xfd_chip_sleep(priv);
+	err = mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 	if (err)
 		goto out_unregister_candev;
 
@@ -1963,12 +1958,13 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 out_unregister_candev:
 	unregister_candev(ndev);
-out_chip_sleep:
-	mcp251xfd_chip_sleep(priv);
 out_runtime_disable:
 	pm_runtime_disable(ndev->dev.parent);
 out_runtime_put_noidle:
 	pm_runtime_put_noidle(ndev->dev.parent);
+out_chip_sleep:
+	mcp251xfd_chip_sleep(priv);
+out_clks_and_vdd_disable:
 	mcp251xfd_clks_and_vdd_disable(priv);
 
 	return err;
@@ -1980,10 +1976,12 @@ static inline void mcp251xfd_unregister(struct mcp251xfd_priv *priv)
 
 	unregister_candev(ndev);
 
-	if (pm_runtime_enabled(ndev->dev.parent))
+	if (pm_runtime_enabled(ndev->dev.parent)) {
 		pm_runtime_disable(ndev->dev.parent);
-	else
+	} else {
+		mcp251xfd_chip_sleep(priv);
 		mcp251xfd_clks_and_vdd_disable(priv);
+	}
 }
 
 static const struct of_device_id mcp251xfd_of_match[] = {
@@ -2206,16 +2204,41 @@ static void mcp251xfd_remove(struct spi_device *spi)
 
 static int __maybe_unused mcp251xfd_runtime_suspend(struct device *device)
 {
-	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
+	struct mcp251xfd_priv *priv = dev_get_drvdata(device);
 
+	mcp251xfd_chip_sleep(priv);
 	return mcp251xfd_clks_and_vdd_disable(priv);
 }
 
 static int __maybe_unused mcp251xfd_runtime_resume(struct device *device)
 {
-	const struct mcp251xfd_priv *priv = dev_get_drvdata(device);
+	struct mcp251xfd_priv *priv = dev_get_drvdata(device);
+	int err;
+
+	err = mcp251xfd_clks_and_vdd_enable(priv);
+	if (err)
+		return err;
 
-	return mcp251xfd_clks_and_vdd_enable(priv);
+	err = mcp251xfd_chip_softreset(priv);
+	if (err == -ENODEV)
+		goto out_clks_and_vdd_disable;
+	if (err)
+		goto out_chip_sleep;
+
+	err = mcp251xfd_chip_clock_init(priv);
+	if (err == -ENODEV)
+		goto out_clks_and_vdd_disable;
+	if (err)
+		goto out_chip_sleep;
+
+	return 0;
+
+out_chip_sleep:
+	mcp251xfd_chip_sleep(priv);
+out_clks_and_vdd_disable:
+	mcp251xfd_clks_and_vdd_disable(priv);
+
+	return err;
 }
 
 static const struct dev_pm_ops mcp251xfd_pm_ops = {
-- 
2.34.1


