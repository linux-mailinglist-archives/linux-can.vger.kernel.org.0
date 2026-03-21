Return-Path: <linux-can+bounces-7206-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHZ3AJiivmmLVAMAu9opvQ
	(envelope-from <linux-can+bounces-7206-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2026 14:52:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6160F2E5A17
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2026 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F02E300EFB7
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2026 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AB38BF8B;
	Sat, 21 Mar 2026 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbRRxNvM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e53JOUzf"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91B2F1FD7
	for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774101058; cv=none; b=jmeX8seshreOh0kUCCHhyHr5/4FSF0yYJRQqictJasAB1igfZwCfxbKz6jRH+ng//N2YJRkTBNsrf+QHVLxpBZqPSxbekuN1/AJtSJRJ2EfVcGwnzyWuVYgWVJfmSLXCw3gBfogvJ9ra70kW6X6jxilv+ZCvEvEGk8+ItSyx0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774101058; c=relaxed/simple;
	bh=92OGINrYIEMHF4Yj1z89XucWCdQo5x7PD93rkEDJkSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwHQHLorsRAs2XIPhktCvUszJuClvXmiNIazTemVYlPt4IHO9vYOsQRsawX+74nGNLnvfW8yhhrOPHp/euiD06jLOkINRqflqj7mKtFw04mfAxv2uecWCbt0T0oIpKLWUyzYhm2Kd52MzVu6OBG5F+vNRK/vDcjaiunlHoeGMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbRRxNvM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e53JOUzf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LA1D0m122120
	for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 13:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dEwv3v4fvUI
	ft8JTog2rIO4fgOp9tun/AvsOV/PcgME=; b=YbRRxNvMbb0bTnKuOUFNjAugrSH
	mbQgzEOVLCNBcbkGentXKXdqKynHhMwdukdelNCMGRLNOdLW8c2AjK+yCiWNKxTU
	SHCDL/h1sX+ZI0t2FrZSpy5X7lOW6B1vGWGfcibHcuqrCgxe4avSPI06cAKMW0VJ
	z749n+4JhMP5MmwmU3EdC6Y6r/7Q+yNh7w55FE8BPyXyyPTW6GWNz2ZRplGTBA3y
	rhiGnGDuiNpUKaGMCCRyOuaE+OzMJgNXo7ncQkDb5BAbLVuJ0nGn3ODGnjF/Xozd
	oIp/Vwz3QuNV38WA3if0WMB/8k8+49WXHcPLSRpnLxS9Pndyvt0TNVWsTPg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e0y8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 13:50:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35641c14663so3583088a91.2
        for <linux-can@vger.kernel.org>; Sat, 21 Mar 2026 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774101056; x=1774705856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEwv3v4fvUIft8JTog2rIO4fgOp9tun/AvsOV/PcgME=;
        b=e53JOUzfRn7jhJ+kfuFsXrL30/aN2GdF1GOQQjbq/O+jcCVchT5TCjr64ihysT0nJR
         nu0lyfuI+ssnk5Twi8esR7WmxWQ7Fl7vMZb/fPbX4KDpxe0tZGK6Es7u4124RgcB124n
         nFieDFP0dgVM6nxCIVhOBKei4UM6e/g6geOiHbp8NI6qG5HSpkjQFN5gDx4RbOaKmJzy
         lYK5rKpLcPHNiOvMlZ2bZQfusKfAXtjFPl5tZFaftX9/DFkYHYgRvVFlNNPntNlvCCTf
         4MgEfIaQDXFqoWcRdx5oKSl3ELexHXTDw6Ss1qHEbdQ4VoGbtnMOvfmDFVU4dw08aupY
         28CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774101056; x=1774705856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEwv3v4fvUIft8JTog2rIO4fgOp9tun/AvsOV/PcgME=;
        b=aH8CBSrAhTtw0rfQGGitmsVM8xbb8po9zIS9F9TMY7rKg+1W0Y71FdpNR+9mxcouEM
         svrXr5qD2szovScZG4VVSDzxdXUGwM0SyU4uvUP2sCWqHCkUYGF5d4s33i1bbvJ3E0M0
         ZSNX5WHO+V43Zt8IfyoDLL4g0wHoEkLMAx7DhySOaN2KPxFWFOF6txsww8MXV8gj5Cpt
         QOkPywYIRNslncb5o24mrzDHOnGheThPabl9AXXOsUev8egiE1EvSr/qLaFEBF46TCXg
         fM6pHrSpVzuQIErSIa3iG1RNxoTEHqwRUv/eYWl+0fWX+fjipGkcQ2ymyG7fZZBWfeTO
         FVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrIGBkc9oSEiVg8jCNEZqV28H7BdUib4i8eGojwRv4cfKbgTh5fEBHOLE3YS3BgzVRcXtjMYZVZ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBm5Qez8n0McKXCFzLRKhvkWSzS2x6d/eM05J6THa1meFHh49
	++Ej2xghNxdfU+WAMoHdVpRh+pdaM7ZG6uv66uMjZQT/CR2gCNaRGEJDK1qGwrYirrBFxfOY2eF
	EY8AVSifwiSou2+dhdJwGpUlXU/Ftb3TNSTRzPcO2S9isodVLBmGAJKfZh5eZ7sM=
X-Gm-Gg: ATEYQzxZs0AkpmZBGZQnKYTsgr16m7XAIBRB4bwnhLu/HV+VPBCFlkuOHIv7PxgfFti
	lXNfJlu+pqS0Gj6Gr0bNEIn39ea9n8nEhEq4iL/W7xML+o8hvkY5pMwIV5D6rl00GDIFLN46DkV
	oT3WC5JMzQ0yfyCFsbM3xdhU9VF1KV3pcOkCWgQQTiQv2wRHqEeMFGsFUhgRa9cYgYIx5gPSOE/
	NKLm6p3QTF0QETdOBZCrV0PDzpoL3kmMh88eOyR46V2FJJTfhjqZrWaEavgVvQb8NwIPXf57zD2
	geV6Fy/vM8tdN5Ih5Mo6LboUDGtLhp4UGeu02rwwDhArnnUScfapgOv17be0mnh6Km4rRIZiFNo
	RyuapCNlEhQRNGEeanwfK4Y3mPMD3uNxELdMYKxCrX3iPeM7wnNJqrtSSWg==
X-Received: by 2002:a17:902:e551:b0:2ae:c9be:5f30 with SMTP id d9443c01a7336-2b0827898f7mr62267075ad.23.1774101055698;
        Sat, 21 Mar 2026 06:50:55 -0700 (PDT)
X-Received: by 2002:a17:902:e551:b0:2ae:c9be:5f30 with SMTP id d9443c01a7336-2b0827898f7mr62266925ad.23.1774101055240;
        Sat, 21 Mar 2026 06:50:55 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516cb9sm54897555ad.2.2026.03.21.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 06:50:54 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linusw@kernel.org, brgl@kernel.org, linux-can@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v3 2/2] can: mcp251xfd: add support for XSTBYEN transceiver standby control
Date: Sat, 21 Mar 2026 19:20:31 +0530
Message-Id: <20260321135031.3107408-3-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
References: <20260321135031.3107408-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XqLg2JQA0dGTOyiuKB-8P5nJxe67LrNW
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69bea240 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=K7bTvPR2ScrnO788fwgA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDExNSBTYWx0ZWRfX2Ivyi5fWwRTV
 TVmKimDHTlJcWFLH7QUDqjjjKYv60SoPvx5tL8DEbGjTkrLoW2J1x1XhvWiDsNStvY9Wli2tIwg
 6XCr3dAuTM/4y1QTBVoKzkU0WODe9Ab15dbS34s9u+iE/dTE+0hUOaeY75Vq4bYeKmY4bJ2oVZC
 PxraAQxN1qKgaVb0hxi63GpPqQAXfKkV8SsfvSb8p1l9zyy4TWF1oAW3CPfY3KWmt/a347rV9CH
 Y/jxUOH+aoeeCS/erPjr69ttBM5xr4zULmsgHQMvjPpemfBURtcFJWTPX4mhZK/hWK2zdnYbU+I
 oTte35JtwKIXotewfKgZ4Kg7wvPoaZ/FJHX4DWI+0Zp0TglcCAeuBpQfgGHIIQ32c23nm6OmA/D
 u6azeFw0tl/yiEqhyk/p+V+bcpcd7afyWW/z7I3BbJpVcWqbZ7/kEHUcgjOsyoCdV/Ik1ETRUZ0
 nh+XLIPPaeDSJz83ixg==
X-Proofpoint-GUID: XqLg2JQA0dGTOyiuKB-8P5nJxe67LrNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210115
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7206-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-can,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6160F2E5A17
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
v2 -> v3:

- Configure xstbyen pin before bringing the controller into normal mode.
- Add a check in mcp251xfd_gpio_request() to ensure that GPIO0 cannot be
  used when xstbyen is enabled.

v2 Link: https://lore.kernel.org/all/20260316131950.859748-3-viken.dadhaniya@oss.qualcomm.com/
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 37 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9c86df08c2c5..92a86083c896 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -764,6 +764,31 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
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
+	 * Pin behaviour by mode:
+	 * - Config mode: controlled by LAT0 (LAT0=0 => LOW => active)
+	 * - Normal mode: hardware drives pin LOW (active)
+	 * - Sleep mode:  hardware drives pin HIGH (standby)
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
@@ -796,6 +821,12 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	if (priv->xstbyen) {
+		err = mcp251xfd_chip_xstbyen_enable(priv);
+		if (err)
+			goto out_chip_stop;
+	}
+
 	err = mcp251xfd_chip_set_normal_mode(priv);
 	if (err)
 		goto out_chip_stop;
@@ -1805,6 +1836,11 @@ static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
 	int ret;
 
+	if (priv->xstbyen && offset == 0) {
+		netdev_err(priv->ndev, "Can't use GPIO 0 with XSTBYEN!\n");
+		return -EINVAL;
+	}
+
 	if (priv->rx_int && offset == 1) {
 		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
 		return -EINVAL;
@@ -2271,6 +2307,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
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


