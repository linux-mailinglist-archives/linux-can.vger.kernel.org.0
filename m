Return-Path: <linux-can+bounces-5076-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942DBAFCC1
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAE32A0283
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741B2D94BE;
	Wed,  1 Oct 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VuRBuuXb"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68E2D9EFF
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309835; cv=none; b=Xa+hENreyWtiASFRVGK9GLPVKgr9AXOrQQdJor+HIv87RzHvgSzUP8szLIj0czUKWU6p21xuKoKo+P3EnHmleAH+BsvN2X2zl4TVNbVuCxt1s5nLuxyqzCgR+6KKoWZPUmYs3MUIplA7ZN6iBbkydmEmxPx9XnabnPPKmJITfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309835; c=relaxed/simple;
	bh=qKSG5ADsXNKPjV3nlzlHBiIYrmbuMHtoYqrl7DKLOKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAXTSsK5JVkHy985bTKFyrKboqNB9rGUfmVzE9LbmQ5RZ9dmqQSK9Ickvk0+t7OjyhsgHBdtgl0hXmsAWLN2g7SPgroz4hnZPQrroFycPCzbUIUAvzblefQ5LFUMlBu/DIIG+Tsac8yFS8Owo8/iYqNRdkKLE/RKUqbReb1VYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VuRBuuXb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMDIGw001106
	for <linux-can@vger.kernel.org>; Wed, 1 Oct 2025 09:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o0FOP3SERm0
	lzOQVjmAaIk/cr88mu/vSl0/yi1Gxue0=; b=VuRBuuXbQ25g4pw/KXGNFZSXySc
	ou3OWgN5RR5xxGX7PxtwaXLN4cFdeTN2HOzYlyzEye4fo7/xvtGhOpWQzTyizpct
	O1hJtCSQiX9+7FwwMQp5pegp0XVKBLcCtXmZcVn0hNoauDfRGA/O7i8Q/IIX8DeZ
	fULc/TENF2jFaZqnp/Jp5k8vPkMg6MPY8ezTfQL19ErTlqVv8hApxu+7KLwneT5R
	ti1KMm3fKDr6IeXJKfkHhKoXhtvdC9ybivy1TiOa2/3I3eYPBvp/TmEmChwefdHv
	VMSdA3lemdDrFsceb7TFfkC4I/1k/pYKwQWKlL8Va/J+vnABrgJL4rSywtA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr7erd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 09:10:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5509ed1854so4656421a12.0
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 02:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309832; x=1759914632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0FOP3SERm0lzOQVjmAaIk/cr88mu/vSl0/yi1Gxue0=;
        b=T6XkBBVvdfX2+cHvQ5VvPauTUY+pK6AOAyC44hduevR+A8uNFqLxWgeqEPIo8gQLCB
         sh2lVaC+Ng7mhhyQ7UMovpN2wUATvcuKZCl/Oq8VeCE6qVsKcmj8Loquv163ZA8+9p6X
         kY7LWkJyH6gAJD9xgSZVQ2svAgrA26Ka+qfhhuU+ie1e3hZxNVvh3trT3/+mg7t/lXzv
         S6TQKtgOxOYMIKwE0udlZjwMvTXOVktp2SKO+6TSbmcHh+FjCGmMMdY/TwM4zpZFVn3P
         TU5EDUiJgI7yslV/UuMKv/CHuoOO35OcdAXgzGoFJOPWkXnM3xK4Z9wBl1fos6ZVJJLi
         58MA==
X-Forwarded-Encrypted: i=1; AJvYcCWV+narmbpWPQYkbGpmxO8a6vfTcKVJz19Oe57kXC3JWCyumooi+MoT6xmgIGW4DzuVmhKknqqvjsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyqdaHvTgY38WyvjA8I4TpF+jQKi82UHVkvn9yIIZvVE8RxNTW
	+pSp8dcGqSvFr4Mm3I95iN27F/yWgYFc4n9/eOuz9OF7BBBteAWlbO2nIZVgz1HCm4MMxaGf56m
	hnUo+K9U5Ckx2qLA2MzWQbgQd9X9zPmzTdVSPjrVdrE/znVzy4C+O1RWaz+XZuLw=
X-Gm-Gg: ASbGncvN29QIKVzBvCHBoxwBsvxExhr7obSi7LsmbEzI7G0NWEzIst/sFCHUlYioLG3
	Ct8/HWdyV8hoRQaSgTOj36f8OYn4wjRgossggLFoBoursKrm9z9e4rTpZ7jNr1zEViSW6ltsEl5
	QYkQFXpDKo9I3B5+Lu8l1gADlfZabmakymr5COvbFwRK3HWSu8dbxBiFXswn+csBAmRKuxmdP2q
	516dA303oHFGkKWPFobgZNO9Lx39hWP/JoWsSbK/vztpsZXrn+bswUMhJQt6onilMuo2zgBP2u0
	pLvGXDxMvEw9HZqXDNbQD9EglEfoWyglN6fOZuCTwdWemek1z9kBT6tae0HK1nEQsf3kw8GvXN4
	NZ2Mqdg==
X-Received: by 2002:a17:90b:1652:b0:32a:e706:b7b6 with SMTP id 98e67ed59e1d1-339a6e75590mr2738733a91.11.1759309831575;
        Wed, 01 Oct 2025 02:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHrsbDPHS1HxcDO+K/KipyOuzCxhUrgWjzzx0QS2Hg/EFoTGnWxrcFhl3HffiKGv+LxmMJQ==
X-Received: by 2002:a17:90b:1652:b0:32a:e706:b7b6 with SMTP id 98e67ed59e1d1-339a6e75590mr2738704a91.11.1759309831072;
        Wed, 01 Oct 2025 02:10:31 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:30 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 3/6] can: mcp251xfd: add workaround for errata 5
Date: Wed,  1 Oct 2025 14:40:03 +0530
Message-Id: <20251001091006.4003841-4-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX6QGfvV2w+PkH
 KgH8pgj+zID3mPpo4LPQ+ZFI2GmBABl3CVgeojrBRk5xDWqaE/SxmcQi/Yhkfun1G3YBBoc7fFf
 u5xGAQK9EJ2kINdKt3F17KHpqVd8OB42isqXh2fP1smtq+pJacDurhcTDdH4lxUipuEcW9Hu/qo
 MNZp6XDBjKzfoBwGKwlbvGUrYy7ilsZsQ8I8HcJ7XEhIr8St9XLvhFR3LovrDAtNxI7grojGZYg
 I423W5xlw6IigIJqCYY8xzKqP1NFKQFWMbJm8u9crfaCdib9KmktwFSkeEzb7uicDPFQqA5Daka
 aBw5vlmu8F6RgZ9Q60+G2sAvsTYLbLxjkhARihIT9knSU7whuNLQRXB/IRi7jMnr2GZv1iiw40+
 hHFTp2juD8mQzmSCj/DxZ4j33FKgsQ==
X-Proofpoint-ORIG-GUID: xhwUVPardaZc92jVu-MRDy04Ncp0nZKO
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68dcf009 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=-2jKClcn1S1UO4fOL_0A:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-GUID: xhwUVPardaZc92jVu-MRDy04Ncp0nZKO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

According to Errata DS80000789E 5 writing IOCON register using one SPI
write command clears LAT0/LAT1.

Errata Fix/Work Around suggests to write registers with single byte write
instructions. However, it seems that every write to the second byte
causes the overwrite of LAT0/LAT1.

Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 89 +++++++++++++++++--
 1 file changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index e61cbd209955..70d5ff0ae7ac 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -13,9 +13,9 @@
 static const struct regmap_config mcp251xfd_regmap_crc;
 
 static int
-mcp251xfd_regmap_nocrc_gather_write(void *context,
-				    const void *reg, size_t reg_len,
-				    const void *val, size_t val_len)
+_mcp251xfd_regmap_nocrc_gather_write(void *context,
+				     const void *reg, size_t reg_len,
+				     const void *val, size_t val_len)
 {
 	struct spi_device *spi = context;
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
@@ -39,6 +39,45 @@ mcp251xfd_regmap_nocrc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_nocrc_gather_write(void *context,
+				    const void *reg_p, size_t reg_len,
+				    const void *val, size_t val_len)
+{
+	const u16 byte_exclude = MCP251XFD_REG_IOCON +
+				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);
+	u16 reg = be16_to_cpu(*(__be16 *)reg_p) & MCP251XFD_SPI_ADDRESS_MASK;
+	int ret;
+
+	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
+	 *
+	 * According to MCP2518FD Errata DS80000789E 5 writing IOCON register using one
+	 * SPI write command clears LAT0/LAT1.
+	 *
+	 * Errata Fix/Work Around suggests to write registers with single byte
+	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
+	 * is for read-only access and writing to it causes the clearing of LAT0/LAT1.
+	 */
+	if (reg <= byte_exclude && reg + val_len > byte_exclude) {
+		size_t len = byte_exclude - reg;
+
+		/* Write up to 0xe05 */
+		ret = _mcp251xfd_regmap_nocrc_gather_write(context, reg_p, reg_len, val, len);
+		if (ret)
+			return ret;
+
+		/* Write from 0xe07 on */
+		reg += len + 1;
+		reg = (__force unsigned short)cpu_to_be16(MCP251XFD_SPI_INSTRUCTION_WRITE | reg);
+		return _mcp251xfd_regmap_nocrc_gather_write(context, &reg, reg_len,
+							    val + len + 1,
+							    val_len - len - 1);
+	}
+
+	return _mcp251xfd_regmap_nocrc_gather_write(context, reg_p, reg_len,
+						  val, val_len);
+}
+
 static int
 mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
 {
@@ -197,9 +236,9 @@ mcp251xfd_regmap_nocrc_read(void *context,
 }
 
 static int
-mcp251xfd_regmap_crc_gather_write(void *context,
-				  const void *reg_p, size_t reg_len,
-				  const void *val, size_t val_len)
+_mcp251xfd_regmap_crc_gather_write(void *context,
+				   const void *reg_p, size_t reg_len,
+				   const void *val, size_t val_len)
 {
 	struct spi_device *spi = context;
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
@@ -230,6 +269,44 @@ mcp251xfd_regmap_crc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_crc_gather_write(void *context,
+				  const void *reg_p, size_t reg_len,
+				  const void *val, size_t val_len)
+{
+	const u16 byte_exclude = MCP251XFD_REG_IOCON +
+				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);
+	u16 reg = *(u16 *)reg_p;
+	int ret;
+
+	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
+	 *
+	 * According to MCP2518FD Errata DS80000789E 5 writing IOCON register using one
+	 * SPI write command clears LAT0/LAT1.
+	 *
+	 * Errata Fix/Work Around suggests to write registers with single byte
+	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
+	 * is for read-only access and writing to it causes the clearing of LAT0/LAT1.
+	 */
+	if (reg <= byte_exclude  && reg + val_len > byte_exclude) {
+		size_t len = byte_exclude - reg;
+
+		/* Write up to 0xe05 */
+		ret = _mcp251xfd_regmap_crc_gather_write(context, &reg, reg_len, val, len);
+		if (ret)
+			return ret;
+
+		/* Write from 0xe07 on */
+		reg += len + 1;
+		return _mcp251xfd_regmap_crc_gather_write(context, &reg, reg_len,
+							  val + len + 1,
+							  val_len - len - 1);
+	}
+
+	return _mcp251xfd_regmap_crc_gather_write(context, reg_p, reg_len,
+						  val, val_len);
+}
+
 static int
 mcp251xfd_regmap_crc_write(void *context,
 			   const void *data, size_t count)
-- 
2.34.1


