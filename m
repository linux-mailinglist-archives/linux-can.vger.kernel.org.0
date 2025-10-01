Return-Path: <linux-can+bounces-5074-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FDEBAFCAF
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63C464E299D
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D268279782;
	Wed,  1 Oct 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W7RVZ9uT"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FF2D94B8
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309825; cv=none; b=bJdflQj7YwDLXuoe3d4Hsjgj7wA5e0A5wDL/j6pa/9zMs6IZdSIhQe1OqEaNlwsX4R2zgrY4U6KafdIzFsBGFKotTkgHV5H9jkp0tH98ScOAxK46SckN3v/2AyU9YaEs3BnWDwluu57lc6Lt+yQe8QIcclBrkOZ4BA4qKKg60uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309825; c=relaxed/simple;
	bh=9tMx3D8608utTcEpPMnkdtIuK+d8YCm/4QGWcLPlEvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxE9Fj2i7RYZJ2iQaXdH7Qyad2D+wX52/HB8UIpu1opDqPkyWGUv0solKql9YhcG6iTPA1uUbDEyda+8m/uzqtIMFqFeEwO2aOGOYITpXXvP1TOf5gv1aOQmGYEjrrgjhtTxKeSPS73qLbMdga2cB8jouEJ9zMbbWANkrXKm8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W7RVZ9uT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918VQdi020359
	for <linux-can@vger.kernel.org>; Wed, 1 Oct 2025 09:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=52JKwdjjF6T
	43Z0oK2sV6asg8JQDNCAzfJwR0DaXYts=; b=W7RVZ9uTkEWPeGuNSdU/UbDlt5i
	MOwWudfsyR7Wg02jsFmdurV2DAj6sEMqmXvJ/aIZCkPNl/q0A9ZO9jGo9LTBy8lb
	qLdzzHvwkDHS9stBLVtMKsVS/x+yvZlnt4CWDILxcGshKzTlPWJu2N3si252gafJ
	iU5hHUw0+E4GbsmSZDiR1hsw3P/v59zfNnQzwVQUD5/QoPm5uqn5OBw0USKrG+wg
	3ffhMnYfK11WIooWbcuuH7/c1SqhCdJG4AKNq66Zp5ggeoC2ooZIq+9eh4OW51OM
	Ipa3SJg4HEGeT5kFwfsmlqfmXdVq/fnAQtD02ILuCO4+MLAZO86p14Ngk+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5v45a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 09:10:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befc08so13615213a91.2
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309821; x=1759914621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52JKwdjjF6T43Z0oK2sV6asg8JQDNCAzfJwR0DaXYts=;
        b=LGvXalDkiKc3ng/2PVSq3+HhSFfrdCnf6ZryCB2sokGoRrKCQF84N40fvm/EJRq9wf
         HbtMNAhPz3giFNoo4TBSgGLiHhb2Cm1wb3Rc3IZZZ16hxQUozMMJoOr//KjUtsX7iyS/
         puTvgAVex0rcRUlLodb3yZuplal9B/dZPWrErxXCFJ0ZNKwe8aSsEXDlDQKJoCCEGGM9
         ssMnJm4XIqHVNbl/lbAVnZnxy1PxHNVvAFaGAst3EJeO6gNA88FWcEy8BUDCvYd8BidS
         5F/ZMgn1JRsWrMkwAriAzar0G9zqRrJeu+CCbyL6xWGNmo2iojLla372tePMTZ3KpzMC
         3A7A==
X-Forwarded-Encrypted: i=1; AJvYcCXvQW1n1kQkW3TkSc/3JvswLdX77BBG34M/OpCd6pe7RjauRS7TsE6mYUaS2SITvLUQhtbrImilAmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vhPUT21XOD825ruPKSLXxKpo9HNAA1sgYBktpCpt1NOTMocB
	MZvw/YFvo4oEkII/I/uzKIYqYBG1I+yBNyWBPN0x+wIC1pUr93r+2lo4xksn/uNytcSSZRnIrVf
	d/677NwEAiNQGasHdDS8MXMt3ua81zCm6jGNSe+yND/ZE7IBXJn50LWSMi26EkmI=
X-Gm-Gg: ASbGncuwNmgKKgq222OSWHD8S1CafZilIg5LwVz3Mm75BlIf84VJUrOzcq0eEzx4eeK
	GaudYqvM4iRyQh97TXaDPstYc++8vFvRvx8OdxvLkDP3Pe9J3F30chld2ftG+MsC6L29dOPyrqf
	qrdXgF4fh7dxon+z7K4oD+QcKLiZLnwu6cf6GfePifQxQ2OUFHYOkm/Y2IT1vxlwl0hvHDNl3kC
	uk1jjCxkJr/nS6Ac0t2fwtMbnGspsG3azcONCGUToSU2cbDqmo5Q/TnThwJZ6eLfO51pP+dkKMy
	oiCYBU9t7SAu4IVMpb7udrFOkZVpD4jMXiNwZphJPq1141/RK9fuKNl19S0b5P0WdGlbE9E1M8f
	DKM6X0A==
X-Received: by 2002:a17:90b:4d08:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-339a6f06b08mr3062001a91.20.1759309820949;
        Wed, 01 Oct 2025 02:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsrXCTkq3psKB6+I+bWAbfu5LwIg87pKujroiTHO2dk0PZb6/apF564mWpnjDjLNtmtKwaBA==
X-Received: by 2002:a17:90b:4d08:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-339a6f06b08mr3061968a91.20.1759309820490;
        Wed, 01 Oct 2025 02:10:20 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:20 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 1/6] can: mcp251xfd: move chip sleep mode into runtime pm
Date: Wed,  1 Oct 2025 14:40:01 +0530
Message-Id: <20251001091006.4003841-2-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
References: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mnvXLoPd4a8mLMOvlJzyRuWJ68U-scd4
X-Proofpoint-ORIG-GUID: mnvXLoPd4a8mLMOvlJzyRuWJ68U-scd4
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68dceffe cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=6KGlMJUpO0AhJANn3KQA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfX3q5CdYBMpJ4k
 NsTnWPWPL0kQ7+W7hVgeZy1X6/pOWUObDRHXwUIQEVzVHe74zjoTCMp0YXlY5exdpG2jUcrBDFI
 5s7CTgR9WgA/+4rtdN+EeC6D/9cp+BlDsXcfNWLNMn93/UYbgWXSAovGOxAKhLxAiaiTMscSy9T
 4uZ+N2d2b0W4s3Kmunf49hlls+fNKvTiM8LsZDYILC3afgKuCk7+bfQNTmH2M4Te72uig/QkccJ
 QsUXCx8CglzKUWVw28m65K+1AT3err7yMAZHPRx4mHSmgX3Az+33oJW7dy4ZZoULgFv9fmW74E1
 Zw2urDgLQVEjXUTtPqqSJ3OvZ0O4Rngt89/K8Pc+hU6voPjA180we/kUcZUKoMZVysuLOcck5Sa
 3JGw0dtbPR8iv/cwZCiRzTDn/8j6IQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

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


