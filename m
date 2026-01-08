Return-Path: <linux-can+bounces-6039-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0895AD02D6C
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 14:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2C830517EC
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE50047ECD5;
	Thu,  8 Jan 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GZ41UKhT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0tyttoB"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18547DFBD
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876738; cv=none; b=G1IX8U5lY3K28VkV3yCZD8YmnTzdL/UYe+5gA35MWUdaa594E+GRSaDavTHMES21N9HEbhghUpL2K5J+CtPdJ9BkdsV1E0c2fG8N/39ew//olv5BhfgceX0Lq9v4s5p2QVGc4vTt7B1EylCJTXzS4I8zysevxYrnrnw1pKq/p+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876738; c=relaxed/simple;
	bh=jLmFH+cwbuNfENRFtA+4MMVYqROr3VN/PhNwAuOLUF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqLH+mpogRbkVlvnCaJ/LqNgfGpuk97icLk2eqG5fQQwWEo2Sm1XEm93v9bAuoQj3wbUStdIdjF7tVjRh+JHhIns3pArFMcwVKyc1aEtLcA+txp04P/wnAaNWmSc6BbU1Byq8nNfP9FhUlkIJw5GjLcIDGRWIk2lKygPxDN+MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GZ41UKhT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h0tyttoB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608BYHNl3751798
	for <linux-can@vger.kernel.org>; Thu, 8 Jan 2026 12:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/yf1Ue7amp8
	9AOLm+XQspD5ZX2yuMeb8ho7pJFXOCxY=; b=GZ41UKhTfLAGZ2utKjKSDThnrh5
	GHe3S7+SfGE+2bZzJFqS509jN3uTF548lOnHYonMS12A2Kr3gAhh7MZZVAkVHaX3
	/f6i8IusG0Ec7i76W/YnCcCf+rPM3XHgx+0vRwgmFO7o46xF6od2Kh8vnRREDs9B
	z2BxpEe/nCa82RcAIp2HzdQBTEuA0xKaT9x6icQ6UsPlde3izATtgWq96jpnpO1+
	UITlxEZF+LIYaxeGf81HCCcmr+pGWW36ClMJA2QKIxA6wCXJro1YTETDm89Bp6AO
	hEfGu0Bvk/DrnTPJJS2YEtbXKx8QsSRWRoydYeLI+Cs0incD81l08O00wiQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuxcu99s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 12:52:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0bb1192cbso35731195ad.1
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767876736; x=1768481536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yf1Ue7amp89AOLm+XQspD5ZX2yuMeb8ho7pJFXOCxY=;
        b=h0tyttoB/4jqRMmZcYAztuPEQ78JcIUiV+gWMkYvDtpQVWjlcnju9cbIUoE7h7cBgD
         iby4AbNG+hJzswv1BbiAMfENScTV7jRwBn4X4uJmxhinHSAlQwpf8O8sK76unA/9eJsC
         wZvIE0VuUHoeHjqWI8P7/NXI+NSVpCjXLFEaelbyD6mnFzZy5MA5t9EZyc+8Tws2V6qp
         OBC6rDidDuLMxLWgudW2sirp406VYqVWPEnAaOAYAIhjeeVG/Cg2GttltZ071i95J4a0
         c6EZX3pHDd78ZVFbDWOhElC3r5J/m4ykOdwDZJW9Aks3K903f+b4rLYPdB9mwtvpQ2VO
         xlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876736; x=1768481536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yf1Ue7amp89AOLm+XQspD5ZX2yuMeb8ho7pJFXOCxY=;
        b=gEVoU4ntdEWEwAbJ4NefSiy1T+Kp0+pOE+pmQx6X5WL42wAsNvUFD4XZvAM0frmt8Q
         b3fAjE1qPmnF4/Qebs5wQkseyMzfjP20xoFGE5jnv1YcwHGdANBndw0Ja+JjkiXajAr6
         TYGDrECRzuAZdTgsGe77sn0XChY0GC2jqenqIedcwn3lcAK7OlM8B1TOJMR5LjdTStZ2
         xCX4/YBDuXcz7jfbCblBmkdOP4VX0nexvHXHznNGMc/b0fNTB09YiS9u4N6Q1aT0hfHZ
         OgMs7BO4fQoxcCw08PNNlet9PEjPuvy2q2cte/G8Mz7wUwgX1cbhaviPaToYpIXexiil
         Cjmw==
X-Forwarded-Encrypted: i=1; AJvYcCXZVf4FXEzkk2Mlakg4LZRypCqpxGbDk+MN165WcsJ7rwW2f+9I0lbHqG5KgxS/VeQjVI4He56LEBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybE/YZ47t2xRQXSO4N0+WomDW9Zro06/ieGOEhmFnO4v1Ghlfr
	NP6rEkiCIqFjRVI3Zt1feWww4PvvdO9DTbB/n+WEjLi5ugJjcDZsp3QGrSiGDspRg9IVn9BlCza
	re3SwNw46KV/4N2VmRY3vZqyRbcjlWSM5TfT3q6frkXZ3dHEVxQenBqyR5rpaOCk=
X-Gm-Gg: AY/fxX7XetCs1u1gM72u2ZZ6vibenFXH5Uu7gjSGLIyR58jkqd+Y8lvOB+VSVkhwHyh
	n+pkqLy1v6NrUQhLs9ZuBbWJszttRKoh62Jc5mxsJb5fsgb/WXHP2q8fJXWEN0GtqQq2i/8B4qk
	IVFywj6iqoqoOt+yN/KZMYV4wtZCkdQSzka6gI+3Fp2J57LKiyFF8jU6DIorA5Qy3DGPyl7QWSK
	eI5j62DkulbEmx4IqREi0ZGLmx8Twd2BIw3OvTX8Affv7pNTc1DBG8KBqPGQhAYchUPKL2wJbnF
	iOlEu4CrbWlLJkT2fCtOFqpNoewQ5yKUyfzhTPWwuD7bg2KDQY3S2PuX0t1CR/ufYCCrgFfkvHk
	xRX3W7fJO6cGKvRpvdRKcoM9sX1Woksarq60YIh9C2t+NjA==
X-Received: by 2002:a17:902:d541:b0:295:a1a5:baf7 with SMTP id d9443c01a7336-2a3ee4c0e9dmr61508265ad.37.1767876735911;
        Thu, 08 Jan 2026 04:52:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG53g2osNOh+cy+7lSdXr7lutMU++eGlQD4ELNCeQpgL6083Zu9k/e5sJKKScvFL3iCNb90qw==
X-Received: by 2002:a17:902:d541:b0:295:a1a5:baf7 with SMTP id d9443c01a7336-2a3ee4c0e9dmr61507915ad.37.1767876735439;
        Thu, 08 Jan 2026 04:52:15 -0800 (PST)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dab89f2a5sm253302b3a.56.2026.01.08.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:52:15 -0800 (PST)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v1 1/2] dt-bindings: can: microchip,mcp251xfd: allow gpio-hog child nodes
Date: Thu,  8 Jan 2026 18:21:59 +0530
Message-Id: <20260108125200.2803112-2-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5MSBTYWx0ZWRfX43PJlcEpDhIy
 F3AzbDJ8JXuXVNx21pxSlA8Ui+ZewOY7eh5AXJn9VyEckQ3+/NwEIQtTBCS40fdQrig+YtiGu0c
 L+rNKGi/idvSL0ajygxNup/TAc2DB+7+cC0C1/H4T8uBtnC0bjVRzEH25kZf8rE2UzkxyDaaWPl
 yB/y1BROC/IhgxnrplESf0LN71Xl4HlUCzeCFYWzXQypoljvgwMASW5aNz0TvOPOcNNBcWJbfLt
 lT6vPAnNDx5wSYjAzXeY0x0pbtjivcat06TVi//gx5TrYyr/EOuYyzW+XO0/B4WS7XftLdX8gpk
 9vh0taldm1KmIZlMHxHdeZFD4E4aJGcaorr/HCQV56SKEMYK5MLxpvbZQ/L2sw2oA5ZKanwaIGS
 OECnOF8UkQV0LKuFRUZp0EFRt/Ul3c1ZxdTmIjMd7B6R3KuBrixZ27WrmFff8vW5ziJ9BIJM3v1
 Ig7GWKfuWp7LTvNXZjw==
X-Proofpoint-ORIG-GUID: Iq1h6FtatbkOEsC4dQ1VF1f7mptILabS
X-Authority-Analysis: v=2.4 cv=SPdPlevH c=1 sm=1 tr=0 ts=695fa880 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=5Uki56Dm3_jOTjpcuNwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Iq1h6FtatbkOEsC4dQ1VF1f7mptILabS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080091

The MCP251XFD can expose two pins as GPIOs. The binding already declares
gpio-controller and #gpio-cells for the device. Whitelist GPIO hog child
nodes using patternProperties so boards can set default GPIO states at
boot via DT, consistent with other GPIO controllers
(e.g. microchip,mpfs-gpio).

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.=
yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2d13638ebc6a..49d6f6bbe193 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -54,6 +54,12 @@ properties:
   "#gpio-cells":
     const: 2
=20
+patternProperties:
+  "^.+-hog(-[0-9]+)?$":
+    type: object
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - reg
--=20
2.34.1


