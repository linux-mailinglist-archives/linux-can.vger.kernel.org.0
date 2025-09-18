Return-Path: <linux-can+bounces-4726-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7914B83310
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C031C8123B
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F82DF717;
	Thu, 18 Sep 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fq1ZLBeY"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC78F58
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178156; cv=none; b=CZWmqARUYGX9oBzH6IkMaqj+kdxi2ZvdLDcnSuWy5zPzgPBqoT0RCY6SDp5B9cNnoF0+OxxbkW/eIH1wYToEVWA+9L6tNYq1t63TNhWeZt6rIgm3WAQJdF6qVm4MW5sqyRaAgAlM2ojc5UpbX/AYHLcDchEaqyZ8zuD03bY5uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178156; c=relaxed/simple;
	bh=ErcDCir/FL2L27V2yhCvXo9PV0YbnBMQYjljKFP6sN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UCjew2u5Uotn72YSyX6NOQcN73q9yWrEFtjavm/ps7CyNTyfhR2wCUdJA/oFYkBUOGvnzWoRGABhEDDmy2XyARMGlcnwWcchGzmRoJyNCo2WwyJ9WvWX9ib4oqczxTeAI/d48eDgIuRL2QEnhfRBNwBem5etlLRyna1UXe4USbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fq1ZLBeY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I53H8p017023
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oIn4sFdMvxF9JDi10QHzfu83QzlIJxyUB2t
	s4/QNXqI=; b=Fq1ZLBeYlag9+wqxoNVEt/DMXQGYMfkrk/3sfP/PP+be+o1ojAf
	vkEthibH226hUUW22oI6qSbzxDId41hBM/VXmVZIwQdZdtPLQhnCteDg9G/ByIN2
	bN2f2zoU6XweTnylEhNe8C/rjt/1iFRA0LF2wRpPYIXhNNLxzwINLW2MoP7KdaeO
	6ITUMnPUCzMDusK/aw6QMm/Kh7uvDQXCwZtTN2GeUz5Ag8eX7dNBS39aIjq56jDZ
	yXkQ3B8pl+5mhulqVaZetsW6HJnjSSv4gQNtlhQZIuzu71rJQRpdz2MlaXTbzevH
	o1X9Lm0mTWvTW9R+wjOoXPSNwQSsgeJMRrA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982de9s3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:13 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54f6a4bf11so413600a12.0
        for <linux-can@vger.kernel.org>; Wed, 17 Sep 2025 23:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178152; x=1758782952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIn4sFdMvxF9JDi10QHzfu83QzlIJxyUB2ts4/QNXqI=;
        b=Pilzg0KrkQl0Ccj0iGIinraJ7yYSvzOHnycTSXiEe0RfuREswWCgePPCTlq5EBhukO
         dfP9ja3VghLnKASaqcByMqJ4FOst/FN7eB658KiRXSDcVImq1KlcWcJoRbeXSuLHV3Zh
         gk8sepNjhD/C1Oak4eW39AhvyUwQtPIioqXDGEZREA6i1DiWfZIH9ChZ/CSkCDV0ONoc
         Hkr3hNxRNRfJIurfb0dCVBa+5CGib41zd5QmxNXS+Kl89CM92sTHJOo7ly7br7p0M15+
         kLo+WMgDiwxVRHSl71A+BvH4pEb4EWZsjq1ebSybnKZPvqBxWFxQSAzbmf66xDOfajos
         RU6w==
X-Forwarded-Encrypted: i=1; AJvYcCU2bapuoiZW4/tibt8PlizuPDOmfteK3jYJInQ1fFs+hsEbjsG5ci1X7lhUqdqKSgnAIODQtqfw2i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tWZASpT2mDIm1C+2v4R88VUPYHdridNhZqqSV/6MaQwXwnSP
	eqOG8U5y9A8DcKDh8bdDAG8vYfdi8W4H9m30BXydw6eGA3GPFN/RPiuLN+iEm2obnT1RRRU+DVT
	ObaQTW42C3O/gPy4B/Tet22hiU4XdMiGPVdL0XWjmiab44qGCf6+oaRCaXVw2Zk4=
X-Gm-Gg: ASbGncvwyXnn+slSGsBcYCawEq7LbXlAFyU49E4+UMACmHDbTqaNdmqLUlxbpeZEdZM
	fQxI/JlzxtA35SaLjgPh9ZblIqwrQDi8gZ7T7Xv9mjX3oW9zECdmW4pJyAn/N6QTqkr11CbzGQV
	zmP5n9RsNYRMJBQVKTAGf2qI8R36kY3EAXrFZ2NL2h4POCXDO2bhloU7KvY32X9lOPJO384+QVZ
	YOQviJlPj5yecO9si1d0q7bLg9Tq+gIXlITRj+X2Vaqf+IGmEN+GsaqUgdWSRy+nbJXfqQhlvqT
	Zv2jF74sGe6mhiA7ekwd7dZNGzhrjzlLbd8bpveT4U4jE8lUGFQmOHyYWoTB606zHf9m2OowXLS
	k
X-Received: by 2002:a05:6a21:9988:b0:24d:56d5:369e with SMTP id adf61e73a8af0-27a9303eedfmr7041388637.3.1758178151919;
        Wed, 17 Sep 2025 23:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4ZviaMBDQpPBzymkzbRdb3vIBqhk21yMuf1H3uqYvz9E+DUhiRUnBAG+10J0W1XlZwNOlmQ==
X-Received: by 2002:a05:6a21:9988:b0:24d:56d5:369e with SMTP id adf61e73a8af0-27a9303eedfmr7041357637.3.1758178151501;
        Wed, 17 Sep 2025 23:49:11 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:11 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 0/6] can: mcp251xfd: add gpio functionality
Date: Thu, 18 Sep 2025 12:18:57 +0530
Message-Id: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cbab69 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=8f9FM25-AAAA:8 a=Do27b2NNzWYMqhJ2O6UA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-GUID: 34ltAt70p5yZS9Fv9_5g84nHdUBoo1QH
X-Proofpoint-ORIG-GUID: 34ltAt70p5yZS9Fv9_5g84nHdUBoo1QH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX2MxpcDnNVdKh
 j5AtIM5YRwi4SujQXIX9idDb2I54mOFn/zBevZDG9F+OSiUiljg7jHzbz4bbSdnw++pc8yB9KHd
 /QODFGC6tzS8S1ANkd4qaHW4hLfnR4xMfcbR751upkvvtKqhcloHtSjuHb2azEdWOfChgfbkALa
 eS9omKNO9IVRoN8fYsCaUDYo5If62nF5izSnI09wyaJiO0oeCIe6jXP37t+qEeURxDQUgzlearj
 abtWs+vjCo0FVQtcNDo1KvpDxQJ4XqX0uFla2Og7xSdNXdQJeapY7i0/QJf88kmO8tNN6sweLHV
 vVtnLoFvOEDmCTVKBESlVQlPEltFqxtkwZzW1ukTzwCqmCWv8eTyk/KfleR9ZYAgBQwHmAApeU7
 rW8Cs7tV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

Hi all,

The mcp251xfd allows two pins to be configured as GPIOs. This series
adds support for this feature.

The GPIO functionality is controlled with the IOCON register which has
an erratum.

Patch 1 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-3-c26a93a66544@pengutronix.de/
Patch 2 refactor of no-crc functions to prepare workaround for non-crc writes
Patch 3 is the fix/workaround for the aforementioned erratum
Patch 4 only configure pin1 for rx-int
Patch 5 adds the gpio support
Patch 6 updates dt-binding

As per Marc's comment on below patch, we aim to get this series into
linux-next since the functionality is essential for CAN on the RB3 Gen2
board. As progress has stalled, Take this series forward with minor code
adjustments. Include a Tested-by tag to reflect validation performed on the
target hardware.

https://lore.kernel.org/all/20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de/
---
Changes in v4:
- Moved GPIO register initialization into mcp251xfd_register after enabling
  runtime PM to avoid GPIO request failures when using the gpio-hog
  property to set default GPIO state.
- Added Tested-by and Signed-off-by tags.
- Dropped the 1st and 2nd patches from the v3 series as they have already been merged.
- Link to v3: https://lore.kernel.org/linux-can/20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com/

Changes in v3:
- Implement workaround for non-crc writes
- Configure only Pin1 for rx-int feature
- moved errata check to .gather_write callback function
- Added MCP251XFD_REG_IOCON_*() macros
- Added Marcs suggestions
- Collect Krzysztofs Acked-By
- Link to v2: https://lore.kernel.org/r/20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com

Changes in v2:
- picked Marcs patches from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de/
- Drop regcache
- Add pm_runtime in mcp251xfd_gpio_request/mcp251xfd_gpio_free
- Implement mcp251xfd_gpio_get_multiple/mcp251xfd_gpio_set_multiple
- Move check for rx_int/gpio conflict to mcp251xfd_gpio_request
- Link to v1: https://lore.kernel.org/r/20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com

---
Gregor Herburger (5):
  can: mcp251xfd: utilize gather_write function for all non-CRC writes
  can: mcp251xfd: add workaround for errata 5
  can: mcp251xfd: only configure PIN1 when rx_int is set
  can: mcp251xfd: add gpio functionality
  dt-bindings: can: mcp251xfd: add gpio-controller property

Marc Kleine-Budde (1):
  can: mcp251xfd: move chip sleep mode into runtime pm

 .../bindings/net/can/microchip,mcp251xfd.yaml |   5 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 292 +++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 +++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  10 +
 4 files changed, 355 insertions(+), 66 deletions(-)

-- 
2.34.1


