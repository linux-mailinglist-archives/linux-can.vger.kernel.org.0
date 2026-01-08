Return-Path: <linux-can+bounces-6038-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92ED02D67
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 14:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125BF30334CF
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D1478841;
	Thu,  8 Jan 2026 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqyjAUZU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gM7+VL4S"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E8471494
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876733; cv=none; b=q2RaLupooQuwAoLnAKAr/mstur/y9kNdxb4t57ViocRtUQuJ3B133pWHbqMXM99neV4VKKqRAUNSQHiKirobh6bWxPqbR2WfWNIY4GHDcKklYJDqcIHKK/dHTJGRuaRowxzJwzM8aPf3YtTOAJgYQaab5p+TKmRhoGmIQ5Ict0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876733; c=relaxed/simple;
	bh=v+R2GyEEtLy/jrg6DaQ1HaFOQE6kRXDmQZsAdgSSTBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S0kkA2z9q5BwJL01PXjp6rmlqqd5yPJ6JwloAq/w0Pi6flrcrTjo+HUaz7VkFXWpvokuwFdVxNyBT2hWYL7XwDjAjm42Z6ir3ONB0oBBp0VRMAhK7JD3zW8iTm7430a8EJ/bUGmEdzyDjdXeP5WAL96G5KSyoUic7uCRQFcExq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqyjAUZU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gM7+VL4S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60896ihN4050069
	for <linux-can@vger.kernel.org>; Thu, 8 Jan 2026 12:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bRHVxDjLYahn82U9zuLx8+
	cgT5tO6EUiRW1cbfAHVoM=; b=BqyjAUZUeHnKpDWtMRo7NBsTqrk1Y7uPN5h/Ez
	X5dJjx++eCeuOosYxPM8crM/EvaDyGuUxcxzNG+K02aPgJtr1moH0q7iPnVjxJff
	7MP36bR7YLBZtND1qcT0PCmHqAnQLWsyDhYwRcS9ws4k3mFqwHb2GE/XIejueBtF
	FvvV8horiF2grobt9QhyVpK2vyWQkgmGB9yVQDsMnog/oJmNzzImjp2fwKP1NPtE
	A0+f9vCsRQUvY4zUDM82pIYONHOkWizVaGtUX6TsmjM2m28Ylw9oxhZFL3cxEjWv
	JB2IvIcTVt+hr7x2SxuaQQV/4VoBUEq+dCCoinFjT5JbpmNw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2n8j1kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 12:52:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81c5e1e3beeso1093672b3a.1
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 04:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767876730; x=1768481530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRHVxDjLYahn82U9zuLx8+cgT5tO6EUiRW1cbfAHVoM=;
        b=gM7+VL4SnuI62qy3S6X+OnBCK/+UOh8neiuo2Recs6ZOH1wDYaLQmvFyyTQR0GHZnx
         D5WwiHlBYLYxqw3+QS2r2GnT7q9+nrMMWiHz+Zq3itCkMZbPAf2EvPU0Y+smXTJ1b5wR
         NBF+5CUPVypFiDuv/5Z80R8QW2YzT26/Kf+pfEHX1WqZaJy0EDhynNL1kddP5EMRXAJL
         OWEi6m0WkvAOOEIUCRsWY/AiT48+TN5/9fRYBAT0igjVVp5qFhVQ8MqXroHr8wJ0WVny
         Acog+uhiEEDLExyP/2Dx02a0B8Or/4q+TBJy5onkYvc+GiAFhUx++VspuHS2jraqeimj
         bWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876730; x=1768481530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRHVxDjLYahn82U9zuLx8+cgT5tO6EUiRW1cbfAHVoM=;
        b=Uqcx0df3jGE0lUcBDtqSHjo0n6vyRIuBn63hrTy/Q3f2cQ+h6tMs3Uf/Z24lNBtY0e
         uqjh2UbRl87AdnEr1acfFD+9KSEJoGWn4mCVmuxCU0CkJaaGcxgZi5xeM6WP5VlVPrOE
         g827OTJGU2SX/pYLRa+VntiwuCxrMwwmaqqIAtxqggAKbD6iOhNFFHAwlaE6PvVt38f+
         CuszSySnOe8wiScRyhhylks7WCki7mRUj3CHipZR2Xs1GaZwwUTMaFwzb6cdnKnG0Aj/
         2zgYEQmDjZ1Vg3ZFdyX6nYdn5Dr54dvQeRD91lM+eUHD2OdGShIFKmjcEGnzQ0Lc/ck2
         u71A==
X-Forwarded-Encrypted: i=1; AJvYcCU+iQiDxYKdq5x2EbR8/FggKVrX33T53AWY1Vv8zlUZsFw8D4B29xdYsJIsDeA3XVTbUb6U63ZRIaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaNl7A6CryJhVTPCogamongVAveUoWlqTRuyd34znWh0WEZ3D
	xg9kRq/bayiQ+KHx+nsA9isLA4MIH0Qsvrqv9nTaAtLsmsi7S3d9N8Wit7SiYNNavgzkzNxjJcO
	x0kWltBLFbUfyvrUfhHQclhCSIPYcoO57dxX14ABPErMTU/67ZnNhyXn4Q0XS5/w=
X-Gm-Gg: AY/fxX68gmNJepIAi6K05UkMjbH3P4480TkDJUPtsWnLVzeK56mwK0B65Ey/NLPva+0
	hFinECBQbTlOTBXkHdipQH31tArSd7SzOttXlpcDT+F3FYLVdTXf25SOaBaNIsqBQ22GqHCPCX0
	c7zjsanBg4aoDMrMnI7fZcSkk11QZEfrcfccWIDNlEhneEwjtjip/GJzk+H9eZd5QaVFvHrFWyS
	qF7hR1RwX4Y1vnwPokSOeolhEi9SEKLdDGn7D+ID4weBxkYL5VmPgFXeWbwPzVotup4ifUu+woH
	pKigLGf+SKv8O3B4gQwX5tbl9/DFxDRwSBwChEs0fe91FlTlT0TWj08nNaHb4ePLUfEbXEeoVtg
	RVmH6kMPuke955NXRrUx6/r1McIcCYItXlt8/OiYVLXMdOw==
X-Received: by 2002:a05:6a00:32cf:b0:7fb:e662:5c8 with SMTP id d2e1a72fcca58-81b7f6e3a8cmr5705930b3a.30.1767876729673;
        Thu, 08 Jan 2026 04:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgScV5G+Nz7moP3oIH4TzGt1E7jfvWoqvlXffiLCn0TQFdYyifLMTpIQmKxakhhybG49WCyw==
X-Received: by 2002:a05:6a00:32cf:b0:7fb:e662:5c8 with SMTP id d2e1a72fcca58-81b7f6e3a8cmr5705890b3a.30.1767876729185;
        Thu, 08 Jan 2026 04:52:09 -0800 (PST)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81dab89f2a5sm253302b3a.56.2026.01.08.04.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:52:08 -0800 (PST)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v1 0/2] dt-bindings: CAN: MCP251XFD GPIO hog support and QCS6490 CAN enablement
Date: Thu,  8 Jan 2026 18:21:58 +0530
Message-Id: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=d+j4CBjE c=1 sm=1 tr=0 ts=695fa87a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=nFuhNNRUEVbzmfeY_84A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: b-8qVU17r7SP4eu_1jnFilmJ80alQ2RH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5MSBTYWx0ZWRfXx/gxyNjQaEeA
 zvbCup5RwDOV3hyAC5DG7v0qnvkImRh/ySNrPvDZYfvNoPrf3fdz7RvF4Hs9masoC0xn4zXfpI8
 7986kJMPMHI/7AK/xJY+/FLQ8dp2wfxN3o24TUKGCSJWtN3B49L9r6im2yFyIuGEnrpOGNLRTfL
 IIWJqUGTXBuB8jnPfcbV2Zy4Ve9IYtcl7/5AJe6kvuI6oypgNmULq+e6eNhlo92NnQMFIBVwyRV
 HmMzwNEswQXgf1XuNDN5g9nw7OEiRo+9VrK7WJ7gC/L71tgAM8J2L1UHmQbEfS2WiLKszlvbPkI
 sRRCn5Ri527Ndj8bWVHWUp/GRBwt2za7C4tWplo9pAEkaLpk4TH5W7bCyB0dAQzee6+NeMWKiTI
 khWF/yhq/9owyaz4hCKze+Dspa2JTZ1nzOO9MciWijQgiyZKQUwSzXccv47e7YA4GjFMBaUAl9i
 PEtzVE1LmqHcoWLORiQ==
X-Proofpoint-GUID: b-8qVU17r7SP4eu_1jnFilmJ80alQ2RH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080091

This series introduces two changes:

1. Extend the MCP251XFD binding to allow GPIO hog child nodes. The
   MCP251XFD family can expose two pins as GPIOs. The binding already
   declares 'gpio-controller' and '#gpio-cells'. Adding a
   'patternProperties' entry permits boards to define hog nodes for default
   GPIO states at boot, which aligns with other GPIO controller bindings
   (e.g., microchip,mpfs-gpio).

2. Enable the MCP2518FD CAN controller on the QCS6490 RB3 Gen2 platform.
   The controller is connected via SPI3 and uses a 40=E2=80=AFMHz oscillato=
r.
   A GPIO hog for GPIO0 is included to configure the CAN transceiver in
   Normal mode during boot.
=20
Viken Dadhaniya (2):
  dt-bindings: can: microchip,mcp251xfd: allow gpio-hog child nodes
  arm64: dts: qcom: qcs6490-rb3gen2: Enable CAN bus controller

 .../bindings/net/can/microchip,mcp251xfd.yaml |  6 ++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 30 +++++++++++++++++++
 2 files changed, 36 insertions(+)

--=20
2.34.1


