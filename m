Return-Path: <linux-can+bounces-3995-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D68CB05863
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D121A60E35
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55772D8762;
	Tue, 15 Jul 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SYHyOvtK"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40302D9482;
	Tue, 15 Jul 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577454; cv=none; b=l7rP4DfxqIufRd6KMNCW/OC83fsKlpphu47WqrAQVHizSjKX0doFRE9rOqjh0iRqooO5Zla2BDd+IUKE5YMy/YrWC5tpJZvGCLNZFcBusH0ir4CeV+rYIK13BjwGVY0vBjLJ5AV0F0eoiBwiFkMjxRoEpljVdBMRAn+R0PC+O4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577454; c=relaxed/simple;
	bh=/mQu7gzdB58wKM9heJDELyytO4aB7yrtrprnY+O6HuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5O6t1NcSvDuc3oqigB0Tw4K/bLlxJpX61Q8BqVLkm0UzYyoza4Ed2vvO4OT3uW0It/RF+2Guv7ZMMDgV5b7kfi0RgxguAtAfej7mwu68EA3nqjpQlYASDZMDXoVDfgk/Hpxsq5vO3z9bdY0OInMMf8Zwlcbq6lNNcfhXm9jtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SYHyOvtK; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id bdQzuifUMRBz4bdR1unSQS; Tue, 15 Jul 2025 13:02:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752577376;
	bh=/HX/emQQpG8/RU30kxSdFLOLv5c8doI4KfW62GN5gSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SYHyOvtK2HX4aAMRmok5POmmhWG7ybjqPjvzlw4BzJ9osbdLsFN9okeSt7w44ZLuA
	 8w2MKg9YeT1mQOam2xvuOJyXjQcHEGMDAA6sU4IBQPbCVzcj6zLUzIFhlkLGuBsdIx
	 ZvCLyG0b1l2n04vAYsXcs92ZOalAnCMena4qxtDVPuXAaxs5TkS1jzHAOmo4qa5jTn
	 yjsMDd6/ADIwW4WMsPPNBgtQzhH5Pt4NbPM8cAgS2mX/cLPVKZTeKuT56ELr8Jdj1i
	 XURHKnGIrQEm6GRT5j5v8dbxd6b6qPWGSQ3IhiDZEfi8PPmBXBFOTkWF1gaOfTyRCZ
	 5VtEDI3sbl2Gw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Jul 2025 13:02:56 +0200
X-ME-IP: 124.33.176.97
Message-ID: <e25e9ad6-592d-47f5-bf8b-ac3f0bfde46c@wanadoo.fr>
Date: Tue, 15 Jul 2025 20:02:53 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: tscan1: Kconfig: add COMPILE_TEST
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
 <20250713-can-compile-test-v1-3-b4485e057375@wanadoo.fr>
 <20250715-mindful-terrestrial-kangaroo-fc81a1-mkl@pengutronix.de>
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
In-Reply-To: <20250715-mindful-terrestrial-kangaroo-fc81a1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/07/2025 at 18:13, Marc Kleine-Budde wrote:
> On 13.07.2025 17:02:45, Vincent Mailhol wrote:
>> tscan1 depends on ISA. Add COMPILE_TEST so that this driver can also be
>> built on other platforms.
>>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>>  drivers/net/can/sja1000/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
>> index 2f516cc6d22c4028b1de383baa6b3d3a7605b791..fee9d6f84f5fb9d6a81df00be9d216219723a854 100644
>> --- a/drivers/net/can/sja1000/Kconfig
>> +++ b/drivers/net/can/sja1000/Kconfig
>> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
>>  
>>  config CAN_TSCAN1
>>  	tristate "TS-CAN1 PC104 boards"
>> -	depends on ISA
>> +	depends on ISA || COMPILE_TEST
>>  	help
>>  	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
>>  	  https://www.embeddedts.com/products/TS-CAN1
>>
> 
> What about making it:
> 
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
>  
>  config CAN_TSCAN1
>          tristate "TS-CAN1 PC104 boards"
> -        depends on ISA
> +        depends on ISA || (COMPILE_TEST && HAS_IOPORT)
>          help
>            This driver is for Technologic Systems' TSCAN-1 PC104 boards.
>            https://www.embeddedts.com/products/TS-CAN1

Yes, I was thinking of the exact same thing after seeing the bot's error
message. I just did not yet find some time to test.

The kernel test robot actually gives instructions on how to reproduce, but for
some reasons which I have not yet troubleshot, it did not work on first try on
my machine.

Well, you know what, because we reached the same conclusion, allow me to be a
bit lazy here. I will just send the v2 and let the bot test it for me.


Yours sincerely,
Vincent Mailhol


