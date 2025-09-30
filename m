Return-Path: <linux-can+bounces-5066-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3002FBACAD0
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3903AF981
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709502F3C3D;
	Tue, 30 Sep 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFwZdirq"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A41D8A10
	for <linux-can@vger.kernel.org>; Tue, 30 Sep 2025 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231553; cv=none; b=sIfFtqygXao//L7RODy8/ZI+xQ3tfhDTblw6Gx9uKcQTj3luZGiXCvude/jiim+Og5WG4B16zu5nxUyrL5Qer7/nTC94o+n07fCN8VH6Vlb8nGu/aTfs7tpCCcYtTrOYuHgLAYMdyYrG839Jo8cvtPa1qs+/o1nGZNdyQALdsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231553; c=relaxed/simple;
	bh=LRRZo+WT2xP6CFwmsKi7m761K4DaPFkni8XtdzN9t7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+vn19EZtNGX7eB9IvOzE/ELv7EAqpWWYn2CKsvZCZqyYw16prj+3/zJlb3P1qPY8RzXL1YDoiTZltsNwZs1uDlMhlZCkxNYZK1LSpuJ+yT0kD17h1gOiVY7/MI2ZQwjr2jXn0t0sSxGcNbVv8XNPyExFSsTBSyzKgJ1GlTlsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFwZdirq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HfEo001106
	for <linux-can@vger.kernel.org>; Tue, 30 Sep 2025 11:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nZmbRUIgjQnJaBNXO8k2s7Ar5zCROndbpUISKQygcl4=; b=dFwZdirqMB4th1KH
	SXS9KalXIO2Ns/HlaaFOtYCOndVLh8SO1IVRBDudkItaW7QlTm4XVFh/QHk6n/kO
	4x/gIE5UfVwHNgeIEDeZEEsxweQxpsAti9IEUo0H7teLRiYtCAMSEPCmsoUXN+fq
	fAKIcr7pUpaxUowzv/jzQEgVZVSdyZyJBHmeEclBe9yca40A5Kfwp9hv2Ve6eH2O
	tFZUZAELHmtZG7zoX5M7dIt5TX36/al7vYFcaSrd0xiZphItRnvw9BetBYZnUrKN
	cXIeu25ySp32mb9+Z8ZYXn2ef3tflgafHwA0ci28ycX1cOzeuKulZh68l+x51rX7
	LQuVEw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr486h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 30 Sep 2025 11:25:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-781171fe1c5so3910247b3a.0
        for <linux-can@vger.kernel.org>; Tue, 30 Sep 2025 04:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231549; x=1759836349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZmbRUIgjQnJaBNXO8k2s7Ar5zCROndbpUISKQygcl4=;
        b=EshdMWfAro6zxPxTBZMP1Yz7AeKSBT17K4M1BywfSMNThaOiMqZMfBxSMT+Br9+MRs
         2f/framp76xYIgyzqZdaPUZj9cEg9LVHeGr9O5o+f3ifoyEVn1y6iQ6wAIE7V7v+IItI
         tHtLGcMe8O2L0nDUGeIvKfi+2PEluA5JZmkk1SAk8APMmjXMIymCytfWBHJnF5Z3UUoa
         poQJGe12rZLBfV5n4GaQVAXLVvg6pnD+oa/MnaufBgysDwylVjesUUoSSsELl1neBw2b
         dJNtaNCbmpEj8XzVhsqCBPhs+cuqFXJaXBFbkl78XjOGWZJsry/6hLyQohFcSNfdhr9L
         jFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYDqN0ZA0kmodEKgp0QIqQFsJNlushFrl4nCExofDdcI0jYv2nd3a4kitz71ARYdIl+wB4tAp3nyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36Jym9/DRG08YSSjYllz8Dq86xHiFAbioLqPhL1IHLfwKU3y5
	XA4beIz9RsVYFtKSEfPkqI+2q3kaHmdMjjPkt9Mrx4PSkBJ9CS9DIPR8/PZ/a84tsinivXAyyLo
	zqJ/WvBXwjJzQbmKZUeiVDx0ekr6k7paKr9iY/EqOnbm6m2dWsMOOUE88B5eDYpQ=
X-Gm-Gg: ASbGncv3pnONO3U55IAxq2bepFslT81QwiOoLKu6aJ6+f8UtZW2siguuqhNqW4WJ3ni
	dTs60nGghqm3IteGYE9mWtkIVVcX1OlhC31jG7zEMOJNClWZxCvpRzjQCSfoDubztTId7z7XVFI
	UeiFokBk//PS3/pjnqRCgQSDLlM+rN0D2QWYgRpUOAOKUdcX5/bZBkpsSILqqF/P4VRWNzJhF5L
	sc3jlBD31SKlN9upMaSq66mw1syUCe/XLR7uN33jsXCsCf4SMrqsFewdR25U4vlylCr0J0f6uwW
	IPvMm7YRMXxL7jbYbFbMqycR+okwkFGjx40ngMxzUr18sUKm0UxORZFa7P7hQkcYGPVbT1GHpN6
	8gQ==
X-Received: by 2002:a05:6a20:a121:b0:247:b1d9:774 with SMTP id adf61e73a8af0-2e7be066ae2mr26632106637.5.1759231549041;
        Tue, 30 Sep 2025 04:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwkhgfyGvhj+bA5hFJW75FNK7qSzTO6ggvNH3y8HKIDf7EE+2tkPsEFmTQBxSe5dDAeV7kNw==
X-Received: by 2002:a05:6a20:a121:b0:247:b1d9:774 with SMTP id adf61e73a8af0-2e7be066ae2mr26632063637.5.1759231548547;
        Tue, 30 Sep 2025 04:25:48 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55741dbsm13545086a12.31.2025.09.30.04.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:25:48 -0700 (PDT)
Message-ID: <f162fe7e-3615-3514-0fd8-a3b76fe9d44e@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 16:55:42 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 5/6] can: mcp251xfd: add gpio functionality
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
        anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>
References: <20250926133018.3071446-1-viken.dadhaniya@oss.qualcomm.com>
 <20250926133018.3071446-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Md2pW1YBNk1PLV+A6rHET4WbHDQf9P_Y4FeoVAgVsxUEA@mail.gmail.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <CAMRc=Md2pW1YBNk1PLV+A6rHET4WbHDQf9P_Y4FeoVAgVsxUEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX8rvdbs0jGU1b
 E4YimRO3+YHCNSjm/IjJ9zFPd9Iorw8/cPf04cs0iSajvyP72ttTb0IPCo5w7mKctc+4AdlZypn
 WGbyOAVSLrlcKKjKGriYe6KrMGs/JVkqYtl1iA5tvI4mlMj5X+jWVcxNhpS/lBXSDPE1w6JGax2
 njNt7UWqdI3VpZWBAt3vTe/sdvYX1BhuXBcXer2JC/6G2LOzTqvdiA0XCTyEtio+rYTiL66OXd3
 ueEu+EXmFUPridb7euCfJ8hiB1U8CsBvKa4bgDm3KM97yrttCOkhs2JdyY6gnz5aXZknVeuAUkw
 P56q5+auw2A0s/2hTDhFQfzwfEpY4jHf5cmMbuv+//41i11PYe5QNdqfJ2+8HnTU1KA8jv1PluH
 LocVZyhwlWwqchUFp8MShQrEgKOTqg==
X-Proofpoint-ORIG-GUID: UNn8bF0-Cqi6Hq2udlHkvqsbSIeA68Kw
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68dbbe3e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8f9FM25-AAAA:8
 a=KKAkSRfTAAAA:8 a=oC8yqeNgLv2HgbuJSHoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=uSNRK0Bqq4PXrUp6LDpb:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UNn8bF0-Cqi6Hq2udlHkvqsbSIeA68Kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082



On 9/29/2025 7:08 PM, Bartosz Golaszewski wrote:
> On Fri, Sep 26, 2025 at 3:30 PM Viken Dadhaniya
> <viken.dadhaniya@oss.qualcomm.com> wrote:
>>
>> From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
>>
>> The mcp251xfd devices allow two pins to be configured as gpio. Add this
>> functionality to driver.
>>
>> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
>> Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
>>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 172 ++++++++++++++++++
>>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   2 +
>>  3 files changed, 175 insertions(+)
>>
>> diff --git a/drivers/net/can/spi/mcp251xfd/Kconfig b/drivers/net/can/spi/mcp251xfd/Kconfig
>> index 877e4356010d..7c29846e6051 100644
>> --- a/drivers/net/can/spi/mcp251xfd/Kconfig
>> +++ b/drivers/net/can/spi/mcp251xfd/Kconfig
>> @@ -5,6 +5,7 @@ config CAN_MCP251XFD
>>         select CAN_RX_OFFLOAD
>>         select REGMAP
>>         select WANT_DEV_COREDUMP
>> +       select GPIOLIB
>>         help
>>           Driver for the Microchip MCP251XFD SPI FD-CAN controller
>>           family.
>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> index ea41f04ae1a6..88035d4404b5 100644
>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>> @@ -1797,6 +1797,172 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
>>         return 0;
>>  }
>>
>> +static const char * const mcp251xfd_gpio_names[] = { "GPIO0", "GPIO1" };
>> +
>> +static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
>> +       int ret;
>> +
>> +       if (priv->rx_int && offset == 1) {
>> +               netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = pm_runtime_resume_and_get(priv->ndev->dev.parent);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
>> +                                 pin_mask, pin_mask);
>> +}
>> +
>> +static void mcp251xfd_gpio_free(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +
>> +       pm_runtime_put(priv->ndev->dev.parent);
>> +}
>> +
>> +static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
>> +                                       unsigned int offset)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 mask = MCP251XFD_REG_IOCON_TRIS(offset);
>> +       u32 val;
>> +       int ret;
>> +
>> +       ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (mask & val)
>> +               return GPIO_LINE_DIRECTION_IN;
>> +
>> +       return GPIO_LINE_DIRECTION_OUT;
>> +}
>> +
>> +static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 mask = MCP251XFD_REG_IOCON_GPIO(offset);
>> +       u32 val;
>> +       int ret;
>> +
>> +       ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return !!(mask & val);
>> +}
>> +
>> +static int mcp251xfd_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
>> +                                      unsigned long *bit)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 val;
>> +       int ret;
>> +
>> +       ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       *bit = FIELD_GET(MCP251XFD_REG_IOCON_GPIO_MASK, val) & *mask;
>> +
>> +       return 0;
>> +}
>> +
>> +static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
>> +                                          unsigned int offset, int value)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
>> +       u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
>> +       u32 val;
>> +
>> +       if (value)
>> +               val = val_mask;
>> +       else
>> +               val = 0;
>> +
>> +       return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
>> +                                 dir_mask | val_mask, val);
>> +}
>> +
>> +static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
>> +                                         unsigned int offset)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
>> +
>> +       return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
>> +                                 dir_mask, dir_mask);
>> +}
>> +
>> +static int mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
>> +       u32 val;
>> +       int ret;
>> +
>> +       if (value)
>> +               val = val_mask;
>> +       else
>> +               val = 0;
>> +
>> +       ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, val_mask, val);
>> +       if (ret)
>> +               dev_err(&priv->spi->dev, "Failed to set GPIO %u: %d\n", offset, ret);
> 
> Why do you loudly complain here but not in other callbacks? I assume
> it's because you had a log here in your previous version (the one
> rebased on v6.16) and just didn't remove it when you switched to the
> new API? Maybe just do `return regmap_update...`?

Sure, I’ll update and post v6.

> 
> Otherwise looks good. With that addressed:
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
>> +
>> +       return ret;
>> +}
>> +
>> +static int mcp251xfd_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
>> +                                      unsigned long *bits)
>> +{
>> +       struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
>> +       u32 val;
>> +       int ret;
>> +
>> +       val = FIELD_PREP(MCP251XFD_REG_IOCON_LAT_MASK, *bits);
>> +
>> +       ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
>> +                                MCP251XFD_REG_IOCON_LAT_MASK, val);
>> +       if (ret)
>> +               dev_err(&priv->spi->dev, "Failed to set GPIOs %d\n", ret);
>> +
>> +       return ret;
>> +}
>> +
>> +static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
>> +{
>> +       struct gpio_chip *gc = &priv->gc;
>> +
>> +       if (!device_property_present(&priv->spi->dev, "gpio-controller"))
>> +               return 0;
>> +
>> +       gc->label = dev_name(&priv->spi->dev);
>> +       gc->parent = &priv->spi->dev;
>> +       gc->owner = THIS_MODULE;
>> +       gc->request = mcp251xfd_gpio_request;
>> +       gc->free = mcp251xfd_gpio_free;
>> +       gc->get_direction = mcp251xfd_gpio_get_direction;
>> +       gc->direction_output = mcp251xfd_gpio_direction_output;
>> +       gc->direction_input = mcp251xfd_gpio_direction_input;
>> +       gc->get = mcp251xfd_gpio_get;
>> +       gc->get_multiple = mcp251xfd_gpio_get_multiple;
>> +       gc->set = mcp251xfd_gpio_set;
>> +       gc->set_multiple = mcp251xfd_gpio_set_multiple;
>> +       gc->base = -1;
>> +       gc->can_sleep = true;
>> +       gc->ngpio = ARRAY_SIZE(mcp251xfd_gpio_names);
>> +       gc->names = mcp251xfd_gpio_names;
>> +
>> +       return devm_gpiochip_add_data(&priv->spi->dev, gc, priv);
>> +}
>> +
>>  static int
>>  mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
>>                               u32 *effective_speed_hz_slow,
>> @@ -1930,6 +2096,12 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
>>
>>         mcp251xfd_ethtool_init(priv);
>>
>> +       err = mcp251fdx_gpio_setup(priv);
>> +       if (err) {
>> +               dev_err_probe(&priv->spi->dev, err, "Failed to register gpio-controller.\n");
>> +               goto out_runtime_disable;
>> +       }
>> +
>>         err = register_candev(ndev);
>>         if (err)
>>                 goto out_runtime_disable;
>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
>> index bd28510a6583..085d7101e595 100644
>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
>> @@ -15,6 +15,7 @@
>>  #include <linux/can/dev.h>
>>  #include <linux/can/rx-offload.h>
>>  #include <linux/gpio/consumer.h>
>> +#include <linux/gpio/driver.h>
>>  #include <linux/kernel.h>
>>  #include <linux/netdevice.h>
>>  #include <linux/regmap.h>
>> @@ -676,6 +677,7 @@ struct mcp251xfd_priv {
>>
>>         struct mcp251xfd_devtype_data devtype_data;
>>         struct can_berr_counter bec;
>> +       struct gpio_chip gc;
>>  };
>>
>>  #define MCP251XFD_IS(_model) \
>> --
>> 2.34.1
>>

