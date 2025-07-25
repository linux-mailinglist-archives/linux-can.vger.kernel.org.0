Return-Path: <linux-can+bounces-4150-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321F9B11F8F
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B93C17F95C
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1E18A6CF;
	Fri, 25 Jul 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0jEMv/9"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0D145355;
	Fri, 25 Jul 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451446; cv=none; b=nv6cCTClj6aMJfJhJctnviX0QDR4s7YjhGPPRuxEVlyzfr8b6ykeEey2HnYBBqiNTEJpJ4SyHRZm6MTDYjpb8au1XNnUPfDLaVxPrOSUJdFV4pQdRyRyWjkv5E30cP4gKAvlFC0awdAtQRV/7Esi6sS2gVLhNroJPq3vurACnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451446; c=relaxed/simple;
	bh=FAPCZ6K0FBV4BSkEjyD8Ux6aerP1JkaHRXR23d1LZ4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvUo+3ta4DKV3BFQaplt4SR7RhuG+kFyXzdazJXm6EEp2eF3AeB+xYzR/5OzsbKr11XQX2KULLbpSWYQnrWJiW1b1uq8EBXw42lexa+PfU/g+OoVhQ+WJOv+HoEDWTAwA23pvdD2dGs01aiHT0la9AwVWp7xHxDjM2HFWxQeX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0jEMv/9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55a4e55d3a9so2393769e87.1;
        Fri, 25 Jul 2025 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753451443; x=1754056243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8AZ8dw4wlMt8tvkWDmYjh+r6b67fQnAZ8m3R9J0K5M=;
        b=R0jEMv/9MCLJ7NsFEoJ25QwJHg2BB5Z5a7Ami2QbU2ydRKfc+LWQVOP0Zdh2LqWoEG
         05qnoFQQxc3cLTlEP0vHylbKn5onD4qmEnvkJYEnu7Npra56AnznrXrSriQ03TXqTFty
         zMnWga06gaIf7Cu/l5ATzg2BdPuZ8QPLa+f3u8u1eZ91Afo5/bM7k3QJIMmsU6cb3F0y
         Shpht1fLfvivabXWP2F4Wtyd3YL9gIWbmaxNXPFcrIijVU1w5bEX4VFKdcvRAZOaLfHZ
         RmzsDKR2r9eNmpQeJO3fIsAS5EwKv61cvcaqVc0a9KGF7mJ7hc19ndFjYPe8MHH/hvSv
         +kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451443; x=1754056243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8AZ8dw4wlMt8tvkWDmYjh+r6b67fQnAZ8m3R9J0K5M=;
        b=tD8D2CDcIjGFIiowzS31d8Q+SMLdHq7BuXxQ5akKnF6mRHcNCV1VFZfJOjZXjQLoI7
         kqC5n4wCOBQZylOsNZ0Ie0bus95WvSNo3wKfQNrTNzCqGMOoO6E+GAZrLA/CbNQhCdI/
         xzEQNhgspXIkioEXI6wyW9B3yX351PmeFax91mhGQTvfJmSqWQMZ89jdO8mng4mPeIPJ
         5AJo5LLP1JMeU/gP9zb6EoasyLUlsBjy/cewy5nXr7CBK8DC0eybpqTHJl2CpRjbDehw
         6FFRKkPrbmNMaC2Lrn1G7VoWbI7VuHh8NmB89QXs7mmmTcVx8yrw6ziHHYk5/CgxOQVK
         WEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtq1ycZDIEi+dZ754eI6e1tSBpBNpEQhGIBjMsc+IoMDsNRN8wyl9r+aZJSWk1kG6FG1N1/o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6z7ooujvBlCx1SoxC8Pb6O/pMjJ0ZIT9lHiRV8XEFK/pZZkL
	sndVa0Yn6XNkAvsUnd7mvGtI6JhLVdxgHOqtm5b/eJ+0yR0Oprf8J2pQ
X-Gm-Gg: ASbGnct9f+ztmYMIPz5Ngqh9xrcflmz0ZznLVGINLX/+gvGuTmaRcojT6DqTyiwToTC
	ZU/zvK/32THW5kH+wspmqHVpt/cGj44YXvdASm3q4oIqrQR2E5TldJlrGeYWe0/N79NpRosXaCW
	cBoBYyt6c0Dz7JOcw30VreSKRYOYRMRfh4JNH2KatmAVfcHDGcbFVcxJp4vliHmM1dOJKZLsE4b
	9qm6H9SWW4ddo8m3TvTkQCHEC4XhuKK4m7ju7slOpJJSeDHFhkxV4SfadO7R9m0yqTjXEOQObbu
	oJlmbnnGs5ncoeLxHrNDlQPnkQdQyx2SKSINTP5s2UEr2veDIerH1B5ThCskp23VONUvoqmEv+p
	7hhdQqMI9Ji2Yusn+vkbFt7KIBTLJFPgcLSPK//mYfOUhM0MVG+pWcOmNN+bTvhPxEouTh7Wxbq
	5h
X-Google-Smtp-Source: AGHT+IEpeOEfwHq491tawCARQrnliwqCVR0pf+lT8L5QZRcVzG0fLoe6k9h43TGvdHOLnJos7LNYbA==
X-Received: by 2002:a05:6512:e89:b0:553:2c01:ff44 with SMTP id 2adb3069b0e04-55b5f3d2fb4mr447430e87.2.1753451442676;
        Fri, 25 Jul 2025 06:50:42 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-55b53b376c4sm952489e87.77.2025.07.25.06.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 06:50:42 -0700 (PDT)
Message-ID: <6cbe9e11-a9b7-48f2-8b13-068fb9eec290@gmail.com>
Date: Fri, 25 Jul 2025 15:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] can: kvaser_pciefd: Add devlink support
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250725123230.8-1-extja@kvaser.com>
 <20250725123230.8-8-extja@kvaser.com>
 <20250725-ingenious-labradoodle-of-action-d4dfb7-mkl@pengutronix.de>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <20250725-ingenious-labradoodle-of-action-d4dfb7-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 2:47 PM, Marc Kleine-Budde wrote:
> On 25.07.2025 14:32:27, Jimmy Assarsson wrote:
>> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
>> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
>> @@ -1751,14 +1751,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>>   			       const struct pci_device_id *id)
>>   {
>>   	int ret;
>> +	struct devlink *devlink;
>>   	struct device *dev = &pdev->dev;
>>   	struct kvaser_pciefd *pcie;
>>   	const struct kvaser_pciefd_irq_mask *irq_mask;
>>   
>> -	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>> -	if (!pcie)
>> +	devlink = devlink_alloc(&kvaser_pciefd_devlink_ops, sizeof(*pcie), dev);
>> +	if (!devlink)
>>   		return -ENOMEM;
>>   
>> +	pcie = devlink_priv(devlink);
>>   	pci_set_drvdata(pdev, pcie);
>>   	pcie->pci = pdev;
>>   	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
>> @@ -1766,7 +1768,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>>   
>>   	ret = pci_enable_device(pdev);
>>   	if (ret)
>> -		return ret;
>> +		goto err_free_devlink;
>>   
>>   	ret = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
>>   	if (ret)
>> @@ -1830,6 +1832,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>>   	if (ret)
>>   		goto err_free_irq;
>>   
>> +	devlink_register(devlink);
>> +
>>   	return 0;
>>   
>>   err_free_irq:
>> @@ -1853,6 +1857,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>>   err_disable_pci:
>>   	pci_disable_device(pdev);
>>   
>> +err_free_devlink:
>> +	devlink_free(devlink);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -1876,6 +1883,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
>>   	for (i = 0; i < pcie->nr_channels; ++i)
>>   		free_candev(pcie->can[i]->can.dev);
>>   
>> +	devlink_unregister(priv_to_devlink(pcie));
>> +	devlink_free(priv_to_devlink(pcie));
>>   	pci_iounmap(pdev, pcie->reg_base);
>                            ^^^^
> 
> This smells like a use after free. Please call the cleanup function in
> reverse order of allocation functions, i.e. move devlink_free() to the
> end of this function.
> 
>>   	pci_release_regions(pdev);
>>   	pci_disable_device(pdev);
> 
> regards,
> Marc


I agree. Thanks for finding this!
I've tested moving devlink_free() to the end of the function, without any
issues.

If you don't find any other problems, do you mind making this change before sending
the PR? Otherwise I need to wait for the netdev 24h grace period, as Paolo
pointed out [1], before sending v5.

[1] https://lore.kernel.org/linux-can/20250725-furry-precise-jerboa-d9e29d-mkl@pengutronix.de/T/#m174402d37840f225b2799fbc53d7658ccc27be72

Best regards,
jimmy

