Return-Path: <linux-can+bounces-6391-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDoFIgIye2kVCQIAu9opvQ
	(envelope-from <linux-can+bounces-6391-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 11:10:10 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81418AE68D
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 11:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE8893009F37
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6C3350295;
	Thu, 29 Jan 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bPDdGrn5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YmXyYgRZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794C349AE0
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681405; cv=pass; b=oHVKR/EsTuhOxgqQjrb/j16Jf5tP7nZ9vLJUgsknNRIlldRZo11Z4yCgiIQfyOPGLzwTC2hKrp4PU+KTTYF4PZKTNEUTNENf92Zcy1u9bWn0M8PFc/VQtxx9mA/TNr3LFI0pHM/5SHPeu+B8sCbde/zz9z+6TZfnjglztkRqsOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681405; c=relaxed/simple;
	bh=JTY0U9NB8+zkuFYX8i0TInKca3OsHJlmPQUUv/7wgvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZMQfWzpsqvlDf9YgMaPAh6XGczPCOXKuu5Bq5G25ujU/JTeLck8/JrE5JR9TkUJm8ipIRdHi6XFjbDjDFo/jfKtJO/MJdNxXuQ1oLjzSMbmzOZ4vf85PxOWSFp4tMZ3yRurolr1kENcqESmAkYDg6dCVzgEXBl5VoeWhU3BLCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=none smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bPDdGrn5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YmXyYgRZ; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769681396; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nQavdIuzAmt4EjIOrtFRvTwufn9Ti2BRDl1umdMAcmopEUcwu1uYyucrAF678im9jn
    xGEX6aUk4//tehjWSwflvnpJN4gI3VsfsKelLPyzeeXx0WSvwIxC21NTUO7uyk0Fc/BF
    FrR2KGXaJg1KKcf5vmVvDCUW39pJ3t2tUZohDEZGQ5WeREROK1nOBRw43NHB+m9dFSic
    KgEjyPGykBIPSPPMIVI/bVA0FgiMz6JJlU5KGCSBibHmepruBEZOKMA8Z/0zDT6IIQsG
    LrcJ0ZC4uZ5gZ1b/bQk377CSaUzJKnMt7POhOTh+oeZdxb7QbK8MSQUKo7xqheTT5ad/
    3EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769681396;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dL4ovVaIoL14urawadtQfEiQbjiJiqTQipX6cUzdKIo=;
    b=B0fv2B4LkBgBcgUksf9PF4E/eAnZyeY38j7iRa/riblecDVXASODqyXseLB9dD0DEz
    HRdrjvzdZ1zKhMRBbfQ9/xoL6TOzJ0oFms+kCy0DMpZ6zZxtJPck4iRWyjvT3G3GhmQK
    AW2hgQ6h14ljVtC/gTnoN27MAs5xUOyerIthh2SyyKkfPcFfWLdThIujf6No3pHLgeii
    vU+X5QbUx0KwfZOA0iTaWLJWeKDiyim2OIIo0Mc7YHFBidYTritdgx9sY3j0isNVRrkd
    CyhGMzcNv3I90cQvdzBaysZAX9VmKw6yIi/7uYvhscMhxAbxEQpLDWB5zkSP7tvmM5em
    F+ig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769681396;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dL4ovVaIoL14urawadtQfEiQbjiJiqTQipX6cUzdKIo=;
    b=bPDdGrn5aaNYbBp91QCsa0yhtEET1eaz7kK0a5z//9N2QQ5DYu7pLsrGKbxc/8UbNY
    /dVytx4cuRZ3eNUiIq98IVCdOjnGlaZUxPbO+HrpkR1uQ4oqO49XFPHiMUiBp+0xDvDp
    3DcjP3cWkfOQ2QdKr9vLaGBVsbZR8nbc2JL4PccROLFz8pueHFuTa6IsATyOoDZfQgFB
    prZcndiPaFFu/ARsGu/CE1T5UPoq29kOhBMjCCdEsT8VCwombkG21GYFTv3BwfOsl2XK
    heqqZRl2Dw0cQK+6EWTgtBjcii05lMUv24KhCccoO5n5snwkfQdEYPUmWDmLAWhxL56j
    AIFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769681396;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dL4ovVaIoL14urawadtQfEiQbjiJiqTQipX6cUzdKIo=;
    b=YmXyYgRZMPj1+dRlZy8OizJZ6AoIALZi6UTFruAj4p/wsAJWrJV1I19Yv3IfH+EG35
    5u+4gbtskoHNihKmikCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20TA9uqlR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Jan 2026 11:09:56 +0100 (CET)
Message-ID: <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
Date: Thu, 29 Jan 2026 11:09:50 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6391-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 81418AE68D
X-Rspamd-Action: no action



On 29.01.26 09:48, Marc Kleine-Budde wrote:
> Cc += tools@k.o, users@k.o, konstantin@l.o
> 
> On 29.01.2026 08:49:24, Oliver Hartkopp wrote:
>>> Hooray for switching to b4!
>>
>> Yes! Unfortunately one of the most relevant features does not work:
>>
>> $ b4 prep --auto-to-cc
>> Will collect To: addresses using get_maintainer.pl
>> Will collect Cc: addresses using get_maintainer.pl
>> Traceback (most recent call last):
>>    File "/usr/bin/b4", line 8, in <module>
>>      sys.exit(cmd())
>>               ~~~^^
>>    File "/usr/lib/python3/dist-packages/b4/command.py", line 417, in cmd
>>      cmdargs.func(cmdargs)
>>      ~~~~~~~~~~~~^^^^^^^^^
>>    File "/usr/lib/python3/dist-packages/b4/command.py", line 83, in cmd_prep
>>      b4.ez.cmd_prep(cmdargs)
>>      ~~~~~~~~~~~~~~^^^^^^^^^
>>    File "/usr/lib/python3/dist-packages/b4/ez.py", line 2835, in cmd_prep
>>      auto_to_cc()
>>      ~~~~~~~~~~^^
>>    File "/usr/lib/python3/dist-packages/b4/ez.py", line 2655, in auto_to_cc
>>      logger.debug('added %s to seen', ltr.addr[1])
>>                                       ~~~~~~~~^^^
>> TypeError: 'NoneType' object is not subscriptable
>>
>>
>> $ b4 --version
>> 0.14.2
> 
> Latest version is v0.14.3, please re-check.

$ b4 --version
0.14.3

Same behavior but different line numbers:

$ b4 prep --auto-to-cc
Will collect To: addresses using get_maintainer.pl
Will collect Cc: addresses using get_maintainer.pl
Traceback (most recent call last):
   File "/usr/bin/b4", line 8, in <module>
     sys.exit(cmd())
              ~~~^^
   File "/usr/lib/python3/dist-packages/b4/command.py", line 417, in cmd
     cmdargs.func(cmdargs)
     ~~~~~~~~~~~~^^^^^^^^^
   File "/usr/lib/python3/dist-packages/b4/command.py", line 83, in cmd_prep
     b4.ez.cmd_prep(cmdargs)
     ~~~~~~~~~~~~~~^^^^^^^^^
   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2907, in cmd_prep
     auto_to_cc()
     ~~~~~~~~~~^^
   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2727, in auto_to_cc
     logger.debug('added %s to seen', ltr.addr[1])
                                      ~~~~~~~~^^^
TypeError: 'NoneType' object is not subscriptable

I upgraded my machine from Debian Trixie to the "unstable" Debian Forky.

I didn't fiddle with 
https://kernel.googlesource.com/pub/scm/utils/b4/b4.git nor pip.

Best regards,
Oliver

> 
>> While get_maintainer.pl itself works ...
>>
>> $ scripts/get_maintainer.pl net/can/bcm.c
>> Oliver Hartkopp <socketcan@hartkopp.net> (maintainer:CAN NETWORK LAYER)
>> Marc Kleine-Budde <mkl@pengutronix.de> (maintainer:CAN NETWORK LAYER)
>> linux-can@vger.kernel.org (open list:CAN NETWORK LAYER)
>> linux-kernel@vger.kernel.org (open list)
>>
>> At least posting via b4 relay works fine and downloading of the v2 patchset
>> you sent was comparably easy too.
> 
> Marc
> 


