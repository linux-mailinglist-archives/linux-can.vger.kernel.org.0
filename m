Return-Path: <linux-can+bounces-5077-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22BBAFCCA
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318A919438D1
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE972D9782;
	Wed,  1 Oct 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkKu3oVJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA02DAFA9
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309843; cv=none; b=MKJBXT0PELaiowNOVDEWQI4rIih2IT9BfcBvNKHjQoEqkEtgLW25WvWUSH9s+Hnh24K+hYBO0dtIvk9e1MiJwhbfkRC/QdH5VR0z/buk2PpS6mjiZlEhdbScTgss1Q5AJH9Pl/YuXvFs8bcswCWG8YTAASQPPTG1I/vajSVdwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309843; c=relaxed/simple;
	bh=fk0TNQn7BAcvjE7TYECp7NGF/xF5QIeAzGhAHgip9EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTdzAGCZw71mUS5w2GwG8QUGdwhmMGzASrXKXXlYaloRM/R4F9PjlTt9gmN/bPftGT6D6zOPlYBELsZVsGoP4AGc7lqHKf17sYotGsHrGFDYH80s1L3BceWzJ27RULZcCJ5yYE4F5TVha5HbRjnS9uJq6XKcE3yjIaMiD/9Hl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkKu3oVJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918w7qq009634
	for <linux-can@vger.kernel.org>; Wed, 1 Oct 2025 09:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fAG+r6LmnpS
	+c29A06CpnJf3DtWoAPxQEN6FpwdQPUk=; b=hkKu3oVJtxvzo3nFqAJrrxfSJLE
	28BuXxUzHcSkSHXTyMerNXvBT5bHeFlM5XKs56aBIzz1VdSCv0KnnggLO1/WFvs8
	JDWtQxcnEHIEVrFzrAsZlgrtPeIqBG5Sv1haLYyBl4bgEmXHybknUcjOFDZzWySP
	pXIbPiVy2STV9xuZfyh1buXnufB14ZlxX8E4zW7/Vy2+Z7cXWJVvy5NTrRPcWLsL
	Own9aUI4Xftjsh/UgvkQWP66ChC0fpP8NfLy1TysqVh77ARg9L66EOffPJtUE/+P
	keSWizTq6L3Qt1hjfHBc86kTT0//OjX2rKO7sUWth8P1gzsVvc4RZsyvhbw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977us62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 09:10:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2697410e7f9so146817415ad.2
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 02:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309840; x=1759914640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAG+r6LmnpS+c29A06CpnJf3DtWoAPxQEN6FpwdQPUk=;
        b=YOgXkGM8nHheSTuu87gjDtIQmESuWaISVpbBMcDZDCD0l3um4tyoh2yea+ZdenCH63
         3XsYOKTJe06KffroBHahkdy+xbIoPOipBwBI5DN7dsygBjm8RGMYLMPbsBp0dJnI/Ifv
         KJeTIjFg09KSzZOo3wAayFw4K6oADAl+i1U7feZdeksqEylSeY7YYaSu1pW5VroWGkwk
         wObVzLNG4lxkCOnIdRLDklMnPph9Uibx8BSnTpsR3om3cNDXK7g5lCDkY0QpMAW+HcQj
         3xqrP+Iq/VLg8kfUqADcNf342TjgVO64J89zj1jEAvIe3+mcztvIryU6tgDHaNfppzJl
         YWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzSakw1Kkk3zeSYsJx4R6lI2Jh7A74inLdxPdFOms+lirYOA5STqXFHGBxMtGGPzF16IyqHn3rmdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FtKQ6n/aCYmLB0An9ogCueN2+iZLjlzBD37oWFldLNsrUK9I
	v1wmI1Zz9a5rI4KZMCo7VXtUGdA1U0abY6hGZy3Wa+4NZ9CV30QqHseM07t1WavwjAo4uw+J9W2
	aSQxF8W3uuE6e7x/mUQxyFat8P7nulkUsYVac5NSkAJUzliRAFrhkvQUwXCeWHkI=
X-Gm-Gg: ASbGncudIJBN7ltASNGIKzzuu7UlcPQFhPvY7ltDbOHYF07V7oUJyabpQgG+6evkrjn
	32eN9SFU4zNPmEhtaREX0QArG6YPj0WvUBmt+6619y0FMHm9ZteP/0GZlgCsKHmCOi/1CG3DcHw
	ipir6RcYSTk92D9kUh2dfm2VbavPLq1sxMZ6/6dATHuJNWgmG38c475VTzA+w7WG8ejPKD73jxc
	K2/NdrEVSrSdSZKDuSvuI2GL+k4O0kjukSFZIiYUxf76zv3fxdd8WLcw3uNkLf2O70WQB3OnwEI
	d1yUM+LlQz6HuNOaEz/Iyocb2RhNjMoFf1OeKYVwFmis3cUpnq1RjBNObQY1dCD9ji/3hE3MXVE
	RwXjZ+A==
X-Received: by 2002:a17:90b:4a8c:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-339a6e906d5mr3004504a91.4.1759309839815;
        Wed, 01 Oct 2025 02:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG2Oc1zqD7w/nvyX6L05+vrpzpYRsOhSjBhkqgqLwDY6UG69cDOCWgjGqXzaNuipkL6H6UfQ==
X-Received: by 2002:a17:90b:4a8c:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-339a6e906d5mr3004460a91.4.1759309839344;
        Wed, 01 Oct 2025 02:10:39 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:39 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 4/6] can: mcp251xfd: only configure PIN1 when rx_int is set
Date: Wed,  1 Oct 2025 14:40:04 +0530
Message-Id: <20251001091006.4003841-5-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1DXanKBEsrgmzLt04m5gDHeXYuzChuL5
X-Proofpoint-ORIG-GUID: 1DXanKBEsrgmzLt04m5gDHeXYuzChuL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXzYTdaYdnbv71
 W5b7wMU201skPR/uxmnpsvCKgUEqbAkIav2+eTlclVDIH1IpHd+X4unBPzkfgARjnyzEEZXKaRo
 QHiMdiXdNjQOvsdf+WrB5eVGaAUDp3UfjdYzLX2pHEkS60KdsHpCd6oaX2AFL/hpNHJUyao7Bjb
 7TozdtUCc3brquUZ9sCKfnPATR3LDRsMopVtI6pqAe3mBVc3HxenoadJ0IGyXE+aE/4eKtgoj/B
 RXgO1yo6GLQoN6yGvViREY7YcxP8idZ7+DQbqvb9vcFqrX7mpGs4RFZk4MkZYYuzg7/U/0j+UgS
 qfJT3/WV+fM8//ktiCOTZQgIj008a9XQwItcqmNeKIP22ft5ySGsFT/8CQ39HczQzndSTSNsEjn
 6uwa3VRqot1orBw6j9Kwda2VXhw49Q==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dcf010 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=Zr3td6iJmGh5AMeZqZgA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

When rx_int is used th mcp251xfd_chip_rx_int_enable and
mcp251xfd_chip_rx_int_disable function configure both PIN0 and PIN1. To
prepare the support of the GPIOS only configure PIN1 with
regmap_update_bits.

This way PIN0 can be used as GPIO while PIN1 is used as rx_int
interrupt.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 22 +++++++------------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  6 +++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f9eabb1810cf..ea41f04ae1a6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -608,23 +608,21 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 
 static int mcp251xfd_chip_rx_int_enable(const struct mcp251xfd_priv *priv)
 {
-	u32 val;
+	u32 val, mask;
 
 	if (!priv->rx_int)
 		return 0;
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input/RX Interrupt
+	/* Configure PIN1 as RX Interrupt:
 	 *
 	 * PIN1 must be Input, otherwise there is a glitch on the
 	 * rx-INT line. It happens between setting the PIN as output
 	 * (in the first byte of the SPI transfer) and configuring the
 	 * PIN as interrupt (in the last byte of the SPI transfer).
 	 */
-	val = MCP251XFD_REG_IOCON_PM0 | MCP251XFD_REG_IOCON_TRIS1 |
-		MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+	val = MCP251XFD_REG_IOCON_TRIS(1);
+	mask = MCP251XFD_REG_IOCON_TRIS(1) | MCP251XFD_REG_IOCON_PM(1);
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, mask, val);
 }
 
 static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
@@ -634,13 +632,9 @@ static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
 	if (!priv->rx_int)
 		return 0;
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input
-	 */
-	val = MCP251XFD_REG_IOCON_PM1 | MCP251XFD_REG_IOCON_PM0 |
-		MCP251XFD_REG_IOCON_TRIS1 | MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+	/* Configure PIN1 as GPIO Input */
+	val = MCP251XFD_REG_IOCON_PM(1) | MCP251XFD_REG_IOCON_TRIS(1);
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, val, val);
 }
 
 static int mcp251xfd_chip_ecc_init(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index dcbbd2b2fae8..bd28510a6583 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -335,13 +335,19 @@
 #define MCP251XFD_REG_IOCON_TXCANOD BIT(28)
 #define MCP251XFD_REG_IOCON_PM1 BIT(25)
 #define MCP251XFD_REG_IOCON_PM0 BIT(24)
+#define MCP251XFD_REG_IOCON_PM(n) (MCP251XFD_REG_IOCON_PM0 << (n))
 #define MCP251XFD_REG_IOCON_GPIO1 BIT(17)
 #define MCP251XFD_REG_IOCON_GPIO0 BIT(16)
+#define MCP251XFD_REG_IOCON_GPIO(n) (MCP251XFD_REG_IOCON_GPIO0 << (n))
+#define MCP251XFD_REG_IOCON_GPIO_MASK GENMASK(17, 16)
 #define MCP251XFD_REG_IOCON_LAT1 BIT(9)
 #define MCP251XFD_REG_IOCON_LAT0 BIT(8)
+#define MCP251XFD_REG_IOCON_LAT(n) (MCP251XFD_REG_IOCON_LAT0 << (n))
+#define MCP251XFD_REG_IOCON_LAT_MASK GENMASK(9, 8)
 #define MCP251XFD_REG_IOCON_XSTBYEN BIT(6)
 #define MCP251XFD_REG_IOCON_TRIS1 BIT(1)
 #define MCP251XFD_REG_IOCON_TRIS0 BIT(0)
+#define MCP251XFD_REG_IOCON_TRIS(n) (MCP251XFD_REG_IOCON_TRIS0 << (n))
 
 #define MCP251XFD_REG_CRC 0xe08
 #define MCP251XFD_REG_CRC_FERRIE BIT(25)
-- 
2.34.1


