Return-Path: <linux-can+bounces-5041-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4FBA3E8A
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B4517738A
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBF2FAC16;
	Fri, 26 Sep 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="migAbhzW"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B392F60C0
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893466; cv=none; b=SQXAetj7N78Fu8CHNHmpBeNcr//cLk39t2kT5PATFkhNiMITMMjbH5tKAIcQUAXKjGxyPw9SbG99Ru0Q5hTTjiwP8BrhVsAvt2wv6+N1LdEmSrDNqe5XirvzH+u/RADZASckQDbExYdqtl/kxgPoo7MwQ7T309maWY6gxVRvqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893466; c=relaxed/simple;
	bh=EDxK0JAECJqknU7nyBNM/XjceytGlGUL11eBwTOLESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCXNDlqjlLFUEQOIUPzrft+bZaYMJFEPUlsVu6Ccl7HuoMDXV94pZMaQ4/weUoUzFLQIKaQt0L8wO9nvsWZ5Nl8EHL6x5g/qaoe+FlzCapjUy2iZmDWUl6480eO2mpAhrnWlCiLh5TuV/yLLTjZJrB8e+HG0QiVqGQoVNvl9UNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=migAbhzW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vmYE014842
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dzJS/eOWAno
	Hpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=; b=migAbhzWL8v+PgJ74M+ufkydUdS
	9n18zmVFuE/FC7LRNpBMccL6mJAKwAybZ5hDDQWte7ypvyvNYcUyB6beadrejWaY
	rR9dGUlpS4JvYl3MxAwkSH97mhh+6BIihQKyZSVZBQ5lMYzsK6u/moyL62hsc9pd
	EYzVA03srswTmqFZSaUWvMMEksf/2p2FJQhEgAdqDdADeTskKN0hcZm3/5JRnTvA
	lHROQLA0kjZZpitvydMlZyscK3tGu40+0QzYRFp385FZRidbVDNQ9Tr+y8cEFBut
	U57viTYbWXTwHmCcVYMfwolorvxg6jySaT0T7CPGKom+9ax3GGMBCXrpaNg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34jyav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:31:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-781044c8791so1783498b3a.3
        for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893462; x=1759498262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJS/eOWAnoHpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=;
        b=s7fTQG462BHBLwwmgYAtRG1LkNX3N/J4yIfJBM2dyZO1pzdqsPCuBClT1Y1by8wL2t
         I1ehtZIeccKiRK+yVtUTTlA5tTt9Ao8P7Qz5xIQt79qb+hOO1IkjQdk76szIXdLwrMMX
         vQjfok1sJSYkO01RwnwCWTBSjeUfQ6JYonosOoOT8B134rfo8UvAAXk0v7dpVBPebqbw
         QPnywF/jOjDQQdsT7uAP5bbDduJGMFO5N2y/4YMm2pJcd+o9u277EkYWgFBaCwOEHzZ4
         UqqccGpdHMlucscgz6E/0fHqHKM9NCCtOhcvwVKjAgWSY9Zn2HiZh78c6i2+2KfmyKh2
         +c1g==
X-Forwarded-Encrypted: i=1; AJvYcCUPeHy7huz1KQ9Mu6H9xNudS/5CcIQyezi8QXs2PNsg6ayG/UA6Hj+kvq9Sh02JHuDE7QPQx7r/dpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/dat0BSggtUgCeLB8ffx7fvSGk5/AmL6swki4xQtFqIKx6F6e
	Cf59tr+xyrmZRrLhgilLiFSE4kmJUqOTDgmJSiIvXt6DfawHn2k2LEhHDX3XMGJtYT18lE8M/Gv
	JBQw23dGiV7c0xvweadicaRut1Bq9D/fKxUpwfD1iQIheqLO1fPbMUWjaR9FMb5w=
X-Gm-Gg: ASbGncvI5BeTS6AC4EB14TuFh1cr0lLOKjNDbMs7g1toP7WMYB0fBKt8Ychwhp/+fgG
	WwAnlbNBbGc2FFJZv+Tj1t+pEpAomgWQnjycItSLdzzmce1ZCVVKifD5s1U/nzm3givcnFRAbnU
	YxcZm8IFDvBlSZPnqhaSKOYx3fykikLzXybYnVUfgzW2X1eB/YbByW7ZVh2aLDTQQXPbQcR2THI
	EhZVk7HKYjbw+8omMkGHf+lN/f1ZsFW2D02Tt4IaNHxIRw/3IERBtlj28OliEjqyE+B+CWxgekC
	hJJoRPIBKoA83AA+ogGqxQHljJQdftwGNTDTVl5xu9OP3uvpyatzvir0nq3dTuQqRek0LtDRe9k
	D
X-Received: by 2002:a05:6a00:1408:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-780fceb49eemr7690270b3a.22.1758893462035;
        Fri, 26 Sep 2025 06:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLeHddy/mn17tTANaaPlDdZJPY7hKHUQGRRzCDSBlp3I0nv2etth7ZbqEJFM0oH9ZNV1jfRA==
X-Received: by 2002:a05:6a00:1408:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-780fceb49eemr7690219b3a.22.1758893461423;
        Fri, 26 Sep 2025 06:31:01 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:31:01 -0700 (PDT)
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
Subject: [PATCH v5 6/6] dt-bindings: can: mcp251xfd: add gpio-controller property
Date: Fri, 26 Sep 2025 19:00:18 +0530
Message-Id: <20250926133018.3071446-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX9Zy5FPbc31Xe
 TyeiBSd1MnrHgaMLtmOjEZm0NBDPD3k6v28OjtCEFcfkrwgjEtINDAwf68U4zXaAlhZfBYqgi3i
 m24L1Tp8BOzJgIvx61oNM15d61No0jiifTdnzbarZBHAESJDWfIJ/IbHjgILhFYzGAOYtBJPYsF
 uu80tphkG7JIscDyEgS/UdSL/+p8tmvKJsIWfs7cbPc0Xds5Ef3KdRbnT1egeBzPXHOC1AaMlYz
 DwUwiSZP7A5bu17H+G/oWP2tWeaMY0o1e+5BYSVXxnzQkUEKFH9Z6j+rI1Geu5h1Q3OZUlYdEy8
 1NWKWiP51/6O0tEFQOE0idP7xnXVThACeWYjacItsutqNhiM1VM84R3OW1S0EWrgsroy9Trukh+
 KIdbGYo/Wfw14DKfTDke4kTMZBSK2g==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d69597 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ubk9sFcynENsk3o0iIUA:9 a=OpyuDcXvxspvyRM73sMx:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ztTk4oMCDhrVvKkyDEV2Br-ZLm05RUSG
X-Proofpoint-GUID: ztTk4oMCDhrVvKkyDEV2Br-ZLm05RUSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

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


