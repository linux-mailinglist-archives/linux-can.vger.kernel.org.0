Return-Path: <linux-can+bounces-5079-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0CBAFCD9
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8193E2A2DE5
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 09:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE82DC32D;
	Wed,  1 Oct 2025 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBqrnrN/"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F782DC320
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309854; cv=none; b=WWQEFiJreTNDI0NgovDuEVLY+R9JYGu8ojeE5her6HwHy5n/l0SfC6Xpg+3ED6SzoiuKJCJBm3FzwuW2oR31zrCuJjTvPiLPHzN70d0oYHwIu7tFK8LF8eQQihk4UgeVl7ZNi9F/1RtlZK+CNYMAHqkJtUlN2ft4sR9gO2EAFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309854; c=relaxed/simple;
	bh=EDxK0JAECJqknU7nyBNM/XjceytGlGUL11eBwTOLESE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvIs2CSClBMod4iTuipJVVArsnBw9/Sk8KRh7gADLKITWvvPg4gqo0Qv3bx3EDp5h97AFQznCgI7SqhLTQ3HMaiYAp21nyh13TsJUb4yk/KO7D3Gt6OXYAgvk4f4HRpeNRMhRLRH6ZblwIHsJAoLUlzoILsU9LzTVk9p+nJGlkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBqrnrN/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULmaoX030546
	for <linux-can@vger.kernel.org>; Wed, 1 Oct 2025 09:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dzJS/eOWAno
	Hpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=; b=mBqrnrN/7cpp9QY5SYGITKEOWKj
	xRApfzEUxwU2oApr0HAAGWj6y6VPoep49b3OthJW6Z70cndLpj2t6eQ/7wnsMvSk
	9ntvar4d6AIWcf2A897rp69IhDTNFzjnVLyGh0BsR8rZKc3MOkA7t6Fh2hqeUbgy
	ikBeMOEUTDSWaMUIWZVNSJJsJwrEm+qZQbwIAIJMhxIH8h30sgCwPx9VjsCu4DS0
	m9VO2oEXMfYLYnnHRDmrfUMsfkqRcRd/jyU95ibpKbMXqSx0nOIfa2lbgRU7ZXrK
	7Eh4epIjK6tx3SBzDr8vbPbcVBVXucjQ5a2NIvlMDyII3UCkqQV5FwQmG7A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdkqhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 09:10:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-286a252bfbfso79680665ad.3
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309852; x=1759914652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzJS/eOWAnoHpfft1/dBeRGBEhv7bksVWKJ4cITaZw8=;
        b=K29QHI7I3+zTTN17tHcEevNxlZ2rDyqsYZxbaTHGxD5JucbckxYVpC3UWdYxs5mo2L
         ZG/2pw9AL9cp5864mQmukHZK+lSy87dwNrgMg+BvjQeK0H8tfB9obifdU9EJTQBUrt4Z
         HdKwu+2JN/syxg37A27oN0TwDboeafK2QEOgBO4qR/tKPopd0ZbYoHyWM20cSZezILJ+
         0QAaouNVey+TWU3ab+Ce5gX4E5PBISwLGG2lmYIPHAalhQgZ3sOUxFINMbSVRpDBglSe
         nFzW8i0MToQ0otomyExEJQjQDA5Yd/mVd5Z3vogfvAG8CJ4QVkv9q5ob/2Ez8lLuTKFk
         yW0A==
X-Forwarded-Encrypted: i=1; AJvYcCUM+lYD1rUqtDCPZtowSn4ZxgxG2p7iXufsKj1AZTV9leeHg/4ZslhZKwH+8Mwl/N0CKLViFuzabeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpxTLOeFcHwWA3VFcxE0vVbs9M93UssmNgUlvdnnDO7wwymue
	gE0yd81hwavPX+XcutoepLP3ehy6XpuJm/6nHRVomo85LGz6sQh8+Z/xtUNnkYcJzFn/T/6NY1B
	tKTsDaKOkpSnUr1OWNNutRqkGpkBz4GYuKGWcNPOn8+Zi+A4YXYJo+LS47W29K9A=
X-Gm-Gg: ASbGncsUIUmaPBH5djS92nhUCaelNfCIxKwXGUbnfkK8XPg+3BUjk8KGOnbwTuaIlQf
	BFq2ov2ZhaNtYeh1Wm6EFINm+S+IwT2CXJgdpAIZuFZDrSkAoBIeliSuxcXSo3lgKKYu2/ydE85
	yJBSJKDPBiLKWQDytiK3NhCDr5+xEFLUVylZehZLHytK8oa0gr1FtvZcmcS7OBRsuFDFwFT2AS7
	PpJmD/cW/rHVOddqWCRqKjzL4BbIifN8voAAnEs2ikZditAHxNm9OyV9xq0ZlE+6SUuBoHkFJEL
	Z43LTeh6zhwtMe+2YCwUsykTSPGBPbpVrvspxCbadfcKd3a5Z0o2c5XxdI8MV4Ee5QHPjNb4ioH
	2HlDcwA==
X-Received: by 2002:a17:903:3201:b0:281:613:8449 with SMTP id d9443c01a7336-28e7f44200amr34870845ad.47.1759309851681;
        Wed, 01 Oct 2025 02:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKedvdV1/ItaIACYKHnY4KYhs298v4BEWXXcoD9/zsLksqKknUQgVmOswuXLjmaqAn+lkDdw==
X-Received: by 2002:a17:903:3201:b0:281:613:8449 with SMTP id d9443c01a7336-28e7f44200amr34870505ad.47.1759309851282;
        Wed, 01 Oct 2025 02:10:51 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:50 -0700 (PDT)
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
Subject: [PATCH v6 6/6] dt-bindings: can: mcp251xfd: add gpio-controller property
Date: Wed,  1 Oct 2025 14:40:06 +0530
Message-Id: <20251001091006.4003841-7-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: oB16CoXPTc-r4rpC58n65vqYfrmQYraM
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dcf01c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=8f9FM25-AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=ubk9sFcynENsk3o0iIUA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=uSNRK0Bqq4PXrUp6LDpb:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: oB16CoXPTc-r4rpC58n65vqYfrmQYraM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfXxqUCivkAHsa0
 z4GsBVVX0P4a0vPZmkOZHl1vswG3gCBU4hn7owVj1ihRZ9cX6iF6IlgDCvETeIhzQFLvQtgNzXy
 bqI+wjd389S1Jo2gAd/EUi5UCDZR3eci/ykK7BA/bj65FoNSFRHFKrGMgRGuVCZuJwYM3btLScs
 t4dZfpNLxcu2yYEfTkc7gLxRSDOekGJNntvaihXiRONVxrYOn/b91JD1jDWRSufxTF9J4mlEfTv
 F3LN/GNKmnR7/8o4D+H+Nt0m87hSjk2+hVg7Ub/LU5iMM4fwNc81fDdQhp18WhpI2JOvJcLto9r
 pisw1+rTf3eMWuoBmRW36IDp8z0zSraGuBYy6u2mwAGAVJuY2/PfFpFAa3lU9Rb6pyvtWipP6+t
 aoIoU1wcBDpj8GSPZO8ImbZLR2PnPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

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


