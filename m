Return-Path: <linux-can+bounces-6040-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433DD0300F
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0477F32512EF
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3748A2A4;
	Thu,  8 Jan 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSrtlj2S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJ4w3e7d"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB348122C
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876745; cv=none; b=UDXBy7U1xf3NgK0jqwXCbQRZgR9Jnn2nfVfjIZE/022QGf3cGFutMpVLiCyZ8QJHwXN3daec3MXSd0uC1YikUugfQpHhmvqMaI9QEKtxTTe/7Xbdp3CBQWXBi6Wufb0xMe9E8Ai9sz0F2aZeXx23hUDKcx9JgARwG26Sofmx4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876745; c=relaxed/simple;
	bh=XlRMvPPKlAymX2hcc4TzJppfzzrPdib+qTdDXUHtTAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtME3ir6HIy6tgbFPhH1X/IqpBuzRCRXSm5nZpmik3ZGZiuE9xb3JTQEcFwe4QAM6fcK8aVhkLw6wJAXUq5sJBhExTcU4uQP8ahAF9m0rdoCD4gwde0+UGln+Iajh6vJAt8gv9yKLjWmAENx8DWPACDx52Iua8EG0XwiC1puJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSrtlj2S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJ4w3e7d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608Cd38g3890461
	for <linux-can@vger.kernel.org>; Thu, 8 Jan 2026 12:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dqYeC64NCQvvq3+TQC/yLoL6U7dsEsommPyssm+Mo0A=; b=nSrtlj2SGTn/oJjV
	l132+tO5pym+vjxdim2eZasRecvHTJ/XZWHfRQXoX+QQ2dBvw8tlLWFAX4645QSi
	nplGN3/ZLNSCxresQ89Fo2jxfYYjrg6AHOGGFR1HZofzMkIr3Fymjm/CQLRs16ak
	rbcpCpkXf9yiBVfqsWWBQCWjIbc8mR2/kxO5oq0xkhn0XRpFsKUMtOOfFFRVcu1u
	N2oGHvlgxGXEiwo/qdHHaqWdSb8ckfk11IY0/zfrUgnQ4SRO55JIEpAbed9xxSfE
	MGiZURjOP423KcOssJdO3xZfBtLnIRuxv5sHjxCbS5c+uebhuP6BvdkzbBu0QnQ8
	XWvb4g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuy734ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 12:52:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-804c73088daso1379175b3a.0
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 04:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767876742; x=1768481542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqYeC64NCQvvq3+TQC/yLoL6U7dsEsommPyssm+Mo0A=;
        b=RJ4w3e7dDVzgJ1kwOZG2Jzvi+Oq0JScQsVnrZPH7bpZiOS4LV8WCRPt7ijONn/gEfZ
         AepBtrq9xgeXwj5zbGA10TgFeoGXDtfhuIbfsD5OHfOd5rNEfkhK9v6yNc9jWc498Ql+
         ukVdinRpg9Z0kznTAnuMlkv+noCSSBpy4x6voEmDkFu8iSbaAdRlm6w+Le6WhAc+MCCb
         faqbUufzJCg2wDW9Lme8xGfz5Vuj51Mlkad5dqmc97EdDVTEkkfnDjCPsf3K5igI0wUZ
         GYmvDUe6k1NRBHrPXMwesXDc4FypmafcLZyeSiMpBbF+TgWL5Jfb7uhwP2pAGv7pO0Al
         Ksug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876742; x=1768481542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqYeC64NCQvvq3+TQC/yLoL6U7dsEsommPyssm+Mo0A=;
        b=XCEJrGBflXPPBgVxqWtAK6HS0tFg4OLWVmFEQp6vnaZvMsbeg5F9+4/r95Q7GJYPWm
         Qm/shA801Qkm2YbGnfA+/fZ8NUj6gwBW2IwzdBD0sDW5m7hNcbTR13CBNGY5HJiPBRrn
         xO2t1GGr05UB5XKodrW49hXC5xSiuw8hXv7vbZ6UBlKyKWoWvGxEDpnNUY6JMuTa4msm
         uY1nff2JNKQKHwgDsTeYfAjKK0YaGKZo713U+MyI7RBVOhgkXfet22Nzq3ncKMyOVonP
         XBd0X16UXi8GLJiKgoK1uQICG7LUxz9f5pl8gC8BMctB6pVq32MYzmoHgbUM3BiVyPCG
         oqqg==
X-Forwarded-Encrypted: i=1; AJvYcCWuclo5H3zDSVU0JJ/hDYuYjmrOswy1H69ZHwQfh4Y7bSNF2/QfnfGKWkGieYgdbcumnlhmmZxIGPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynLlid8SlXpn9qiza2kQwSXXt53ltSnt3Ty535joCR7t4VJx2V
	CbKWqDdyNRQ6TUlWJYFA7ekycpX8JwYkw0QeBOMUuuKPoVmKNcJKS13+8HkQEBoXt+g4ewZ5saX
	xuQ181MW0dZgUfz/bhEA+82Gq/l8gkpeCV2tGEv2022dSRdYVkItyjwPt0C67OK0=
X-Gm-Gg: AY/fxX62dRnH0J33hCPRR9AYlRD045VU1VrX/CceiJFVzs9CbE//2E1bvKOE1Lq8a8z
	rNinIPZePWJpW8LTkJ7J3CXwkM3FQ1i3s8cBlMZw1c/ZGbKVkstFr/tlTUSIxjjqm3aAzYaoACk
	SwHhvDH7smIE7IiyJnpJ3aqoDvB+koxPRcPANoXSrvGBzzSk7hiCfVYTfOAZhY03mjU/GLX6rU6
	ZQyEsUHRVZl7Dvb49wXfPqyto1cyGj9ggtjyjGHY+sriFjV107awFv9lK1zeTZDnjXARNx0g37o
	RLnEsIMKC86H/vg0qvivJzdBIj0f6cQkjW5Q0dm23G1TF5fa1veOo1Felu6lmiUbvysh54H8aIu
	EbNonaA14Riy0ExIYAYH3aJ4VKc13ww0Is0IAr78ffybP/Q==
X-Received: by 2002:aa7:869a:0:b0:7e8:3fcb:9b01 with SMTP id d2e1a72fcca58-8194e130c64mr5945324b3a.23.1767876741690;
        Thu, 08 Jan 2026 04:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7fJWcSWnWEsA+4ccIsBSJbS+iZbKv78WluDAaYqqjbFF8xPa4rUh8bOAxTSVBtf4OiWxTCw==
X-Received: by 2002:aa7:869a:0:b0:7e8:3fcb:9b01 with SMTP id d2e1a72fcca58-8194e130c64mr5945293b3a.23.1767876741179;
        Thu, 08 Jan 2026 04:52:21 -0800 (PST)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dab89f2a5sm253302b3a.56.2026.01.08.04.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:52:20 -0800 (PST)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v1 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus controller
Date: Thu,  8 Jan 2026 18:22:00 +0530
Message-Id: <20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Lcif2M-up-Gq-03gfaublWx0IpIJ0EqZ
X-Proofpoint-GUID: Lcif2M-up-Gq-03gfaublWx0IpIJ0EqZ
X-Authority-Analysis: v=2.4 cv=DZEaa/tW c=1 sm=1 tr=0 ts=695fa886 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XYn_8lXowKPdo-AIkF0A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5MSBTYWx0ZWRfX+HqOlQ0B+GeN
 m6flvTaybr4rWzIlIvCJH3f+h4WW6iVzFSQhIhBwY4IgOCQaaz5q7pS7o7XfkvZpwMPMWSdIN3J
 8cwfycIUSfYau4h/bJuvD2kEgl2VyGo8tUiPqFB9DXBKLEeRP41mT3dORX70bZ8Z+/uY3GYFCmx
 sEXfHAqGNU3x1mO3UGalMT8ysWlVULUgIXt2lnDEe6A6Bw9MKTq6g4vNF7hqGvBv0bsdjl98Kfu
 OacvV7rKBhrccyedzoqIDDqAU/VyOTPOUQgxpSLSthKgfR8iY3oHpAtp0wSdjA28UD/NSagsviJ
 /BGhaWGzVbfvxMnSMuLqX6FVK9/63qBlHvmcP/LmTfhStU0a7ybkNnwoHtlrktivb7dq3KSHwui
 9T2HBHTZjycIw3a395u02mnTIzlp6H6lTo1v3I6C0bnNLgiBS2lp9y+nnzLjMfzxlXbvKVE6yXu
 qyPh9/R8ZzVf5rYKrwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080091

Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
The controller is connected via SPI3 and uses a 40=E2=80=AFMHz oscillator.
A GPIO hog for GPIO0 is included to configure the CAN transceiver in
Normal mode during boot.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot=
/dts/qcom/qcs6490-rb3gen2.dts
index e3d2f01881ae..f2f2925e645a 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -44,6 +44,14 @@ chosen {
 		stdout-path =3D "serial0:115200n8";
 	};
=20
+	clocks {
+		mcp2518fd_osc: can-clk {
+			compatible =3D "fixed-clock";
+			clock-frequency =3D <40000000>;
+			#clock-cells =3D <0>;
+		};
+	};
+
 	dp-connector {
 		compatible =3D "dp-connector";
 		label =3D "DP";
@@ -1151,6 +1159,28 @@ platform {
 	};
 };
=20
+&spi3 {
+	status =3D "okay";
+
+	can@0 {
+		compatible =3D "microchip,mcp2518fd";
+		reg =3D <0>;
+		interrupts-extended =3D <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
+		clocks =3D <&mcp2518fd_osc>;
+		spi-max-frequency =3D <10000000>;
+		vdd-supply =3D <&vreg_l11c_2p8>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+
+		gpio0-hog {
+			gpio-hog;
+			gpios =3D <0 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name =3D "mcp251xfd-gpio0";
+		};
+	};
+};
+
 &swr2 {
 	status =3D "okay";
=20
--=20
2.34.1


