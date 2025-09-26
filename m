Return-Path: <linux-can+bounces-5035-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8666DBA3E51
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 15:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4414D7AEA48
	for <lists+linux-can@lfdr.de>; Fri, 26 Sep 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5DC2F5A0C;
	Fri, 26 Sep 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDvH8+yN"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0622C1891AB
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893430; cv=none; b=HA6xmcKj96N9misZ+d9uiIMCddlpDPfA+fCzRaIXoE6+/3FZaJMC0/YzTCHmvzTwv5P5lZetnEtIhqNMAY7EmIlC4Wf75ftHN2ZwzSV+l8xHESgYZ/fIBSdAKluC9rxWTswVBjwqGCA/4iXK+0o/uoSxoBECTvdTHZ9a7dRkApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893430; c=relaxed/simple;
	bh=sBL5VFqjA7dAOE+3fWCfFfyRLa+xg3ZQNoJJ1E1miiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LJMbK1za9pZyp1XWjjYIgh/W88wiE2tJHzj2Gw0FjwbyVxePMXBr+VbzRqVHpxpiBZqxevvpXeMneRaUTgfCGvOQqPOV1OlIME1cADn0TRnM6XnIargcTg9ujUStrj70/H5Jc7pIGWHYLenPYcEfb5DFZ4yHiPpG/otaQboG9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDvH8+yN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q9jjEP024045
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uoKwV0Sq51MNwidirUMq5Xk0YmJQ4zILgpI
	xT3e4Fyg=; b=FDvH8+yNzzEOiwaXKTY8sPYfIV8PHWJJ1jDY2JYdvEQphR4FCZ1
	naDyl/KhmBWPSkMWSbNDcMYCJMddHfoeVoZmfWPEU7Ne+envdUOvVFwmf1yfWpSX
	9VE3lBM9sG8nPokgnMWH5hBu9Iym62wzx8cBbJzz8GqdtRclAG4Wn/1oJliXTneQ
	EMeAK8Q0V931PWLUnuh4XBU4HZuT5zQWrgrdjBbyIo9zinqOThj6c/0l3LT0xWga
	tG52d9M4VGR+xojl9fURcPeHr02paFtCFihu6C3Ed8nC0C33eiLCnBX9krwatCMi
	RbYDmIWtTmx2RkEwSMhXJI25i0Jkg1zuXMA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49drfwgkum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 13:30:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f68c697d3so1697414b3a.1
        for <linux-can@vger.kernel.org>; Fri, 26 Sep 2025 06:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758893427; x=1759498227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoKwV0Sq51MNwidirUMq5Xk0YmJQ4zILgpIxT3e4Fyg=;
        b=xOY/9JzZdFzSziy0A8goYX6JSNu+L7GfQH9TTB0L42f17X0cMJcJAyBWPxdPzbvJ4r
         c4ZqShhmYDjNPUcr39IkbV7AIotnayGvqq+gprhvVoMoYl+LXyZXSbxsmSmLKFiWc6lg
         FjEPY5F0+RoRxzTpbozhs8g83ZB5tBUsBnLPjMYCtgw2azx06N8dEkirMzRioNWKySVc
         GXA5SMjtXd5lWoihcrQUjoZNq/zaUao8SBux32HO2hWJW2lHKaP1B/ic6dinnStPgFV1
         i75DY1QI69dgKurAcl2shigGEg/ymUJNyMauVrqx4cxkF1wXgd6hYNOASEHbgFzlXsRt
         qF/A==
X-Forwarded-Encrypted: i=1; AJvYcCU6KSi391ZUewynZsPqSV4/RQVk+9psLLxeww4jEhkeo1jIEVjSTewO9fbiGKN0msXFmnkIeaZBA3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOQTQuVcCINmRUiU+YyiBF8cZhoAuzvxIBOdl5QG1uiILTSSv
	yMlfOHJF1v1YTfaG5cbiDWFSVPE4tPXWLB2Ch3sjlxS8Nk+XIRvrvZWRIAa2q71PMXOJ39l7O7o
	QB4GSHevUOR55rMd85s1TGcS3bRnDqaNEZbLMyx/f8x9aPB3BBzx/bEl17jem/zI=
X-Gm-Gg: ASbGncudXbi0FuQRcuiU+mrk/BRnv7uzuSPg1IfpeiBpFGiQrDht9Cx5A/sHcyWDgJK
	44ifJPnKZOoXSSffBnf/nmtdTtwdDxwW45FoEunWwNoQT1yLpg5uRVt9AwKYKUmSdg1M109/zMa
	8PEX0dD2YKh/HBNghtTkmDt6OuiXmOXXvzf/ktE2XJE4CN046U7e0/T+EOI/oB+9M7jmDUhKhcX
	sGWM9jn+JbWuUR6GyLAOfCx8EuJkSzGlUicjWVh+3ReV0H1dGqf+cCwbakceZRJLqkMORUwQU96
	NbGCZa+X+LzZ2aiwlxFkOQ42vl7AFag0x3DMsju/SbiL7CiSJPQVX3u4aBqOxlXQO7ilAeTA/6Q
	B
X-Received: by 2002:a05:6a00:6601:b0:77d:a490:269c with SMTP id d2e1a72fcca58-780fced43b4mr5805004b3a.29.1758893427096;
        Fri, 26 Sep 2025 06:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGumQSX5BQbxqGqsIJENyb3Nbz5wMeh4B8GMjP3A1nfNcTm/05iiJIt6Wzbgdo06eK/BjzVQ==
X-Received: by 2002:a05:6a00:6601:b0:77d:a490:269c with SMTP id d2e1a72fcca58-780fced43b4mr5804958b3a.29.1758893426364;
        Fri, 26 Sep 2025 06:30:26 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238d321sm4504174b3a.17.2025.09.26.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:30:26 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v5 0/6] can: mcp251xfd: add gpio functionality
Date: Fri, 26 Sep 2025 19:00:12 +0530
Message-Id: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n4Pv2VRy_Uye4Td6wd7Id2_y8u34oLUW
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=68d69574 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8
 a=dBwfbOYln0D7H48MSAAA:9 a=2VI0MkxyNR6bbpdq8BZq:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-GUID: n4Pv2VRy_Uye4Td6wd7Id2_y8u34oLUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA4OSBTYWx0ZWRfXzgyx4xZEz8lJ
 UTFMEnM5B08ZjfymrWqxDyMi5nZ0jBW7hEeh2+O7gRQ2cot+I5j4QWqOVy7htwnwpdUZGV8AJz3
 GGfTZFBejdktonvaBFL7Km4xpw+7CsObHdnsxFQKdcqpnHsBVo6HFS4avnYWh+Tx10uk2DUW2fg
 sgcFVZY1YWdVLb9PP3gdp49HcQjaXYMtEn8pHHIJJ31VEiWSJwwFXz+NImcAUZLU8hhoQQacKTI
 +mtrIG9sajGHOWtZBFFxUKxVWJ9STAlEyGl0V4LLxgknSw9iv6zhTc9ngKfN2ihtFH8/LLppCzM
 yCMDWUcNudrg86pUfKEkeaf9OB9owfp3FzOA5vixFWjU8du68KGT3pQ95LQ2AB0z89mAGOlee8E
 aSV/mhKo8WYpg+o0gfdY9BuSyEeAEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260089

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
 drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 285 +++++++++++++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 114 +++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
 5 files changed, 347 insertions(+), 66 deletions(-)

-- 
2.34.1


