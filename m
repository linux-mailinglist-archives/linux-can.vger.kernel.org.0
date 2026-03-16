Return-Path: <linux-can+bounces-7088-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I3GOo8FuGkWYQEAu9opvQ
	(envelope-from <linux-can+bounces-7088-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:28:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3529A5B8
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EF4C3078FB2
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3723976B0;
	Mon, 16 Mar 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMjzyhbe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i2rR7O5v"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707E39769F
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667209; cv=none; b=bzfJW0pr+HEkezbC/JCxyWwQHTPoNxyXgunNjK6sQ2Cm/nE/mF9F2K1OD3FOt0nks/8ZT/diuYQW3mCMdqSAOsAblIVVweAU05RFGIGSCxcg8uF4HspLWchaFcJ2y/bF5ggEwErO8GfyizRzTXlH1PgYcAse0MhYfT08h+pcgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667209; c=relaxed/simple;
	bh=zzURQ2iZmKgYEW6uRD7yseqVngQWWegQi7IQwZw6XFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpxoFEjMT0Bw0j3rNP7ZGOr0H3dJMVRaTJbsph4xMo413Xi0TkUNfh3PnPdyWCK9eRFkrtB8X0MDPAwjTtLLSTVL96h3WFYPxy4SuzquAow6jkJkAFt+XWxlBXP19fARSmMTR6a+qdlPJ42sUr3tAG88U8EveU5zHp78w75saAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMjzyhbe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i2rR7O5v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G7n3Xo042138
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iP1kOyErYkC
	m69CvjI78yK2kPWPB5SUYFba/JegI/s0=; b=hMjzyhbe1q2sbqRdvKjH0mrodTp
	jKkQ8zjYtiM6aOONe92Je3nJqzHbcFDGRo1eqJk71nGSa63cSvhrLDlANrd1vEdp
	lDOT21auegIEGfLqXwkNmhoYOFH0zuxSBscVf9BudTyj5TFdwshanMSExZ6S5QOB
	ocki5Dc/ugK+ua0EJqMB3bfCa1O5O3wVP+Zd6lHIiugbL3LMVas/SHUwztjdCfO/
	cg9yThU5SYJvx+mfOGmVJVrKmjLYvx0WabhEMY5xNivy9uCzDbBQWDmB7vh38QUQ
	1pI74/YPkqZ0SKXW4V0/5lEWx3ImouffTOn6cp4VFvF5NSeOs+29if0A+UA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxdt819h7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35641c14663so5150766a91.2
        for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773667206; x=1774272006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP1kOyErYkCm69CvjI78yK2kPWPB5SUYFba/JegI/s0=;
        b=i2rR7O5vvqzbNlLcQeJqS1xirQUVIm3A3Wi8366Gh56CQR3GRVo2HswBONmNSLCDgi
         acV4MzfPW1nWYEJ3ZA7yAC+6Mk3w48xs7AOUrSgYtZKH6PqlcKJRmnDcxJk9rJBmQPXH
         /8criKMf0yRHM6sHSiF04/uevCO19fQ3+OyOv7ZR35z9BX8iNsyRcvd9qqT5K7NT/rVZ
         /tOFjZ4Zn4q4wbX5alg2KNkEKtIA6o26LxjnmwtqNrhiDyLRHyIZzRNyhG7RQhK2su/3
         DMQZqGGWLlCFmIdXoY3T56jybPQSmhoM/aqRJwYn631eDB2/XYa9jAZceL/uA1l4l9QH
         7QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667206; x=1774272006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iP1kOyErYkCm69CvjI78yK2kPWPB5SUYFba/JegI/s0=;
        b=Cbu3TnzRiN2IYBtZG8L6G8Ek8gw4o2aHXAu8PEotDKfTxmTx40vUBaecfIkKyXGyeB
         0DECczEtjlHrSMmAV7GcYHzPGTuDC7PCeR0EPchnBSoIFOs1ENVQGpk+dYliZfoQ2812
         pAoqQXXB5pcL/+JNNPEkwCYz0QqxKH/cjvnQ+Avp8bzaxb3/FJoNpHFhczNQWCgUTsmn
         qOf22x/dH0DmOAyhCzECaNU1VK8EinkLZSXrvQ6GEpM7H+yN6OPALVgRSbH9s1PeN1qL
         trPP3Y7CcrKJPZ4iCbD1PURD041sue7wyXjeidghuK1u3+KqKDp90IhvE7UfBMblUcVU
         0vgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVcI4YyNBxvnGTjLQGg1mZlKyAvj3jv6GR0uITkcHtOmljVgLGBCtu9nZqF/S++enUg7JleqEFy0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwbXtzKvAbHEOg1cBRoajG4NuqrByWNlaRFYlhdouqln7AUMl
	9QcGBBfr3kD421MVnM6cv08MVdR5qNhLzj4uSxUuWn0bpQKdVn0O72efUjBzx1Z8U/ElQAR8ss2
	mrBQkI5Gfn8+B4p185QVjANgfzztR+wd/CrObmB7PyjtxcN+BR8oJOEpa8FcW2hM=
X-Gm-Gg: ATEYQzzIFg5Z1WNpBEcJ4wthsk0r5562yDe5URTX+DCeTsUDRA+420jDVqV+RptNh19
	HvF5xWKqJvp058JNa9FilkWg3aivNFl8X4h3E1OVP2UmKuREAKNaqjJGvv/1dS1tRI7GMoN2lBR
	Lbxun0tG3vNvL8XILPQWJJTq/8DTI2WC4ExVsw9FyNG8w+FeGxGDF1qksqa2N7VdISs5XjNfDvX
	R13+gy2VOnmgsnWUz3v00eOrSjReR4V3WrcyRdzol4UuGLJ3dD5KPGqub7Y9kb7b8hdv5J/3fJk
	pxMlJWBgR43ENPjp9PTFFM/z/I7NrdbKtU1O+OjimiMDyut/bq3NSYIntI+2RieyG0Msbj5CJBU
	5cL/V7dw7p0kx99lPG1WI8a4YoV8UaBbqpoxYYx7mDNjS72rFy6WydcKngg==
X-Received: by 2002:a17:90b:4d88:b0:35b:a656:a614 with SMTP id 98e67ed59e1d1-35ba656e90cmr1687310a91.21.1773667206185;
        Mon, 16 Mar 2026 06:20:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4d88:b0:35b:a656:a614 with SMTP id 98e67ed59e1d1-35ba656e90cmr1687269a91.21.1773667205624;
        Mon, 16 Mar 2026 06:20:05 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9303eb9bsm5209648a91.8.2026.03.16.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:20:05 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 1/3] dt-bindings: can: mcp251xfd: add microchip,xstbyen property
Date: Mon, 16 Mar 2026 18:49:48 +0530
Message-Id: <20260316131950.859748-2-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: aQwxllYHxZ5PUa_oWZs140SJIg0zzOlz
X-Authority-Analysis: v=2.4 cv=CKInnBrD c=1 sm=1 tr=0 ts=69b80387 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MbkHCQl1Ze6FRj4IwLIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: aQwxllYHxZ5PUa_oWZs140SJIg0zzOlz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMSBTYWx0ZWRfX3sJeQZOFT0vg
 KiZfZX23zUWLY1FAdHMNiX7r3JOqpTck705WxqX8c2hsmH56Ziu1FyGS97kkMsRNyPMMKdGzOV/
 837R03SNq+2Rudh6HFu34M2x8T64l80na0BlpnOScVpgj95z/CB/QEdWRugIkHR3J5BU75m5JuE
 tuH+2bi/YJLmavNMBEngVSxcPTpPo+IsvmZpeQFQ8yDMzGmxWZHpq/FVmlkgD3NjcW5r8M0B/yF
 7jrpnjkVWWrrNSiIn5Cr2RNdZ4jhi1TiW5aomA0QRhZ+meDxhIezm3xCNp+LdC8Ot9ehuPENQNo
 PAcWP5rMDf4TJ4hrMDnw7xRjuxSdBdHwyD29OiOaPjhIjzeKf2HP/ZeUwao2ppmvhtxn8g1omzN
 m4yeXhpwLpM3ow8XCDvtsMoWzh9lC0vuJrrMjrC7Fx9IWJAGwYwQsTYk0L5nFQOVWSgGkFCGNiH
 C0e+IuBfQqPUgKIy3Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160101
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7088-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: AFF3529A5B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the boolean property 'microchip,xstbyen' to enable the dedicated
transceiver standby control function on the INT0/GPIO0/XSTBY pin of
the MCP251xFD family.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
v1 -> v2:

- Drop the gpio-hog approach as suggested by Dmitry.
- Add the microchip,xstbyen property to enable transceiver standby control.

v1 Link: https://lore.kernel.org/all/20260108125200.2803112-2-viken.dadhaniya@oss.qualcomm.com/
---
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2d13638ebc6a..28e494262cd9 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -44,6 +44,14 @@ properties:
       signals a pending RX interrupt.
     maxItems: 1
 
+  microchip,xstbyen:
+    type: boolean
+    description:
+      If present, configure the INT0/GPIO0/XSTBY pin as transceiver standby
+      control. The pin is driven low when the controller is active and high
+      when it enters Sleep mode, allowing automatic standby control of an
+      external CAN transceiver connected to this pin.
+
   spi-max-frequency:
     description:
       Must be half or less of "clocks" frequency.
-- 
2.34.1


