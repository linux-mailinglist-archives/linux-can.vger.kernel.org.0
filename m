Return-Path: <linux-can+bounces-4083-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2519B10145
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454207A2651
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA381F582F;
	Thu, 24 Jul 2025 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cymAFjAr"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB51F2382
	for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340740; cv=none; b=gyull0trxW4aLwbc8vTm3x6vO81SfA5c1HtvEKOVxSG4ZHg39j8RGt5FP3QGRtINUKoL3hodeQeS5X6RfF+kPjYbffjQGgbPTdiKs1q1MFhGIM6f8NhTgfCa1PXFPdErgmKei6njK7FmmvM285IC8OEZgPjij0pcRLsgW9grjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340740; c=relaxed/simple;
	bh=ZzvSi2Gge1jvflOuTSfZXRlKqMjMIfLpv73L93t3YCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ce02GlGbJMoNnizuJXuYn0sn0AywNRyyY2OAIWArdWNAvNgmCnDBSP5LvDzS8rrp8evr+9q9pAzISLRR/L7eys2fKFNl8qo2HgP8JI+TlNkbtYBbyRpK68Jx2YdVe+kWTlyBBBiK6genivdsSObNsGEvTLRTscBgaiiNnV0/7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cymAFjAr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso1345089a12.2
        for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753340737; x=1753945537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JFKHDvcV8VJDq/6jbBHfdflS6hCwAv4+zLNgcwrv+4=;
        b=cymAFjArxJYmtOdEkou0Kkcs4E16YTy9zw/k8CsaAu9ndjbI+hsaCB37Hs3qqvBgCX
         /YlHBhJVRkH7Qxv+fCLyOZ6HfQFYBKSOWM5P/mxwXZGtv/zx54BrXodVuhAATxo/KT0x
         vzsjLJZoQYWZLthSoOkiFpwXq5blJEa3ftcKjG89C09pYpdFvE7lBb2lMqYscpdSbb02
         B1JIMeWRYz0atTfrQrm1Dp+N5XM0FonDYhyaytotYSe1ubjMiu16lPpcizaUj9Y6Bp1s
         aZ9cL/KnWMcMCFo6db+czPnLLsgGB1Dnp9BHtNfmUf70061KIzUyg0dtFzHhj5sRgcCd
         VFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753340737; x=1753945537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JFKHDvcV8VJDq/6jbBHfdflS6hCwAv4+zLNgcwrv+4=;
        b=BfocAFLBdRouY23VO0OlcIIHSvz6Rj1IDdg29xTiarIJVhFn8himeOqFuotmneTzpx
         4lUFwsROQRp9ntP+D4xgVQ5mJ6TUBS5xzapZK3bXmSFvtkiKiFof7Y8arir8qFLvsPs2
         1DXSs9WxhINO6+nTPpZleemofF03XXDbVZ83Livj3BPTZZo01eNCpf5F47AdpgaTjDvW
         Pgp4+hVVmLa5gJNJLK0Y6DoD8jMob8uG4+DMG56y4JcgHd+0ME3AREx1uPOZf1GGuWBp
         qdQf23ezUIQgSQZRT0+xnr10+a+JdjkzLyBC0PasooGNemPKYsEa6NV899oRLYf1x0QR
         lj4w==
X-Forwarded-Encrypted: i=1; AJvYcCXvMFqZQPuRpwYZmsSDp4PyHY7awU57W/coVI7QqwYhTrn3Voz4Itl6faswBwa+PrPoNE++MbXzWeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPK4JXXzLT686B14nQU/5LGAXztmvTObJALWfwVh0ElfhvaECQ
	8NS3IcMdqskbGJGQN8xHtyQ6mb3g7pfWszMIi0X9zYAARiPhSNRz4Y3M
X-Gm-Gg: ASbGncs5R+hz/61aT9dE99IE+uSOWxC1b61N+5LCR2YzSWm8tfSpYDPgRpSS7Y+YmXE
	xqTGEGFHRWUU/wvbNPbjQ45DfMHH42ZlkHkqAUPrqY07u1sRqoC5eOtfjTrAwshSyRPeAKI7aV1
	yn1kDdYs8F7q8k/8q8HeBDUWSDRmC9IlQI6vtymrYQ6ApFD2O+G5Jl/uRxuldjNx5yy0a7UgdSe
	DfY0a9K9DvhI/E5aw4ccQ3FrWVIhCUrB59q7gKgrCLQWVStlBvClJrmMmac/EubW3LglFgIdT4K
	LJsNXNObC82752+SgA3/w+NzZB2fzQBENWobZYxLol0NuMDhZiadXexuiu6P281+kbRyDwl1oY1
	i5/T3+k7P6USEWezUNh49wCmb0Eo/R12n1iEFuQydhJU58RgQKPJ8fX7XS/665K2EjWXs6OrT74
	Q9
X-Google-Smtp-Source: AGHT+IGJ3qurmuWgsebwHcFEdvdGx7BT88WnVS8XbVwK99X73wuY6IHnCgfRJK597qe+1VolbESx8w==
X-Received: by 2002:a05:6402:35c7:b0:612:c2a3:6b5e with SMTP id 4fb4d7f45d1cf-6149b590a8fmr5087444a12.20.1753340736837;
        Thu, 24 Jul 2025 00:05:36 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-614cd2fc1ecsm478524a12.43.2025.07.24.00.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 00:05:36 -0700 (PDT)
Message-ID: <a5a32ee9-3bfd-4f47-8438-8748957b0eef@gmail.com>
Date: Thu, 24 Jul 2025 09:05:35 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] can: kvaser_pciefd: Store device channel index
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-6-extja@kvaser.com>
 <64db0624-d267-4ec5-ba2e-fdff0023fb21@wanadoo.fr>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <64db0624-d267-4ec5-ba2e-fdff0023fb21@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 2:27 PM, Vincent Mailhol wrote:
> On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
>> Store device channel index in netdev.dev_id.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   drivers/net/can/kvaser_pciefd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
>> index eba19819ca43..7feece6d1d41 100644
>> --- a/drivers/net/can/kvaser_pciefd.c
>> +++ b/drivers/net/can/kvaser_pciefd.c
>> @@ -1030,6 +1030,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>>   		can->completed_tx_bytes = 0;
>>   		can->bec.txerr = 0;
>>   		can->bec.rxerr = 0;
>> +		can->can.dev->dev_id = i;
> 
> Isn't dev_port a better fit here?
> 
> See the description here:
> 
>    https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-net
> 
>    What:		/sys/class/net/<iface>/dev_id
>    Date:		April 2008
>    KernelVersion:	2.6.26
>    Contact:	netdev@vger.kernel.org
>    Description:
>    		Indicates the device unique identifier. Format is an hexadecimal
>    		value. This is used to disambiguate interfaces which might be
>    		stacked (e.g: VLAN interfaces) but still have the same MAC
>    		address as their parent device.
> 
>    What:		/sys/class/net/<iface>/dev_port
>    Date:		February 2014
>    KernelVersion:	3.15
>    Contact:	netdev@vger.kernel.org
>    Description:
>    		Indicates the port number of this network device, formatted
>    		as a decimal value. Some NICs have multiple independent ports
>    		on the same PCI bus, device and function. This attribute allows
>    		userspace to distinguish the respective interfaces.
> 
>    		Note: some device drivers started to use 'dev_id' for this
>    		purpose since long before 3.15 and have not adopted the new
>    		attribute ever since. To query the port number, some tools look
>    		exclusively at 'dev_port', while others only consult 'dev_id'.
>    		If a network device has multiple client adapter ports as
>    		described in the previous paragraph and does not set this
>    		attribute to its port number, it's a kernel bug.
> 

Yes, dev_port is what we want. I looked at kvaser_usb, where dev_id is used.

> Also, not populating dev_port is a kernel bug, meaning that you should probably
> add a fix tag.

Looks like there are more SocketCAN drivers using dev_id instead of dev_port:
   $ grep -r 'dev_id ='
   rockchip/rockchip_canfd-core.c:	dev_id = rkcanfd_read(priv, RKCANFD_REG_RTL_VERSION);
   peak_canfd/peak_canfd.c:	ndev->dev_id = index;
   softing/softing_main.c:		netdev->dev_id = j;
   usb/gs_usb.c:	netdev->dev_id = channel;
   usb/peak_usb/pcan_usb_core.c:	netdev->dev_id = ctrl_idx;
   usb/esd_usb.c:	netdev->dev_id = index;
   usb/kvaser_usb/kvaser_usb_core.c:	netdev->dev_id = channel;
   sja1000/f81601.c:		dev->dev_id = i;
   sja1000/ems_pcmcia.c:		dev->dev_id = i;
   sja1000/kvaser_pci.c:	dev->dev_id = channel;
   sja1000/plx_pci.c:			dev->dev_id = i;
   sja1000/peak_pcmcia.c:		netdev->dev_id = i;
   sja1000/sja1000_isa.c:	dev->dev_id = idx;
   sja1000/peak_pci.c:		dev->dev_id = i;
   sja1000/ems_pci.c:			dev->dev_id = i;
   spi/mcp251xfd/mcp251xfd-core.c:	*dev_id = get_unaligned_le32(buf_rx->data);

I'll also assign dev_port in kvaser_usb, but keep the assignment of dev_id
to avoid potential regressions.

Or do you got other suggestions?

Best regards,
jimmy

> 
>>   		init_completion(&can->start_comp);
>>   		init_completion(&can->flush_comp);
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


