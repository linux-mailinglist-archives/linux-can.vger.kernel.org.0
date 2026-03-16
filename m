Return-Path: <linux-can+bounces-7090-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DfPCM0DuGlpYAEAu9opvQ
	(envelope-from <linux-can+bounces-7090-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:21:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 045E129A416
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 14:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AA0F301DF6B
	for <lists+linux-can@lfdr.de>; Mon, 16 Mar 2026 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0099398903;
	Mon, 16 Mar 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y149H9Ug";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mq9U+vWB"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5C397E79
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667223; cv=none; b=UDy9qPQ4cAo47IAtezzJ0BSvdOfYT7q17+5D95VzuvQhd2P13e5cB7r/S36WjavQsXQGiB65gOzKoxNPMPDxHvw5i2gF6pCsjmft/fOiDX0rVOEB4MwSwrjwpx38xx2RFL/Iizp25R4XAvaG5z/B0wDZdtO0UOWBmnVGdew4gEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667223; c=relaxed/simple;
	bh=dJbTfvAcFEBr0KgQiHACLmah4/Nutv+8vmj1PgJofSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMAkaHkKn1FNxv0PMIISVu4eOqqtEgNqXB+p4xZF9kfBwUwxX9g84J6ZiYRtBWyb7A3U79NquDXIlk3JdJtkzucIgnritCPlS82CktNalUYKTdyISYWUijPoYeiDcLLQl3xZBzq0EHgcmPI8lRJsHAmKXqA59b3aq11aYtSSrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y149H9Ug; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mq9U+vWB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBf1Rn1066921
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pbJPBsQP9F6kyoPC+2wB07LxBFNQb4kGKV2bLW+wM9w=; b=Y149H9Ugm11cflVU
	PmU1pISnb4e3D7cdu0GnqzOV/b80saYTAFSFeHYJg2nci5UhilckxhrS8GX0bCMa
	GQ5sinfUCD7cnekK8EPRrQ9iFU5Ut6goACXpmB+EBVABFAuGW4ZC1rR5SC4vBnqe
	rYug0nX+xnItYIsAYVgqRrAnewJRffdI8b+tQev6pZTRqhap3HyaiHANuvftzJRd
	yVlDF5EF7hIu702yTgKWDwNNdL9aGQTJDaeSjuFwvUBJPu8mIxCBB70MHtFkOrZK
	IN22NcE13MmlsnKly3RqzV9rip3G1JubUeVw4wxG68l29p8BipNOdu/DGxgVynQm
	yVwScA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027dysa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 13:20:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-359fe456655so3982532a91.3
        for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773667221; x=1774272021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbJPBsQP9F6kyoPC+2wB07LxBFNQb4kGKV2bLW+wM9w=;
        b=Mq9U+vWB1gXAb2m9wTlrTGGcHK6OnvDEAehKv0shhf/G7xfds3iodQ55FYMp15Z9Me
         qAeRq4X5XSBb8sHSq6IDhAi2dINW8QLi5zVVnVz5Cg8ksK8P8ZfjRD8z5HI71MoNLR0A
         pkBx6CSdrN6mJXrD+N8BA0+q3ifUkBMD4/KATIwUsPEgH+UdhDDezwQqKUvsYRAD6h1E
         U7ck6AuV2G5z3+cEu26K76HYB99ZiAkwgFXz2qZeyYu8d9SoKsYqkt7TjtZrjuSeRTUG
         CBuJk21f6n9DSiC8jKXxY5IsK2XDmcwE0ogFQlOTuLtkgRosn+vXgY0AClPR9mz9BVe/
         sa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667221; x=1774272021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbJPBsQP9F6kyoPC+2wB07LxBFNQb4kGKV2bLW+wM9w=;
        b=Ytx5RQFiwMa88dCfGUPMPr34y3Up9tTSWScNtFT5Dp2XABYYYWDxO1d4i6JIoyyJeu
         C9TuIJuiRqsDxx+PCvo9sFpgsqAVLhUzA94rK93U97LPmH78264elbD5XibJoNqxSp0E
         rweTg7Gs41aFN2tbPRjeQ3nJ2yOuGRSvaV7zJja0I0Xk4njFjOlVDIjgMFivA6tG45Fb
         9B74D6iWsGrbhtwksUlXri085gDF1lPzP94WUznUSrFeXgY1b7dcp+q+XLqQj/YtcTRI
         QyedaPpVqJTkj2QjS+i99HJlF+DbS2lEubG63hO53NG+LzOsxS1ZXrHeNfwpxBCuxSet
         NHZw==
X-Forwarded-Encrypted: i=1; AJvYcCWrmR8rmNJLxHLtqhifFPoMzr+IuGFdbiPgLJlZgvqAFT4zaSfyRICV7bn+OvJb1eqFsgT9SOnornY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSS8QJdp+b/QX5XIZOYU9OwFDTnnSQBVwEM4Hbibsd0zEr68AY
	iv8imY1qxYvw/V3UfDgmwmsfsoKJ+XrTFIGeScwmQpdBSO1F8QXM9izt0asHhE9V/2jWBK/m+7G
	w8X5lS8t4Xi3/yhMrwjWB1+DNUedY7MDzEvMx4MQ1CLRZJs1Zp2IH0HU/y02Vtpk=
X-Gm-Gg: ATEYQzxiTvJH3suCP4BJ37INcEBejNOoa+9J+PClC/C7Jt622olSAKAosD52u3Rv6Vs
	ZwvBL6AJXyI8JfTwBaHB1sPkRfodwe4sktdqKthgU44gOsiGXlUq1zPs+j3tsmRl78LhvC6gvPe
	e2xf1jJ5/poOiRFwA2BvsKUL3WY09yv/ym8q14zKXH6cXeIDNSjPbjVK1AhxkeM+g2g21oQ3nLr
	k/QD2aoRzG0Lu7B4mYhnzCBepH8/DzeNJV3Ay+GaU9fcy5/Gl+Xd9mE8drkgpIhBRlsUSkO/FND
	u7aL6f/cRKRCjHZrgrqlRbRIBHlu32KcMQLIi26RrWO+SRuzKyIlAH/lD+EQ09vuF4/V4E8ex96
	HGG10OsDewsfMwfpSMn0ILU6y4zCpiVQSe14C2rAGUIHA0Jx4LCBgkEXCkw==
X-Received: by 2002:a17:90b:4a47:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-35a21f007ccmr11940410a91.2.1773667220603;
        Mon, 16 Mar 2026 06:20:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4a47:b0:359:83d3:27d3 with SMTP id 98e67ed59e1d1-35a21f007ccmr11940380a91.2.1773667220116;
        Mon, 16 Mar 2026 06:20:20 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9303eb9bsm5209648a91.8.2026.03.16.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:20:19 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus controller
Date: Mon, 16 Mar 2026 18:49:50 +0530
Message-Id: <20260316131950.859748-4-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
References: <20260316131950.859748-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MDMjZMmbLqfrMNZggBKFPHppj-nDjkbZ
X-Proofpoint-ORIG-GUID: MDMjZMmbLqfrMNZggBKFPHppj-nDjkbZ
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b80395 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2RAHEg2qjUOD6Jr5jaMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMiBTYWx0ZWRfXzP8JzPQrEjnd
 pGfE923WY255M0mRBGy9vveVNR/ysi6H31M7K8wL6CV/eMH2YPx/gv4n86M55VaRSHYntC9OBKs
 rr+u0QLBguFANZFMcT0qDlmKCCxC0GS6N713ygOrmxI6if7GoV79TP7mfnT4c31VjvIJbFw3ZgW
 cqGy4q+rAyoRZWzLJ8lkQiYKk85zqIBNvgfm2iQZjfss11/7zk5UILQFhGV1NMlFWMdGsuzyYcq
 I+jCqmM/dm6E0f+scRvNoJsoD6i0gAX9etJoGG99yi1mSyIAwldo2WJdHuiU/1IntL6glilNii4
 qHuB40YyYjD7zfrSOzLS4VqcUu6XcHAyWKKIGIMB8zmXag9jnmGOMJ9zVOsZ6X2s4zKerJVldGk
 DKBpbquZTd7O2OqaEk0t2ct4eAf2DhhhqVIUbNIcGGZlGKSbucWdaa3EBYqxmW/MoHqCjhGv3EE
 MvfTOdPvi3cYaWFlIGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160102
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7090-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 045E129A416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
The controller is connected via SPI3 and uses a 40 MHz oscillator.

The setup was tested with CAN-FD loopback and actual data transfer
using an external PCAN-USB FD adapter.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
v1 -> v2:

- Drop the gpio-hog property.
- Add the microchip,xstbyen property to enable transceiver standby control.

v1 Link: https://lore.kernel.org/all/20260108125200.2803112-3-viken.dadhaniya@oss.qualcomm.com/
---
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index e3d2f01881ae..245961722f84 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -44,6 +44,14 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		mcp2518fd_osc: can-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <40000000>;
+			#clock-cells = <0>;
+		};
+	};
+
 	dp-connector {
 		compatible = "dp-connector";
 		label = "DP";
@@ -1151,6 +1159,20 @@ platform {
 	};
 };
 
+&spi3 {
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp2518fd";
+		reg = <0>;
+		interrupts-extended = <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&mcp2518fd_osc>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&vreg_l11c_2p8>;
+		microchip,xstbyen;
+	};
+};
+
 &swr2 {
 	status = "okay";
 
-- 
2.34.1


