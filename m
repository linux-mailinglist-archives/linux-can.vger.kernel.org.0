Return-Path: <linux-can+bounces-5073-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE90BAFCA9
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A24644E29A7
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6AA2D8DD4;
	Wed,  1 Oct 2025 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cs3KW9wy"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AF283FEE
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309820; cv=none; b=Hbu2I6byTD/6CMqIJaxAMdP1dLzEVFZ0aZUWE5o6wkSL7meUMlkmx34Y0xXA3NeuhmvmOUKxkmYQ3tTcN5u8VIS26Az7u/RGrY8ly+liBQKLJ9rMms2Vmgrv7rEqhfdGv8kqnDxVIp3ia1Cw5czCaz3WNBObKazW3+NLg5lwYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309820; c=relaxed/simple;
	bh=UyVEvwAYo4fSvnzb0e/4dzS8EsEpGI3fDXNtQzwqMU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kp/gKBx0GUXNKK7mNg02DBajcUd7d8q9D9rOqgTYB3sTjcoxajvguj7sxTeqvmXY8zxKhteRqGso7T9tIMn0EWpgIofwnyMpg7FoDFagMiadiNFDSqeS1jnL3JiZUoS+1VoPfI4CGDymqsZz4c7e+QPbBfQ8abtVovl2+RoUmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cs3KW9wy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UMII3Q017533
	for <linux-can@vger.kernel.org>; Wed, 1 Oct 2025 09:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lNeRLPEUYWV5BSZQOFcWupcqoxEfdoUY9Dt
	Rc7VMxGo=; b=cs3KW9wyJxuoqwMzScpV8dL+thIIjvu4hqq0lU8UHHZDID0Squf
	u0f6v2bf5PAtCCUa7usQ6Tc8IozfVwPXE6RqPoKyXblRhpfy9YVtbQhXrsOFU0Ju
	WbLrMmJEdeOMjYYiKuMFLKpcxQ/A+G4g8EFm+1aApDri3bdDLBDEDsnYjIFuVGHX
	4/6TO+AWtB0bc3i366FBqi+u7uC5iUV6dEIk5q4YXog18MySutsy+47AlE1WKI42
	+LqyZCCzK2DZ6qmcZ8UJ+Fw0Bqa5d9q5f/JuP0iyYwDJ69uPbQG4F+5xJPsmM+Ie
	5//HKF+une5/7fOn8OsFXwEm1MrxMNXcKDw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tv5ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 09:10:17 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b557abaad02so9029995a12.3
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 02:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309815; x=1759914615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNeRLPEUYWV5BSZQOFcWupcqoxEfdoUY9DtRc7VMxGo=;
        b=NxquRQxX0FrHFxYanzgkZ4Pg9oRf+LoD8f5BO5r756RMq5zzbnnUYJtJdMhQB5gPGW
         CAxkJaL5a+G+t0N/oKhS0+Mc1wUXoGDn/w9NNK5OMTSZsxFKkNCEWmlwdV3SxdDQ0A0F
         nSSkhK+bUJgxDOT0bYTo0x6yqmTcMd/btPXUbENdud3jTofgq4T478JM1/U0t6HD/ckJ
         ZmNO+09p0NEWuluwOx00QqqJfEUy9pUjwSH5QJ5+IhmPVn6SDla2ZfoOsazerDgMU2Jt
         bhQ/2inSvu9X+TQcNefPB6WtfmuojYAFKqzpYk7Rtfaqr3SykRFz1WiigdYxWOddHzIF
         5Sbw==
X-Forwarded-Encrypted: i=1; AJvYcCVBwFakm9hPRFgM6+8UkG24gswFHpSASnN+lGEvpoQ7UhJRd1qDKEPdWzZ4AAcA6/IuiYpGSzV1YEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGt6HIMZUexP+WhZuAjP6RIv8bSzKmCjeQl6Gz+kr8LRwmhRR
	32yhMuoBMYl/HRMY8CNXPiRoXN4yqFZel0VWuk3zy0P0QOkEvIjB+wGZaHlejyYish06pYGWY4q
	3T7ZRCsReVIvjcmwnMRyIfMiQIWicUYfSAsbO3CEQ12Ev1CRrM0/JrYPA0Kf2/s0=
X-Gm-Gg: ASbGncug734Y0hyF0+C62qVgKURLfqaqLROogNdENgkiePrwEK4NlkSAMF+EBATe+w0
	gYdKhccmW1ltSgPr4jaVKV9BzBn7DmnIfjVd/ERyc6TClIUOTbaKABfTovY5uagDr9mEHSVOEeH
	DsqO7Yx/+74Rls3VhAQIGNUnYXoiDpbQQTcYFqaxcDyVY/ypiVlnBp3CYQl+CX/yYyLfKM+X6VV
	bMamW3oEQ+oQJo+SCtol3rnOlkITVpPo31t8nfJ5F4OlKAx/yh87EIIRs18Ahz68ynHvzkDuy7U
	2+tIbJG6PP2niR7xf1fHtbK/xJNKYoAg4wf06AexuMqTZOoe2zevw97OvSCISvJN3+y4J+tdcJO
	589gmgw==
X-Received: by 2002:a17:902:cecd:b0:25e:37ed:d15d with SMTP id d9443c01a7336-28e7ecaf7e2mr34346145ad.0.1759309814975;
        Wed, 01 Oct 2025 02:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfNj7f557yGS4zV0OIPzKADeCcll3WFCIzqLMSWFr6e1FWj582ctC461ZTnDu2IPH09h6TZw==
X-Received: by 2002:a17:902:cecd:b0:25e:37ed:d15d with SMTP id d9443c01a7336-28e7ecaf7e2mr34345945ad.0.1759309814463;
        Wed, 01 Oct 2025 02:10:14 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ea09ebsm1859315a91.2.2025.10.01.02.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:10:14 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 0/6] can: mcp251xfd: add gpio functionality
Date: Wed,  1 Oct 2025 14:40:00 +0530
Message-Id: <20251001091006.4003841-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX9G84JyGxEUvu
 F2ojTpIDxpWg/ijH16oPey8bS2pVEuOala0BSuKjPCPrn/e9AyUIc/9woRDO58yE5o6tNZP71jD
 ls5R7fBtC3p++jqPbMqTaR3BTwJAO4eQQNRs9221IbVFTBvMbfhI5jlCyEbLj0G0bzonuXU+OgN
 78IteUznQ2Ld/c/XLi5RoKxwA6d16Ou5EWA+lGnyt7B32lsGu2HIJCsP9U1qWtzZrFtTqQuk3h5
 cC3Ao1YaiM+p/KktYMBgd4jgUf+Nc82xd/VIP2kFZQ6BBvdS/TsOmebTZ64pxw/MpJQK+SrNIds
 hXE0eqRCHYD6B/AQPIoFyD9l2RHchw788n7q/pMUVerhuFRViL4LMf78UDHIqCARwP+zGkoulrR
 ivem810CnEGAsC3ilcpVZF6u9kKbVg==
X-Proofpoint-GUID: JFDYwQTd6wwYYKkJXsjMaLPRfj4Uh4F3
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68dceff9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8
 a=O1qDPIM8N228WRSNLNwA:9 a=bFCP_H2QrGi7Okbo017w:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-ORIG-GUID: JFDYwQTd6wwYYKkJXsjMaLPRfj4Uh4F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

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
Changes in v6:
- Simplified error handling by directly returning regmap_update_bits() result.
- Added Acked-By tag.
- Link to v5: https://lore.kernel.org/all/20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com/

Changes in v5:
- Removed #ifdef GPIOLIB and added select GPIOLIB in Kconfig
- Rebased patch on latest baseline
- Resolved Kernel Test Robot warnings
- Link to v4: https://lore.kernel.org/all/20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com/

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
 drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 273 +++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 ++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
 5 files changed, 335 insertions(+), 66 deletions(-)

-- 
2.34.1


