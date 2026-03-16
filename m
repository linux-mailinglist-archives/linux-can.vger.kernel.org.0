Return-Path: <linux-can+bounces-7089-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKOvGcQFuGlpYAEAu9opvQ
	(envelope-from <linux-can+bounces-7089-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:29:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2CA29A606
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BCFB307AFD7
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47B397E7C;
	Mon, 16 Mar 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahwkKhMW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GHuJHQiA"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1E3976AF
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667215; cv=none; b=WXTebpe/7kJXgrFsqLpwyESTD3hDinApJ1t0fNd59syjdGAJL8wxfskIZ/pC81cdefZg9HBKZodZNwb+dgrWjl+GZ4bfy2knQCRkD+BnTHxYoCfD2bDauNQJ5F94LRkdWGFpnBLh53RUXRUvB3Y+luUI6VlrxTQTt+Njowei70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667215; c=relaxed/simple;
	bh=nA8U/iwRABvjNTx2JQEwhwxwRQjDOtrXw15Af+P3hFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9UD24QyUh6Pwn2cXWyrYfTlyT7k9GUmzKTx4yaqpcqPizWOVo45aU3qx7iAKF5ApCrmqdQ1FoOousF1jD1EaTHuDT2XFy34oZbYdTQk+Bicrl3B3tTy55z8R147HhWF8zCKUkin/w3XQjgbxZJb6om9hY7JaCyasTDnscvE4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ahwkKhMW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GHuJHQiA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBYadK1282088
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=50e4WqrX7UY
	a9bS7lYNGP5/8mA2vG+IzNq+mgjXtBT0=; b=ahwkKhMWx7WA9gJ3fd1zeEIECL/
	V/2vfGCdx+6gqIRlfgHULvNNG1FnbAHau6RcqC55zCLC9AXPZmWRaRPFGF7/3s8h
	eit+5P4HihierCbx4lQtQsffGxMLOr4I8eg16B4LqyfEmHbaTIMYn1x4fgiBdlw8
	XRVYWzv7fRR7aSgAQlI4VdNu/ikFMC1XLn/Bf23LxuVdOMNw7gOdGR4diQblHqSR
	jPgn0M6XXncCbeqITQI22IGNI+PdUInAeZLy0Rmmvbx8aaO9x03ZLe/HymgW4Jpn
	4tAGoEpb4ZeLsOsAkUimfa6H3eqE4ajqzjQaQsUWbpqcQ2+DXllsJmWgAbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyyc5s73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5269342a91.2
        for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773667213; x=1774272013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50e4WqrX7UYa9bS7lYNGP5/8mA2vG+IzNq+mgjXtBT0=;
        b=GHuJHQiA6Gl3VZX4G/GtW+mjtjFloKshplLwrhks4cSqBzOw21H3s8yzzO7zXaLGUv
         OXmAllBewxpzDFz9en/aem5oQpeABvIB6vleTZ71mrWkh8Zf3yFSClm4H4APumESfMu5
         nDm4Gv7oprzjW+T2ma8vp/ecSwzfBzkX6+obUXR8i+EPNHV8g5NPB4Ey/mIit0bLgSjR
         8CpoIrqx3MR3OOfQRCZ++dF6dOlSHFRLaiHPwaD7L2mO6OYRu8hhwW+JZShunleaP9cg
         m6HMhWoM1P7SFxpdE/RomjJl6zTJxYHGA2mUo6B7zLFnE+wtvtjuvPLrMpj4k7n/do+p
         2WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667213; x=1774272013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50e4WqrX7UYa9bS7lYNGP5/8mA2vG+IzNq+mgjXtBT0=;
        b=ceF07FohlueP4L39UYf0/vKdTMILETtWmQ6FxT4tnxLEN1IooA3q/HWrIxxuOqLskB
         dOZ95QoLiL7wMvxQBPsBVpOKe7csgzd8U+aOjPZHamHxdaZBBL5fzJrHEQr1eO5pVsEJ
         z75J2pklCpqVVvsecR463feuAXcxOKBcmuEGTtDpNguveDDnoD8bpAhN3xch1Sua3kzp
         9NIV9A44r4npMHksavN2FS0d+kHz06UxMZprEyGmloF3k40DVpFJksweo9khzx/ZqdoY
         O5Rqf/yCp16uvjE+k69Or9K3XFEm6IIarFWJgXC3HZCBmjbExxXW4bd2IYrMXJWTm8FA
         8i3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVm4k5PZjkuVjX1iEX84UZo+GaHlCmCacOnyVsxhFNoOZgXgqpgm1isn5vU/H5viPpnAjcL/RG3BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrIsD9yDDoy2cN9U/kQELBTGS9lU9D6nCRcTiZH2ky86EhpUd
	CJzsjPHP5IgEGnr28X8QCpWS36EMY+f0YO7MxXTDlfBwwJEPxaTkmbOjGyCH/PT+n8iESZ0dIib
	kXLkugci+BzdKHPwLWIM5q7+ayAzCpZ1UMELl79yphD2sAeOPZetkjHDUfxMLZc4=
X-Gm-Gg: ATEYQzznjFpzNy6vwFoKtMskwkikIyPb6EtRW9mZWtE6MSnZXbHOb4gpA982v5ajVE1
	Gn2F8pDGcHbCnr1M1EyhGqXHNm9FgW1W4brseAbANWnes7ndd3nR36ce4nF0hkixqSfX2Ap9O4+
	V0XaPXqiC4thmTt374rkZV6QHBcvP9v7JvB+jdchZkfnCWt1SjbL3REMNYxw+vZz/PRhm0JS0vb
	wnPravHC3DYulqCa0mHd++qHGIRCZWK0968derF442/uUBBgK//NyGOxC7RppsbpVeNDkHw9K7t
	H+hXCxQpJJC3wyS9Csxw5BJMdYTmHJ+CHMXUegG5UQZ6cvA+Mo7+pZ5X74wM0If/DGJlklSvzXB
	s1gH4aFSsZohWfiYwEYZM8Tw/mHe13NNsOa0hSf4tSL4ZtlSOtEE2pJJSCw==
X-Received: by 2002:a17:90b:3812:b0:35b:a960:62bb with SMTP id 98e67ed59e1d1-35ba960651fmr1013831a91.15.1773667212740;
        Mon, 16 Mar 2026 06:20:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3812:b0:35b:a960:62bb with SMTP id 98e67ed59e1d1-35ba960651fmr1013796a91.15.1773667212067;
        Mon, 16 Mar 2026 06:20:12 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9303eb9bsm5209648a91.8.2026.03.16.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:20:11 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 2/3] can: mcp251xfd: add support for XSTBYEN transceiver standby control
Date: Mon, 16 Mar 2026 18:49:49 +0530
Message-Id: <20260316131950.859748-3-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
References: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=euXSD4pX c=1 sm=1 tr=0 ts=69b8038d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=8AlNlYzCCwYCxcDbmjsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: MMTBD1AW4yKWD1ep6i2EmdFHtfthVwlu
X-Proofpoint-ORIG-GUID: MMTBD1AW4yKWD1ep6i2EmdFHtfthVwlu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMSBTYWx0ZWRfXwa4wRdTjPnmo
 aq0PIH81uFPxejHoUaZaiMG6WnsoP9tCCTwix17Lh90rFfKYDUyEOBw6WThSEJ1V2PE8ODjppd7
 e8NA58X2/9bvOXBrgLUT9V0456iLjRTDhAE4Q97hmW17djGntnx/eJne51/dvav6a+KTvXInEOo
 Yr61ETvyW9D7JUMfy4scdmC1dDqPK4hqDh7Y6zXrP8KukZlr3ZdT6KYHz/76H8LTWuqcqgRTDwG
 kXJTvc2N+sG13suhTvrgEDAYfRYqWMyKabpaZ3GhIKZlbQyKfW4qszAR9yEtbpnNkCulaYVw5eH
 RnOOq/hY6YNzAJERSDQcUXTn85fGVg5ChL9/LgTDUWnG8WECD80B1j0DYBE24khdXItMU+QhG8z
 HKGhR9waL2OfZZZdnqaJKp6aRuWTJfaSTD33fK2p/iqxQ1RMpQOH71BUvyTYL3ymmC3siyHpmS/
 l77R7qV8ucItRMMd+HA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160101
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7089-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C2CA29A606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MCP251xFD has a dedicated transceiver standby control function on
the INT0/GPIO0/XSTBY pin, controlled by the XSTBYEN bit in IOCON.
When enabled, the hardware automatically manages the transceiver
standby state: the pin is driven low when the controller is active
and high when it enters Sleep mode.

Enable this feature when the 'microchip,xstbyen' device tree property
is present.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 30 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9c86df08c2c5..7a152acf4931 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -764,6 +764,29 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 	mcp251xfd_chip_set_mode(priv, MCP251XFD_REG_CON_MODE_CONFIG);
 }
 
+static int mcp251xfd_chip_xstbyen_enable(const struct mcp251xfd_priv *priv)
+{
+	/* Configure the INT0/GPIO0/XSTBY pin as transceiver standby control:
+	 *
+	 * - XSTBYEN=1: route the pin to the transceiver standby function
+	 * - TRIS0=0:   set output direction; the reset default is 1 (input),
+	 *              which leaves the pin floating HIGH and keeps the
+	 *              transceiver in standby regardless of XSTBYEN
+	 * - LAT0=0:    drive pin LOW => transceiver active (not in standby)
+	 *
+	 * All three bits are included in the mask; only XSTBYEN is set in
+	 * val, so TRIS0 and LAT0 are cleared to 0 atomically.
+	 *
+	 * Once configured, the hardware automatically drives the pin HIGH
+	 * on Sleep mode entry and LOW on Sleep mode exit.
+	 */
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  MCP251XFD_REG_IOCON_XSTBYEN |
+				  MCP251XFD_REG_IOCON_TRIS0 |
+				  MCP251XFD_REG_IOCON_LAT0,
+				  MCP251XFD_REG_IOCON_XSTBYEN);
+}
+
 static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 {
 	int err;
@@ -800,6 +823,12 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
+	if (priv->xstbyen) {
+		err = mcp251xfd_chip_xstbyen_enable(priv);
+		if (err)
+			goto out_chip_stop;
+	}
+
 	return 0;
 
 out_chip_stop:
@@ -2271,6 +2300,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->pll_enable = pll_enable;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
+	priv->xstbyen = device_property_present(&spi->dev, "microchip,xstbyen");
 	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
 
 	/* Errata Reference:
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 085d7101e595..d3f4704e2678 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -672,6 +672,7 @@ struct mcp251xfd_priv {
 	struct gpio_desc *rx_int;
 	struct clk *clk;
 	bool pll_enable;
+	bool xstbyen;
 	struct regulator *reg_vdd;
 	struct regulator *reg_xceiver;
 
-- 
2.34.1


