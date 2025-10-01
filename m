Return-Path: <linux-can+bounces-5075-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF0BAFCB8
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3233D4E29D6
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4312D9499;
	Wed,  1 Oct 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hu8WF6OV"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B22D97A1
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309829; cv=none; b=Ur6I3SDxqk/ElIV3UprIoolvYtTir3IAyolZtRFmSQHMAcjRfHja3WUNSLykwNiaTF6bMnVw8CQDKiy0/CuqMBLl7ZuCpZmdJYw1ejiUTMUReV/Du4jtPMZCYE1Kbtv0yfXx8QAlxdIt+lA0oRbOFpYJj096mK1x6PFPW32+M20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309829; c=relaxed/simple;
	bh=+IOLF0XPvUULiaKZhdl3sSn55zuFmc8DaivaubnewwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQt1W7XQ9KMtVXqJI7DGJtwkMSka3W3P/m5ZsQY9/CT4Q20xr2SdnCm1KfuctD4ZAdtZwsxMZwDQX6wNDK+lAJmP/oKxtrn+W/3savw7L6LmrncyB9St1CeQURXs9P0sdV1TZR1APey6bPNJApZOxoIi/JnIhp6zqzOrH9w/zDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hu8WF6OV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMIT1O016964
	for <linux-can@vger.kernel.org>; Wed, 1 Oct 2025 09:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QmS6oCHS+MH
	N39AhLGTMSeGEuEf2T3uv/XWwxaYqPAw=; b=Hu8WF6OVCKn3Skl4NYACHfGx+rA
	/5DwJ2FQIQmNip1e4GJ9VczFdpAbm5sMd8lMOZLDCHU2aH/9VsHWCcm2nU76z1Ue
	i/3DDrMxjSb8YdT9/q76m5hfXz2C5y0eZtwNEjnM+eOZyhlnELgrbVb6QplFjdzu
	xuRnevkPQ609FY5UNoHxhJHtVKojXQwCc9iyFO3CIr/b7tGnStzJY/HnZ0lj6HEo
	WSmABK5V5/WdEyr0DPQwWTQKN3aaWPfz1BoeyaUmx/XwfuaWTTUpinBfPoZJTf6o
	7q575aoB6nKh1p4/k8AvXLYPtYB5NaIrEyN5RGOIszsPafPuHTV25MU8z+w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkp78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 09:10:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b550fab38e9so4876982a12.0
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 02:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309826; x=1759914626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmS6oCHS+MHN39AhLGTMSeGEuEf2T3uv/XWwxaYqPAw=;
        b=clN86l0jS3a41By8fibny7/kQi3QgBYDGagZUOIWtYSF/1L7GSOMRuDA7GrKEj212+
         oG3ZzyKk5y1OMTtDybuivddMvgZ5iO1JnsnDQbOVUKbAywGJxeUhzMC0fRxLBrBZwL1D
         AgQgTBP55FB3P87ESk6ETwvZD8/xrQG4P2gLCSFWwAWLPTM1H60mjG3z/bOX3O6uFHVA
         PdT/JDfdSCyjHT8YrZ1XR3EmAWaoW3dsAcicA5rI1zl63II8FPBob4mgJCdN6MlVWKq3
         oc+5A9KokAISGxEyQLFZmOZf5Mjp+SR8S9ffpXn54x7+9n/m2aIdDDmo7MSpH9RPixW8
         v6RA==
X-Forwarded-Encrypted: i=1; AJvYcCUkZU7UoMrFXmKQ8mly3c8/p0l9sI4S3PYEkl1BRrqZwe9D7sDJyGdM6cFAxbZxlWhoblZUkDxkCro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhALqn59G/v2QgINH9v+aL7sB34hTMtaVlnDbGiw5ckURmV9q
	j3s64brzwSsmfOh6J8PMFV2azLMpwXnkAnUa+XXw0oSvKEKcpEjCPY2I1Ttk1mjmz74/1Pn9Nvt
	V3tkG+PoZ+sFKu3+iZgmu/4/bBuddKJC7/MJ+p4V2DRUmXrv7ID+FC0awKCgVIAE=
X-Gm-Gg: ASbGncvREHQz6kuB1ev/k3QJz+OpPjTCE7tgVr4ZGUPOZx8r1ls6qgSDRRZEKrgkidO
	edqoawtXt7cxdccq4sGWipydgfeyBqnNfF+4CsmKVrEM5PDKwuuGvLcsbjz55eyJ8+Vky0/eKuZ
	nBTthLAv1HoPmhsYP6HLLzGrVSe3ASsWVeZj4C7cEzV82pmF/Y5fkPJwzHMjutvtoINS/hxEndc
	A3R7zot9pDKOV35fRnlCFJh/vh3Njwo85I6h/siWKUqu/ZRZNUecBiw2GbwY3w4Xf4g6XXXkFXR
	ifiHCxAX3rPQRUJ9v+wIaXslOGRESaDQko9MmjCikKQ9woU1CDQWsg+dp/azxwfiQb7Ac1F28nY
	yk8AKbA==
X-Received: by 2002:a17:90b:4c4b:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-339a6ea6944mr2853267a91.15.1759309826217;
        Wed, 01 Oct 2025 02:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+bOT3MEqE41+QlxIP2fM85SUvDyvlyXBiaARdM+M1zo58jJX+wcMITxe2A+o0XfcEuLOxPQ==
X-Received: by 2002:a17:90b:4c4b:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-339a6ea6944mr2853241a91.15.1759309825769;
        Wed, 01 Oct 2025 02:10:25 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:25 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 2/6] can: mcp251xfd: utilize gather_write function for all non-CRC writes
Date: Wed,  1 Oct 2025 14:40:02 +0530
Message-Id: <20251001091006.4003841-3-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX5FzPWYZZfh9F
 ys8xfHP23JFxTu2Qeoak4QREMDUYHX/JZltS6AnYH/iITi5oWVxjvB+eRN5lKGPsbSuxkQvVWfb
 W8ZcR6URcQBTK29kUagFOWsKgZZlInhjFyk2WTtva47LoCL8b03OA1etF8lHMpIIhuCI/+EQcvV
 nuF03Yw3YHYNpjOKSoOGRtRH7VlLlKupd5r6QUJJiGroIVvKg40n1ge0/YnulbchHQeCk60GCzK
 DLqKjdaNa0gZxhPQxstBBXexA0mT8L55Zw6CkUSt+chV2+hrxlB7j9Tx5eRINvjwupt1rhg5JzA
 pVtpxksW+pNxO9t2WwzvjAFuuZlV3fXkJmDyGDL2+sFshAd+3D2FmE01YbPgB0M/UTjpvqaWxel
 NsJv6W0OJ4rZN8DwTkHQTjzC2+Ii8A==
X-Proofpoint-GUID: YzKmUxC9ZvGf-RetcIUqEINc_1nkW9rR
X-Proofpoint-ORIG-GUID: YzKmUxC9ZvGf-RetcIUqEINc_1nkW9rR
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dcf003 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=lCqp9tVl3zhOgjhhuWQA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

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


