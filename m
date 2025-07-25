Return-Path: <linux-can+bounces-4147-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A29B11EED
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBCD588079
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706972EACEA;
	Fri, 25 Jul 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMSukQvK"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB92242922;
	Fri, 25 Jul 2025 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447497; cv=none; b=gLs3BR8OIMfSUXj1z2yfxVNNjVPO3mJSE0hCKeC9Sy7YAMloSBckqa8flWu+VnQyon0qJ8j7hYieynq5+1d/1r1/LaAiYx9QWeKxQX6itPsQxEkKXGd00Ux35jls18NVsI3r0EZUuoZDQIIznA36wZSdXdOTR+MKI55ATIeTTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447497; c=relaxed/simple;
	bh=A98CNkIqw4lEqs0rLsEBdQFNXUmuEvOGGk3A8tgZmzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEa0/QnL9HoeTTD5gTVjnIwvLZ/zRimDwdW/5/EPlzBUoyQntkG2Zmo13PtGmSgDX81rncEybXhEQZNwetLO566ELHixxSawXizoP1LeO+gS+EBUXM7SCVbXcQ2I3Xq/Qzi2hgmzLthyvBNjNBGJxlpSCHQV3G1PueIWt2u4T94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMSukQvK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5561d41fc96so2459068e87.1;
        Fri, 25 Jul 2025 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753447494; x=1754052294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FH4dxVOhBTxDopjkGlhvcDVekSBWAVOR3CJgpSj8TD0=;
        b=XMSukQvKkLZI8bwvVuZ34AgdhUEfNsB4IqiOBCYBMT7o53vFIxZWLJZacvtO4rmYjh
         hrXLuxNQ7dMu/WkoJgAA9o0NlPD0Sa7FZD1ij0I8UulB+c/w5AhKXoWibzlduy7mSxLn
         +/WF/WKEJ80rL8Ov9FLit93qo9azOACXnfVJ0sxcxQiKQV1YrEZh5Btf7HPSCUF3SpFH
         Qe97CGPPGttFcMc9OhvfeWmOUvjj/SxJVzkXRQvLdfLDu356EVMDhDJcJ9JHrWBcNsxo
         GxL1W1CMUruLQwJWTHea3+CboQ3oUgFVdaiZC/NDEdLX3OuBcnonW5x44lv2MrcCep+b
         5aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447494; x=1754052294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FH4dxVOhBTxDopjkGlhvcDVekSBWAVOR3CJgpSj8TD0=;
        b=PnaFKDo7DIHIHz4cqtOVLSFgrvyKadKObvI38KmCuEuIQHZv/EJoyjYMYh+Q7YaGsw
         yLxYEV39nucOY2UnYZs6UrBOvV6++NCvWJ8+W9P6OOhwfduYrUZfKWYzIl+tPwrjm96z
         71WEgtIGXiCWgbaYg+U03Q9J6hVJYKAphB+62QC2VoT50S3BQXOqSotbf/vfHmjLZIk1
         nvn+xXiQ+Vhvz+Va/zXttqWEtj2PFaIb+wyvFDJH6Uuo786VVYT+Pt775wYR5ygN0pkh
         wk2pJi9qKI5509PCtUmrZE39oxKaxggOeTRgesu+xKNOesepYDz/3yuPwXVZYg8LajGc
         zIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0kVECqveedTSukONDTVr/x7nHDa/8CAihwfTcl75/9CpuGEONd3PmJeGoN6wMY6jb185cjhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1PCyfs7yaRS5eM+7O9MvXU2xiV58h82L8BVJG03247RUGktP
	1j3BYeNiY1v57H1dY+2gLPgSc4ztqQ2cSVoeqwqIwWzgrDfqJFtJ/fc8d0G+qEvP
X-Gm-Gg: ASbGncvGRXLnpKXEX/vNEh64jsJ/RBFnWJw4MIHMGNsjX3CbJZHblObsj1y6fI3GVTi
	oZjEvngNk2URx9bdiPrfwuWvv/mKxEEX0h5OIq1eLxe2nmc8WoUz943Ko5FoG0IG2cEEMGSvIw7
	jCTbY8P5cliiYjYr7RYPFCESs9WaP/llwyGSGx9cUqkNReYcjZ3+wFj5ESQS2HJwMRb5/Y7VYHI
	QAq1DpOVBmqGHaN6stDEnOgzxS919DNRHb7xTnLu4VfDJUsN1TiEPQKTPd4hSaWGH7VDzp2mqUF
	ctoyvSlEW9uAmO2kAIKGF74d5wCrWvVc5cbNi2kg5S3yHjg9Y9m1noqxaCKww445lfrqCG28HBe
	UOQPPYxOFKem+tPRUuSrHSeSODZeInFcgM42zc73gbP4x5oQPAhNI4DDVDEMU5sap4j4DAa2wv9
	0AfZDEKtc4SPQ=
X-Google-Smtp-Source: AGHT+IEwDjI4dV8667FlmXhuo0pL2q6t5HgpuvWm/jAKIyyZe1KPs7/llfc0Vg2U6iTJO0QA8NvUSg==
X-Received: by 2002:ac2:4bc7:0:b0:55b:5393:bb47 with SMTP id 2adb3069b0e04-55b5f4d1d68mr615193e87.50.1753447493318;
        Fri, 25 Jul 2025 05:44:53 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-55b53b34e95sm913135e87.56.2025.07.25.05.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:44:52 -0700 (PDT)
Message-ID: <a07d995f-0fdf-4773-8cc4-4db6f72ce398@gmail.com>
Date: Fri, 25 Jul 2025 14:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] can: kvaser_usb: Add support to control CAN LEDs
 on device
To: Simon Horman <horms@kernel.org>, Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org
References: <20250724092505.8-1-extja@kvaser.com>
 <20250724092505.8-2-extja@kvaser.com>
 <20250724182611.GC1266901@horms.kernel.org>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <20250724182611.GC1266901@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 8:26 PM, Simon Horman wrote:
> On Thu, Jul 24, 2025 at 11:24:55AM +0200, Jimmy Assarsson wrote:
>> Add support to turn on/off CAN LEDs on device.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> 
> ...
> 
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> 
> ...
> 
>> +static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
>> +				    enum kvaser_usb_led_state state,
>> +				    u16 duration_ms)
>> +{
>> +	struct kvaser_usb *dev = priv->dev;
>> +	struct kvaser_cmd *cmd;
>> +	int ret;
>> +
>> +	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
>> +	if (!cmd)
>> +		return -ENOMEM;
>> +
>> +	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
>> +	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
>> +	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
>> +
>> +	cmd->led_action_req.duration_ms = cpu_to_le16(duration_ms);
>> +	cmd->led_action_req.action = state |
>> +				     FIELD_PREP(KVASER_USB_HYDRA_LED_IDX_MASK,
>> +						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
>> +						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
>> +
>> +	ret = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> 
> When building this file with GCC 15.1.0 with KCFLAGS=-Warray-bounds
> I see the following:
> 
>    In file included from ./include/linux/byteorder/little_endian.h:5,
>                     from ./arch/x86/include/uapi/asm/byteorder.h:5,
>                     from ./include/linux/bitfield.h:12,
>                     from drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:15:
>    In function 'kvaser_usb_hydra_cmd_size',
>        inlined from 'kvaser_usb_hydra_set_led' at drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:1993:38:
>    drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:532:65: warning: array subscript 'struct kvaser_cmd_ext[0]' is partly outside array bounds of 'unsigned char[32]' [-Warray-bounds=]
>      532 |                 ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
>    ./include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:532:23: note: in expansion of macro 'le16_to_cpu'
>      532 |                 ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
>          |                       ^~~~~~~~~~~
>    In file included from ./include/linux/fs.h:46,
>                     from ./include/linux/compat.h:17,
>                     from ./arch/x86/include/asm/ia32.h:7,
>                     from ./arch/x86/include/asm/elf.h:10,
>                     from ./include/linux/elf.h:6,
>                     from ./include/linux/module.h:19,
>                     from ./include/linux/device/driver.h:21,
>                     from ./include/linux/device.h:32,
>                     from drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:17:
>    In function 'kmalloc_noprof',
>        inlined from 'kzalloc_noprof' at ./include/linux/slab.h:1039:9,
>        inlined from 'kvaser_usb_hydra_set_led' at drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:1979:8:
>    ./include/linux/slab.h:905:24: note: object of size 32 allocated by '__kmalloc_cache_noprof'
>      905 |                 return __kmalloc_cache_noprof(
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~
>      906 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>          |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      907 |                                 flags, size);
>          |                                 ~~~~~~~~~~~~
> 
> 	if (cmd->header.cmd_no == CMD_EXTENDED)
> 		ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
> 
> GCC seems to know that:
> * cmd was allocated sizeof(*cmd) = 32 bytes
> * struct kvaser_cmd_ext is larger than this (96 bytes)
> 
> And it thinks that cmd->header.cmd_no might be CMD_EXTENDED.
> This is not true, becuae .cmd_no is set to CMD_LED_ACTION_REQ
> earlier in kvaser_usb_hydra_set_led. But still, GCC produces
> a big fat warning.
> 
> On the one hand we might say this is a shortcoming in GCC,
> a position I agree with. But on the other hand, we might follow
> the pattern used elsewhere in this file for similar functions,
> which seems to make GCC happy, I guess, and it is strictly a guess,
> because less context is needed for it to analyse things correctly.

Thanks for finding this!

Marc Kleine-Budde actually sorted this out for other commands some years ago [1],
but I had completely forgotten.

[1] https://lore.kernel.org/all/20221219110104.1073881-1-mkl@pengutronix.de

...


