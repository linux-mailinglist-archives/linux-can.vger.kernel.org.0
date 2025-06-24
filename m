Return-Path: <linux-can+bounces-3891-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A23CAE72C7
	for <lists+linux-can@lfdr.de>; Wed, 25 Jun 2025 01:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9785316FA21
	for <lists+linux-can@lfdr.de>; Tue, 24 Jun 2025 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEFF248880;
	Tue, 24 Jun 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="acS0ZZnb"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A6182BC;
	Tue, 24 Jun 2025 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806199; cv=none; b=ZMd4QkQYF4CCVsCPcmP5ysfhBhuMRZrZImP9PNNbA0YGqS+fCzfc+20tpjiehfRh5DRVPeqEnl7Lz9/w+Zg0/dDQlOsCbT2ClBZXZR+GRhJv8GzJVxYXRhwMWIKUeyBbXvviGZlaZacAs7gH9DnPAWklTNO8iT0hD1ZHy+dS8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806199; c=relaxed/simple;
	bh=u7fnXWU89mXl6VCDkxomu9p8oT+OclQJ+R/dMItSh6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG4sSxEGQeh0UVVAFXGkoMb6PJjRZOn6xOsGyOJHOTl/PepTb252Cg6FfXXM3wwKyjUiBdeKWYhc77dn2WtW0Qw2Mmz9hpje1LKKYKld5cociFsMaKKw/AgT9EXtFWQoh3yMP8e6oeE0yXoItGZY/sIPBdqEOXRlOEQMVdrO/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=acS0ZZnb; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id UCfWuoG3yBqt7UCfXuDeCI; Wed, 25 Jun 2025 01:03:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750806195;
	bh=Ko4NqvLV82FQuAdMQ/DGTdBZhXnjKp6bqjobRG5+Hg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=acS0ZZnbX6Wd7BLQYemVnA/HARH86s8RLzUUnFp8X4LukZcnWlz9xgemHBDbmVSvc
	 hXixB/domeqZqtHiPcIKhhFK+ODVkS7qPvE3h9JW8RHNX03vUAR83dSAM80OCQf0+D
	 v7sp/RsX0bdZh1m8k+UmG5Z6GZqli3wlZZc+ixx/5Y5gWVP2a6mUgjMvr4N+AY2C/T
	 9rFmuj0vgkcPi8coKS0XrCn1dbTY4+n8HGPtTxXSRwWyFdFSyv+joBZyDdq5Na7h/q
	 goArL4x/MLgs+wXzAAh39Uc4rcagi9ou0X3Mfe2MvsbbLuwQuLabLb866S3031dZZ6
	 XsyzAchqpkSaQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 25 Jun 2025 01:03:15 +0200
X-ME-IP: 124.33.176.97
Message-ID: <0cc46642-e13a-49d6-8280-9ed378dd2e62@wanadoo.fr>
Date: Wed, 25 Jun 2025 08:03:09 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: ucan: Use usb_endpoint_type() rather than
 duplicating its implementation
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org
References: <48e217a7-b90e-4af3-b535-812c449dd3ba@web.de>
 <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <8b6c8271-c3b5-4950-abb4-5888c3d4c67f@web.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <8b6c8271-c3b5-4950-abb4-5888c3d4c67f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2025 at 04:21, Markus Elfring wrote:
>>> +++ b/drivers/net/can/usb/ucan.c
>>> @@ -1353,16 +1353,14 @@ static int ucan_probe(struct usb_interface *intf,
>>>  		ep = &iface_desc->endpoint[i].desc;
>>>  
>>>  		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This is:
>>
>> 	usb_endpoint_dir_in(ep)
> 
> Can the check for a single value like “USB_DIR_IN” be really mapped to
> an other value range?
> https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/usb/ch9.h#L495-L503

Look at the actual values of USB_ENDPOINT_DIR_MASK and USB_DIR_IN ;)


Yours sincerely,
Vincent Mailhol


