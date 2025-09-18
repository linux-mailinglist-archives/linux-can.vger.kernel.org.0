Return-Path: <linux-can+bounces-4732-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC31B83355
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 08:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FD67B4D3F
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3132EAB60;
	Thu, 18 Sep 2025 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cENixNJJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB42EA721
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178189; cv=none; b=BMqqP2+OU+BUQ0b/yJ7VdGZvlTLGdk8qc+iAKrs363EPTXooUn895ba63MSMDuFxTO2sVDqUECAGWKDF2kJxTtx0OXWVqvMi4LDfDEdt/Gdi137xcLNnnUdBJkNRHr4U6ctSK2dG4uO12lcCth7RZL0sN6uN4echOyGQmkIYW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178189; c=relaxed/simple;
	bh=EDxK0JAECJqknU7nyBNM/XjceytGlGUL11eBwTOLESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoklQaaGDSoWLBGnaoveUHEnlXD1fJsEliKMlwovkwwipDx3wQ3iPCPmDKq9YX2ZnXmfJxQtS7CGR31ylL89/M9jx02pJ37XBFIVZyVxX/W5sHxCd18nNvntbi84Hsi6SXzGRd5/zbR4BwtTKcpO/kw5+jU7jxS9pnJqpoeZsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cENixNJJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I33Kl9026798
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dzJS/eOWAno
	Hpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=; b=cENixNJJK/h9/M/2CyV2djLyEcm
	PWAfS6nYBYj4IM1o5HhaYZ7RqgOVdD3V9tz72prPrBo+yIxsm+XL3r1hzrNMsmpL
	MQBSGImqqtEniqctJt5uYVSfxIKFcp4TVDGDZHvbAiFlbd8k/aXJDhd1MYmiTA7/
	cnBjJDtn8qSnuJCODaiOAcbcbpTQQ1W55vZvwZc8aQpgYWoEQOuq0O4L2pMxEDb8
	0zWSZteX6riJnKbwpkCAGyk3q3O6CWKt3NHm1LjQtT62AVoIy0cR6s2bT9pVMjwm
	MXKL2kt8moqOIjuxqRTuWAnZdx0EEg3gHAAc+GCKtSne2cGKZ5vqDm7BY7g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt59me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77c5a0c19d4so928065b3a.3
        for <linux-can@vger.kernel.org>; Wed, 17 Sep 2025 23:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178187; x=1758782987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJS/eOWAnoHpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=;
        b=qyG+S+k5aXN7IX0TKa7WGOlqPAkerptWva9z4q971drjVH0ReNhskdzgi4ASdxW8y4
         tyIw2DEUOpzRH3lD9q2YpwnJoTy6kYWx+LBhP1d4nW95GtLSeqVvCFVcjz254YS4Hnac
         unOHZyYSTZhD6G8kJh0kWOKVoFWxLAiNyuDEdaJEpxw/I8w/6bTbJsV2VXA59vlsFyzA
         Nkm0mjISkYKz8rAhNdA5y9aK4Y+Y4MjJkxK1YQkgEv/Jc192328s5CPhH4VFi3c4VyzV
         Dl+Q7F2kcB3mMST7b6Cmd71T0/xmqrXUUZMh5GyB5JedBDwOh2/GhcVTdHdyPDkYjLWd
         we/w==
X-Forwarded-Encrypted: i=1; AJvYcCUPFu0IXKPEYoRTky3xBb4mr7mmP7a2zEtUhE31nvCYDcoA1Kr4Wb0KMCEx+xTl65onMWsQOmFgKrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xK2BbWTbWgBbrSz6X/rQ4jmiQgWF/mVauioW78vETpTluA0L
	6abU49ExHRL/XQV4I1jSkPaZm7wGUTM6KzFe3lHx79bYUVnj5teclbQairbXpHiVHIux3QVOrNP
	6M+4om4iPmL+7TNY60HinPyRfvQe3NrB4VST9xi2akh3njMwxbOx1s0su58/vs5E=
X-Gm-Gg: ASbGncvv3z6U3TA3JBrwkrCZ7+0I5Aaxbx+GqR0S93myKx08YbePJa29OXXB/ANp71x
	Pqvr0LSDUXTnLNEsV+LLy8oUD5D7rRaD6G2+4eb8qLkDT94D2uVL/pH+KmcFEZBo+4xfmcMFzK8
	25kSMdp6SwbRP3iuPednpW/Qpu3CigR+gCnQGhu2obEDhKBqYnTRu412s1JysBj4AFOlm05vcSo
	vBeXRKys5dwUfjGo5TRZddtTNDZiRWWmo2FmRj0S7KYAxmXqytIbRlotSMb34MsmrFZyXPbHVvm
	EkZA4qA9njwJJwVv3CkbrGsS2X8siJRtJ3ouhG61ZDNVwECUpvFrtrq2ClDxH4JJFYrtShA9ByO
	y
X-Received: by 2002:a05:6a00:39a3:b0:771:e3d7:4320 with SMTP id d2e1a72fcca58-77bf9c4ee61mr5751216b3a.19.1758178186650;
        Wed, 17 Sep 2025 23:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY0H1OHgZXTD07nw2+cuSZdMjUSSXrxm4zMX8TS1uckPmlzXEVaCFUKW165uUvcbg/3u2M9g==
X-Received: by 2002:a05:6a00:39a3:b0:771:e3d7:4320 with SMTP id d2e1a72fcca58-77bf9c4ee61mr5751194b3a.19.1758178186193;
        Wed, 17 Sep 2025 23:49:46 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:45 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 6/6] dt-bindings: can: mcp251xfd: add gpio-controller property
Date: Thu, 18 Sep 2025 12:19:03 +0530
Message-Id: <20250918064903.241372-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G8g2Nwd3WWiXhckNk1DRRwvRHvnWrw4V
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cbab8b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ubk9sFcynENsk3o0iIUA:9 a=OpyuDcXvxspvyRM73sMx:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwdA/0H86R+s+
 hAxVLgUQ8sz6LPQ1jfhh45MS7fBzTvcYNTz0GBvbTMCcvCQvlR5LXjxlVJpu+NY7gL4eRv6riWD
 mVsANCplU8tTbwwBc5gpe/kyhigBh7vBMzK8X6Ch4Gesj+FceNJ54/WHwVc9QqHkl3TvBIACv+L
 4nnLTC4+lCvEUi9J+Ppt5+FMLSc8d6lNsjCvUg4SPytQETDPvdASCFk+A/fuZddp1Et6CiTohgV
 LzLdjab671IePFbIK1iSG36el+jQEYDS6efEnXYMLjHnPiBTeNJk5AXaBtOxQn18vopqK0Dxn1G
 fEPLcMdpFyjfkpbZ0vXZ0P3PnPHsBq+MhNqDhPJijaNDPwPRHb38m2fjrUzv9OcbqmvSO9moODB
 rGGgsH3o
X-Proofpoint-ORIG-GUID: G8g2Nwd3WWiXhckNk1DRRwvRHvnWrw4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
property to binding description.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index c155c9c6db39..2d13638ebc6a 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -49,6 +49,11 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 20000000
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
 required:
   - compatible
   - reg
-- 
2.34.1


