Return-Path: <linux-can+bounces-5037-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE8BA3E60
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7471516CFA1
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667BA2F83C0;
	Fri, 26 Sep 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/gCVSxJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DC2F83AC
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893442; cv=none; b=rKtnjOk09RwzBwCnKkvfYfZmAGUjBg9AEQ3G4sO3iXCP8iKMuDwDcE5Xn+qn4DBpjMzLhLIp2ecwYRNdlOqXkTlBkeRPVk+YnjlhDcT8cZWqOYDx3LECyVveEhH6DclR0v7y/c2QPxYwV8eItXkd8O+Qh34tHhZTYpF5mr15kNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893442; c=relaxed/simple;
	bh=+IOLF0XPvUULiaKZhdl3sSn55zuFmc8DaivaubnewwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJaPaROrx5br1Nm0N/T6UN/GbF/MaA0aU3lRuA7AvgwcmnoQM8JRYm0GVASE7rvibzNKDKjuhg01yr1hmLdwlh0zhPC/daHzLA7METRtAOCQDBRGGKLunNl6nWmRItWP7MQIfDdjuznE1OXrXW7LeG40yMKV4wgQFkD0wKHytVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/gCVSxJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vqMF021014
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QmS6oCHS+MH
	N39AhLGTMSeGEuEf2T3uv/XWwxaYqPAw=; b=m/gCVSxJp/vkvDWz9f6l6NsLaBp
	w3+bkwbPE1iXtmIXIOb/CyKcHbmhXFdZ+FtlRDT75wFX2YdNzkXRImMlhIBA2/BX
	XvtWn8OBLbpoyah2nsrVCCSNjdomXWYQwol2ObeHLKnGkJM8q1E7wcKFpStIbVUj
	zWPamctQjQcA16xWuGECMvu9VbDCbnwo0iveauX2HAoypNmRK/+cnbEaT39uGxz3
	5M86cCAH9FcBC9RBjqUmOcAr7gXzrUfc9c/QXzgCT3EsvwB2eY+rkusILFoHlZcs
	eF0gGRM8PuIV0o7uij7XO/VsensQAFLwCm5EM0VcU+NyhYnLV4gRhGX7d3w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qu0en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781044c8791so1783050b3a.3
        for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 06:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893439; x=1759498239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmS6oCHS+MHN39AhLGTMSeGEuEf2T3uv/XWwxaYqPAw=;
        b=OZOEzQ8l5zBhU5DE7oUHx5cy5256xJDencUkI6NT55B3yRNV8NMSN9dB+8zKPxH8fx
         cfMld2EmDpa79U0GY0p01W4tyArnFfaB/IicGaJHvoS0T7bb1mp8cYfuI/+8ym2v2WEW
         fOuyOdi66l3siQkvR5LoH6KCM0iH5uLY4gBMxl1wKKmn6bId/GmHHxtqdZFsBf2/41Bo
         e+vQDwtRD2ncIxTnMbLIv6JHkvq7oEqpBBjboJroKu46btxIU6eBrXQLNihLWhA6PIH0
         FSGBDA6rLJhIXIM5Z6orwahTePFrLoV4bxHZsVQA949wXbPx8OQIO5Pf2mZU927pBxkY
         CE8w==
X-Forwarded-Encrypted: i=1; AJvYcCXbfLqERYCfjnaWDLlajnHfp96k36rI98YOUrqm/qIPJwfWnUw+SJ/nsxlYdcOWk03ScRgPg5lxUQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmdRZtAHO5uTa0QXzBpI4qB/Ga9Ea4QZsgYEO+RWfTuLyMMyU
	7WRT65GmVPuJ8nLMRimQSSIsvuv9pcgs86vhTJgs92GiB0vapf+QMzFfunuUpaDUpoCuAsU7w2m
	csdWo+DTiWIgMhsZgB/97dGsByU7cRHRI3fBzC6ckx0+zMhEZ+bDiXC5mkDRKRNs=
X-Gm-Gg: ASbGncsqxMFjP793Dqdzfk/WOpwNIZ8JyxGUHUDGP4HfTdFvIOs+qnyhhHN/KtEYMPs
	x0RUSzd8ROr1TGkn4SDQQoZlmgljK/fOb0340l7PgtnEX9OTPv/Y5wopQwaCtJxjZxtBbIvy0s1
	iHg11ohj2Wtj8avddNAMPeaV/Hpz5NkvCtk3Ug2OG9v/WNqeBpgzVy+12qDbUZxC/DY4rDTrf+d
	vUPOUqBsNBoF5I7SkoMU9XSPxu6QTpTQ4j3wwhwe37eMbFHzWwENWPVcwwYmOhMNzGl12eeUqLp
	r64v4hbjY3fYUJYLx2QTs+lTk3QiwkcWFg1uvgHeehAA6fgo0HadWwOIq7sqtuf9vky+5n9qkY6
	U
X-Received: by 2002:a05:6a00:2d88:b0:781:21db:4e16 with SMTP id d2e1a72fcca58-78121db4f59mr624975b3a.4.1758893438929;
        Fri, 26 Sep 2025 06:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsielPPomP21N2Fqm4F4onXqE5w84lbLbYWd6SPPbSs5v9gEnLj3E/5yVmC9Upkyo6oZ+pXg==
X-Received: by 2002:a05:6a00:2d88:b0:781:21db:4e16 with SMTP id d2e1a72fcca58-78121db4f59mr624916b3a.4.1758893438284;
        Fri, 26 Sep 2025 06:30:38 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:30:37 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 2/6] can: mcp251xfd: utilize gather_write function for all non-CRC writes
Date: Fri, 26 Sep 2025 19:00:14 +0530
Message-Id: <20250926133018.3071446-3-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: KpMtD7TmG9E-nw2LchcwjHtPTdZowx8h
X-Proofpoint-ORIG-GUID: KpMtD7TmG9E-nw2LchcwjHtPTdZowx8h
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d69580 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=lCqp9tVl3zhOgjhhuWQA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXx/I3p2pX7sGD
 L3KrBaztTDROhaFv4E+iISu4tpMZ95bL9st0yh8dCKNKwhadJ8Cza/tbg0+1dhPGkz/na8hq2l4
 N3ZlWiDa6ZX7UGbCWCu8DKkRKTeQTor/jxZwAWyYp7+iboqik+X0Qb97wBCer+xmHnc62cU7dT/
 aKMIijzw8LkHQvQ/874hqtQuWnHET3GOdgI2mWUwenzsq921ZBG0/v0n9jEkCJqLzBtu4J0z1RJ
 DUVTm/n/e9pnlVdabsXEZF1o2tPGz+aN+X1YhHl/gZjKmD5xQ78YrNydN6O5ROLoYq1tf29vGUp
 FMWZq38IebjI3IR0T9iiFlu5gtoICT7l8iS00kLNgqeeApqUySsDvYYA2+4XYkY4NDCvXYxGgGB
 4s5+TDvTheyvnnkcoprB6P2Mb8Z22A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

This is a preparation patch to add errata workaround for non crc writes.

Currently for non-crc writes to the chip can go through the
.gather_write, .write or the reg_update_bits callback.

To allow the addition of the errata fix at a single location use
mcp251xfd_regmap_nocrc_gather_write for all non-CRC write instructions,
similar to the crc regmap.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 8c5be8d1c519..e61cbd209955 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -12,14 +12,6 @@
 
 static const struct regmap_config mcp251xfd_regmap_crc;
 
-static int
-mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
-{
-	struct spi_device *spi = context;
-
-	return spi_write(spi, data, count);
-}
-
 static int
 mcp251xfd_regmap_nocrc_gather_write(void *context,
 				    const void *reg, size_t reg_len,
@@ -47,6 +39,15 @@ mcp251xfd_regmap_nocrc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
+{
+	const size_t data_offset = sizeof(__be16);
+
+	return mcp251xfd_regmap_nocrc_gather_write(context, data, data_offset,
+						   data + data_offset, count - data_offset);
+}
+
 static inline bool
 mcp251xfd_update_bits_read_reg(const struct mcp251xfd_priv *priv,
 			       unsigned int reg)
@@ -64,6 +65,7 @@ mcp251xfd_update_bits_read_reg(const struct mcp251xfd_priv *priv,
 	case MCP251XFD_REG_CON:
 	case MCP251XFD_REG_OSC:
 	case MCP251XFD_REG_ECCCON:
+	case MCP251XFD_REG_IOCON:
 		return true;
 	default:
 		mcp251xfd_for_each_rx_ring(priv, ring, n) {
@@ -139,10 +141,9 @@ mcp251xfd_regmap_nocrc_update_bits(void *context, unsigned int reg,
 	tmp_le32 = orig_le32 & ~mask_le32;
 	tmp_le32 |= val_le32 & mask_le32;
 
-	mcp251xfd_spi_cmd_write_nocrc(&buf_tx->cmd, reg + first_byte);
-	memcpy(buf_tx->data, &tmp_le32, len);
-
-	return spi_write(spi, buf_tx, sizeof(buf_tx->cmd) + len);
+	reg += first_byte;
+	mcp251xfd_spi_cmd_write_nocrc(&buf_tx->cmd, reg);
+	return mcp251xfd_regmap_nocrc_gather_write(context, &buf_tx->cmd, 2, &tmp_le32, len);
 }
 
 static int
-- 
2.34.1


