Return-Path: <linux-can+bounces-4814-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0702CB915BB
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47051886616
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C27111A8;
	Mon, 22 Sep 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8QyDB+O"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791B1DBB3A
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546959; cv=none; b=X4ZXEPP2mXBNE6hrHbgyksgMycyfw0O2K3YB492DVkCHeF1+R6wO9MmIWr7HM5Hj4k8q+B9kWZBTpZE8SKYrj8dA5cPjMeZrtYaks1psR+JwA7UVE8USnomOLQmXN2W8l6u8uaHTNExlU2LThQ2hQC8lmScA3btdu8jYUOCFst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546959; c=relaxed/simple;
	bh=H3IP16ww0WDCJ+jXWGBbAdfLN4zv66+LQvFJvHx81q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2jZwyhSphiEAomW8cAMagTRs34J1GsovljEonhBTcNvBKdhU947xLfyy+8Y9lL7VTtE+nSakg9/v2zHW5AkATAOqLbgJep1AFlEB3pLckUC+hjjnN+gTv0qa00MlU9uNXese4er4dttHlGsbtjl+9PhXLFxIi/arQQTeUqFNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8QyDB+O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7pqrm007069
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 13:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6qUiWWx4TK1U0L43SvL0E376P5VuAjOTkFKo8rMJQnM=; b=f8QyDB+OyBdt5TbW
	qumxL4YZgxV+3ACms7uE5A/WK/LdbdGnJWYY/Z+Ny+lfbAbz32kKrnkqO+M7W62j
	12MDyGp1VNZhZ5XTok8ugiimGNvd7fznuv+DzbZw9FTzB1Loq8Jfr84FGIgE2TZF
	2VCpTFW+8/l1SkH1pdqJ3NrJpohNNXHG5U0pOmjNQrUSgMWWXLfdccwhy7U2P3Im
	I9ih6FJ07YCxFcVQdGBspLpWOAj9J0AEGmd0KjZep3Nu3/Tgtl3fG3JcBhtru7ZZ
	ovzFR55mykbF+gi4lZq93yGG5KIDtDXz//Sdl1AYFWYVJI3B9DXEgrp3josV2Biv
	1tsx/g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b2e110a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 13:15:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b551ca103d8so2126346a12.1
        for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 06:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546955; x=1759151755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qUiWWx4TK1U0L43SvL0E376P5VuAjOTkFKo8rMJQnM=;
        b=HEk4AUZtOxgudDB56hm1SmyZZu1tfwJfLAplm5tYa93xlLVF0DDeywqQ4logajnXs3
         RLwnbqVU8ZoKov0YRKXmHZ5LYzAYz0Hp86IHtiRRFilAiNFJ6dZSnfQ66Yv4mKn10q7T
         Z5LLN8zEbgK99jqiETffqM9Rkh+HXK9zTKjVOQN2B37YuLna63b0Fp8heXYDGEDf4y2I
         AQAaAT7fHDFyhVa6WPaOEPTCT4Igup97D7t2dM/8ZhQLHPzMiUotdsQAMJzV5HyHwHY4
         4DHnLR44TMymSAdzJyuFJOoxvLP3LV+cluFz+tKm3/Ch610cYSVzqZVjEdS+tC84kjts
         E1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXaFtFy8D91VJlSemuyJEp238Ese0s3B5F1D3U4J5XGiYOC3LyZ8Ygy00G/1Z1dIy7FqwW+ftaQqMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6h3Jk6p4v9hcMA5EZ1oC1usvRlbKe9oe3KW0UdaSZYDlDCzFT
	hBymaIOLOvI0+hLqoZnfmvhwWPlZMUYDyRgnGKV4csrJt+3ivBZVS55aK45uBbtSnj0hLwk2mwO
	ETNYBZT4RhrpN//sL+8qn0ngk5FyjzPhFEQ258xpVZxa/xEhrXZkISIMkZf6FU7M=
X-Gm-Gg: ASbGncvvxc6g1l11xUYA2IYJarU5eS2ZGlaFxnAQMqDWvwyH8x9fg2K3FRzwq71V/IL
	zPnafscsAmWFm2ByjTD/TmOKli8rllsby4unAd3953z6iTSf9VfmIvGyCOR78cZWxKo30fPo2MF
	VBlgBAcDFPWKuEekpSmXPGwNWlN23NeI01L5p6KWkXiTTXB5mtLsw1zPnrZq32QATspOe4XdA+K
	CENJYk3xO2W5TAdmQHjfj/s+ae9NElSlrU1zQoMQZbGbpMhUmb0ggYs0YzTVvHcGVelHbn7lUlH
	IQwbZcQRNh70ee2J2n7MDeTepUmhL3TvkXDGR/zWV0ER693ie9OiETk0cMOCvdyrU/WFB7YAIfM
	=
X-Received: by 2002:a17:902:e88f:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-26ee6ab6903mr135902385ad.5.1758546954590;
        Mon, 22 Sep 2025 06:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8FceqNmu1Keq5p5ZZARdjJs04BUAGVHKikSD6fdT+RdHvPij1E8fPv9RnSnlMfQIj4YbyZg==
X-Received: by 2002:a17:902:e88f:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-26ee6ab6903mr135901545ad.5.1758546953855;
        Mon, 22 Sep 2025 06:15:53 -0700 (PDT)
Received: from [192.168.0.102] ([49.205.248.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5531d90d1asm6729316a12.18.2025.09.22.06.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:15:53 -0700 (PDT)
Message-ID: <fa832a39-268f-2347-df01-e6d8c06547e9@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:45:47 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org,
        thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
 <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA3NiBTYWx0ZWRfX7GpDtJkNSLoU
 /legojZ2Zkj1ZGa6nApnaXORT95YMmR9AFciRiB0RgnxBsfPBDjHwPq/j9J30rv9zFYROIQueNk
 FSRb2G3buXNiKP4QvJRGCzYXZC83+N7yWTLMPYl7sTHWzpTO9tFMnTWUKoHXEmj7gRe3gnUGdlw
 FGCUNp2IPJNJa0iVBOUqhJEOFwBjSLeAxfhGmkkZk6DVHSUve3MC3ZSvEDslCXk9Gu+TIh3N0ng
 hmLx2mtmF1+ZuANKaVCTMHnMiQwB+SkvJm8kM1htbqkbZHrhkpktSKAfR2Ao8ObIASQxsdtwXpA
 UVKOVwVCz5rauP3s0RGt1TEB8wYtFnZo9KMF3yNsh9Y/QGP/6FPPbEpcOY6Ll7xYf/Gmk0zzh+I
 qlJ7XL9H
X-Proofpoint-ORIG-GUID: h1vt-G98oQYAuOPn10KCiG3Tbx85Pfts
X-Authority-Analysis: v=2.4 cv=HM7DFptv c=1 sm=1 tr=0 ts=68d14c0b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=t7+/ES3qvP6ClPp5AF2fig==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=DlECaWPWOyncsgY1a_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: h1vt-G98oQYAuOPn10KCiG3Tbx85Pfts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220076



On 9/18/2025 4:28 PM, Marc Kleine-Budde wrote:
> On 18.09.2025 05:46:44, Bartosz Golaszewski wrote:
>>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> index ea41f04ae1a6..8c253091f498 100644
>>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/bitfield.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/device.h>
>>> +#include <linux/gpio/driver.h>
>>>  #include <linux/mod_devicetable.h>
>>>  #include <linux/module.h>
>>>  #include <linux/pm_runtime.h>
>>> @@ -1797,6 +1798,178 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
>>>  	return 0;
>>>  }
>>>
>>> +#ifdef CONFIG_GPIOLIB
>>
>> Any reason why you don't just depend on GPIOLIB in Kconfig? There's no
>> reason to make it optional if the device always has the GPIO pins.
> 
> I don't mind having the ifdef. But it's up to you.
> 
> [...]

Sure, I’ll add depends on GPIOLIB in the Kconfig and remove the #ifdef CONFIG_GPIOLIB
from the driver in the next patch.

> 
>>> +static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>> +			       int value)
>>
>> You must be rebased on pre v6.17 code, this will not compile with current
>> mainline.
> 
> You mean "post" v6.17? Best rebase to latest net-next/main, which
> already contains the new signatures for the GPIO callbacks.
> 
> regards,
> Marc
> 

Sure, I will update in next patch.

Thanks
Viken

